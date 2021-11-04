/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.aplicacion.servlet;

import herramientas.Datos;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author orteg
 */
@WebServlet(name = "Servlet_compruebaregistro", urlPatterns = {"/Servlet_compruebaregistro"})
public class Servlet_compruebaregistro extends HttpServlet {

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
            out.println("<title>Servlet Servlet_compruebaregistro</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet Servlet_compruebaregistro at " + request.getContextPath() + "</h1>");
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
        String parametro = request.getParameter("accion");
        parametro= (parametro==null) ? "compruebaregistroCDC": parametro;
        
        HttpSession session= (HttpSession) request.getSession();
        String idUsuario="";
        if(session.getAttribute("rol")!=null){
            idUsuario = session.getAttribute("rol").toString().equals("D") 
                    ? session.getAttribute("idUsuario").toString()
                    : session.getAttribute("idDocente").toString();      
        }
        try{
        switch( parametro ){
                case "compruebaregistroCDC": 
                    compruebaRegistroCDC(request,response,idUsuario);    
                break;
            }
        }catch(IOException | ServletException e){
            System.out.println("Error: Servlet_compruebaregistro --> "+e);
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

    private void compruebaRegistroCDC(HttpServletRequest request, HttpServletResponse response, String idUsuario) throws ServletException, IOException{
        PrintWriter out = response.getWriter();

        String respuesta = "ok";

            ArrayList<String> confirmacionPlaza=new Datos().validacionComboPlazaQueParticipaCDC(idUsuario);
            
            if (confirmacionPlaza.get(1).length()>1){
                respuesta=confirmacionPlaza.get(1);
            }else{
                respuesta = confirmacionPlaza.get(0).equals("true") ? "ok" :"Existe una incompatibilidad en la plaza que aspira con la plaza que obstenta, valide la informacion de plazas  oprimimiendo el boton guardar y continuar en la informacion laboral y finalmente continuar"; 
                
            }
            out.print(respuesta);
    }
}
