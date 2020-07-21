/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.aplicacion.servlet;

import com.aplicacion.beans.Docente;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author David Reyna
 */
@WebServlet(name = "BorrarHoraGrupo", urlPatterns = {"/BorrarHoraGrupo"})
public class Servlet_borrarHoraGrupo extends HttpServlet {

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
        PrintWriter out = response.getWriter();
        try {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet Servlet_borrarHoraGrupo</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet Servlet_borrarHoraGrupo at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        } finally {
            out.close();
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
        //processRequest(request, response);
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        HttpSession session= (HttpSession) request.getSession();     
        if(session.getAttribute("idUsuario")!=null){
            String idUsuario=session.getAttribute("idUsuario").toString();
            String id=request.getParameter("i");
            Docente d=new Docente();
            d.setIdUsuario(idUsuario);
            d.borraHoras(id);
            d.consultaHoras();
            String respuesta="";
            int horas=0,grupos=0;
            for(String[] hora:d.getListaHoras()){
                respuesta+="<tr><td>";
                respuesta+="Periodo: "+hora[2]+"<br/>";                
                if(hora[7].equals("A")){
                    respuesta+="Componente básico y/o propedéutico: ";
                }else if(hora[7].equals("S")){
                    respuesta+="Componente profesional:  ";
                }else if(hora[7].equals("T")){
                    respuesta+="Taller: ";
                }                
                if(hora[5]!=null){
                    respuesta+=hora[5]+" - ";
                }
                respuesta+=hora[4]+"<br/>";                                                              
                respuesta+="Grupo: "+hora[10]+"<br/>"; 
                respuesta+="Semestre: "+hora[6]+"<br/>"; 
                respuesta+="Horas: "+hora[9]+"<br/>";
                respuesta+="</td>";
                respuesta+="<td class='text-center'>";
                respuesta+="<button type='button' class='btn btn-sm' title='Borrar' onclick='borrarHoraGrupo("+hora[0]+")'>";
                respuesta+="<span class='glyphicon glyphicon-trash'></span>";
                respuesta+="</button>";                                               
                respuesta+="</td></tr>";
                horas+=Integer.parseInt(hora[9]);
                grupos++;
            }
            respuesta+="|"+horas+"|"+grupos;
            out.println(respuesta);
        }        
        out.close();
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
