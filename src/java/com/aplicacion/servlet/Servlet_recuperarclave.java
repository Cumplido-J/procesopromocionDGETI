package com.aplicacion.servlet;

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
import correos.Enviar_clave;
import java.io.IOException;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
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
@WebServlet(urlPatterns = {"/Servlet_recuperarclave"})
public class Servlet_recuperarclave extends HttpServlet {

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
            out.println("<title>Servlet Servlet_recuperarclave</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet Servlet_recuperarclave at " + request.getContextPath() + "</h1>");
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
    Enviar_clave mail = new Enviar_clave();
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet Servlet_recuperarclave</title>");
            out.println("</head>");
            out.println("<body>");
            String correo = request.getParameter("correo");
            String btnlogin = request.getParameter("recuperarclave");
            if (btnlogin != null) {
                String busquedacorreo = metodos.buscarcorreo(correo);
                if (correo.equals("root")) {
                    out.println("ADMINISTTRADOR");
                }//fin if root
                else if (busquedacorreo.equals("USUARIO ENCONTRADO")) {
                    String busqueda_clave = metodos.buscarclave(correo);
                     String claveDesencriptada = Encriptar_Desencriptar.desencriptar(busqueda_clave);
                     mail.enviar_correo(claveDesencriptada,correo);
                    out.println("Bienvenido, tu Clave es: " + claveDesencriptada);
                } else {
                    out.println("USUARIO NO REGISTRADO");
                }

            }
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
