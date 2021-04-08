/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.aplicacion.servlet;

import herramientas.Datos;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import metodos_sql.Metodos_sql;

/**
 *
 * @author jtrinidadl
 */
@WebServlet(name = "borrarUsuario", urlPatterns = {"/borrarUsuario"})
public class Servlet_borrarUsuario extends HttpServlet {

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
            out.println("<title>Servlet Servlet_borrarUsuario</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet Servlet_borrarUsuario at " + request.getContextPath() + "</h1>");
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
        PrintWriter out = response.getWriter();
        try{
            HttpSession session= (HttpSession) request.getSession();
            Metodos_sql metodo = new Metodos_sql();
            String rfc="";
            rfc = session.getAttribute("rfc").toString();
            if(request.getParameter("id")!= null){
                String id=request.getParameter("id");
                String programa=request.getParameter("programa");
                String subsistema=request.getParameter("subsistema");
                String entidad=request.getParameter("entidad");
                String plantel=request.getParameter("plantel");
                String usuario=request.getParameter("usuario")==null?"":request.getParameter("usuario");
                String tusuario=request.getParameter("tusuario");
                
                String[] parametros={id};
                String[] parametrosEliminado={id,rfc,tusuario};
                    List<String[]> datos;
                    datos=metodo.ejecutaSP("sp_insertbitacorausuarioeliminado",parametrosEliminado);
                    if(tusuario.equals("D")){
                        datos=metodo.ejecutaSP("sp_borraAspirante",parametros);
                    }else{
                        datos=metodo.ejecutaSP("sp_borraAdmin",parametros);
                    }
                    
                    String informacion=new Datos().desplegarUsuarios(programa, subsistema, entidad, plantel, usuario, tusuario);
                    out.print(informacion);
            }
        } finally {
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
