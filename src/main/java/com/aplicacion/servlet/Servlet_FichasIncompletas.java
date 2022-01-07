/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.aplicacion.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import metodos_sql.Metodos_sql;

/**
 *
 * @author orteg
 */
@WebServlet(name = "Servlet_FichasIncompletas", urlPatterns = {"/Servlet_FichasIncompletas"})
public class Servlet_FichasIncompletas extends HttpServlet {

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
            out.println("<title>Servlet Servlet_FichasIncompletas</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet Servlet_FichasIncompletas at " + request.getContextPath() + "</h1>");
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
        
        String parametro = request.getParameter("accion");
        parametro= (parametro==null) ? "": parametro;
        
        try{
            switch(parametro){
                case "registroFichaIncompleta1": 
                    registroFichaIncompleta1(request,response);    
                break;
                
                case "registroFichaIncompleta2": 
                    registroFichaIncompleta2(request,response);    
                break;
                
                case "registroFichaIncompleta3": 
                    registroFichaIncompleta3(request,response);    
                break;
                
                case "registroFichaIncompleta4": 
                    registroFichaIncompleta4(request,response);    
                break;
            }
        }catch(Exception e){
            System.out.println("Servlet_FichasIncompletas : " + e);
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

    private void registroFichaIncompleta1(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
        Metodos_sql metodo=new Metodos_sql();
        List<String[]> datos; 
        try{
            String idUsuario = request.getParameter("idUsuario");
            String[] parametros={idUsuario, "Cuenta con un cargo Directivo, Subdirector o Jefe de Departamento" };
            datos=metodo.ejecutaSP("sp_insertFichaIncompleta",parametros);
        }catch(Exception e){
            System.out.println("Error :Servlet_FichasIncompletas1 :" +e);
        }
    }
    
    private void registroFichaIncompleta2(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
        Metodos_sql metodo=new Metodos_sql();
        List<String[]> datos; 
        try{
            String idUsuario = request.getParameter("idUsuario");
            String[] parametros={idUsuario, "No cuenta con la compatibilidad de carta protesta" };
            datos=metodo.ejecutaSP("sp_insertFichaIncompleta",parametros);
        }catch(Exception e){
            System.out.println("Error :Servlet_FichasIncompletas1 :" +e);
        }
    }
    
    
    private void registroFichaIncompleta3(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
        Metodos_sql metodo=new Metodos_sql();
        List<String[]> datos; 
        try{
            String idUsuario = request.getParameter("idUsuario");
            String[] parametros={idUsuario, "Se registro una categoria inadecuada en cambio de horas" };
            datos=metodo.ejecutaSP("sp_insertFichaIncompleta",parametros);
        }catch(Exception e){
            System.out.println("Error :Servlet_FichasIncompletas1 :" +e);
        }
    }
    
    private void registroFichaIncompleta4(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
        Metodos_sql metodo=new Metodos_sql();
        List<String[]> datos; 
        try{
            String idUsuario = request.getParameter("idUsuario");
            String[] parametros={idUsuario, "Se registro una catidad mayor a 19 horas" };
            datos=metodo.ejecutaSP("sp_insertFichaIncompleta",parametros);
        }catch(Exception e){
            System.out.println("Error :Servlet_FichasIncompletas1 :" +e);
        }
    }
}
