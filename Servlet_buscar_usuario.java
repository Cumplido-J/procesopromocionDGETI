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
import metodos_sql.Metodos_sql;
import seguridad.Encriptar_Desencriptar;

/**
 *
 * @author charl
 */
@WebServlet(name = "Servlet_buscar_usuario", urlPatterns = {"/Servlet_buscar_usuario"})
public class Servlet_buscar_usuario extends HttpServlet {

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
            out.println("<title>Servlet Servlet_buscar_usuario</title>");
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
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            //out.println("<title>Servlet Servlet</title>");
            out.println("</head>");
            out.println("<body>");
            String entidadt = "";
            String entidad = "";
            String n_plantel = "";
            String usuario = "";

            String per1 = request.getParameter("permiso1");
            String per3 = request.getParameter("permiso3");
            String per4 = request.getParameter("permiso4");
            String nom1 = request.getParameter("nombre");
            String ent1 = request.getParameter("dato_ent");
            String pla1 = request.getParameter("dato_pla");
            String rfc1 = request.getParameter("dato_rfc");
            entidadt = request.getParameter("campoentidad7");
            entidad = request.getParameter("entidad");
            n_plantel = request.getParameter("n_plantel");
            usuario = request.getParameter("usuario");

            String btnlogin = request.getParameter("buscarusuario");
            if (btnlogin != null) {

                if (entidad.equals("0") && n_plantel.equals("0") && usuario.equals("")) {
                    request.setAttribute("consulta", "1");
                    //out.print("caso 1"); //nada

                } else if (entidad != ("0") && n_plantel != ("0") && usuario.equals("")) {
                    if (n_plantel.equals("0")) {
                        request.setAttribute("consulta", "2");
                        //out.print("caso 2");//entidad
                    } else {
                        request.setAttribute("consulta", "3");
                        //out.print("caso 3"); //entidad y plantel  
                    }

                } else if (entidad.equals("0") && n_plantel.equals("0") && usuario != "") {
                    request.setAttribute("consulta", "4");
                    //out.print("caso 4");   //usuario
                } else if (entidad != "0" && n_plantel != ("0") && usuario != "") {
                    if (n_plantel.equals("0")) {
                        request.setAttribute("consulta", "5");
                        //out.print("caso 5");//entidad y usuario
                    } else {
                        request.setAttribute("consulta", "6");
                        //out.print("caso 6"); //todos
                    }

                    //request.setAttribute("consulta", "4");
                }

                request.setAttribute("est", entidad);
                request.setAttribute("pla", n_plantel);
                request.setAttribute("usu", usuario);
                request.setAttribute("opc", "1");
                request.setAttribute("nom", nom1);
                request.setAttribute("dato_ent", ent1);
                request.setAttribute("dato_pla", pla1);
                request.setAttribute("dato_rfc", rfc1);
                request.setAttribute("per1", per1);
                request.setAttribute("per3", per3);
                request.setAttribute("per4", per4);
                RequestDispatcher rd = request.getRequestDispatcher("administracion_usuarios.jsp");
                rd.forward(request, response);
            } else {
                request.setAttribute("error", "Administrador No Registrado");
                RequestDispatcher rd = request.getRequestDispatcher("administracion_usuarios.jsp");
                rd.forward(request, response);
                //out.println("USUARIO NO REGISTRADOs");
            }

//            }
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
