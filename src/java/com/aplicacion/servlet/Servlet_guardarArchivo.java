/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.aplicacion.servlet;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;
import metodos_sql.Metodos_sql;

/**
 *
 * @author David Reyna
 */
@WebServlet(name = "GuardarArchivo", urlPatterns = {"/GuardarArchivo"})
@MultipartConfig
public class Servlet_guardarArchivo extends HttpServlet {

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
        PrintWriter out = response.getWriter();
        try {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet Servlet_guardarArchivo</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet Servlet_guardarArchivo at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        } finally {
            out.close();
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
        PrintWriter out = response.getWriter();
        try{
            HttpSession session= (HttpSession) request.getSession();
            String idUsuario=session.getAttribute("idUsuario").toString();
            
            String idRequisito=request.getParameter("idArchivo");
            
            Part archivo=request.getPart("archivo");
            InputStream is=archivo.getInputStream();
            
            File carpeta = new File("C:/ArchivosPromocion");
            if (!carpeta.exists()) {
                carpeta.mkdirs();                    
            }
            String ruta=carpeta+"/"+idUsuario+"_"+idRequisito+".pdf";
            File f=new File(ruta);
            FileOutputStream ous=new FileOutputStream(f);
            int dato=is.read();
            while(dato!=-1){
                ous.write(dato);
                dato=is.read();
            }
            ous.close();
            is.close();
            
            Metodos_sql metodo = new Metodos_sql();
            String[] parametros={idUsuario,idRequisito,ruta};
            List<String[]> datos;                           
            datos=metodo.ejecutaSP("sp_registroConstancia",parametros);            
            if(!datos.isEmpty()){
                out.print("ok");
            }else{
                out.print("Error en almacenamiento de datos, intente nuevamente");
            }
            
        }finally{
            out.close();
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
