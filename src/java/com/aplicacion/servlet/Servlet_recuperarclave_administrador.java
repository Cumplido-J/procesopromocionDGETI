/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.aplicacion.servlet;

import correos.Enviar_clave;
import herramientas.Correo;
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
@WebServlet(name = "Servlet_recuperarclave_administrador", urlPatterns = {"/Servlet_recuperarclave_administrador"})
public class Servlet_recuperarclave_administrador extends HttpServlet {

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
            out.println("<title>Servlet Servlet_recuperarclave_administrador</title>");            
            out.println("</head>");
            out.println("<body>");
          RequestDispatcher rd = request.getRequestDispatcher("login.jsp");
            rd.forward(request, response);
            out.println("</body>");
            out.println("</html>");
        }catch(Exception e){
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
    Correo mail = new Correo();
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title></title>");
            out.println("</head>");
            out.println("<body>");
            String correo = request.getParameter("correo");
            System.out.println(correo);
            //String btnlogin = request.getParameter("recuperarclaveadmin");
            //if (btnlogin != null) {
                String busquedacorreo = metodos.buscarcorreoadmin(correo);
                if (correo.equals("root")) {
                    out.println("ADMINISTTRADOR");
                }//fin if root
                else if (busquedacorreo.equals("USUARIO ENCONTRADO")) {
                    String busqueda_clave = metodos.buscarclaveadmin(correo);
                    String claveDesencriptada = Encriptar_Desencriptar.desencriptar(busqueda_clave);
                    //mail.enviar_correo(claveDesencriptada, correo);
                    mail.enviarCorreo("Recuperación de contraseña","Su contraseña es:"+claveDesencriptada, correo);
                    //response.sendRedirect("administradores.jsp");
                    request.setAttribute("error", "Contraseña enviada");
                    RequestDispatcher rd = request.getRequestDispatcher("recuperar_contraseña_administrador.jsp");
                    rd.forward(request, response);
                } 
                else {
                    request.setAttribute("error", "Correo No Registrado");
                    RequestDispatcher rd = request.getRequestDispatcher("recuperar_contraseña_administrador.jsp");
                    rd.forward(request, response);
                    //out.println("USUARIO NO REGISTRADO");
                }

            //}
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
