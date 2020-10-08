/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.aplicacion.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import metodos_sql.Metodos_sql;

/**
 *
 * @author David Reyna
 */
public class Servlet_login extends HttpServlet {

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
            out.println("<title>Servlet Servlet_login</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet Servlet_login at " + request.getContextPath() + "</h1>");
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
        try (PrintWriter out = response.getWriter()) {
            String rfc = request.getParameter("rfc");
            String clave = request.getParameter("clave");
            Metodos_sql metodos=new Metodos_sql();
            String[] parametros={rfc};
            List<String[]> datos=metodos.ejecutaSP("sp_consultaInfoLogin",parametros);
            if(!datos.isEmpty()){
                if(datos.get(0)[4].equals(clave)){
                    HttpSession session = (HttpSession) request.getSession(true);
                    session.setAttribute("idUsuario", datos.get(0)[0]);
                    session.setAttribute("estado", datos.get(0)[1]);
                    session.setAttribute("plantel", datos.get(0)[2]);
                    session.setAttribute("rfc", datos.get(0)[5]);
                    session.setAttribute("nombre", datos.get(0)[3]);
                    if(datos.get(0)[6].equals("D")){
                        response.sendRedirect("SesionDocente"); 
                    }else{                        
                        List<String[]> vinculos = new ArrayList<String[]>();
                        String[] vinculo = null;
                        for(String[] dato:datos){
                            System.out.println(dato[7]+"-"+dato[8]+"-"+dato[9]);
                            vinculo=new String[3];
                            vinculo[0]=dato[7];
                            vinculo[1]=dato[8];
                            vinculo[2]=dato[9];
                            vinculos.add(vinculo);
                        }
                        session.setAttribute("vinculos",vinculos);
                        response.sendRedirect("SesionAdministrador");
                    }
                }else{
                    request.setAttribute("error", "Contraseña incorrecta");
                    RequestDispatcher rd = request.getRequestDispatcher("login.jsp");
                    rd.forward(request, response);
                }
            }
            else {
                request.setAttribute("error", "El usuario no existe");
                RequestDispatcher rd = request.getRequestDispatcher("login.jsp");
                rd.forward(request, response);
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
