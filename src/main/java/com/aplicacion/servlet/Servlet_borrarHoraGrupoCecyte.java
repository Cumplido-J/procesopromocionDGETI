/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.aplicacion.servlet;

import com.aplicacion.beans.Docente;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author Fernando
 */
@WebServlet(name = "BorrarHoraGrupoCecyte", urlPatterns = {"/BorrarHoraGrupoCecyte"})
public class Servlet_borrarHoraGrupoCecyte extends HttpServlet {

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
            out.println("<title>Servlet Servlet_borrarHoraGrupoCecyte</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet Servlet_borrarHoraGrupoCecyte at " + request.getContextPath() + "</h1>");
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
        //processRequest(request, response);
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        HttpSession session= (HttpSession) request.getSession();     
        if(session.getAttribute("rol")!=null){
            String idUsuario;
            if(session.getAttribute("rol").toString().equals("D")){
                idUsuario=session.getAttribute("idUsuario").toString();
            }else{
                idUsuario=session.getAttribute("idDocente").toString();
            }
            String id=request.getParameter("i");
            Docente d=new Docente();
            d.setIdUsuario(idUsuario);
            d.borraHorascCecyte(id);
            d.consultaHorasCecyte();
            
            /*Metodos_sql metodos=new Metodos_sql();
            String descripcion="El usuario con id "+idUsuario+" elimino la información de horas con id "+id;
            String[] parametros={idUsuario,"A",descripcion};
            metodos.ejecutaSP("sp_insertBitacora", parametros);*/
            
            String respuesta="";
            int horas=d.getTotalHorasCecyte();
            int grupos=d.getNumGruposCecyte();
            respuesta=d.mostrarHorasCecyte();
            respuesta+="|"+horas+"|"+grupos;
            out.println(respuesta);
        }        
        out.close();
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
