/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.aplicacion.servlet;

import com.aplicacion.beans.Docente;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author Fernando
 */
@WebServlet(name = "RegistroGrupoCecyte", urlPatterns = {"/RegistroGrupoCecyte"})
public class Servlet_registroGrupoCecyte extends HttpServlet {

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
            out.println("<title>Servlet Servlet_registroGrupoCecyte</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet Servlet_registroGrupoCecyte at " + request.getContextPath() + "</h1>");
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
        HttpSession session= (HttpSession) request.getSession();     
        if(session.getAttribute("rol")!=null){
            String idUsuario,rfc;
            if(session.getAttribute("rol").toString().equals("D")){
                idUsuario=session.getAttribute("idUsuario").toString();
                rfc=session.getAttribute("rfc").toString();
            }else{
                idUsuario=session.getAttribute("idDocente").toString();                
                rfc=session.getAttribute("rfcDocente").toString();
            }
            
            String idPeriodo=request.getParameter("periodo2").toUpperCase();
            String grupo=request.getParameter("grupo2").toUpperCase();
            String semestre=request.getParameter("semestre2").toUpperCase();
            String tipoInfo=request.getParameter("tipoInfoCecyte").toUpperCase();
            String version=request.getParameter("version2").toUpperCase();
            String carrera=request.getParameter("carrera_cp2").toUpperCase();
            String modulo=request.getParameter("modulo2").toUpperCase();
            String submodulo=request.getParameter("submodulo2").toUpperCase();
            String horas=request.getParameter("horas2").toUpperCase();
            String idAsignatura=request.getParameter("asignatura2").toUpperCase();
            
            Docente d=new Docente();
            d.setIdUsuario(idUsuario);
            //d.registraHoras(idPeriodo, idAsignatura, horas, grupo,semestre);
            d.registraHorasCecyte(idPeriodo,grupo,semestre,tipoInfo,version,carrera,modulo,submodulo,horas,idAsignatura);
            d.consultaHorasCecyte();
            String respuesta="";
            int totalHoras=d.getTotalHorasCecyte();
            int grupos=d.getNumGruposCecyte();
            respuesta=d.mostrarHorasCecyte();
            respuesta+="|"+totalHoras+"|"+grupos;
            out.println(respuesta);
        }        
        out.close();
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
