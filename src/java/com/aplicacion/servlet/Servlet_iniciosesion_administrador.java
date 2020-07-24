/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.aplicacion.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import metodos_sql.Metodos_sql;
import seguridad.Encriptar_Desencriptar;

/**
 *
 * @author charl
 */
@WebServlet(name = "Servlet_iniciosesion_administrador", urlPatterns = {"/Servlet_iniciosesion_administrador"})
public class Servlet_iniciosesion_administrador extends HttpServlet {

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
            out.println("<title>Servlet Servlet_iniciosesion_administrador</title>");
            out.println("</head>");
            out.println("<body>");
            RequestDispatcher rd = request.getRequestDispatcher("login.jsp");
            rd.forward(request, response);
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
        //processRequest(request, response);
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            //out.println("<title>Servlet Servlet</title>");
            out.println("</head>");
            out.println("<body>");
            String rfc = request.getParameter("rfc");
            String clave = request.getParameter("clave");
            String claveEncriptada = "";
            claveEncriptada = Encriptar_Desencriptar.encriptar(clave);
            String btnlogin = request.getParameter("iniciarsesionadmin");
            int boton1 = 0, boton2 = 0, boton3 = 0, boton4 = 0, boton5 = 0, boton6 = 0, boton7 = 0, boton8 = 0, boton9 = 0;
            String colorred = "color:#FF3000";
            String per1 = "true";
            String per2 = "true";
            String per3 = "true";
            String per4 = "true";
            String per5 = "true";

            if (btnlogin != null) {
                String busquedaadmin = metodos.buscaradmin(rfc, claveEncriptada);
                if (rfc.equals("root") && clave.equals("root")) {
                    out.println("ADMINISTTRADOR");
                }//fin if root
                else if (busquedaadmin.equals("USUARIO ENCONTRADO")) {
                    String busqueda_nombre[] = metodos.buscaradmin2(rfc);

                    int lon = busqueda_nombre[4].length();

                    String numero_permisos = String.valueOf(busqueda_nombre[4]);
                    char permisos[] = new char[lon];
                    permisos = numero_permisos.toCharArray();

                    for (int n = 0; n < lon; n++) {
                        if (permisos[n] == '1') {
                            boton1 = 1;
                            per1 = "false";
                        }
                        if (permisos[n] == '2') {
                            boton2 = 1;
                            per2 = "false";
                        }
                        if (permisos[n] == '3') {
                            boton3 = 1;
                            per3 = "false";
                        }
                        if (permisos[n] == '4') {
                            boton4 = 1;
                            per4 = "false";
                        }
                        if (permisos[n] == '5') {
                            boton5 = 1;
                            per5 = "false";
                        }

                    }


                    
//                 out.println(String.valueOf(boton1)+
//                         String.valueOf(boton2)+
//                         String.valueOf(boton3)+
//                         String.valueOf(boton4)+
//                         String.valueOf(boton5)+
//                         String.valueOf(boton6)+
//                         String.valueOf(boton7)+
//                         String.valueOf(boton8)+
//                         String.valueOf(boton9));

//                 out.println(String.valueOf(per1)+
//                         String.valueOf(per2)+
//                         String.valueOf(per3)+
//                         String.valueOf(per4)+
//                         String.valueOf(per5));


                    request.setAttribute("opc", "1");
                    request.setAttribute("consulta", "1");
                    request.setAttribute("dato_ent", busqueda_nombre[0]);
                    request.setAttribute("dato_pla", busqueda_nombre[1]);
                    request.setAttribute("nom", busqueda_nombre[2]);
                    request.setAttribute("dato_rfc", busqueda_nombre[3]);
                    request.setAttribute("per1", per1);
                    request.setAttribute("per3", per3);
                    request.setAttribute("per4", per4);
                    RequestDispatcher rd = request.getRequestDispatcher("administracion_usuarios.jsp");
                    rd.forward(request, response);

                } else {
                    request.setAttribute("error", "Administrador No Registrado");
                    RequestDispatcher rd = request.getRequestDispatcher("administradores.jsp");
                    rd.forward(request, response);
                    //out.println("USUARIO NO REGISTRADOs");
                }

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