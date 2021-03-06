/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.aplicacion.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
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
@WebServlet(name = "AltaConvocatoria", urlPatterns = {"/AltaConvocatoria"})
public class Servlet_cbAltaConvocatoria extends HttpServlet {

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
            out.println("<title>Servlet Servlet_cbAltaConvocatoria</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet Servlet_cbAltaConvocatoria at " + request.getContextPath() + "</h1>");
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
        HttpSession session= (HttpSession) request.getSession();     
        if(session.getAttribute("idUsuario")!=null){
            ServletContext sc = getServletContext();
            response.setContentType("text/html;charset=UTF-8");
            PrintWriter out = response.getWriter();
            RequestDispatcher rd;
            
            String idEntidad="";
            String idPlantel="";
            String idPrograma="";
            
                if(session.getAttribute("entidad")!=null && session.getAttribute("plantel")!=null){
                    idEntidad=session.getAttribute("entidad").toString();
                    idPlantel=session.getAttribute("plantel").toString();
                    idPrograma=session.getAttribute("programa").toString();
                    
                    String idSubsistema=session.getAttribute("subsistema").toString();
                    Metodos_sql metodo = new Metodos_sql();
                    List<String[]> datos;            
                    String[] parametros={idEntidad,idPlantel,idSubsistema,idPrograma};                                      
                    datos=metodo.ejecutaSP("sp_consultaCBase",parametros);
                    if(datos.isEmpty()){
                        rd = sc.getRequestDispatcher("/altaConvocatoria.jsp");
                        rd.forward(request,response);
                    }else{
                        request.setAttribute("informacion", datos.get(0));
                        rd = sc.getRequestDispatcher("/altaConvocatoria.jsp");
                        rd.forward(request,response);
                    }
                }else{
                    rd = sc.getRequestDispatcher("/altaConvocatoria.jsp");
                    rd.forward(request,response);
                }
        }else{
            response.sendRedirect("login.jsp");
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
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        HttpSession session= (HttpSession) request.getSession();     
        if(session.getAttribute("idUsuario")!=null){            
            ServletContext sc = getServletContext();
            RequestDispatcher rd;
            System.out.println("post alta convocatoria");
            if(request.getParameter("idConvocatoria")!=null){
                String id=request.getParameter("idConvocatoria").toString();
                Metodos_sql metodo = new Metodos_sql();
                List<String[]> datos;            
                String[] parametros={id};                                      
                datos=metodo.ejecutaSP("sp_consultaConvocatoria",parametros);
                request.setAttribute("informacion", datos.get(0));
                rd = sc.getRequestDispatcher("/cambioConvocatoria.jsp");
                System.out.println("post cambio convocatoria");
            }else{
                System.out.println("post cambio altaConvocatoria");
                rd = sc.getRequestDispatcher("/altaConvocatoria.jsp");
            }
            rd.forward(request,response);
        }else{
            response.sendRedirect("login.jsp");
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
