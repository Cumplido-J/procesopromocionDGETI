/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.aplicacion.servlet;

import herramientas.Comite;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import metodos_sql.Metodos_sql;

/**
 *
 * @author David Reyna
 */
@WebServlet(name = "RegistroComite", urlPatterns = {"/RegistroComite"})
public class Servlet_registroComite extends HttpServlet {

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
            out.println("<title>Servlet Servlet_registroComite</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet Servlet_registroComite at " + request.getContextPath() + "</h1>");
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
        try{
            PrintWriter out = response.getWriter();
            HttpSession session= (HttpSession) request.getSession();     
            /*if(session.getAttribute("idUsuario")!=null&&session.getAttribute("rfc")!=null){*/
                String[] datos=new String[8];
                Comite c=new Comite();
                if(request.getParameter("idComite")!=null){
                    String id=request.getParameter("idComite"); 
                    
                    datos=c.consultaComite(id);
                }
                else{                    
                    datos[0]=c.registraComite(request.getParameter("idPrograma"),request.getParameter("idTipo"),request.getParameter("idSubsistema"),  request.getParameter("idEntidad"),request.getParameter("idPlantel"));
                    
                    datos[0]=c.desplegarComite2(request.getParameter("idPrograma"),request.getParameter("idTipo"),request.getParameter("idSubsistema"),request.getParameter("idEntidad"),request.getParameter("idPlantel"));
                   
                    datos[1]=request.getParameter("idPrograma");
                    datos[2]=request.getParameter("idSubsistema");
                    datos[3]=request.getParameter("idEntidad");
                    datos[4]=request.getParameter("idPlantel");
                    datos[5]=request.getParameter("idTipo");
                    datos[6]="F";
                    datos[7]="";
                }
                session.setAttribute("idComite", datos[0]);
                session.setAttribute("idDocente", "comite"+datos[0]);
                session.setAttribute("rfcDocente", "-");
                request.setAttribute("datos", datos);
                request.setAttribute("aux", "comite"+datos[0]+"_19");
                ServletContext sc = getServletContext();
                RequestDispatcher rd = sc.getRequestDispatcher("/conformacionComite.jsp");
                rd.forward(request,response);
                                
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
