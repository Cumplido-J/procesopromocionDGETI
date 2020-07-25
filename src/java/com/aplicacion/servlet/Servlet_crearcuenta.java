
/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.aplicacion.servlet;

import correos.Validar_correo;
import java.io.IOException;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.sql.Date;
import java.util.regex.Matcher;
//import javafx.scene.control.Alert;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.swing.JOptionPane;
import metodos_sql.Metodos_sql;
//import org.apache.commons.codec.digest.DigestUtils;
import seguridad.Encriptar_Desencriptar;

/**
 *
 * @author charl
 */
@WebServlet(name = "Servlet_crearcuenta", urlPatterns = {"/Servlet_crearcuenta"})
public class Servlet_crearcuenta extends HttpServlet {

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
        response.setContentType("text/html;charset=ISO-8859-1");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet Servlet_crearcuenta</title>");
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
            String telfijo = request.getParameter("telfijo");
            String telcel = request.getParameter("telcel");
            String perfil = "D";

            String consideraciones = request.getParameter("texto");
            String programa = request.getParameter("programa");
            String entidad = request.getParameter("campoentidad7");
            String plantel = request.getParameter("n_plantel");
            String nombre = request.getParameter("Nombre");
            String primerApellido = request.getParameter("primerApellido");
            String segundoApellido = request.getParameter("segundoApellido");
            String correo = request.getParameter("correo");
            String clave = request.getParameter("clave");
            String rfc = request.getParameter("rfc");
            String claveEncriptada = "";
            claveEncriptada = Encriptar_Desencriptar.encriptar(clave);
            String btnlogin = request.getParameter("crearcuenta");
            if (btnlogin != null) {
                int datos1 = metodos.guardar2(0, programa, entidad, plantel, nombre, primerApellido, segundoApellido, correo, claveEncriptada, rfc, telfijo, telcel, perfil, consideraciones);
                //int datos2 = metodos.guardar3(0, telfijo, telcel, consideraciones);
                //if (datos2 > 0 && datos1 > 0) {
                if (datos1 > 0) {
                    response.sendRedirect("login.jsp");
                } else {
                    out.print("DATOS NO GUARDADOS");
                }

            }//fin presionar boton

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
