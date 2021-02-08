/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.aplicacion.servlet;

import herramientas.Fecha;
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
 * @author jtrinidadl
 */
@WebServlet(name = "RegistrarConvocatoriaBase", urlPatterns = {"/RegistrarConvocatoriaBase"})
public class Servlet_registrarConvocatoriaBase extends HttpServlet {

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
            out.println("<title>Servlet Servlet_registrarConvocatoria</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet Servlet_registrarConvocatoria at " + request.getContextPath() + "</h1>");
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
        try {  
            HttpSession session = (HttpSession) request.getSession(true);
            String id;
            if(request.getParameter("idConvocatoria")!=null){
                id=request.getParameter("idConvocatoria");
            }else{
                id="";
            }
            
            String permisoEdicion_ = session.getAttribute("permisoEdicion").toString();
            
            if(permisoEdicion_.equals("V")){
                String programa=request.getParameter("programa");
                String subsistema=request.getParameter("subsistema");            
                String entidad=request.getParameter("entidad");
                String plantel=request.getParameter("plantel");
                Fecha fecha=new Fecha();
                String publicacion=fecha.formatoAlmacenar(request.getParameter("publicacion"));
                String inicioRegistro=fecha.formatoAlmacenar(request.getParameter("inicioRegistro"));
                String finRegistro=fecha.formatoAlmacenar(request.getParameter("finRegistro"));            
                String inicioValoracion=fecha.formatoAlmacenar(request.getParameter("inicioValoracion"));
                String finValoracion=fecha.formatoAlmacenar(request.getParameter("finValoracion"));          
                String inicioDictaminacion=fecha.formatoAlmacenar(request.getParameter("inicioDictaminacion"));
                String finDictaminacion=fecha.formatoAlmacenar(request.getParameter("finDictaminacion"));
                String resultados=fecha.formatoAlmacenar(request.getParameter("resultados"));             
                String estatus=request.getParameter("estatus");
                String tipoConvocatoria=request.getParameter("tipoConvocatoria");
                
                if(tipoConvocatoria == null){
                    if(entidad.equals("") && plantel.equals("")){
                    tipoConvocatoria = "NACIONAL";
                    entidad = "0";
                    plantel = "0";
                    }else if(!entidad.equals("") && plantel.equals("")){
                        tipoConvocatoria = "ESTATAL";
                        plantel = "0";
                    }else{
                        tipoConvocatoria = "PLANTEL";
                    }
                }else{
                    if(entidad==null && plantel==null){
                    entidad = "0";
                    plantel = "0";
                    }else if(entidad!=null && plantel==null){
                        plantel = "0";
                    }
                }
                
                String respuesta="Error en almacenamiento de datos, intente nuevamente";
                Metodos_sql metodo = new Metodos_sql();
                List<String[]> datos;       
                
                //Validacion cuando una convocatoria es nueva
                if(id.equals("")){
                    estatus="0";
                }
                
                String[] parametros={id,publicacion,inicioRegistro,finRegistro,inicioValoracion,finValoracion,inicioDictaminacion,finDictaminacion,resultados,plantel,programa,tipoConvocatoria,estatus,entidad,subsistema};                                      
                datos=metodo.ejecutaSP("sp_insertConvocatoriaBase",parametros);            
                if(!datos.isEmpty()){
                    respuesta=datos.get(0)[0]; 
                }
                out.print(respuesta);   
                }else{
                    out.print("El usuario no tienen permisos para guardar");
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
