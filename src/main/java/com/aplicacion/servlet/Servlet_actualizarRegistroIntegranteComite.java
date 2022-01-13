/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.aplicacion.servlet;

import herramientas.Comite;
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
import org.json.JSONObject;

/**
 *
 * @author Jonathan Trinidad de Lazaro
 */
@WebServlet(name = "Servlet_actualizarRegistroIntegranteComite", urlPatterns = {"/actualizarRegistroIntegranteComite"})
public class Servlet_actualizarRegistroIntegranteComite extends HttpServlet {

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
            out.println("<title>Servlet Servlet_actualizarRegistroIntegranteComite</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet Servlet_actualizarRegistroIntegranteComite at " + request.getContextPath() + "</h1>");
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
                HttpSession session= (HttpSession) request.getSession();
                String permisoEdicion = session.getAttribute("permisoEdicion").toString();
                String idComite=request.getParameter("idComite");
                String rfc=request.getParameter("rfcEditar").toUpperCase();
                String nombre=request.getParameter("nombreEditar").toUpperCase();
                String paterno=request.getParameter("apPaternoEditar").toUpperCase();
                String materno=request.getParameter("apMaternoEditar").toUpperCase();
                String correo=request.getParameter("correoEditar").toLowerCase();
                String rol=request.getParameter("rolEditar");
                //String[] p2={idUsuario,curp,correo,tipoEncuesta};
                Metodos_sql metodos=new Metodos_sql(); 
                
                String[] parametros={idComite,rfc,nombre,paterno,materno,correo,rol};
                List<String[]> retorno=null;                
                retorno=metodos.ejecutaSP("sp_updatetMiembroComite",parametros);
                if(!retorno.isEmpty()){
                    Comite c=new Comite();
                    JSONObject json=new JSONObject();
                    if(retorno.get(0)[0].equals("ok")){
                        json.put("id", "1");
                        json.put("mensaje", retorno.get(0)[0]);
                        json.put("resgistros", c.desplegarIntegrantesComite(idComite,permisoEdicion));
                        out.print(json.toString());
                    }  
                    else{
                        json.put("id", "2");
                        json.put("mensaje", retorno.get(0)[0]);
                        json.put("resgistros","");
                        out.print(json.toString());
                    }
                }else{
                    out.print("Error de almacenamiento, intente más tarde");
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
