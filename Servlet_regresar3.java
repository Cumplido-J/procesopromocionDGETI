/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.aplicacion.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author charl
 */
@WebServlet(name = "Servlet_regresar3", urlPatterns = {"/Servlet_regresar3"})
public class Servlet_regresar3 extends HttpServlet {

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
            out.println("<title>Servlet Servlet_regresar3</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet Servlet_regresar3 at " + request.getContextPath() + "</h1>");
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
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("</head>");
            out.println("<body>");
            String per1 = request.getParameter("permiso1");
            String per3 = request.getParameter("permiso3");
            String per4 = request.getParameter("permiso4");
            String nom1 = request.getParameter("nombre");
            String ent1 = request.getParameter("dato_ent");
            String pla1 = request.getParameter("dato_pla");
            String rfc1 = request.getParameter("dato_rfc");
            String btnregresa2 = request.getParameter("regresa3");
            if (btnregresa2 != null) {
                request.setAttribute("opc", "1");
                request.setAttribute("consulta", "1");
                request.setAttribute("nom", nom1);
                request.setAttribute("dato_ent", ent1);
                request.setAttribute("dato_pla", pla1);
                request.setAttribute("dato_rfc", rfc1);
                request.setAttribute("per1", per1);
                request.setAttribute("per3", per3);
                request.setAttribute("per4", per4);
                RequestDispatcher rd = request.getRequestDispatcher("administracion_usuarios.jsp");
                rd.forward(request, response);
            }
            //out.println("<h1>Servlet Servlet at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
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
