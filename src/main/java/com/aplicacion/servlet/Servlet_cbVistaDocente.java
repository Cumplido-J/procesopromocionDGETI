/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.aplicacion.servlet;

import com.aplicacion.beans.Docente;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author David Reyna
 */
@WebServlet(name = "VistaDocente", urlPatterns = {"/VistaDocente"})
public class Servlet_cbVistaDocente extends HttpServlet {
    Docente docente;
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
            out.println("<title>Servlet Servlet_cbVistaDocente</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet Servlet_cbVistaDocente at " + request.getContextPath() + "</h1>");
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
        HttpSession session= (HttpSession) request.getSession();     
        if(session.getAttribute("idDocente")!=null&&session.getAttribute("rfcDocente")!=null){
            docente=new Docente();
            docente.setIdUsuario(session.getAttribute("idDocente").toString());
            docente.setRfc(session.getAttribute("rfcDocente").toString());
            docente.consultaInfoAspirante(); 
            session.setAttribute("idConvocatoria",docente.getIdConvocatoria());
            docente.consultaEncuestados();            
            request.setAttribute("Docente", docente);
            request.setAttribute("validacionConvocatoria", docente.getValidaAccionPorConvocatoria(docente.getIdUsuario()).get(0) );
            ServletContext sc = getServletContext();
            RequestDispatcher rd = sc.getRequestDispatcher("/vistaDocente.jsp");
            rd.forward(request,response);
        }else{
            response.sendRedirect("login.jsp");
        }
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
        HttpSession session= (HttpSession) request.getSession();     
        //if(session.getAttribute("idUsuario")!=null&&session.getAttribute("rfc")!=null){
            session.setAttribute("idDocente",request.getParameter("idUsuario"));
            session.setAttribute("rfcDocente",request.getParameter("rfc"));
            docente=new Docente();
            docente.setIdUsuario(request.getParameter("idUsuario"));
            docente.setRfc(request.getParameter("rfc"));
            docente.consultaInfoAspirante(); 
            session.setAttribute("idConvocatoria",docente.getIdConvocatoria());
            docente.consultaEncuestados(); 
            session.setAttribute("totalEncuestados",docente.getTotalEncuestados());
            session.setAttribute("entidadDocente", docente.getInfoRegistro()[7]);
            request.setAttribute("Docente", docente);
            request.setAttribute("vinculos", session.getAttribute("vinculos"));
            //System.out.println("---------------------"+docente.getInfoRegistro()[64]);
            //session.setAttribute("programa",docente.getInfoRegistro()[64]);
                        request.setAttribute("validacionConvocatoria", docente.getValidaAccionPorConvocatoria(request.getParameter("idUsuario")).get(0) );
            if( !session.getAttribute("rol").toString().equals("D")){
                    session.setAttribute("programa",docente.getInfoRegistro()[64]);
                }
            ServletContext sc = getServletContext();
            RequestDispatcher rd = sc.getRequestDispatcher("/vistaDocente.jsp");    
            rd.forward(request,response);
        
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
