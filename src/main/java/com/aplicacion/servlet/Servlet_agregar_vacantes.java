/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.aplicacion.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
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
@WebServlet(name = "Servlet_agregar_vacantes", urlPatterns = {"/Servlet_agregar_vacantes"})
public class Servlet_agregar_vacantes extends HttpServlet {

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
        try  {
            PrintWriter out = response.getWriter();
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet Servlet_agregar_vacantes</title>");
            out.println("</head>");
            out.println("<body>");
            RequestDispatcher rd = request.getRequestDispatcher("login.jsp");
            rd.forward(request, response);
            out.println("</body>");
            out.println("</html>");
        }catch(Exception e){
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
        response.setContentType("text/html;charset=UTF-8");
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

                String control_combobox = request.getParameter("control_combobox");
                String nac1 = request.getParameter("nacional");//AGREGAR---------------------------
                String per1 = request.getParameter("permiso1");
                String per3 = request.getParameter("permiso3");
                String per4 = request.getParameter("permiso4");
                String nom1 = request.getParameter("nombre");
                String ent1 = request.getParameter("dato_ent");
                String pla1 = request.getParameter("dato_pla");
                String rfc1 = request.getParameter("dato_rfc");
                String estado = request.getParameter("campoentidad");
                String estadon = request.getParameter("entidad");
                String plantel = request.getParameter("n_plantel");
                String plaza = request.getParameter("entidad2");
                String cantidad1 = request.getParameter("cantidad");
                String tipo = request.getParameter("campotipo");
                String tipon = request.getParameter("n_plantel2");
                String jornada = request.getParameter("campojornada");
                String jornadan = request.getParameter("n_plantel3");
                String grado_academico = request.getParameter("campogrado1");
                String vacancia = request.getParameter("tipovacancia");
                String convocatoria = request.getParameter("convocatoria");
                String btnvacantes = request.getParameter("agregarvacantes");
                //out.println(estado);

                if (btnvacantes != null) {
                    List<String[]> datos=null; 
                    int datos5=0;
                    if (control_combobox.equals("true") && nac1.equals("1")) { //administrador nacional
                        
                    }else if (control_combobox.equals("false") && nac1.equals("1")) { //super usuario
                        
                        String[] parametros={estadon, plantel, plaza, cantidad1, tipon, jornadan,convocatoria};
                        datos=metodos.ejecutaSP("sp_registraVacancia",parametros);            
                        
                        //datos5 = metodos.guardar5( estadon, plantel, plaza, cantidad1, tipon, jornadan, vacancia,convocatoria);
                    }else if (control_combobox.equals("true") && nac1.equals("2")) {//administrador estatal
                        
                    }else if (control_combobox.equals("true") && nac1.equals("3")) {//administrador plantel
                        
                    }
                    
                    if(!datos.isEmpty()){
                        if(datos.get(0)[0].equals("ok")){
                            request.setAttribute("control_combobox", control_combobox);
                            request.setAttribute("nacional", nac1);//AGREGAR-------------------------------
                            request.setAttribute("ver", "1");
                            request.setAttribute("opc", "1");
                            request.setAttribute("consulta", "1");
                            request.setAttribute("nom", nom1);
                            request.setAttribute("dato_ent", ent1);
                            request.setAttribute("dato_pla", pla1);
                            request.setAttribute("dato_rfc", rfc1);
                            request.setAttribute("per1", per1);
                            request.setAttribute("per3", per3);
                            request.setAttribute("per4", per4);
                            request.setAttribute("modal", 1);
                            //session.setAttribute("idUsuario", idUsuario);
                            //session.setAttribute("rfc", rfc);
                            RequestDispatcher rd = request.getRequestDispatcher("vacantes.jsp");
                            rd.forward(request, response);
                        }else {
                            out.print("Servidor en mantenimiento, Datos no guardados");
                        }
                    }else {
                        out.print("Servidor en mantenimiento, Datos no guardados");
                    }

                    /*if (datos5 > 0) {
                        request.setAttribute("control_combobox", control_combobox);
                        request.setAttribute("nacional", nac1);//AGREGAR-------------------------------
                        request.setAttribute("ver", "1");
                        request.setAttribute("opc", "1");
                        request.setAttribute("consulta", "1");
                        request.setAttribute("nom", nom1);
                        request.setAttribute("dato_ent", ent1);
                        request.setAttribute("dato_pla", pla1);
                        request.setAttribute("dato_rfc", rfc1);
                        request.setAttribute("per1", per1);
                        request.setAttribute("per3", per3);
                        request.setAttribute("per4", per4);
                        request.setAttribute("modal", 1);
                        //session.setAttribute("idUsuario", idUsuario);
                        //session.setAttribute("rfc", rfc);
                        RequestDispatcher rd = request.getRequestDispatcher("vacantes.jsp");
                        rd.forward(request, response);
                    } else {
                        out.print("Servidor en mantenimiento, Datos no guardados");
                    }*/

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
