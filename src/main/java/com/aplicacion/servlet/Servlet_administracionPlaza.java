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
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import metodos_sql.Metodos_sql;

/**
 *
 * @author David Reyna
 */
public class Servlet_administracionPlaza extends HttpServlet {

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
            out.println("<title>Servlet Servlet_administracionPlaza</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet Servlet_administracionPlaza at " + request.getContextPath() + "</h1>");
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
        PrintWriter out = response.getWriter();
        try {
            Fecha fecha=new Fecha();
            HttpSession session= (HttpSession) request.getSession();
            String idUsuario="",rfc="",programa="",clave,subsistema;
            if(session.getAttribute("rol").toString().equals("D")){
                idUsuario=session.getAttribute("idUsuario").toString();
                rfc=session.getAttribute("rfc").toString();
            }else{
                idUsuario=session.getAttribute("idDocente").toString();                
                rfc=session.getAttribute("rfcDocente").toString();
            }           
            Metodos_sql metodo = new Metodos_sql(); 
            if(request.getParameter("id")==null){
                programa=session.getAttribute("programa").toString();
                subsistema=session.getAttribute("subsistema").toString();
                if(Integer.parseInt(subsistema)!=2){
                    String clavePresupUnidad=request.getParameter("clavePresupUnidad");
                    String categoriaPresupuestal=request.getParameter("categoriaPresupuestal");
                    //String valorClavePresupuestal=request.getParameter("valorClavePresupuestal");
                    String clavePresupHoras=request.getParameter("clavePresupHoras");
                    String clavePresupPlaza=request.getParameter("clavePresupPlaza");
                    clave = clavePresupUnidad + categoriaPresupuestal + clavePresupHoras + clavePresupPlaza;
                }else{
                    String clavePresupUnidad=request.getParameter("clavePresupUnidad");
                    clave = clavePresupUnidad;
                }
                String horas="";
                if(Integer.parseInt(subsistema)!=2){
                    horas=request.getParameter("horas");
                    horas= !horas.equals("") ? horas : "0";
                }else{
                   horas=request.getParameter("horas3"); 
                }
                String idCategoria=request.getParameter("categoria");
                String idJornada=request.getParameter("jornada");
                String fechaPlaza=fecha.formatoAlmacenar(request.getParameter("fechaPlaza"));
                String idTipoNombramiento=request.getParameter("tipoNombramiento");
                String cargo="",fechaRenuncia="";
                if(request.getParameter("cbDirectivo")!=null){
                    cargo=request.getParameter("cargo");
                    fechaRenuncia=fecha.formatoAlmacenar(request.getParameter("fechaRenuncia"));
                }
                String inCompleto=request.getParameter("z");
                if(inCompleto==null){
                    inCompleto="";
                }
                
                if(request.getParameter("cbDirectivo")==null && inCompleto.equals("F")){
                    cargo=request.getParameter("cargo");
                    fechaRenuncia=fecha.formatoAlmacenar(request.getParameter("fechaRenuncia"));
                    clave=request.getParameter("clave");
                }
                
                String[] parametros={idUsuario,idCategoria,idJornada,horas,fechaPlaza,idTipoNombramiento,clave,cargo,fechaRenuncia};
                List<String[]> datos = null;
                if(inCompleto.equals("F")){
                    datos=metodo.ejecutaSP("sp_insertUsuarioPlazaFin",parametros);
                }else{
                    if(programa.equals("2")){
                        String validarRespuesta=new Datos().validarSeleccionadasAdd(idUsuario);
                        String idCategoriaRespuesta="0";
                        if(validarRespuesta.contains(",")){
                            String[] auxRespuesta=validarRespuesta.split(",");
                            validarRespuesta=auxRespuesta[4];
                            idCategoriaRespuesta=auxRespuesta[0];
                            if(validarRespuesta.equals("")){
                                validarRespuesta="0";
                            }
                        }
                        
                        if(validarRespuesta.equals("")){
                                validarRespuesta="0";
                            }
                        boolean registro=true;
                        String texto="";
                        String[] docente = {"1", "2", "3"};
                        String[] tecnicoDdocente = {"10", "11"};
                        String[] docenteTresCuartos = {"4", "5" ,"6","7","8","9","12","13","14","15","16","17"};
                        List<String> d = new ArrayList<>(Arrays.asList(docente));
                        List<String> td = new ArrayList<>(Arrays.asList(tecnicoDdocente));
                        List<String> dtc = new ArrayList<>(Arrays.asList(docenteTresCuartos));
                        
                        int horasRegistradas= Integer.parseInt(validarRespuesta)+ Integer.parseInt(horas);
                        if( !idCategoriaRespuesta.equals("0") ){
                            if( td.contains(idCategoriaRespuesta) || d.contains(idCategoriaRespuesta)){
                                if( td.contains(idCategoria) || d.contains(idCategoria)){
                                    registro = true;
                                }else if(dtc.contains(idCategoria)){
                                    registro = false;
                                    texto = "No puede registrar una categoría de medio o 3/4 de tiempo, se marcará como ficha incompleta";
                                }
                                else{
                                    registro = false;
                                    texto = "Unicamente puede registrar categorias del mismo tipo";
                                }
                            }/*else if( d.contains(idCategoriaRespuesta) ){
                                if( d.contains(idCategoria) ){
                                    registro = true;
                                }else{
                                    registro = false;
                                    texto = "Unicamente puede registrar categorias del mismo tipo";
                                }
                            }*/
                            else if(dtc.contains(idCategoria)){
                                registro = false;
                                texto = "No puede registrar una categoría de medio o 3/4 de tiempo, se marcará como ficha incompleta";
                            }
                        }else if( !idCategoria.equals("") ){
                            if(dtc.contains(idCategoria)){
                                registro = false;
                                texto = "No puede registrar una categoría de medio o 3/4 de tiempo, se marcará como ficha incompleta";
                            }
                        }
                        
                        if(registro){
                            String[] parametrosPla={idUsuario};  
                             List<String[]> infoPlazasAspiraH=new Metodos_sql().ejecutaSP("sp_consultaUsuarioCategoriaAspira",parametrosPla);
                            int totalHoras=0;
                            for(String[] dato:infoPlazasAspiraH){
                                totalHoras +=dato[6]!= null ? Integer.parseInt(dato[6]) : 0;
                            }
                            horasRegistradas+=totalHoras;
                            if(horasRegistradas<=19){
                                datos=metodo.ejecutaSP("sp_insertUsuarioPlaza",parametros);
                            }else{
                                out.print("Excede el numero de horas permitidas para esta convocatoria");
                            }
                        }else{                        //out.print(datos.get(0)[0]);
                            out.print(texto);
                        }       
                    }else{
                        String[] docenteCambioCategoria = {"1", "2"};
                        String[] tecnicoDdocente = {"10", "11"};
                        List<String> dCambio = new ArrayList<>(Arrays.asList(docenteCambioCategoria));
                        List<String> td = new ArrayList<>(Arrays.asList(tecnicoDdocente));
                        if(td.contains(idCategoria) || dCambio.contains(idCategoria)){
                            out.print("Unicamente puede asignar una categoria C E4523 de horas");
                        }else if(!td.contains(idCategoria) || !dCambio.contains(idCategoria)){
                            datos=metodo.ejecutaSP("sp_insertUsuarioPlaza",parametros);   
                        }   
                    }
                }
                if(datos != null){
                if(!datos.isEmpty()){
                    if(datos.get(0)[0].equals("ok")){
                        String informacion=new Datos().desplegarPlazas(idUsuario);
                        out.print(informacion);  
                    }else{
                        out.print(datos.get(0)[0]);
                    }
                }else{
                    out.print("Error en almacenamiento de datos, intente nuevamente");
                }
                }
            }else{
                String id=request.getParameter("id");
                if(request.getParameter("k").equals("B")){
                    String[] parametros={id};
                    List<String[]> datos;                           
                    datos=metodo.ejecutaSP("sp_deleteUsuarioPlaza",parametros);

                    String respuestaHoras=new Datos().validarSeleccionadasAdd(idUsuario);
                    if(respuestaHoras.contains(",")){
                        String[] aux=respuestaHoras.split(",");
                        respuestaHoras=aux[4];
                        List<String[]> datosHoras;
                        String[] parametrosHoras={idUsuario,respuestaHoras};
                        datosHoras=metodo.ejecutaSP("sp_updateHoras",parametrosHoras);
                    }

                    if(!datos.isEmpty()){
                        if(datos.get(0)[0].equals("ok")){
                            String informacion=new Datos().desplegarPlazas(idUsuario);
                            out.print(informacion);                     
                        }
                    }else{
                        out.print("Error al eliminar la información, intente nuevamente");
                    }
                }else if(request.getParameter("k").equals("S")){
                    String seleccionada=request.getParameter("s");
                    String[] parametros={id,seleccionada};
                    List<String[]> datos;                           
                    datos=metodo.ejecutaSP("sp_actualizarPlazaActual",parametros);            
                    if(!datos.isEmpty()){
                        if(datos.get(0)[0].equals("ok")){
                            String respuesta=new Datos().validarSeleccionadas(idUsuario);
                            System.out.println(respuesta);
                            if(!respuesta.contains(",")){
                                parametros[1]="F";
                                datos=metodo.ejecutaSP("sp_actualizarPlazaActual",parametros);
                            }else{
                                respuesta="ok";
                            }
                            out.print(respuesta);                     
                        }
                    }else{
                        out.print("Error al eliminar la información, intente nuevamente");
                    }
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
