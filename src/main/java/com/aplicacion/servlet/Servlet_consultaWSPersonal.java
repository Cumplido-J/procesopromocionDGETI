/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.aplicacion.servlet;

import com.aplicacion.beans.Docente;
import com.aplicacion.beans.Grupo;
import com.aplicacion.beans.Personal;
import herramientas.Catalogos;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import metodos_sql.Metodos_sql;

/**
 *
 * @author David Reyna
 */
@WebServlet(name = "ConsultaWSPersonal", urlPatterns = {"/ConsultaWSPersonal"})
public class Servlet_consultaWSPersonal extends HttpServlet {

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
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet Servlet_consultaWSPersonal</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet Servlet_consultaWSPersonal at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
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
        
        String parametro = request.getParameter("accion");
        parametro= (parametro==null) ? "preregistro": parametro;
        try{
         switch(parametro){
                case "preregistro": 
                    ConsultaWSPersonal(request,response);    
                    break;
                case "preregistroRFC":
                    registroPreRegistroRFC(request, response);
                    break;   
            }
        }catch(IOException | ServletException e){
            System.out.println("Error: ConsultaWSPersonal --> "+e);
        }
        /*PrintWriter out = response.getWriter();
        try {

            String rfc=request.getParameter("rfc");
            String respuesta;
            Docente docente=new Docente();
            docente.setRfc(rfc);
            docente.consumeWSCatalogoPersonal();
            docente.procesaJsonPersonal();
            List<Personal> personal=docente.getPersonal();
            String nombre="";
            String primerApellido="";
            String segundoApellido="";
            String idEstado="";
            String idPlantel="";
            String cct1="";
            String cct2="";
            int periodos=personal.size();
            if(periodos>0){
                String[] aux;
                //aux=personal.get(periodos-1).getNombre().split(" ");
                //int a=aux.length;
                //if(a>=3){
                   // primerApellido=aux[0].toUpperCase();
                    //segundoApellido=aux[1].toUpperCase();
                    //for(int c=2;c<a;c++){
                    //    nombre+=aux[c].toUpperCase()+" ";
                  //  }
                //}
                nombre=personal.get(periodos-1).getNombre();
                cct1=personal.get(periodos-1).getCct1();
                cct2=personal.get(periodos-1).getCct2();
                Metodos_sql metodo=new Metodos_sql();
                String[] parametros={cct1,cct2};
                List<String[]> datos=metodo.ejecutaSP("sp_selectCatPlantelCCTs",parametros);
                
                if(!datos.isEmpty()){
                    idPlantel=datos.get(0)[0];
                    idEstado=datos.get(0)[1];
                    //Catalogos catalogo=new Catalogos();
                    //catEstado=catalogo.desplegarOpcionesEstado(idEstado);
                    //catPlantel=catalogo.desplegarOpcionesPlanteles(idEstado, idPlantel);
                }
            }
            
            out.print(nombre+"|"+idEstado+"|"+idPlantel);
        }catch(Exception e){
            out.println(e);
        } 
        finally {
            out.close();
        }*/
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

    
    private void ConsultaWSPersonal(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        try {
            /* TODO output your page here. You may use following sample code. */
            String rfc=request.getParameter("rfc");
            String respuesta;
            Docente docente=new Docente();
            docente.setRfc(rfc);
            docente.consumeWSCatalogoPersonal();
            docente.procesaJsonPersonal();
            List<Personal> personal=docente.getPersonal();
            String nombre="";
            String primerApellido="";
            String segundoApellido="";
            String idEstado="";
            String idPlantel="";
            String cct1="";
            String cct2="";
            int periodos=personal.size();
            if(periodos>0){
                String[] aux;
                /*aux=personal.get(periodos-1).getNombre().split(" ");
                int a=aux.length;
                if(a>=3){
                    primerApellido=aux[0].toUpperCase();
                    segundoApellido=aux[1].toUpperCase();
                    for(int c=2;c<a;c++){
                        nombre+=aux[c].toUpperCase()+" ";
                    }
                }*/
                nombre=personal.get(periodos-1).getNombre();
                cct1=personal.get(periodos-1).getCct1();
                cct2=personal.get(periodos-1).getCct2();
                Metodos_sql metodo=new Metodos_sql();
                String[] parametros={cct1,cct2};
                List<String[]> datos=metodo.ejecutaSP("sp_selectCatPlantelCCTs",parametros);
                
                if(!datos.isEmpty()){
                    idPlantel=datos.get(0)[0];
                    idEstado=datos.get(0)[1];
                    /*Catalogos catalogo=new Catalogos();
                    catEstado=catalogo.desplegarOpcionesEstado(idEstado);
                    catPlantel=catalogo.desplegarOpcionesPlanteles(idEstado, idPlantel);*/
                }
            }
            
            out.print(nombre+"|"+idEstado+"|"+idPlantel);
        }catch(Exception e){
            out.println(e);
        } 
        finally {
            out.close();
        }
    }
    
    private void registroPreRegistroRFC (HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        try {
        
            String rfc=request.getParameter("rfc");
            Docente docente=new Docente();
            docente.setRfc(rfc);
            docente.consumeWSCatalogoPersonal();
            docente.procesaJsonPersonal();
            List<Personal> personal=docente.getPersonal();
            int restDatos=personal.size();
            String nombre="";
            String cct1="";
            String cct2="";
            String respuesta="";
            if(restDatos > 0){
                nombre=personal.get(0).getNombre();
                cct1=personal.get(0).getCct1();
                cct2=personal.get(0).getCct2();
                Metodos_sql metodo=new Metodos_sql();
                String[] parametros={rfc.toUpperCase(),cct1,cct2};
                List<String[]> datos=metodo.ejecutaSP("sp_insertPreAspirante2Validacion",parametros);
                if(!datos.isEmpty()){
                    respuesta=datos.get(0)[0];
                }
                out.print(nombre+"|"+respuesta);
            }else if(restDatos < 1){
                out.print(nombre+"|"+respuesta+"|"+"Noencontrado");
            }

        }catch(Exception e){
            out.println(e);
        } 
        finally {
            out.close();
        }
    }
    
    
}
