/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.aplicacion.servlet;

import com.aplicacion.beans.Docente;
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
@WebServlet(name = "RegistroInfoAcademica", urlPatterns = {"/RegistroInfoAcademica"})
public class Servlet_registroInfoAcademica extends HttpServlet {

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
            out.println("<title>Servlet Servlet_registroInfoAcademica</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet Servlet_registroInfoAcademica at " + request.getContextPath() + "</h1>");
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
        //processRequest(request, response);
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        
        String parametro = request.getParameter("accion");
        parametro= (parametro==null) ? "ingresa": parametro;
        try{
         switch(parametro){
                case "ingresa": 
                    registroInfoAcademica(request,response);    
                    break;
                case "observacionesPaso1":
                    registroObservacionPaso1(request, response);
                    break;
                case "observacionesPaso2":
                    registroObservacionPaso2(request, response);
                    break;
                case "observacionesPaso3":
                    registroObservacionPaso3(request, response);
                    break; 
                case "observacionesPaso4":
                    registroObservacionPaso4(request, response);
                    break;     
            }
        }catch(Exception e){}
        /*try {
           HttpSession session= (HttpSession) request.getSession();
        String id="",rfc="";
        boolean vistaAdmin=false;  
        if(session.getAttribute("rol")!=null){
        if(session.getAttribute("rol").toString().equals("D")){
            id=session.getAttribute("idUsuario").toString();
            rfc=session.getAttribute("rfc").toString();
            vistaAdmin=false; 
            
        }else{
            id=session.getAttribute("idDocente").toString();
            rfc=session.getAttribute("rfcDocente").toString();
            vistaAdmin=true;                       
        }
        if(!id.equals("")&&!rfc.equals("")){
            String idEntidad=request.getParameter("entidad");
            String idTipoInstitucion=request.getParameter("tipoInstitucion");
            String idInstitucion=request.getParameter("institucion");
            String idCCT=request.getParameter("cct");
            String idEscuela=request.getParameter("escuela");
            String idGrado=request.getParameter("grado");
            String carrera=request.getParameter("carrera");
            String anioEgreso=request.getParameter("egreso");
            String idModalidadTitulacion=request.getParameter("modalidad");
            String anioTitulacion=request.getParameter("titulacion");
            //String idComprobante=request.getParameter("documento");
            String cedula=request.getParameter("cedula"); 
            
            String institucionOtro=request.getParameter("institucionOtro"); 
            String cctOtro=request.getParameter("cctOtro"); 
            String escuelaOtro=request.getParameter("escuelaOtro"); 

            

            Metodos_sql metodo = new Metodos_sql();
            //in _idUsuario int,in _idEscuelaEstudio int, in _carrera varchar(300),in _anioEgreso int,in _idGradoAcademico int, in _idModalidadTitulacion int,in _anioTitulacion int,in _cedula varchar(20),idcct
            String[] parametros={id,idEscuela,carrera,anioEgreso,idGrado,idModalidadTitulacion,anioTitulacion,cedula,idCCT,idEntidad,idTipoInstitucion,idInstitucion,institucionOtro,cctOtro,escuelaOtro};
            List<String[]> datos;                           
            datos=metodo.ejecutaSP("sp_registroInfoAcademica",parametros);            
            if(!datos.isEmpty()){
                out.print("ok");
            }else{
                out.print("Error en almacenamiento de datos, intente nuevamente");
            }
        }
        }
            
        } finally {
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

    private void registroInfoAcademica(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
        PrintWriter out = response.getWriter();
        try {
           HttpSession session= (HttpSession) request.getSession();
        String id="",rfc="";
        boolean vistaAdmin=false;  
        if(session.getAttribute("rol")!=null){
        if(session.getAttribute("rol").toString().equals("D")){
            id=session.getAttribute("idUsuario").toString();
            rfc=session.getAttribute("rfc").toString();
            vistaAdmin=false; 
            
        }else{
            id=session.getAttribute("idDocente").toString();
            rfc=session.getAttribute("rfcDocente").toString();
            vistaAdmin=true;                       
        }
        if(!id.equals("")&&!rfc.equals("")){
            String idEntidad=request.getParameter("entidad");
            String idTipoInstitucion=request.getParameter("tipoInstitucion");
            String idInstitucion=request.getParameter("institucion");
            String idCCT=request.getParameter("cct");
            String idEscuela=request.getParameter("escuela");
            String idGrado=request.getParameter("grado");
            String carrera=request.getParameter("carrera");
            String anioEgreso=request.getParameter("egreso");
            String idModalidadTitulacion=request.getParameter("modalidad");
            String anioTitulacion=request.getParameter("titulacion");
            //String idComprobante=request.getParameter("documento");
            String cedula=request.getParameter("cedula"); 
            
            String institucionOtro=request.getParameter("institucionOtro"); 
            String cctOtro=request.getParameter("cctOtro"); 
            String escuelaOtro=request.getParameter("escuelaOtro");
            String archivoevidencia=request.getParameter("documento");

            

            Metodos_sql metodo = new Metodos_sql();
            //in _idUsuario int,in _idEscuelaEstudio int, in _carrera varchar(300),in _anioEgreso int,in _idGradoAcademico int, in _idModalidadTitulacion int,in _anioTitulacion int,in _cedula varchar(20),idcct
            String[] parametros={id,idEscuela,carrera,anioEgreso,idGrado,idModalidadTitulacion,anioTitulacion,cedula,idCCT,idEntidad,idTipoInstitucion,idInstitucion,institucionOtro,cctOtro,escuelaOtro,archivoevidencia};
            List<String[]> datos;                           
            datos=metodo.ejecutaSP("sp_registroInfoAcademica",parametros);            
            if(!datos.isEmpty()){
                out.print("ok");
            }else{
                out.print("Error en almacenamiento de datos, intente nuevamente");
            }
        }
        }
            
        } finally {
            out.close();
        }
    }
    
        private void registroObservacionPaso1(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
            PrintWriter out = response.getWriter();
            HttpSession session= (HttpSession) request.getSession();
            Metodos_sql metodo=new Metodos_sql();
            List<String[]> datos; 
        try {
            String observacion1P1D, observacion1P1R,idDocente;
            idDocente=session.getAttribute("idDocente").toString();
            observacion1P1R = request.getParameter("observacion1P1R");
            observacion1P1D = request.getParameter("observacion1P1D");
            String tipoOb = ( observacion1P1R.length() > 0 ) ? "5" : "1";
            String observacion =( observacion1P1R.length() > 0 ) ? observacion1P1R : observacion1P1D;
            //byte ptext[] = observacion.getBytes("ISO-8859-1"); 
            String value = observacion;//new String(ptext, "UTF-8");
            String[] parametros={tipoOb,idDocente,value};
            datos=metodo.ejecutaSP("sp_insertObservacionesPaso1",parametros);
            
            if(!datos.isEmpty()){
                out.print("ok");
            }else{
                out.print("Error en almacenamiento de datos, intente nuevamente");
            }
            } finally {
            out.close();
        }
    }
    
        private void registroObservacionPaso2(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
            PrintWriter out = response.getWriter();
            HttpSession session= (HttpSession) request.getSession();
            Metodos_sql metodo=new Metodos_sql();
            List<String[]> datos; 
        try {
            String observacion2P1D, observacion2P1R, idDocente;
            idDocente=session.getAttribute("idDocente").toString();
            observacion2P1R = request.getParameter("observacion2P1R");
            observacion2P1D = request.getParameter("observacion2P1D");

            String tipoOb = ( observacion2P1R.length() > 0 ) ? "6" : "2";
            String observacion =( observacion2P1R.length() > 0 ) ? observacion2P1R : observacion2P1D;
            
            //byte ptext[] = observacion.getBytes("ISO-8859-1"); 
            String value = observacion;//new String(ptext, "UTF-8");
            String[] parametros={tipoOb,idDocente,value};
            datos=metodo.ejecutaSP("sp_insertObservacionesPaso1",parametros);
            if(!datos.isEmpty()){
                out.print("ok");
            }else{
                out.print("Error en almacenamiento de datos, intente nuevamente");
            }
            } finally {
            out.close();
        }
    }
    
        private void registroObservacionPaso3(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
            PrintWriter out = response.getWriter();
            HttpSession session= (HttpSession) request.getSession();
            Metodos_sql metodo=new Metodos_sql();
            List<String[]> datos; 
        try {
            String observacion3P1D, observacion3P1R, idDocente;
            idDocente=session.getAttribute("idDocente").toString();
            observacion3P1R = request.getParameter("observacion3P1R");
            observacion3P1D = request.getParameter("observacion3P1D");
            
            String tipoOb = ( observacion3P1R.length() > 0 ) ? "7" : "3";
            String observacion =( observacion3P1R.length() > 0 ) ? observacion3P1R : observacion3P1D;
            
            //byte ptext[] = observacion.getBytes("ISO-8859-1"); 
            String value = observacion;//new String(ptext, "UTF-8");
            String[] parametros={tipoOb,idDocente,value};
            datos=metodo.ejecutaSP("sp_insertObservacionesPaso1",parametros);
            if(!datos.isEmpty()){
                out.print("ok");
            }else{
                out.print("Error en almacenamiento de datos, intente nuevamente");
            }
            } finally {
            out.close();
        }
    }
        
        private void registroObservacionPaso4(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
            PrintWriter out = response.getWriter();
            HttpSession session= (HttpSession) request.getSession();
            Metodos_sql metodo=new Metodos_sql();
            List<String[]> datos; 
        try {
            String observacion4P1D="", observacion4P1R="", idDocente, observacion="";
            idDocente=session.getAttribute("idDocente").toString();
            observacion4P1R = request.getParameter("observacion4P1R");
            observacion4P1D = request.getParameter("observacion4P1D");

            String tipoOb = ( observacion4P1R.length() > 0 ) ? "8" : "4";
            observacion =( observacion4P1R.length() > 0 ) ? observacion4P1R : observacion4P1D;
            
            //byte ptext[] = observacion.getBytes("ISO-8859-1"); 
            String value = observacion;//new String(ptext, "UTF-8");
            String[] parametros={tipoOb,idDocente,value};
            datos=metodo.ejecutaSP("sp_insertObservacionesPaso1",parametros);
                        //System.out.println("aqui--->>>>>observacion4P1D : "+value);
            if(!datos.isEmpty()){
                out.print("ok");
            }else{
                out.print("Error en almacenamiento de datos, intente nuevamente");
            }
            } finally {
            out.close();
        }
    }
    
}
