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
@WebServlet(name = "Servlet_agregar_usuario", urlPatterns = {"/Servlet_agregar_usuario"})
public class Servlet_agregar_usuario extends HttpServlet {

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
            out.println("<title>Servlet Servlet_agregar_usuario</title>");
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
        response.setContentType("text/html;charset=ISO-8859-1");
        try (PrintWriter out = response.getWriter()) {

            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            //out.println("<title>Servlet Servlet_crearcuenta</title>");
            out.println("</head>");
            out.println("<body>");

            String nom1 = request.getParameter("nombre");
            String ent1 = request.getParameter("dato_ent");
            String pla1 = request.getParameter("dato_pla");
            String rfc1 = request.getParameter("dato_rfc");
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
            
            int lon = check.length;
            String permisos="";
            if(lon==1){permisos = check[0];}
            if(lon==2){permisos = check[0]+check[1];}
            if(lon==3){permisos = check[0]+check[1]+check[2];}
            if(lon==4){permisos = check[0]+check[1]+check[2]+check[3];}
            if(lon==5){permisos = check[0]+check[1]+check[2]+check[3]+check[4];}
            if(lon==6){permisos = check[0]+check[1]+check[2]+check[3]+check[4]+check[5];}
            if(lon==7){permisos = check[0]+check[1]+check[2]+check[3]+check[4]+check[5]+check[6];}
            if(lon==8){permisos = check[0]+check[1]+check[2]+check[3]+check[4]+check[5]+check[6]+check[7];}
            if(lon==9){permisos = check[0]+check[1]+check[2]+check[3]+check[4]+check[5]+check[6]+check[7]+check[8];}
           
            
            String btnlogin = request.getParameter("agregarusuario");

            if (btnlogin != null) {

                int datos5 = 0;

                int datos4 = metodos.guardar4(0, id_estado, plantel, usuario, nombre, apellidopaterno, apellidomaterno, telfijo, telcel, correo, claveEncriptada, perfil,permisos);

                int id = metodos.buscarid();

                for (int n = 0; n < check.length; n++) {
                    if (check[n] != ("0")) {
                        datos5 = metodos.guardar6(0, id, Integer.parseInt(check[n]));
                    }
                }
                if (datos4 > 0 && datos5 > 0) {
                    request.setAttribute("opc", "1");
                    request.setAttribute("nom", nom1);
                    request.setAttribute("consulta", "1");
                    request.setAttribute("dato_ent", ent1);
                    request.setAttribute("dato_pla", pla1);
                    request.setAttribute("dato_rfc", rfc1);
                    RequestDispatcher rd = request.getRequestDispatcher("administracion_usuarios.jsp");
                    rd.forward(request, response);
                } else {
                    out.print("Servidor en mantenimiento, Datos no Guardados");
                }

            }//fin presionar boton

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
