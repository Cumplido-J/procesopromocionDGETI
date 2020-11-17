/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.aplicacion.servlet;

import constants.ConstantsWS;
import herramientas.Correo;
import herramientas.UtileriasHelper;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import metodos_sql.Metodos_sql;

/**
 *
 * @author David Reyna
 */
public class Servlet_recuperacionContrasena extends HttpServlet {

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
            out.println("<title>Servlet Servlet_recuperacionContrasena</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet Servlet_recuperacionContrasena at " + request.getContextPath() + "</h1>");
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
        try (PrintWriter out = response.getWriter()) {
            String rfc = request.getParameter("rfc");
            Metodos_sql metodos=new Metodos_sql();
            String[] parametros={rfc};
            List<String[]> datos=metodos.ejecutaSP("sp_consultaInfoLogin",parametros);
            String respuesta;
            if(!datos.isEmpty()){
                String contrasena=datos.get(0)[5];
                UtileriasHelper utilerias = new UtileriasHelper();
                String pass = utilerias.desencriptarCodigo(contrasena, ConstantsWS.LLAVE_CIFRADO);
                
                String correo=datos.get(0)[13];
                Correo c=new Correo();
                c.enviarCorreo("Envío de contraseña","Usted ha solicitado el envío de datos de acceso al Sistema de Promoción Docente. <br/>Los datos son: <br/> Usuario: <b>"+rfc+"</b><br/>Contrase&ntilde;a:<b>"+pass+"</b>", correo);
                respuesta="Datos de acceso enviados al correo: "+correo;  
            }
            else{ 
                respuesta="El usuario no existe";                
            }
            request.setAttribute("error", respuesta);
            RequestDispatcher rd = request.getRequestDispatcher("recuperar_contraseña.jsp");
            rd.forward(request, response);
        }catch(Exception e){
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
