/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.aplicacion.servlet;

import com.google.gson.Gson;
import constants.ConstantsWS;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import metodos_sql.Metodos_sql;
import org.json.JSONException;
import org.json.JSONObject;

/**
 *
 * @author Jonathan Trinidad de Lazaro
 */
@WebServlet(name = "Servlet_consultarMienbroComitePorId", urlPatterns = {"/consultarMienbroComitePorId"})
public class Servlet_consultarMienbroComitePorId extends HttpServlet {

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
            out.println("<title>Servlet Servlet_consultarMienbroComitePorId</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet Servlet_consultarMienbroComitePorId at " + request.getContextPath() + "</h1>");
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
        try {
            PrintWriter out = response.getWriter();
            String id=request.getParameter("id");
            Metodos_sql metodo = new Metodos_sql();
            JSONObject json=new JSONObject();
            String[] parametros={id};
            List<String[]> datos;
            datos=metodo.ejecutaSP("sp_consultarMiembroComitePorId",parametros);
            
            String rfc=datos.get(0)[2];
            String nombre=datos.get(0)[3];
            String primerApellido=datos.get(0)[4];
            String segundoApellido=datos.get(0)[5];
            String correo=datos.get(0)[6];
            String rol=datos.get(0)[7];
            
            
            json.put("rfc",rfc);
            json.put("nombre",nombre);
            json.put("primerApellido",primerApellido);
            json.put("segundoApellido",segundoApellido);
            json.put("correo",correo);
            json.put("rol",rol);
            
            out.print(json.toString());
        } catch (JSONException ex) {
            Logger.getLogger(Servlet_consultarMienbroComitePorId.class.getName()).log(Level.SEVERE, null, ex);
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
