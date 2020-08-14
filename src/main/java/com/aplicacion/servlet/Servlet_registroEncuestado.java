/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.aplicacion.servlet;

import correos.Enviar_clave;
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
@WebServlet(name = "RegistroEncuestado", urlPatterns = {"/RegistroEncuestado"})
public class Servlet_registroEncuestado extends HttpServlet {

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
            out.println("<title>Servlet Servlet_registrarEncuestado</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet Servlet_registrarEncuestado at " + request.getContextPath() + "</h1>");
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
            HttpSession session= (HttpSession) request.getSession();     
            if(session.getAttribute("idUsuario")!=null&&session.getAttribute("rfc")!=null){
                String idUsuario=session.getAttribute("idUsuario").toString();
                String rfc=session.getAttribute("rfc").toString();
                String curp=request.getParameter("curp");
                String correo=request.getParameter("correo");
                String tipoEncuesta=request.getParameter("tipoEncuesta");
                //String[] p2={idUsuario,curp,correo,tipoEncuesta};
                Metodos_sql metodos=new Metodos_sql(); 
                Correo c=new Correo();
                String[] parametros=new String[1];
                List<String[]> retorno=null;
                do{
                    parametros[0]=Pin.generaPin();
                    retorno=metodos.ejecutaSPEncuestas("sp_selectLecturaUrl",parametros);
                }while(!retorno.isEmpty());
                
                String[] parametros2={rfc,curp,parametros[0],tipoEncuesta,correo};
                retorno=metodos.ejecutaSPEncuestas("sp_insertLecturaUrl",parametros2);
                if(!retorno.isEmpty()){                    
                    if(retorno.get(0)[0].equals("ok")){                        
                        c.enviarCorreo("Envío de PIN","El PIN de acceso asignado es:"+parametros[0], correo);
                    }
                    out.print(retorno.get(0)[0]);
                }else{
                    out.print("Error de almacenamiento, intente más tarde");
                }
                    //out.print(retorno.get(0)[0].trim());
                
                /*List<String[]> retorno=metodos.ejecutaSP("sp_insertEncuestado",parametros);
                if(!retorno.isEmpty()){
                    out.print(retorno.get(0)[0].trim());
                }
                System.out.println(Pin.generaPin());*/
            }
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