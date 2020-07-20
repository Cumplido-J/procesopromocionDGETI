/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.aplicacion.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Date;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import metodos_sql.Metodos_sql;

/**
 *
 * @author charl
 */
@WebServlet(name = "Servlet_guardar_convocatoria", urlPatterns = {"/Servlet_guardar_convocatoria"})
public class Servlet_guardar_convocatoria extends HttpServlet {

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
            out.println("<title>Servlet Servlet_guardar_convocatoria</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet Servlet_guardar_convocatoria at " + request.getContextPath() + "</h1>");
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
      response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("</head>");
            out.println("<body>");
            String nom1 = request.getParameter("nombre");
            String ent1 = request.getParameter("dato_ent");
            String pla1 = request.getParameter("dato_pla");
            String rfc1 = request.getParameter("dato_rfc");

//            String logosems1 = request.getParameter("logo_sems");
//            String logouemstis1 = request.getParameter("logo_uemstis");
            String textarea1 = request.getParameter("textarea");
            Date publicacion1 = Date.valueOf(request.getParameter("publicacion"));
            Date periodo_registro_inicio1 = Date.valueOf(request.getParameter("periodo_registro_inicio"));
            Date periodo_registro_fin1 = Date.valueOf(request.getParameter("periodo_registro_fin"));
            Date periodo_valoracion_inicio1 = Date.valueOf(request.getParameter("periodo_valoracion_inicio"));
            Date periodo_valoracion_fin1 = Date.valueOf(request.getParameter("periodo_valoracion_fin"));
            Date periodo_dictaminacion_inicio1 = Date.valueOf(request.getParameter("periodo_dictaminacion_inicio"));
            Date periodo_dictaminacion_fin1 = Date.valueOf(request.getParameter("periodo_dictaminacion_fin"));
            Date publicacion_resultados1 = Date.valueOf(request.getParameter("publicacion_resultados"));

            String btnregresa = request.getParameter("guardar");
            if (btnregresa != null) {
//                out.print(logosems1);
//                out.print(logouemstis1);
                out.print(textarea1);
                out.print(publicacion1);
                out.print(periodo_registro_inicio1);
                out.print(periodo_registro_fin1);
                out.print(periodo_valoracion_inicio1);
                out.print(periodo_valoracion_fin1);
                out.print(periodo_dictaminacion_inicio1);
                out.print(periodo_dictaminacion_fin1);
                out.print(publicacion_resultados1);

                 int datos6 = metodos.guardar7(0, 1, 1, textarea1, publicacion1, periodo_registro_inicio1, periodo_registro_fin1, periodo_valoracion_inicio1, periodo_valoracion_fin1, periodo_dictaminacion_inicio1, periodo_dictaminacion_fin1, publicacion_resultados1);
            
                 if (datos6 > 0 ) {
                request.setAttribute("opc", "1");
                request.setAttribute("nom", nom1);
                request.setAttribute("dato_ent", ent1);
                request.setAttribute("dato_pla", pla1);
                request.setAttribute("dato_rfc", rfc1);
                RequestDispatcher rd = request.getRequestDispatcher("Registro_convocatoria.jsp");
                rd.forward(request, response);
                 }
                 else {
                    out.print("Servidor en mantenimiento, Datos no Guardados");
                }
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
