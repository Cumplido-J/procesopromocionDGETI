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
import javax.servlet.http.HttpSession;
import metodos_sql.Metodos_sql;
import seguridad.Encriptar_Desencriptar;

/**
 *
 * @author charl
 */
@WebServlet(name = "Servlet_iniciosesion_vacancia", urlPatterns = {"/Servlet_iniciosesion_vacancia"})
public class Servlet_iniciosesion_vacancia extends HttpServlet {

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
            out.println("<title>Servlet Servlet_iniciosesion_vacancia</title>");
            out.println("</head>");
            out.println("<body>");
            RequestDispatcher rd = request.getRequestDispatcher("login.jsp");
            rd.forward(request, response);
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
    Metodos_sql metodos = new Metodos_sql();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        //processRequest(request, response);
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            //out.println("<title>Servlet Servlet</title>");
            out.println("</head>");
            out.println("<body>");
            HttpSession session = (HttpSession) request.getSession(true);
            String idUsuario = "";
            String rfc = "";
            if (session.getAttribute("idUsuario") != null && session.getAttribute("rfc") != null) {
                idUsuario = session.getAttribute("idUsuario").toString();
                rfc = session.getAttribute("rfc").toString();

                String rfc2 = request.getParameter("rfc");
                String clave = request.getParameter("clave");
                String claveEncriptada = "";
                claveEncriptada = Encriptar_Desencriptar.encriptar(clave);
                String btnlogin = request.getParameter("iniciarsesionvacancia");
                if (btnlogin != null) {
                    String busquedavacante = metodos.buscarvacancia(rfc2, claveEncriptada);
                    if (rfc.equals("root") && clave.equals("root")) {
                        out.println("ADMINISTTRADOR");
                    }//fin if root
                    else if (busquedavacante.equals("USUARIO ENCONTRADO")) {
                        String busqueda_vacante = metodos.buscarvacancia(rfc2);
                        //out.println("Bienvenido "+busquedavacante);
                        //request.setAttribute("nom", busqueda_vacante);
                        session.setAttribute("idUsuario", idUsuario);
                        session.setAttribute("rfc", rfc);
                        RequestDispatcher rd = request.getRequestDispatcher("agregar_vacantes.jsp");
                        rd.forward(request, response);
                        //response.sendRedirect("ppsesion.html");
                    } else {
                        request.setAttribute("error", "Vacante No Registrado");
                        RequestDispatcher rd = request.getRequestDispatcher("vacancia.jsp");
                        rd.forward(request, response);
                        //out.println("USUARIO NO REGISTRADOs");
                    }

                }
            } else {
                response.sendRedirect("login.jsp");
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
