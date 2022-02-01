/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.aplicacion.servlet;

import herramientas.Datos;
import herramientas.DatosHoras;
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
@WebServlet(name = "Servlet_reporteAsignacion", urlPatterns = {"/reporteAsignacion"})
public class Servlet_reporteAsignacion extends HttpServlet {

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
            out.println("<title>Servlet Servlet_reporteAsignacion</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet Servlet_reporteAsignacion at " + request.getContextPath() + "</h1>");
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
        try {
            PrintWriter out = response.getWriter();
            HttpSession session = (HttpSession) request.getSession();
            String programa = request.getParameter("programa");
            String subsistema = request.getParameter("subsistema");
            String entidad = request.getParameter("entidad");
            String periodo = request.getParameter("periodo");
            String proceso = request.getParameter("proceso");
            Datos d = new Datos();
            if (proceso.equals("1")) {
                out.print(d.generarReporte(programa, subsistema, entidad, periodo));
            } else if (proceso.equals("2")) {
                out.print(d.generarReporteEstatal(programa, subsistema, periodo));
            } else if (proceso.equals("3")) {
                DatosHoras dh = new DatosHoras();
                out.print(dh.generarReporte(programa, subsistema, entidad, periodo));
            }else if (proceso.equals("4")) {
                out.print(d.generarReporteVacancia(programa, subsistema));
            }

        } catch (Exception e) {
            System.out.println(e.toString());
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
