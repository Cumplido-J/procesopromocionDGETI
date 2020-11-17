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
            /*String idEntidad=request.getParameter("entidad");
            String idTipoInstitucion=request.getParameter("tipoInstitucion");
            String idInstitucion=request.getParameter("institucion");*/
            String idCCT=request.getParameter("cct");
            String idEscuela=request.getParameter("escuela");
            String idGrado=request.getParameter("grado");
            String carrera=request.getParameter("carrera");
            String anioEgreso=request.getParameter("egreso");
            String idModalidadTitulacion=request.getParameter("modalidad");
            String anioTitulacion=request.getParameter("titulacion");
            //String idComprobante=request.getParameter("documento");
            String cedula=request.getParameter("cedula");  


            Metodos_sql metodo = new Metodos_sql();
            //in _idUsuario int,in _idEscuelaEstudio int, in _carrera varchar(300),in _anioEgreso int,in _idGradoAcademico int, in _idModalidadTitulacion int,in _anioTitulacion int,in _cedula varchar(20),idcct
            String[] parametros={id,idEscuela,carrera,anioEgreso,idGrado,idModalidadTitulacion,anioTitulacion,cedula,idCCT};
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
