/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.aplicacion.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import javax.json.Json;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import metodos_sql.Metodos_sql;

/**
 *
 * @author Fernando
 */
@WebServlet(name = "Servlet_consultaConBase", urlPatterns = {"/Servlet_consultaConBase"})
public class Servlet_consultaConBase extends HttpServlet {

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
            out.println("<title>Servlet Servlet_consultaConBase</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet Servlet_consultaConBase at " + request.getContextPath() + "</h1>");
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
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        try {
            ServletContext sc = getServletContext();
            RequestDispatcher rd;
            
            String programa=request.getParameter("p");
            String subsistema=request.getParameter("s");
            String entidad=request.getParameter("e");
            String plantel=request.getParameter("k");
            
            String respuesta="";
            String json = "";
            String fecha1="";
            String fecha2="";
            String fecha3="";
            String fecha4="";
            String fecha5="";
            String fecha6="";
            String fecha7="";
            String fecha8="";
            
            Metodos_sql metodo = new Metodos_sql();
                List<String[]> datos;            
                String[] parametros={entidad,plantel,subsistema,programa};                                      
                datos=metodo.ejecutaSP("sp_consultaCBase",parametros);
                if(datos.isEmpty()){
                    json="No existe convocatoria base para esta combinación";
                }else{
                    //request.setAttribute("informacion", datos.get(0));
                    fecha1 = datos.get(0)[1];
                    fecha2 = datos.get(0)[2];
                    fecha3 = datos.get(0)[3];
                    fecha4 = datos.get(0)[4];
                    fecha5 = datos.get(0)[5];
                    fecha6 = datos.get(0)[6];
                    fecha7 = datos.get(0)[7];
                    fecha8 = datos.get(0)[8];
                    
                    json = Json.createObjectBuilder()
                    .add("key1", fecha1)
                    .add("key2", fecha2)
                    .add("key3", fecha3)
                    .add("key4", fecha4)
                    .add("key5", fecha5)
                    .add("key6", fecha6)
                    .add("key7", fecha7)
                    .add("key8", fecha8)
                    .build()
                    .toString();
                    
                }
            
            out.println(json);
                      
        }catch(Exception e){
            out.println(e);
        } 
        finally {
            out.close();
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
