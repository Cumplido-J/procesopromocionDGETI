/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.aplicacion.servlet;

import herramientas.Datos;
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
 * @author Fernando
 */
@WebServlet(name = "Servlet_agregarCategoriasAspira", urlPatterns = {"/AgregarCategoriasAspira"})
public class Servlet_agregarCategoriasAspira extends HttpServlet {

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
            out.println("<title>Servlet Servlet_agregarCategoriasAspira</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet Servlet_agregarCategoriasAspira at " + request.getContextPath() + "</h1>");
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
        PrintWriter out = response.getWriter();
        try{
            HttpSession session= (HttpSession) request.getSession();
            String idUsuario="",rfc="",programa="",idEntidad="",idPlantel="",numhoras="0",idCategoria="",idJornada="",horas="0",idCategoriaSel="",idJornadaSel="",horasSel="0",idCat="";
            if(session.getAttribute("rol").toString().equals("D")){
                idUsuario=session.getAttribute("idUsuario").toString();
                rfc=session.getAttribute("rfc").toString();
            }else{
                idUsuario=session.getAttribute("idDocente").toString();                
                rfc=session.getAttribute("rfcDocente").toString();
            }
            
            Metodos_sql metodo = new Metodos_sql();
            
            String eliminarCategoria = request.getParameter("k")!=null?"B":"Z";
            
            if(eliminarCategoria.equals("B")){
                String id=request.getParameter("id");
                String[] parametros={id};
                List<String[]> datos;                           
                datos=metodo.ejecutaSP("sp_deleteUsuarioCategoriaAspira",parametros);            
                if(!datos.isEmpty()){
                    if(datos.get(0)[0].equals("ok")){
                        String informacion=new Datos().desplegarCategoriasAspira(idUsuario);
                        out.print(informacion);                     
                    }
                }else{
                    out.print("Error al eliminar la información, intente nuevamente");
                }
            }else{
                idCategoria=request.getParameter("categoria");
                idJornada=request.getParameter("jornada");
                horas=request.getParameter("horas");
                idCat=request.getParameter("idCategoria");

                String[] categoria;
                categoria = idCategoria.split("-");
                idCategoria=categoria[0];

                String respuesta=new Datos().validarSeleccionadasAdd(idUsuario);
                System.out.println("respuesta"+respuesta);
                if(respuesta.contains(",")){
                    String[] aux=respuesta.split(",");
                    System.out.println("longitud"+aux.length);
                    idCategoriaSel=aux[0];
                    idJornadaSel=aux[1];
                    horasSel=aux[4];
                }
                
                String[] parametros={idUsuario,idCategoria,idJornada,horas,horasSel,idCat};
                List<String[]> datos;                           
                datos=metodo.ejecutaSP("sp_registroplazaaspira",parametros);
                
                if(!datos.isEmpty()){
                    if(datos.get(0)[0].contains("permitidas")){
                        out.print(datos.get(0)[0].toString());
                    }else if(datos.get(0)[0].contains("previamente")){
                        out.print(datos.get(0)[0].toString());
                    }else{
                        String respuestaCategorias=new Datos().desplegarCategoriasAspira(idUsuario);
                        out.print(respuestaCategorias);
                    }
                }
            }
        } finally {
            out.close();
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
