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
@WebServlet(name = "RegistrarCriterio", urlPatterns = {"/RegistrarCriterio"})
public class Servlet_registrarCriterio extends HttpServlet {

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
            out.println("<title>Servlet Servlet_registrarCriterio</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet Servlet_registrarCriterio at " + request.getContextPath() + "</h1>");
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
            HttpSession session= (HttpSession) request.getSession();
            String idUsuario,rfc,estatus,idPermiso;
            int idEntidad = 0, idSubsistema = 0;
            boolean vistaAdmin;
            idEntidad = Integer.parseInt(request.getParameter("idEntidad"));
            idSubsistema = Integer.parseInt(request.getParameter("idSubsistema"));
            idPermiso = session.getAttribute("permisoActual").toString();
            if(session.getAttribute("rol").toString().equals("D")){
                idUsuario=session.getAttribute("idUsuario").toString();
                rfc=session.getAttribute("rfc").toString();
                vistaAdmin=false;
                estatus="P";
            }else{
                idUsuario=session.getAttribute("idDocente").toString();                
                rfc=session.getAttribute("rfcDocente").toString();
                vistaAdmin=true;
                estatus="R";
            }
            //String idConvocatoria=session.getAttribute("idConvocatoria").toString();
            String idCriterio=request.getParameter("idCriterio");
            int idCriterioNum = Integer.parseInt(request.getParameter("idCriterio"));
            Metodos_sql metodo = new Metodos_sql();
            String[] parametros;
            List<String[]> datos;
            if(!(idCriterio.equals("10") || idCriterio.equals("25"))){ 
                String idPuntaje=null;
                if(idCriterioNum == 1 || idCriterioNum == 2 || idCriterioNum == 3 || idCriterioNum == 4 || idCriterioNum == 16 || idCriterioNum == 17 || idCriterioNum == 18 || idCriterioNum == 19 ||idCriterioNum == 21){
                    idPuntaje=request.getParameter("puntaje");    
                }else{
                    if(request.getParameter("cbConstancia")!=null){
                        idPuntaje="0";
                    }else{
                        idPuntaje="55";
                    }
                }  
                System.out.println("puntaje="+idPuntaje);
                if(Integer.parseInt(idPuntaje)>=0){
                    parametros=new String[5];
                    parametros[0]=idUsuario;
                    parametros[1]=idCriterio;
                    parametros[2]=idPuntaje; 
                    parametros[3]=estatus;
                    parametros[4]=idPermiso;
                    datos=metodo.ejecutaSP("sp_insertConstanciasProceso",parametros);            
                    if(!datos.isEmpty()){
                        out.print(datos.get(0)[0]);
                    }else{
                        out.print("Error en almacenamiento de datos, intente nuevamente");
                    }
                }else{
                    parametros=new String[2];
                    parametros[0]=idUsuario;
                    parametros[1]=idCriterio;                          
                    datos=metodo.ejecutaSP("sp_deleteConstanciasProceso",parametros);            
                    if(!datos.isEmpty()){
                        if(datos.get(0)[0].equals("ok")){
                            out.print("Información almacenada correctamente");
                        }
                    }else{
                        out.print("Error en almacenamiento de datos, intente nuevamente");
                    }
                }
            }else{
                parametros=new String[5];
                int puntaje=0;
                String idPuntaje10 = ""; 
                String idPuntaje11 = ""; 
                String idPuntaje12 = ""; 
                String idPuntaje13 = ""; 
                String idPuntaje14 = "";
                
                if (idEntidad == 10 && idSubsistema == 2)
                {
                    idPuntaje10=request.getParameter("puntaje25"); 
                    idPuntaje11=request.getParameter("puntaje26"); 
                    idPuntaje13=request.getParameter("puntaje27"); 
                }               
                else
                {
                    idPuntaje10=request.getParameter("puntaje10"); 
                    idPuntaje11=request.getParameter("puntaje11"); 
                    idPuntaje12=request.getParameter("puntaje12"); 
                    idPuntaje13=request.getParameter("puntaje13"); 
                    idPuntaje14=request.getParameter("puntaje14");                
                }
                parametros[0]=idUsuario;
                
                if (idEntidad == 10 && idSubsistema == 2)
                    parametros[1]="25";
                else
                    parametros[1]="10";
                                
                parametros[2]=idPuntaje10;   
                parametros[3]=estatus;
                parametros[4]=idPermiso;
                datos=metodo.ejecutaSP("sp_insertConstanciasProceso",parametros);
                if(!datos.isEmpty( )){
                    puntaje+=Integer.parseInt(datos.get(0)[0]);
                }

                if (idEntidad == 10 && idSubsistema == 2)
                    parametros[1]="26";
                else
                    parametros[1]="11";

                parametros[2]=idPuntaje11;                                           
                datos=metodo.ejecutaSP("sp_insertConstanciasProceso",parametros);
                if(!datos.isEmpty()){
                    puntaje+=Integer.parseInt(datos.get(0)[0]);
                }

                if (!(idEntidad == 10 && idSubsistema == 2))
                {
                    parametros[1]="12";
                    parametros[2]=idPuntaje12;                                           
                    datos=metodo.ejecutaSP("sp_insertConstanciasProceso",parametros);
                    if(!datos.isEmpty()){
                        puntaje+=Integer.parseInt(datos.get(0)[0]);
                    }
                }

                if (idEntidad == 10 && idSubsistema == 2)
                    parametros[1]="27";
                else
                    parametros[1]="13";
                       
                parametros[2]=idPuntaje13;
                datos=metodo.ejecutaSP("sp_insertConstanciasProceso",parametros);
                if(!datos.isEmpty()){
                    puntaje+=Integer.parseInt(datos.get(0)[0]);
                }

                if (!(idEntidad == 10 && idSubsistema == 2))
                {
                    parametros[1]="14";
                    parametros[2]=idPuntaje14;                                           
                    datos=metodo.ejecutaSP("sp_insertConstanciasProceso",parametros);
                    if(!datos.isEmpty()){
                        puntaje+=Integer.parseInt(datos.get(0)[0]);
                    }
                }
                out.print(puntaje);
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
