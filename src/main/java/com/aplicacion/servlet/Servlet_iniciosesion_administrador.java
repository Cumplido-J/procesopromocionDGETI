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
import javax.servlet.http.HttpSession;
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
        try {
            PrintWriter out = response.getWriter();
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
        } catch (Exception e) {
            System.out.println(e.toString());
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

            String rfc2 = request.getParameter("rfc");
            String clave = request.getParameter("clave");
            String claveEncriptada = "";
            claveEncriptada = Encriptar_Desencriptar.encriptar(clave);

            String btnlogin = request.getParameter("iniciarsesionadmin");

            int boton1 = 0, boton2 = 0, boton3 = 0, boton4 = 0, boton5 = 0, boton6 = 0, boton7 = 0, boton8 = 0, boton9 = 0;
            int numero = 0;

            String per1 = "true";
            String per2 = "true";
            String per3 = "true";
            String per4 = "true";
            String per5 = "true";

            if (btnlogin != null) {

                String busquedaadmin = metodos.buscar_rfc(rfc2);

                if (rfc2.equals("root") && clave.equals("root")) {
                    out.println("ADMINISTTRADOR");
                }//fin if root
                else if (busquedaadmin.equals("RFC ENCONTRADO")) {

                    String busquedaclave[] = metodos.buscar_clave(rfc2, claveEncriptada);

                    if (busquedaclave[0].equals("USUARIO ENCONTRADO")) {
                        HttpSession session = (HttpSession) request.getSession(true);
                        String idUsuario = busquedaclave[1].toString();
                        String rfc = rfc2;

                        String busqueda_nombre[] = metodos.buscaradmin2(rfc2);
                       
                        String id_usuario = busqueda_nombre[4].toString();
                        String permisos[] = metodos.buscarpermisos(Integer.parseInt(id_usuario));
                        
                        for (int i = 0; i < permisos.length; i++) {
                            if (permisos[i] != null) {
                                numero++;
                            }
                        }

                        for (int n = 0; n < numero; n++) {
                            if (permisos[n].equals("1")) {
                                boton1 = 1;
                                per1 = "false";
                            }
                            if (permisos[n].equals("2")) {
                                boton2 = 1;
                                per2 = "false";
                            }
                            if (permisos[n].equals("3")) {
                                boton3 = 1;
                                per3 = "false";
                            }
                            if (permisos[n].equals("4")) {
                                boton4 = 1;
                                per4 = "false";
                            }
                            if (permisos[n].equals("5")) {
                                boton5 = 1;
                                per5 = "false";
                            }
                        }
                  
                        request.setAttribute("opc", "1");
                        request.setAttribute("consulta", "1");
                        request.setAttribute("dato_ent", busqueda_nombre[0]);
                        request.setAttribute("dato_pla", busqueda_nombre[1]);
                        request.setAttribute("nom", busqueda_nombre[2]);
                        request.setAttribute("dato_rfc", busqueda_nombre[3]);

                        request.setAttribute("per1", per1);//alta administradores
                        request.setAttribute("per2", per2);//carga convocatoria
                        request.setAttribute("per3", per3);
                        request.setAttribute("per4", per4);//carga vancancia
                        request.setAttribute("per5", per5);
                        session.setAttribute("idUsuario", idUsuario);
                        session.setAttribute("rfc", rfc2);

                        if (busqueda_nombre[5].toString().equals("S")) {
                            request.setAttribute("control_combobox", "false");
                            RequestDispatcher rd = request.getRequestDispatcher("administracion_usuarios.jsp");
                            rd.forward(request, response);
                        }
                        if (busqueda_nombre[5].toString().equals("A")) {
                            if (per1.equals("false")) {
                                request.setAttribute("control_combobox", "true");
                                RequestDispatcher rd = request.getRequestDispatcher("administracion_usuarios.jsp");
                                rd.forward(request, response);
                            }
                            if (per2.equals("false")) {
                                request.setAttribute("control_combobox", "true");
                                RequestDispatcher rd = request.getRequestDispatcher("convocatoria.jsp");
                                rd.forward(request, response);
                            }
                            if (per4.equals("false")) {
                                request.setAttribute("control_combobox", "true");
                                RequestDispatcher rd = request.getRequestDispatcher("vacantes.jsp");
                                rd.forward(request, response);
                            }
                        }
                        if (busqueda_nombre[5].toString().equals("D")) {
                            response.sendRedirect("SesionDocente");                            
                        }
                    }//USUARIO ENCONTRADO
                    else {
                        request.setAttribute("error", "Contraseña incorrecta");
                        RequestDispatcher rd = request.getRequestDispatcher("login.jsp");
                        rd.forward(request, response);
                        //out.println("USUARIO NO REGISTRADOs");
                    }
                } //RFC ENCONTRADO
                else {
                    request.setAttribute("error", "El usuario no existe");
                    RequestDispatcher rd = request.getRequestDispatcher("login.jsp");
                    rd.forward(request, response);
                    //out.println("USUARIO NO REGISTRADOs");
                }

            }//BOTON
            else {
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
