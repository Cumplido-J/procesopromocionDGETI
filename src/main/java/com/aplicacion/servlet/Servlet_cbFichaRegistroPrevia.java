/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.aplicacion.servlet;

import com.aplicacion.beans.Docente;
import herramientas.CriteriosValoracion;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletContext;
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
@WebServlet(name = "FichaRegistroPrevia", urlPatterns = {"/FichaRegistroPrevia"})
public class Servlet_cbFichaRegistroPrevia extends HttpServlet {
    Docente docente;
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
            out.println("<title>Servlet Servlet_cbFichaRegistroPrevia</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet Servlet_cbFichaRegistroPrevia at " + request.getContextPath() + "</h1>");
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
        if(session.getAttribute("idUsuario")!=null){
            String idUsuario=session.getAttribute("idUsuario").toString();
            String rfc=session.getAttribute("rfc").toString();
            CriteriosValoracion cv=new CriteriosValoracion();
            docente=new Docente();
            docente.setIdUsuario(idUsuario);
            docente.consultaInfoAspirante();
            docente.consultaHoras();            
            docente.actualizaBanderaIngles();
            String[][] puntajes=cv.consultaPuntajes(idUsuario); 
            String[] puntajeEncuestas=cv.consultaPuntajeEncuestas(rfc);
            request.setAttribute("Docente", docente);
            request.setAttribute("puntajes", puntajes);
            request.setAttribute("puntajeEncuestas", puntajeEncuestas);            
            request.setAttribute("cursos", cv.getFilasCursosFicha(idUsuario));
            request.setAttribute("aportaciones", cv.getFilasAportacionesFicha(idUsuario));
            request.setAttribute("participaciones", cv.getFilasParticipacionesFicha(idUsuario));
            request.setAttribute("tutorias", cv.getFilasTutoriasFicha(idUsuario));
            request.setAttribute("publicaciones", cv.getFilasPublicacionesFicha(idUsuario));
            request.setAttribute("resultados", cv.getFilasResultadosFicha(idUsuario));
            ServletContext sc = getServletContext();
            RequestDispatcher rd = sc.getRequestDispatcher("/FichaRegistroPrevia.jsp");
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
