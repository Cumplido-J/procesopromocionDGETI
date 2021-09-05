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
@WebServlet(name = "RegistroHorasGrupo", urlPatterns = {"/RegistroHorasGrupo"})
public class Servlet_registroHorasGrupo extends HttpServlet {

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
            out.println("<title>Servlet Servlet_registroHorasGrupo</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet Servlet_registroHorasGrupo at " + request.getContextPath() + "</h1>");
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
        response.setContentType("text/html;charset=UTF-8");
        
        String parametro = request.getParameter("accion");
        parametro= (parametro==null) ? "cecyte": parametro;
        
        try{
         switch(parametro){
                case "cecyte": 
                    registroInfoCECYTE(request,response);    
                    break;
                case "dgeti":
                    registroInfoDGETI(request, response);
                    break;
            }
        }catch(IOException | ServletException e){
            System.out.println("Servlet_registroHorasGrupo :"+ e);}
        /*response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        HttpSession session= (HttpSession) request.getSession();     
        if(session.getAttribute("rol")!=null){
            String idUsuario,rfc;
            if(session.getAttribute("rol").toString().equals("D")){
                idUsuario=session.getAttribute("idUsuario").toString();
                rfc=session.getAttribute("rfc").toString();
            }else{
                idUsuario=session.getAttribute("idDocente").toString();                
                rfc=session.getAttribute("rfcDocente").toString();
            }
            
            String tipoInfo="";
            String idPeriodo=request.getParameter("periodo");
            tipoInfo=request.getParameter("tipoInfo");
            
            if(tipoInfo==null){
                tipoInfo=request.getParameter("tipoInfoCecyte");
            }
            
            String idAsignatura="0";
            switch (tipoInfo){
                case "cbp":
                    idAsignatura=request.getParameter("asignatura");
                    if(idAsignatura==null){
                        idAsignatura=request.getParameter("asignatura1");
                    }
                    break;
                case "cp":
                    idAsignatura=request.getParameter("submodulo");
                    if(idAsignatura==null){
                        idAsignatura=request.getParameter("submodulo1");
                    }
                    break;
                case "tl":
                    idAsignatura=request.getParameter("taller");
                    if(idAsignatura==null){
                        idAsignatura=request.getParameter("taller1");
                    }
                    break;
                default:
                    break;                
            }
            
            String semestre="";
            String horas=request.getParameter("horas");
            semestre=request.getParameter("semestre");
            String grupo=request.getParameter("grupo").toUpperCase();
            if(horas==null){
                horas="";
            }
            if(semestre==null){
                semestre=request.getParameter("semestre1");
            }
            if(grupo==null){
                grupo="";
            }
            Docente d=new Docente();
            d.setIdUsuario(idUsuario);
            d.registraHoras(idPeriodo, idAsignatura, horas, grupo,semestre);
            d.consultaHoras();
            String respuesta="";
            int totalHoras=d.getTotalHoras();
            int grupos=d.getNumGrupos();
            respuesta=d.mostrarHoras();
            respuesta+="|"+totalHoras+"|"+grupos;
            out.println(respuesta);
        }        
        out.close();*/
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

    private void registroInfoCECYTE(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
    
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        HttpSession session= (HttpSession) request.getSession();     
        if(session.getAttribute("rol")!=null){
            String idUsuario,rfc;
            if(session.getAttribute("rol").toString().equals("D")){
                idUsuario=session.getAttribute("idUsuario").toString();
                rfc=session.getAttribute("rfc").toString();
            }else{
                idUsuario=session.getAttribute("idDocente").toString();                
                rfc=session.getAttribute("rfcDocente").toString();
            }
            
            String tipoInfo="";
            String idPeriodo=request.getParameter("periodo");
            tipoInfo=request.getParameter("tipoInfo");
            
            if(tipoInfo==null){
                tipoInfo=request.getParameter("tipoInfoCecyte");
            }
            
            String idAsignatura="0";
            
            /*switch (tipoInfo){
                case "cbp":
                    idAsignatura=request.getParameter("asignatura");
                    if(idAsignatura==null){
                        idAsignatura=request.getParameter("asignatura1");
                    }
                    break;
                case "cp":
                    idAsignatura=request.getParameter("submodulo");
                    if(idAsignatura==null){
                        idAsignatura=request.getParameter("submodulo1");
                    }
                    break;
                case "tl":
                    idAsignatura=request.getParameter("taller");
                    if(idAsignatura==null){
                        idAsignatura=request.getParameter("taller1");
                    }
                    break;
                default:
                    break;                
            }*/
            
            String semestre="";
            String horas=request.getParameter("horas");
            semestre=request.getParameter("semestre");
            String grupo=request.getParameter("grupo").toUpperCase();
            if(horas==null){
                horas="";
            }
            if(semestre==null){
                semestre=request.getParameter("semestre1");
            }
            if(grupo==null){
                grupo="";
            }
            Docente d=new Docente();
            d.setIdUsuario(idUsuario);
            d.registraHoras(idPeriodo, idAsignatura, horas, grupo,semestre);
            d.consultaHoras();
            String respuesta="";
            int totalHoras=d.getTotalHoras();
            int grupos=d.getNumGrupos();
            respuesta=d.mostrarHoras();
            respuesta+="|"+totalHoras+"|"+grupos;
            out.println(respuesta);
        }
                out.close();
    }
    
    private void registroInfoDGETI(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
    
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        HttpSession session= (HttpSession) request.getSession();     
        if(session.getAttribute("rol")!=null){
            String idUsuario,rfc;
            if(session.getAttribute("rol").toString().equals("D")){
                idUsuario=session.getAttribute("idUsuario").toString();
                rfc=session.getAttribute("rfc").toString();
            }else{
                idUsuario=session.getAttribute("idDocente").toString();                
                rfc=session.getAttribute("rfcDocente").toString();
            }
            
            String tipoInfo="";
            String idPeriodo=request.getParameter("periodo");
            tipoInfo=request.getParameter("tipoInfo");
            
            
            String idAsignatura="0",idAsignatura2="0",idAsignatura3="0";
            idAsignatura=request.getParameter("asignatura1");
            idAsignatura2=request.getParameter("submodulo1");
            idAsignatura3=request.getParameter("taller1");
            

            
            String semestre="";
            String horas=request.getParameter("horas");
            semestre=request.getParameter("semestre");
            String grupo=request.getParameter("grupo").toUpperCase();
            if(horas==null){
                horas="";
            }
            if(semestre==null){
                semestre=request.getParameter("semestre1");
            }
            if(grupo==null){
                grupo="";
            }
            Docente d=new Docente();
            d.setIdUsuario(idUsuario);
            if((!idAsignatura.equals("0") || !idAsignatura2.equals("0")) || !idAsignatura3.equals("0")) {
                d.registraHorasDGETI(idPeriodo, idAsignatura, horas, grupo,semestre,idAsignatura2,idAsignatura3);
            } 
            d.consultaHoras();
            String respuesta="";
            int totalHoras=d.getTotalHoras();
            int grupos=d.getNumGrupos();
            respuesta=d.mostrarHoras();
            respuesta+="|"+totalHoras+"|"+grupos;
            out.println(respuesta);
        }
                out.close();
    }
}
