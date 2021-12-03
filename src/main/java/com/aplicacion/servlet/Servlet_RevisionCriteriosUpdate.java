/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.aplicacion.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import metodos_sql.Metodos_sql;

/**
 *
 * @author orteg
 */
@WebServlet(name = "Servlet_RevisionCriteriosUpdate", urlPatterns = {"/Servlet_RevisionCriteriosUpdate"})
public class Servlet_RevisionCriteriosUpdate extends HttpServlet {

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
            out.println("<title>Servlet Servlet_RevisionCriteriosUpdate</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet Servlet_RevisionCriteriosUpdate at " + request.getContextPath() + "</h1>");
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
        processRequest(request, response);
        
        String parametro = request.getParameter("accion");
        parametro= (parametro==null) ? "updateTotal": parametro;
        try{
         switch(parametro){
                case "updateTotal": 
                    actualizacionPuntaje(request,response);    
                    break;
   
            }
        }catch(IOException | ServletException e){}
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

        private void actualizacionPuntaje(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
        try {
            Metodos_sql metodo=new Metodos_sql();
                    HttpSession session= (HttpSession) request.getSession();  
            String total=request.getParameter("total");
            String[] categoria=total.split("-");
            String consejo=categoria[0], evaluacion1=categoria[1], evaluacion2=categoria[2];
            String idUsuario = session.getAttribute("rol").toString().equals("D")?session.getAttribute("idUsuario").toString():session.getAttribute("idDocente").toString();
            String type = consejo.equals("CR") ? "1" : "2";
            String[] parametros = { idUsuario, evaluacion1, evaluacion2, type };
            metodo.ejecutaSP("sp_updatePuntaje",parametros);
            System.out.println("---------------------------------------------"+total);
        } finally {
           
        }
    }
}
