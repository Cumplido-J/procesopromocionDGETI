/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.aplicacion.servlet;

import herramientas.Datos;
import herramientas.Fecha;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import metodos_sql.Metodos_sql;

/**
 *
 * @author David Reyna
 */
@WebServlet(name = "RegistroInfoLaboral", urlPatterns = {"/RegistroInfoLaboral"})
public class Servlet_registroInfoLaboral extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        try {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet Servlet_registroInfoLaboral</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet Servlet_registroInfoLaboral at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        } finally {
            out.close();
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        try {
            HttpSession session= (HttpSession) request.getSession();
            String idUsuario="",rfc="",programa="";
            if(session.getAttribute("rol").toString().equals("D")){
                idUsuario=session.getAttribute("idUsuario").toString();
                rfc=session.getAttribute("rfc").toString();
            }else{
                idUsuario=session.getAttribute("idDocente").toString();                
                rfc=session.getAttribute("rfcDocente").toString();
            }
            programa=session.getAttribute("programa").toString();
            //out.println(idUsuario);
            Fecha fecha=new Fecha();
            String activo,ingresoSubsistema="",ingresoPlantel="",idJornada="",fechaPlaza="",idTipoNombramiento="",fechaUltimaPromocion="",idJornadaAspira="",idPerfilRequerido="",notaSancion="N",idCategoria="",idCategoriaAspira="";
            if(request.getParameter("activoServicio")!=null){
                activo="S";
                ingresoSubsistema=fecha.formatoAlmacenar(request.getParameter("ingresoSubsistema"));
                ingresoPlantel=fecha.formatoAlmacenar(request.getParameter("ingresoPlantel")); 
                /*idCategoria=request.getParameter("categoria");
                idJornada=request.getParameter("jornada");
                fechaPlaza=fecha.formatoAlmacenar(request.getParameter("fechaPlaza"));
                idTipoNombramiento=request.getParameter("tipoNombramiento");*/
                if(request.getParameter("cbUP")==null){
                    fechaUltimaPromocion=fecha.formatoAlmacenar(request.getParameter("fechaPromocion"));
                }else{
                    fechaUltimaPromocion="";
                }
                idCategoriaAspira=request.getParameter("categoriaAspira");
                idJornadaAspira=request.getParameter("jornadaAspira");
                idPerfilRequerido=request.getParameter("opReqCat");                
                if(request.getParameter("notaDesfavorable")!=null){
                    notaSancion="S";
                }
            }else{
                activo="N";
            }
            String horas="0";
            String respuesta=new Datos().validarSeleccionadas(idUsuario);
            System.out.println("respuesta"+respuesta);
            if(respuesta.contains(",")){
                String[] aux=respuesta.split(",");
                System.out.println("longitud"+aux.length);
                idCategoria=aux[0];
                idJornada=aux[1];
                horas=aux[2];
                idTipoNombramiento=aux[3];
            }
            System.out.println("cat"+idCategoria);
            System.out.println("jor"+idJornada);
            if(idCategoria.equals("-1")||idJornada.equals("-1")){
                out.print("Debe seleccionar la plaza con la que participará");
            }else{
                if(idTipoNombramiento.equals("5")){
                    int categoriaActual=Integer.parseInt(idCategoria);
                int categoriaAspira=Integer.parseInt(idCategoriaAspira);
                int jornadaActual=Integer.parseInt(idJornada);
                int jornadaAspira=Integer.parseInt(idJornadaAspira);
                boolean bandera=false;
                if(programa.equals("1")){
                    if((categoriaActual==3 && categoriaAspira==4)||((categoriaActual==11 && categoriaAspira==12))){
                        if(Integer.parseInt(horas)>=18){
                            bandera=true;
                        }
                    }else{
                        if(categoriaAspira==categoriaActual && jornadaAspira==jornadaActual+1){
                            bandera=true;
                        }else if(categoriaAspira==categoriaActual+1 && jornadaAspira==jornadaActual){
                            bandera=true;
                        }else if(categoriaAspira==categoriaActual+1 && jornadaAspira==jornadaActual+1){
                            bandera=true;
                        }
                    }
                }else if(programa.equals("2")){
                    if(jornadaAspira==jornadaActual && jornadaAspira==1){
                        if(Integer.parseInt(horas)<=19){
                            bandera=true;
                        }else{
                            bandera=false;
                        }
                    }else{
                        bandera=false;
                    }
                }
                
                if(bandera){
                //out.println(notaSancion);
                    Metodos_sql metodo = new Metodos_sql();
                    String[] parametros={idUsuario,activo,ingresoSubsistema,ingresoPlantel,idCategoria,idJornada,fechaPlaza,idTipoNombramiento,fechaUltimaPromocion,idCategoriaAspira,idJornadaAspira,idPerfilRequerido,notaSancion};
                    List<String[]> datos;                           
                    datos=metodo.ejecutaSP("sp_registroInfoLaboral",parametros);           
                    if(!datos.isEmpty()){
                        out.print("ok");
                    }else{
                        out.print("Error en almacenamiento de datos, intente nuevamente");
                    }
                }else{
                    out.print("No puede aplicar a esa combinación de categoria y jornada");
                    if(programa.equals("2")){
                        out.println("Excede el número de horas permitidas");
                    }
                }
                }else{
                    out.print("-El tipo de tipo de nombramiento no es valido para esta convocatoria-");
                }
            }            
        } finally {
            out.close();
        }
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>
    
}
