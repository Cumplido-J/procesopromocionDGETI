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
import java.util.regex.Matcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import metodos_sql.Metodos_sql;
import org.apache.commons.codec.digest.DigestUtils;
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
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet Servlet_crearcuenta</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet Servlet_crearcuenta at " + request.getContextPath() + "</h1>");
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

        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {

            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            //out.println("<title>Servlet Servlet_crearcuenta</title>");
            out.println("</head>");
            out.println("<body>");
            int id = 0;
            String nombre = request.getParameter("nombre");
            String apellido = request.getParameter("apellido");
            String correo = request.getParameter("correo");
            String clave = request.getParameter("clave");
            String claveEncriptada = "";
            claveEncriptada = Encriptar_Desencriptar.encriptar(clave);
            //String claveencriptMD5 = DigestUtils.md5Hex(clave);
            String btnlogin = request.getParameter("crearcuenta");
            if (btnlogin != null) {
                Matcher comparar = validar.validar_correo(correo);
                if (comparar.find() == true) {
                    int i = metodos.guardar(id, nombre, apellido, correo, claveEncriptada);
                    if (i > 0) {
                        out.print("DATOS GUARDADOS");
                    } else {
                        out.print("DATOS NO GUARDADOS");
                    }
                }//fin comparar
                else
                {
                    out.println("ESCRIBE BIEN TU CORREO");
                }
            }//fin presionar boton
            // out.println("<h1>Servlet Servlet_crearcuenta at " + request.getContextPath() + "</h1>");
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
