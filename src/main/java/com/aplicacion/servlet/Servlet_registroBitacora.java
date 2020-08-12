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
import metodos_sql.Metodos_sql;

/**
 *
 * @author David Reyna
 */
@WebServlet(name = "RegistroBitacora", urlPatterns = {"/RegistroBitacora"})
public class Servlet_registroBitacora extends HttpServlet {

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
        PrintWriter out = response.getWriter();
        try {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet Servlet_registroBitacora</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet Servlet_registroBitacora at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        } finally {
            out.close();
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
            /* TODO output your page here. You may use following sample code. */
            String idUsuario=request.getParameter("idUsuario");
            String descripcion=request.getParameter("rfc")+":"+request.getParameter("descripcionBitacora"); 
            String idHora=request.getParameter("idHora");
            String movimiento="A";
            Metodos_sql metodos=new Metodos_sql();
            System.out.println(idHora);
            if(!idHora.isEmpty()){
                String confirmacion;
                movimiento="C";
                if(idHora.contains("-")){
                    idHora=idHora.replace("-","");
                    confirmacion="F";
                }else{
                    confirmacion="V";
                }
                String[] parametros={idHora,confirmacion};
                metodos.ejecutaSP("sp_registraConfirmacionHora", parametros);
                descripcion+="idHora:"+idHora;
                //out.println(idHora);                
                Docente d=new Docente();
                d.setIdUsuario(idUsuario);                
                d.consultaHoras();
                String respuesta="";
                int horas=d.getTotalHoras();
                int grupos=d.getNumGrupos();
                respuesta=d.mostrarHoras();
                respuesta+="|"+horas+"|"+grupos;
                out.println(respuesta);                
            }
            String[] parametros2={idUsuario,movimiento,descripcion};
            metodos.ejecutaSP("sp_insertBitacora", parametros2);
            //out.println(respuesta);
                      
        }catch(Exception e){
            out.println(e);
        } 
        finally {
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
