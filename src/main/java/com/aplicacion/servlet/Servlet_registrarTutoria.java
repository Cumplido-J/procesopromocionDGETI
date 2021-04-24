/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.aplicacion.servlet;

import herramientas.CriteriosValoracion;
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
 * @author David Reyna
 */
@WebServlet(name = "RegistrarTutoria", urlPatterns = {"/RegistrarTutoria"})
public class Servlet_registrarTutoria extends HttpServlet {

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
            out.println("<title>Servlet Servlet_registrarTutoria</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet Servlet_registrarTutoria at " + request.getContextPath() + "</h1>");
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
            Fecha fecha=new Fecha();
            HttpSession session= (HttpSession) request.getSession();
            String idUsuario,rfc,idPermiso;
            boolean vistaAdmin;
            idPermiso = session.getAttribute("permisoActual").toString();
            if(session.getAttribute("rol").toString().equals("D")){
                idUsuario=session.getAttribute("idUsuario").toString();
                rfc=session.getAttribute("rfc").toString();
                vistaAdmin=false;
            }else{
                idUsuario=session.getAttribute("idDocente").toString();                
                rfc=session.getAttribute("rfcDocente").toString();
                vistaAdmin=true;
            }            
            Metodos_sql metodo = new Metodos_sql(); 
            if(request.getParameter("id")==null){
                String inicio=fecha.formatoAlmacenar(request.getParameter("inicioTutoria"));  
                String fin=fecha.formatoAlmacenar(request.getParameter("finTutoria")); 
                String documento=request.getParameter("documento"); 
                String[] parametros={idUsuario,inicio,fin,documento};
                List<String[]> datos;                           
                datos=metodo.ejecutaSP("sp_insertTutorias",parametros);            
                if(!datos.isEmpty()){
                    if(datos.get(0)[0].equals("ok")){
                        String[] info=new CriteriosValoracion().getFilasTutorias(idUsuario,vistaAdmin, idPermiso,session.getAttribute("permisoActualEdicion").toString());
                        out.print(info[0]+"||"+info[1]+"||"+info[2]);                    
                    }else{
                        out.print(datos.get(0)[0]);
                    }
                }else{
                    out.print("Error en almacenamiento de datos, intente nuevamente");
                }
            }else{
                String id=request.getParameter("id");
                String[] parametrosDelete={id};
                String[] parametros={id,idPermiso};                 
                List<String[]> datos=null;   
                String idAccion=request.getParameter("k");
                if(idAccion.equals("B")){
                    datos=metodo.ejecutaSP("sp_deleteTutorias",parametrosDelete);
                }else if(idAccion.equals("A")){
                    datos=metodo.ejecutaSP("sp_aprobarTutoria",parametros); 
                }else if(idAccion.equals("R")){
                    datos=metodo.ejecutaSP("sp_rechazarTutoria",parametros); 
                }                            
                if(!datos.isEmpty()){
                    if(datos.get(0)[0].equals("ok")){
                        String[] info=new CriteriosValoracion().getFilasTutorias(idUsuario,vistaAdmin, idPermiso,session.getAttribute("permisoActualEdicion").toString());
                        out.print(info[0]+"||"+info[1]+"||"+info[2]);                    
                    }
                }else{
                    out.print("Error al eliminar la información, intente nuevamente");
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
