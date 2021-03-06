/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.aplicacion.servlet;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileReader;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Enumeration;
import java.util.Properties;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author David Reyna
 */
@WebServlet(name = "Convocatoria", urlPatterns = {"/Convocatoria"})
public class Servlet_descargaConvocatoria extends HttpServlet {

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
            out.println("<title>Servlet Servlet_descargaConvocatoria</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet Servlet_descargaConvocatoria at " + request.getContextPath() + "</h1>");
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
        try {            
            Properties p = new Properties();
            p.load(new FileReader(request.getServletContext().getInitParameter("rutaConfig")));
            String ruta=p.getProperty("path_pdfs");
            /*HttpSession session= (HttpSession) request.getSession();
            String idUsuario=session.getAttribute("idUsuario").toString();
            String idDocumento="0";     */       
            File documento;
            String fichero=request.getParameter("k").toString();            
            ruta+=fichero;
            documento=new File(ruta);
            if(documento.exists()){
                FileInputStream fis=new FileInputStream(documento.getPath());
                int tamanio=fis.available();
                byte[] datos=new byte[tamanio];
                fis.read(datos,0,tamanio);
                response.setHeader("Content-disposition","inline; filename=documento.pdf");
                response.setContentType("application/pdf");
                response.setContentLength(tamanio);
                response.getOutputStream().write(datos);
                fis.close();
            }else{
                PrintWriter out = response.getWriter();
                response.setContentType("text/html;charset=UTF-8");
                out.println("<h1>El archivo solicitado no existe</h1>");
                out.close();
            }
        } finally {
            
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
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
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
