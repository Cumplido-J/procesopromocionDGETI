/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.aplicacion.servlet;

import com.aplicacion.beans.Docente;
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
@WebServlet(name = "CancelaPin", urlPatterns = {"/CancelaPin"})
public class Servlet_cancelarPin extends HttpServlet {

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
            out.println("<title>Servlet Servlet_cancelarPin</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet Servlet_cancelarPin at " + request.getContextPath() + "</h1>");
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
        try{
            response.setContentType("text/html;charset=UTF-8");
            PrintWriter out = response.getWriter();
            HttpSession session= (HttpSession) request.getSession();     
            if(session.getAttribute("idUsuario")!=null&&session.getAttribute("rfc")!=null){                
                String idUsuario=session.getAttribute("idUsuario").toString();
                String rfc=session.getAttribute("rfc").toString();
                String idEncuestado=request.getParameter("i").toString(); 
                String idTipo=request.getParameter("t").toString(); 
                Metodos_sql metodos=new Metodos_sql();
                String[] parametros={idEncuestado};
                List<String[]>retorno;
                retorno=metodos.ejecutaSPEncuestas("sp_cancelaPin", parametros);
                if(!retorno.isEmpty()){  
                    if(retorno.get(0)[0].equals("ok")){ 
                        Docente d=new Docente();
                        d.setIdUsuario(idUsuario);
                        d.setRfc(rfc);
                        d.consultaEncuestados();
                        String[] datos=d.generaFilasEncuestados(idTipo);
                        if(datos[0]==""){
                            datos[0]="<tr><td colspan='3'>Sin información</td></tr>";
                        }
                        out.print(datos[0]+"|"+datos[1]);
                    }else{
                        out.print(retorno.get(0)[0]);
                    }
                }else{
                    out.print("Error de almacenamiento, intente más tarde");
                }
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
