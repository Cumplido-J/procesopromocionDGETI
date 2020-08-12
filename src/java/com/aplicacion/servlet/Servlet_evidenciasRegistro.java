/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.aplicacion.servlet;

import com.aplicacion.beans.Docente;
import correos.Validar_correo;
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
 * @author Iker Fernando
 */
@WebServlet(name = "RegistroRegistroEvidencias", urlPatterns = {"/RegistroRegistroEvidencias"})
public class Servlet_evidenciasRegistro extends HttpServlet {
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
            out.println("<title>Servlet Servlet_evidenciasRegistro</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet Servlet_evidenciasRegistro at " + request.getContextPath() + "</h1>");
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
        if(session.getAttribute("idUsuario")!=null&&session.getAttribute("rfc")!=null){
            docente=new Docente();
            docente.setIdUsuario(session.getAttribute("idUsuario").toString());
            docente.setRfc(session.getAttribute("rfc").toString());
            docente.consultaInfoAspirante();
            String datos[]=docente.getInfoRegistro();        
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
    //----------------------------------------------------------CREAR CUENTA
    Metodos_sql metodos = new Metodos_sql();
    Validar_correo validar = new Validar_correo();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("text/html;charset=ISO-8859-1");
        try (PrintWriter out = response.getWriter()) {

            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            //out.println("<title>Servlet Servlet_crearcuenta</title>");
            out.println("</head>");
            out.println("<body>");
            //HttpSession session = (HttpSession) request.getSession(true);
            String idUsuario = "";
            String rfc = "";
            
            HttpSession session= (HttpSession) request.getSession();  
            
            //if (session.getAttribute("idUsuario") != null && session.getAttribute("rfc") != null) {
                /*idUsuario = session.getAttribute("idUsuario").toString();
                rfc = session.getAttribute("rfc").toString();*/

                String antiguedad = request.getParameter("antiguedad");
                
                if (antiguedad != null) {
                    int datos1 = metodos.guardarAntiguedad(0, antiguedad, antiguedad);
                    //int datos2 = metodos.guardar3(0, telfijo, telcel, consideraciones);
                    //if (datos2 > 0 && datos1 > 0) {
                    if (datos1 > 0) {
                        session.setAttribute("idUsuario", idUsuario);
                        session.setAttribute("rfc", rfc);
                        RequestDispatcher rd = request.getRequestDispatcher("aviso_guardar.jsp");
                        rd.forward(request, response);
                        //response.sendRedirect("aviso_guardar.jsp");
                    } else {
                        out.print("DATOS NO GUARDADOS");
                    }

                }//fin presionar boton
            /*} else {
                response.sendRedirect("login.jsp");
            }*/
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
