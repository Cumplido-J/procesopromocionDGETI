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

/**
 *
 * @author charl
 */
@WebServlet(name = "Servlet_buscar_convocatoria", urlPatterns = {"/Servlet_buscar_convocatoria"})
public class Servlet_buscar_convocatoria extends HttpServlet {

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
        try {
            PrintWriter out = response.getWriter();
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet Servlet_buscar_convocatoria</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet Servlet_buscar_convocatoria at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        } catch (Exception e) {
            System.out.println(e.toString());
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

                String control_combobox = request.getParameter("control_combobox");
                String per1 = request.getParameter("permiso1");
                String per2 = request.getParameter("permiso2");
                String per4 = request.getParameter("permiso4");
                String nom1 = request.getParameter("nombre");
                String ent1 = request.getParameter("dato_ent");
                String pla1 = request.getParameter("dato_pla");
                String rfc1 = request.getParameter("dato_rfc");
                String entidad = request.getParameter("entidad");
                String plantel = request.getParameter("n_plantel");
                String publicacion = request.getParameter("publicacion");
                String resultados = request.getParameter("resultados");
                String estatus = request.getParameter("estatus");
                out.print(estatus);
                String btnconvocatoria = request.getParameter("buscar_convocatoria");
                if (btnconvocatoria != null) {

                    if (entidad.equals("0") && plantel.equals("0") && estatus.equals("0") && publicacion.equals("") && resultados.equals("")) {
                        request.setAttribute("consulta", "0");
//                        out.print("caso 0"); //nada
                    } else if (entidad.equals("0") && plantel.equals("0") && estatus.equals("0") && publicacion.equals("") && resultados != ("")) {
                        request.setAttribute("consulta", "1");
//                        out.print("caso 1");//
                    } else if (entidad.equals("0") && plantel.equals("0") && estatus.equals("0") && publicacion != ("") && resultados.equals("")) {
                        request.setAttribute("consulta", "2");
//                        out.print("caso 2");//
                    } else if (entidad.equals("0") && plantel.equals("0") && estatus.equals("0") && publicacion != ("") && resultados != ("")) {
                        request.setAttribute("consulta", "3");
//                        out.print("caso 3");//
                    } else if (entidad.equals("0") && plantel.equals("0") && estatus != ("0") && publicacion.equals("") && resultados.equals("")) {
                        request.setAttribute("consulta", "4");
//                        out.print("caso 4");//
                    } else if (entidad.equals("0") && plantel.equals("0") && estatus != ("0") && publicacion.equals("") && resultados != ("")) {
                        request.setAttribute("consulta", "5");
//                        out.print("caso 5");//
                    } else if (entidad.equals("0") && plantel.equals("0") && estatus != ("0") && publicacion != ("") && resultados.equals("")) {
                        request.setAttribute("consulta", "6");
//                        out.print("caso 6");//
                    } else if (entidad.equals("0") && plantel.equals("0") && estatus != ("0") && publicacion != ("") && resultados != ("")) {
                        request.setAttribute("consulta", "7");
//                        out.print("caso 7");//
                    } else if (entidad != ("0") && plantel != ("0") && estatus.equals("0") && publicacion.equals("") && resultados.equals("")) {
                        request.setAttribute("consulta", "8");
//                        out.print("caso 8");//
                    } else if (entidad != ("0") && plantel != ("0") && estatus.equals("0") && publicacion.equals("") && resultados != ("")) {
                        request.setAttribute("consulta", "9");
//                        out.print("caso 9");//
                    } else if (entidad != ("0") && plantel != ("0") && estatus.equals("0") && publicacion != ("") && resultados.equals("")) {
                        request.setAttribute("consulta", "10");
//                        out.print("caso 10");//
                    } else if (entidad != ("0") && plantel != ("0") && estatus.equals("0") && publicacion != ("") && resultados != ("")) {
                        request.setAttribute("consulta", "11");
//                        out.print("caso 11");//
                    } else if (entidad != ("0") && plantel != ("0") && estatus != ("0") && publicacion.equals("") && resultados.equals("")) {
                        request.setAttribute("consulta", "12");
//                        out.print("caso 12");//
                    } else if (entidad != ("0") && plantel != ("0") && estatus != ("0") && publicacion.equals("") && resultados != ("")) {
                        request.setAttribute("consulta", "13");
//                        out.print("caso 13");//
                    } else if (entidad != ("0") && plantel != ("0") && estatus != ("0") && publicacion != ("") && resultados.equals("")) {
                        request.setAttribute("consulta", "14");
//                        out.print("caso 14");//
                    } else if (entidad != ("0") && plantel != ("0") && estatus != ("0") && publicacion != ("") && resultados != ("")) {
                        request.setAttribute("consulta", "15");
//                        out.print("caso 15");//
                    } 

                    request.setAttribute("control_combobox", control_combobox);
                    request.setAttribute("opc", "1");
                    request.setAttribute("nom", nom1);
                    request.setAttribute("dato_ent", ent1);
                    request.setAttribute("dato_pla", pla1);
                    request.setAttribute("dato_rfc", rfc1);
                    request.setAttribute("per1", per1);
                    request.setAttribute("per2", per2);
                    request.setAttribute("per4", per4);
                    
                    request.setAttribute("ent", entidad);
                    request.setAttribute("pla", plantel);
                    request.setAttribute("est", estatus);
                    request.setAttribute("pub", publicacion);
                    request.setAttribute("res", resultados);
                    session.setAttribute("idUsuario", idUsuario);
                    session.setAttribute("rfc", rfc);
                    RequestDispatcher rd = request.getRequestDispatcher("convocatoria.jsp");
                    rd.forward(request, response);
                } else {
                    request.setAttribute("error", "Vacante No Registrado");
                    RequestDispatcher rd = request.getRequestDispatcher("vacantes.jsp");
                    rd.forward(request, response);
                    //out.println("USUARIO NO REGISTRADOs");
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
