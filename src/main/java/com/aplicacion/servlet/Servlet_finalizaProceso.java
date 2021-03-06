/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.aplicacion.servlet;

import java.io.IOException;
import java.io.PrintWriter;
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
public class Servlet_finalizaProceso extends HttpServlet {

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
            out.println("<title>Servlet Servlet_finalizaProceso</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet Servlet_finalizaProceso at " + request.getContextPath() + "</h1>");
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
        HttpSession session= (HttpSession) request.getSession();     
        if(session.getAttribute("rol")!=null){
            String idUsuario,rfc,totalEncuestados,retorno,observacion="",total="",idPermiso="";
            idPermiso = session.getAttribute("permisoActual").toString();
            if(session.getAttribute("rol").toString().equals("D")){
                idUsuario=session.getAttribute("idUsuario").toString();
                rfc=session.getAttribute("rfc").toString();
                retorno="SesionDocente";
            }else{
                idUsuario=session.getAttribute("idDocente").toString();                
                rfc=session.getAttribute("rfcDocente").toString();
                retorno="VistaDocente";
                observacion=request.getParameter("observaciones");
                total=request.getParameter("evaluacion");
            }           
            totalEncuestados=session.getAttribute("totalEncuestados").toString();
            Metodos_sql metodo=new Metodos_sql();
            byte ptext[] = observacion.getBytes("ISO-8859-1"); 
            String value = new String(ptext, "UTF-8");
            String[] parametros={idUsuario,totalEncuestados,value,total,idPermiso};
            metodo.ejecutaSP("sp_finProceso",parametros);
            String[] parametros1={idUsuario};
            metodo.ejecutaSP("sp_insertAspiranteClon",parametros1);
            response.sendRedirect(retorno);
            /*if(completo.equals("true")){
                response.sendRedirect("evidenciaRegistroDocentes.html");
            }else{
                response.sendRedirect("FichaRegistroIncompleto");
            }*/
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
