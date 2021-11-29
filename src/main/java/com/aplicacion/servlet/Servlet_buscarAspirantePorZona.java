/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.aplicacion.servlet;

import herramientas.Datos;
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
 * @author Jonathan Trinidad de Lazaro
 */
@WebServlet(name = "aspirantePorZona", urlPatterns = {"/aspirantePorZona"})
public class Servlet_buscarAspirantePorZona extends HttpServlet {

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
            out.println("<title>Servlet Servlet_buscarAspirantePorZona</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet Servlet_buscarAspirantePorZona at " + request.getContextPath() + "</h1>");
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
        try{
            PrintWriter out = response.getWriter();
            HttpSession session= (HttpSession) request.getSession();
                String id=request.getParameter("id");
                String programa=request.getParameter("programa");
                String subsistema=request.getParameter("subsistema");
                String entidad=request.getParameter("entidad");
                String plantel=request.getParameter("plantel");
                String categoria=request.getParameter("categoria");
//              String jornada=request.getParameter("jornada");
                String vacancia=request.getParameter("vacancia");
                String periodo=request.getParameter("periodo");
                String zonaEconomica=request.getParameter("zonaEconomica");
                Datos d=new Datos();
//                if(entidad.isEmpty() && plantel.isEmpty()){
                int idProceso=Integer.parseInt(entidad);
                if(id.equals("r")){
                    if(idProceso==0){
                        out.print(d.generarResultadosZonaEconomica(programa,subsistema,entidad,plantel,vacancia,periodo));
                    }else{
                        out.print(d.generarResultadosZonaEconomicaPorEntidad(programa,subsistema,entidad,plantel,vacancia,periodo));
                    }
                }else{
//                    out.print(d.desplegarAspirantesPorZona(id, programa, subsistema, entidad, plantel, categoria, jornada, vacancia, periodo));
//                    out.print(d.desplegarAspirantesZona(id,programa,subsistema,entidad,periodo,vacancia,zonaEconomica,categoria));
                    out.print(d.desplegarAspirantesZona(id,programa,subsistema,entidad,periodo,vacancia,zonaEconomica,categoria));
                }
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
