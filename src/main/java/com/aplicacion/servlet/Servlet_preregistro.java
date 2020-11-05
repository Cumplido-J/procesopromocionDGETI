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
import javax.servlet.http.HttpSession;
import metodos_sql.Metodos_sql;

/**
 *
 * @author David Reyna
 */
@WebServlet(name = "Preregistro", urlPatterns = {"/Preregistro"})
public class Servlet_preregistro extends HttpServlet {

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
            out.println("<title>Servlet Servlet_preregistro</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet Servlet_preregistro at " + request.getContextPath() + "</h1>");
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
        try {    
            String programa=request.getParameter("programa");
            String subsistema=request.getParameter("subsistema");
            String rfc=request.getParameter("rfc");
            String nombre=request.getParameter("nombre");
            String apellido1=request.getParameter("apellido1");
            String apellido2=request.getParameter("apellido2");
            String entidad=request.getParameter("entidad");
            String plantel=request.getParameter("plantel");
            String fijo=request.getParameter("fijo"); 
            String movil=request.getParameter("movil"); 
            String correo=request.getParameter("correo");
            String consideraciones=request.getParameter("consideraciones"); 
            String pass1=request.getParameter("pass1"); 
            String perfil="D";
            String respuesta="Error en almacenamiento de datos, intente nuevamente";
            Metodos_sql metodo = new Metodos_sql();
            List<String[]> datos; 
            String[] parametros1={plantel,programa};
            datos=metodo.ejecutaSP("sp_countRegistrosVacancia",parametros1);
            if(!datos.isEmpty()){
                if(!datos.get(0)[0].equals("0")){
                    String[] parametros2={entidad,plantel,nombre,apellido1,apellido2,correo,pass1,rfc,fijo,movil,perfil,consideraciones,"P",subsistema,programa};                                      
                    datos=metodo.ejecutaSP("sp_insertUsuario",parametros2);            
                    if(!datos.isEmpty()){
                        respuesta=datos.get(0)[0];                    
                    }
                }else{
                    respuesta="No existe convocatoria abierta para esta solicitud";
                }
            }
            out.print(respuesta);
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
