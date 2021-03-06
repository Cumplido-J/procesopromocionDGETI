/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.aplicacion.servlet;

import com.aplicacion.beans.Docente;
import herramientas.Catalogos;
import herramientas.CriteriosValoracion;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletContext;
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
@WebServlet(name = "RegistroCriterios", urlPatterns = {"/RegistroCriterios"})
public class Servlet_cbRegistroCriterios extends HttpServlet {

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
            out.println("<title>Servlet Servlet_cbRegistroCriterios</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet Servlet_cbRegistroCriterios at " + request.getContextPath() + "</h1>");
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
        HttpSession session= (HttpSession) request.getSession();  

        if(session.getAttribute("rol")!=null){
            String idUsuario,rfc, idPermiso, permisoEdicion;
            boolean vistaAdmin;
            if(session.getAttribute("rol").toString().equals("D")){
                idUsuario=session.getAttribute("idUsuario").toString();
                rfc=session.getAttribute("rfc").toString();
                vistaAdmin=false;
            }else{
                idUsuario=session.getAttribute("idDocente").toString();                
                rfc=session.getAttribute("rfcDocente").toString();
                vistaAdmin=true;
            }           
            Docente docente;  
            idPermiso = session.getAttribute("permisoActual").toString();
            permisoEdicion = session.getAttribute("permisoActualEdicion").toString();
            Metodos_sql metodos=new Metodos_sql();
            CriteriosValoracion cv=new CriteriosValoracion();
            String[] parametros={idUsuario};            
            List<String[]>criterios=metodos.ejecutaSP("sp_selectCatCriteriosValoracion", parametros);
            
            docente=new Docente();
            docente.setIdUsuario(idUsuario);
            docente.setRfc(rfc);
            docente.consultaInfoAspirante();
            
            if (Integer.parseInt((docente.getInfoRegistro())[7]) == 10 && Integer.parseInt((docente.getInfoRegistro())[75]) == 2)
            {
                String[] infoRegsTmp = docente.getInfoRegistro();
                if (infoRegsTmp[19].equals("11") || infoRegsTmp[19].equals("12") || infoRegsTmp[19].equals("13"))
                    infoRegsTmp[19] = "69";
                if (infoRegsTmp[19].equals("14"))
                    infoRegsTmp[19] = "70";
                if (infoRegsTmp[19].equals("15"))
                    infoRegsTmp[19] = "71";
                docente.setInfoRegistro(infoRegsTmp);    
            }
            
            docente.consultaDocumentos();
            String[][] puntajes=cv.consultaPuntajes(idUsuario); 
            Catalogos catalogos=new Catalogos();
            ArrayList<String> datosUser=catalogos.getSelectUsuarioByID(idUsuario);
            String[] puntajeEncuestas=cv.consultaPuntajeEncuestas(rfc, datosUser.get(15));
            if( !session.getAttribute("rol").toString().equals("D")){
                    session.setAttribute("programa",docente.getInfoRegistro()[64]);
                }
            if(puntajeEncuestas[5]==null || puntajeEncuestas[5].isEmpty()){
                puntajeEncuestas[5]="0.0";
            }
            puntajeEncuestas[5] =  Double.toString(Math.round(Double.parseDouble(puntajeEncuestas[5])*100.0)/100.0);
            String validacionConvocatoria= session.getAttribute("rol").toString().equals("D") ? "0" :docente.getValidaAccionPorConvocatoria(idUsuario).get(0);
            String permisoTablaUsuarioEdicion=session.getAttribute("permisoTablaUsuarioEdicion").toString();
            cv.setPuntajeEncuestas(idUsuario, puntajeEncuestas[5]);
            
            request.setAttribute("docente", docente);
            request.setAttribute("criterios", criterios);
            request.setAttribute("puntajes", puntajes);
            request.setAttribute("puntajeEncuestas", puntajeEncuestas);
            request.setAttribute("validacionConvocatoria", validacionConvocatoria);            
            request.setAttribute("cursos", cv.getFilasCursos(idUsuario,vistaAdmin, idPermiso, permisoEdicion, permisoTablaUsuarioEdicion));

            if (!(Integer.parseInt((docente.getInfoRegistro())[7]) == 10 && Integer.parseInt((docente.getInfoRegistro())[75]) == 2))
            {
                request.setAttribute("aportaciones", cv.getFilasAportaciones(idUsuario,vistaAdmin, idPermiso, permisoEdicion, permisoTablaUsuarioEdicion));
            }           
            
            request.setAttribute("participaciones", cv.getFilasParticipaciones(idUsuario,vistaAdmin, idPermiso, permisoEdicion, permisoTablaUsuarioEdicion));
            request.setAttribute("tutorias", cv.getFilasTutorias(idUsuario,vistaAdmin, idPermiso, permisoEdicion ,permisoTablaUsuarioEdicion));
            request.setAttribute("publicaciones", cv.getFilasPublicaciones(idUsuario,vistaAdmin, idPermiso, permisoEdicion, permisoTablaUsuarioEdicion));
            
            if (!(Integer.parseInt((docente.getInfoRegistro())[7]) == 10 && Integer.parseInt((docente.getInfoRegistro())[75]) == 2))
            {
                request.setAttribute("resultados", cv.getFilasResultados(idUsuario,vistaAdmin, idPermiso, permisoEdicion, permisoTablaUsuarioEdicion));
            }
            
            request.setAttribute("vistaAdmin", vistaAdmin);
            
//            if (idPermiso.equals("6"))
//            {
                String[][] puntajesDictaminador=cv.consultaPuntajesDictaminador(idUsuario);
                request.setAttribute("puntajesDictaminador", puntajesDictaminador);
//            }
            
            ServletContext sc = getServletContext();
            RequestDispatcher rd;
            if(vistaAdmin){
                rd= sc.getRequestDispatcher("/revisionCriterios.jsp");
            }else{
                rd= sc.getRequestDispatcher("/registroCriterios.jsp");
            }
            rd.forward(request,response);
        }else{
            response.sendRedirect("login.jsp");
        }
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
        processRequest(request, response);
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
