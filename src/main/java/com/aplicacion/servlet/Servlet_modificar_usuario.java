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
@WebServlet(name = "Servlet_modificar_usuario", urlPatterns = {"/Servlet_modificar_usuario"})
public class Servlet_modificar_usuario extends HttpServlet {

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
            out.println("<title>Servlet Servlet_modificar_usuario</title>");
            out.println("</head>");
            out.println("<body>");
            //out.println("<h1>Servlet Servlet_modificar_usuario at " + request.getContextPath() + "</h1>");
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
    Metodos_sql metodos = new Metodos_sql();

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
        // processRequest(request, response);
        response.setContentType("text/html;charset=ISO-8859-1");
        try (PrintWriter out = response.getWriter()) {

            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            //out.println("<title>Servlet Servlet_crearcuenta</title>");
            out.println("</head>");
            out.println("<body>");
            HttpSession session = (HttpSession) request.getSession(true);
            String idUsuario = "";
            String rfc = "";
            if (session.getAttribute("idUsuario") != null && session.getAttribute("rfc") != null) {
                idUsuario = session.getAttribute("idUsuario").toString();
                rfc = session.getAttribute("rfc").toString();

                String id_modificar = request.getParameter("id_modificar");
                String control_combobox = request.getParameter("control_combobox");
                String nac1 = request.getParameter("nacional");//AGREGAR---------------------------
                String per1 = request.getParameter("permiso1");
                String per2 = request.getParameter("permiso2");
                String per4 = request.getParameter("permiso4");
                String nom1 = request.getParameter("nombre");
                String ent1 = request.getParameter("dato_ent");
                String pla1 = request.getParameter("dato_pla");
                String rfc1 = request.getParameter("dato_rfc");

                String nivel = request.getParameter("nivel");//AGREGAR---------------------------
                String nivel_plantel = request.getParameter("nivel_plantel");//AGREGAR---------------------------
                String estado = request.getParameter("campoentidad");
                String id_estado = request.getParameter("entidad");
                String plantel = request.getParameter("n_plantel");
                String usuario = request.getParameter("usuario");
                String nombre = request.getParameter("Nombre");
                String apellidopaterno = request.getParameter("primerApellido");
                String apellidomaterno = request.getParameter("segundoApellido");
                String telfijo = request.getParameter("telfijo");
                String telcel = request.getParameter("telcel");
                String correo = request.getParameter("correo");
                String clave = request.getParameter("clave");
                String perfil = "A";
                String claveEncriptada = "";
                String[] check = request.getParameterValues("ckl");
                claveEncriptada = Encriptar_Desencriptar.encriptar(clave);
                String btnlogin = request.getParameter("modificarusuario");

//                out.print(id_modificar);
//                out.print(control_combobox);
//                out.print(nac1);
//                out.print(per1);
//                out.print(per2);
//                out.print(per4);
//                out.print(nom1);
//                out.print(ent1);
//                out.print(pla1);
//                out.print(rfc1);
//                out.print(nivel);
//                out.print(id_estado);//
//                out.print(plantel);//
//                out.print(usuario);
//                out.print(nombre);
//                out.print(apellidopaterno);
//                out.print(apellidomaterno);
//                out.print(telfijo);
//                out.print(telcel);
//                out.print(correo);
//                out.print(clave);
//                out.print(check[0]);
//                out.print(check[1]);
//                out.print(check[2]);
//                out.print(check[3]);
//                out.print(check[4]);
                int lon = check.length;
                String permisos = "";
                if (lon == 1) {
                    permisos = check[0];
                }
                if (lon == 2) {
                    permisos = check[0] + check[1];
                }
                if (lon == 3) {
                    permisos = check[0] + check[1] + check[2];
                }
                if (lon == 4) {
                    permisos = check[0] + check[1] + check[2] + check[3];
                }
                if (lon == 5) {
                    permisos = check[0] + check[1] + check[2] + check[3] + check[4];
                }
                if (lon == 6) {
                    permisos = check[0] + check[1] + check[2] + check[3] + check[4] + check[5];
                }
                if (lon == 7) {
                    permisos = check[0] + check[1] + check[2] + check[3] + check[4] + check[5] + check[6];
                }
                if (lon == 8) {
                    permisos = check[0] + check[1] + check[2] + check[3] + check[4] + check[5] + check[6] + check[7];
                }
                if (lon == 9) {
                    permisos = check[0] + check[1] + check[2] + check[3] + check[4] + check[5] + check[6] + check[7] + check[8];
                }

                if (btnlogin != null) {

                    int datos4 = 0;
                    int datos5 = 0;

                    if (control_combobox.equals("true") && nac1.equals("1")) {
                        out.print("SI SE EJECUTA1");
                        //super usuario---------------------------------------------------------------------
                        if (nivel.equals("1")) {
                            //if (id_estado.equals("0")) {
                            id_estado = null;
                            // }
                            //if (plantel.equals("0")) {
                            plantel = null;
                            //}
                            datos4 = metodos.modificar_usuarios_A(id_modificar, id_estado, plantel, nombre, apellidopaterno, apellidomaterno, correo, claveEncriptada, usuario, telfijo, telcel, perfil, nivel);
                        } else if (nivel.equals("2")) {
//                            if (plantel.equals("0")) {
                            plantel = null;
//                              }
                            datos4 = metodos.modificar_usuarios_A(id_modificar, id_estado, plantel, nombre, apellidopaterno, apellidomaterno, correo, claveEncriptada, usuario, telfijo, telcel, perfil, nivel);
                        } else if (nivel.equals("3")) {
                            datos4 = metodos.modificar_usuarios_A(id_modificar, id_estado, plantel, nombre, apellidopaterno, apellidomaterno, correo, claveEncriptada, usuario, telfijo, telcel, perfil, nivel);
                        }

                    } else if (control_combobox.equals("false") && nac1.equals("1")) {
                        //super usuario---------------------------------------------------------------------

                        if (nivel.equals("1")) {
                            //if (id_estado.equals("0")) {
                            id_estado = null;
                            // }
                            //if (plantel.equals("0")) {
                            plantel = null;
                            //}

                            datos4 = metodos.modificar_usuarios_A(id_modificar, id_estado, plantel, nombre, apellidopaterno, apellidomaterno, correo, claveEncriptada, usuario, telfijo, telcel, perfil, nivel);
                        } else if (nivel.equals("2")) {
//                            if (plantel.equals("0")) {
                            plantel = null;
//                              }      

                            //datos4 = metodos.modificar_usuarios_B();
                            datos4 = metodos.modificar_usuarios_A(id_modificar, id_estado, plantel, nombre, apellidopaterno, apellidomaterno, correo, claveEncriptada, usuario, telfijo, telcel, perfil, nivel);
                        } else if (nivel.equals("3")) {
                            datos4 = metodos.modificar_usuarios_A(id_modificar, id_estado, plantel, nombre, apellidopaterno, apellidomaterno, correo, claveEncriptada, usuario, telfijo, telcel, perfil, nivel);
                        }
                    }//fin super usuario---------------------------------------------------------------------
                    else if (control_combobox.equals("true") && nac1.equals("2")) {
                        //administrador estatal--------------------------------------------------------------  
                        if (nivel.equals("2")) {
                            //out.print("2");
                            plantel = null;                           
                            datos4 = metodos.modificar_usuarios_A(id_modificar, id_estado, plantel, nombre, apellidopaterno, apellidomaterno, correo, claveEncriptada, usuario, telfijo, telcel, perfil, nivel);
                        } else if (nivel.equals("3")) {
                            //out.print("3");
                            datos4 = metodos.modificar_usuarios_A(id_modificar, id_estado, plantel, nombre, apellidopaterno, apellidomaterno, correo, claveEncriptada, usuario, telfijo, telcel, perfil, nivel);
                        }
                    } else if (control_combobox.equals("true") && nac1.equals("3")) {
                        //administrador plantel--------------------------------------------------------------                       
                        datos4 = metodos.modificar_usuarios_A(id_modificar, ent1, pla1, nombre, apellidopaterno, apellidomaterno, correo, claveEncriptada, usuario, telfijo, telcel, perfil, nivel);
                    }
                                    
//                    int id = metodos.buscarid();

                      metodos.borrar_permisos_usuarios(0,id_modificar);


                    for (int n = 0; n < check.length; n++) {
                        if (check[n] != ("0")) {
                           datos5 = metodos.guardar6(0, Integer.parseInt(id_modificar), Integer.parseInt(check[n]));
                        }
                    }

                    if (datos4 > 0 && datos5 > 0) {
                    //if (datos4 > 0) {
                        request.setAttribute("control_combobox", control_combobox);
                        request.setAttribute("nacional", nac1);//AGREGAR-------------------------------
                        request.setAttribute("ver", "1");
                        request.setAttribute("opc", "1");
                        request.setAttribute("nom", nom1);
                        request.setAttribute("consulta", "1");
                        request.setAttribute("dato_ent", ent1);
                        request.setAttribute("dato_pla", pla1);
                        request.setAttribute("dato_rfc", rfc1);
                        request.setAttribute("per1", per1);
                        request.setAttribute("per2", per2);
                        request.setAttribute("per4", per4);
                        session.setAttribute("idUsuario", idUsuario);
                        session.setAttribute("rfc", rfc);
                    RequestDispatcher rd = request.getRequestDispatcher("aviso_guardar_datos.jsp");
                    rd.forward(request, response);
                    } else {
                        out.print("Servidor en mantenimiento, Datos no Guardados");
                    }

                }//fin presionar boton
            } else {
                response.sendRedirect("login.jsp");
            }
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
