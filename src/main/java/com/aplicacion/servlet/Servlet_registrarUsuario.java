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
 * @author David Reyna
 */
@WebServlet(name = "RegistrarUsuario", urlPatterns = {"/RegistrarUsuario"})
public class Servlet_registrarUsuario extends HttpServlet {

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
            out.println("<title>Servlet Servlet_registrarUsuario</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet Servlet_registrarUsuario at " + request.getContextPath() + "</h1>");
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
            String nivel=request.getParameter("nivel");            
            String usuario=request.getParameter("usuario");
            String nombre=request.getParameter("nombre");
            String apellido1=request.getParameter("apellido1");
            String apellido2=request.getParameter("apellido2");
            String entidad=request.getParameter("entidad");
            String plantel=request.getParameter("plantel");
            String fijo=request.getParameter("fijo"); 
            String movil=request.getParameter("movil"); 
            String correo=request.getParameter("correo");
            String consideraciones=""; 
            String pass1=request.getParameter("pass1"); 
            String permisos=request.getParameter("permisos");
            String[] aux=permisos.split(";");
            
            String perfil="A";
            String respuesta="Error en almacenamiento de datos, intente nuevamente";
            Metodos_sql metodo = new Metodos_sql();
            List<String[]> datos;            
            String[] parametros={entidad,plantel,nombre,apellido1,apellido2,correo,pass1,usuario,fijo,movil,perfil,consideraciones,nivel,subsistema,programa};                                      
            datos=metodo.ejecutaSP("sp_insertUsuario",parametros);            
            if(!datos.isEmpty()){
                respuesta=datos.get(0)[0]; 
                parametros=new String[3];
                parametros[0]="";
                parametros[1]=usuario;                
                if(respuesta.equals("ok")){
                    for (String i : aux) {
                        parametros[2]=i;
                        datos=metodo.ejecutaSP("sp_insertUsuarioPermiso",parametros);                        
                    }
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
