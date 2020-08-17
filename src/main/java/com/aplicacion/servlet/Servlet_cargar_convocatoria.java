/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.aplicacion.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Date;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import metodos_sql.Metodos_sql;

/**
 *
 * @author charl
 */
@WebServlet(name = "Servlet_cargar_convocatoria", urlPatterns = {"/Servlet_cargar_convocatoria"})
public class Servlet_cargar_convocatoria extends HttpServlet {

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
            out.println("<title>Servlet Servlet_cargar_convocatoria</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet Servlet_cargar_convocatoria at " + request.getContextPath() + "</h1>");
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
    Metodos_sql metodos = new Metodos_sql();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
//        processRequest(request, response);
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("</head>");
            out.println("<body>");
            HttpSession session = (HttpSession) request.getSession(true);
            String idUsuario = "";
            String rfc = "";
            if (session.getAttribute("idUsuario") != null && session.getAttribute("rfc") != null) {
                idUsuario = session.getAttribute("idUsuario").toString();
                rfc = session.getAttribute("rfc").toString();

                String control_combobox = request.getParameter("control_combobox");
          
                String entidad = request.getParameter("entidad");
                String plantel = request.getParameter("n_plantel");
                String programa = request.getParameter("programa");
//              

                String per1 = request.getParameter("permiso1");
                String per2 = request.getParameter("permiso2");
                String per4 = request.getParameter("permiso4");
                String nom1 = request.getParameter("nombre");
                String ent1 = request.getParameter("dato_ent");
                String pla1 = request.getParameter("dato_pla");
                String rfc1 = request.getParameter("dato_rfc");
                String btnregresa = request.getParameter("buscar");
                String btnguardar = request.getParameter("guardar1");

                if (btnguardar != null) {
                   
                String id = request.getParameter("id");  
                Date publicacion1 = Date.valueOf(request.getParameter("publicacion"));
                Date periodo_registro_inicio1 = Date.valueOf(request.getParameter("periodo_registro_inicio"));
                Date periodo_registro_fin1 = Date.valueOf(request.getParameter("periodo_registro_fin"));
                Date periodo_valoracion_inicio1 = Date.valueOf(request.getParameter("periodo_valoracion_inicio"));
                Date periodo_valoracion_fin1 = Date.valueOf(request.getParameter("periodo_valoracion_fin"));
                Date periodo_dictaminacion_inicio1 = Date.valueOf(request.getParameter("periodo_dictaminacion_inicio"));
                Date periodo_dictaminacion_fin1 = Date.valueOf(request.getParameter("periodo_dictaminacion_fin"));
                Date publicacion_resultados1 = Date.valueOf(request.getParameter("publicacion_resultados"));
                String estatus = request.getParameter("estatus");
                      
                
                int datos7=0;
                
                datos7= metodos.modificar_convocatoria(id,publicacion1, periodo_registro_inicio1, periodo_registro_fin1, periodo_valoracion_inicio1, periodo_valoracion_fin1, periodo_dictaminacion_inicio1, periodo_dictaminacion_fin1, publicacion_resultados1, estatus);
                
                if (datos7 > 0) {
                        request.setAttribute("control_combobox", control_combobox);                       
                        request.setAttribute("nom", nom1);
                        request.setAttribute("dato_ent", ent1);
                        request.setAttribute("dato_pla", pla1);
                        request.setAttribute("dato_rfc", rfc1);
                        request.setAttribute("per1", per1);
                        request.setAttribute("per2", per2);
                        request.setAttribute("per4", per4);
                        request.setAttribute("ver", "1");
                        session.setAttribute("idUsuario", idUsuario);
                        session.setAttribute("rfc", rfc);
                       
                        RequestDispatcher rd = request.getRequestDispatcher("aviso_modificar_convocatoria.jsp");
                        rd.forward(request, response);
                    } else {
                        out.print("Servidor en mantenimiento, Datos no Guardados");
                    }
                    
                }

                if (btnregresa != null) {
                    
                    
                    String datosconvocatoria[] = metodos.buscar_convocatoria(entidad, plantel, programa);
                    if (datosconvocatoria[11] != null) {
                        request.setAttribute("mensaje", "");
                        if (datosconvocatoria[10].equals("temporal")) {
                            request.setAttribute("ver", "1");
                        }
                        else
                        {
                             request.setAttribute("ver", "2");
                        }
                    } else {
                        request.setAttribute("mensaje", "No se encuentra la convocatoria");
                        request.setAttribute("ver", "0");
                    }
                    request.setAttribute("control_combobox", control_combobox);

                    request.setAttribute("entidad", entidad);
                    request.setAttribute("plantel", plantel);
                    request.setAttribute("programa", programa);
                    request.setAttribute("publ", datosconvocatoria[0]);
                    request.setAttribute("ireg", datosconvocatoria[1]);
                    request.setAttribute("freg", datosconvocatoria[2]);
                    request.setAttribute("ival", datosconvocatoria[3]);
                    request.setAttribute("fval", datosconvocatoria[4]);
                    request.setAttribute("idic", datosconvocatoria[5]);
                    request.setAttribute("fdic", datosconvocatoria[6]);
                    request.setAttribute("resu", datosconvocatoria[7]);
                    request.setAttribute("idpl", datosconvocatoria[8]);
                    request.setAttribute("idpr", datosconvocatoria[9]);
                    request.setAttribute("esta", datosconvocatoria[10]);
                    request.setAttribute("id", datosconvocatoria[11]);
                    request.setAttribute("opc", "1");
                    request.setAttribute("consulta", "1");
                    request.setAttribute("nom", nom1);
                    request.setAttribute("dato_ent", ent1);
                    request.setAttribute("dato_pla", pla1);
                    request.setAttribute("dato_rfc", rfc1);
                    request.setAttribute("per1", per1);
                    request.setAttribute("per2", per2);
                    request.setAttribute("per4", per4);
                    session.setAttribute("idUsuario", idUsuario);
                    session.setAttribute("rfc", rfc);
                    RequestDispatcher rd = request.getRequestDispatcher("Modificar_convocatoria.jsp");
                    rd.forward(request, response);

                }
            } else {
                response.sendRedirect("login.jsp");
            }
            //out.println("<h1>Servlet Servlet at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
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
