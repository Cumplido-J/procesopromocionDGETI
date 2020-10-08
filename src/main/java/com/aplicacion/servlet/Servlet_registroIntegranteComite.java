/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.aplicacion.servlet;

import com.aplicacion.beans.Docente;
import herramientas.Comite;
import herramientas.Correo;
import herramientas.Pin;
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
@WebServlet(name = "RegistroIntegranteComite", urlPatterns = {"/RegistroIntegranteComite"})
public class Servlet_registroIntegranteComite extends HttpServlet {

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
            out.println("<title>Servlet Servlet_registroIntegranteComite</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet Servlet_registroIntegranteComite at " + request.getContextPath() + "</h1>");
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
            /*HttpSession session= (HttpSession) request.getSession();     
            if(session.getAttribute("idUsuario")!=null&&session.getAttribute("rfc")!=null){*/
                String idComite=request.getParameter("idComite");
                String rfc=request.getParameter("rfc").toUpperCase();
                String nombre=request.getParameter("nombre").toUpperCase();
                String paterno=request.getParameter("apPaterno").toUpperCase();
                String materno=request.getParameter("apMaterno").toUpperCase();
                String correo=request.getParameter("correo").toLowerCase();
                String rol=request.getParameter("rol");
                //String[] p2={idUsuario,curp,correo,tipoEncuesta};
                Metodos_sql metodos=new Metodos_sql(); 
                
                String[] parametros={idComite,rfc,nombre,paterno,materno,correo,rol};
                List<String[]> retorno=null;                
                retorno=metodos.ejecutaSP("sp_insertMiembroComite",parametros);
                if(!retorno.isEmpty()){                    
                    if(retorno.get(0)[0].equals("ok")){                        
                        Comite c=new Comite();
                        out.print(c.desplegarIntegrantesComite(idComite));
                    }  
                    else{
                        out.print(retorno.get(0)[0]);
                    }
                }else{
                    out.print("Error de almacenamiento, intente más tarde");
                }
                    //out.print(retorno.get(0)[0].trim());
                
                /*List<String[]> retorno=metodos.ejecutaSP("sp_insertEncuestado",parametros);
                if(!retorno.isEmpty()){
                    out.print(retorno.get(0)[0].trim());
                }
                System.out.println(Pin.generaPin());*/
            //}
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
