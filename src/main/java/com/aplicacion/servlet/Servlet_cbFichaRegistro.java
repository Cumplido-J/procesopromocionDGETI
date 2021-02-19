/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.aplicacion.servlet;

import com.aplicacion.beans.Docente;
import com.aplicacion.beans.HoraGrupo;
import herramientas.CriteriosValoracion;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.PrintWriter;
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
@WebServlet(name = "FichaRegistro", urlPatterns = {"/FichaRegistro"})
public class Servlet_cbFichaRegistro extends HttpServlet {
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
        PrintWriter out = response.getWriter();
        try {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet Servlet_cbFichaRegistro</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet Servlet_cbFichaRegistro at " + request.getContextPath() + "</h1>");
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
        HttpSession session= (HttpSession) request.getSession();     
        if(session.getAttribute("rol")!=null){
            String idUsuario,rfc,idPermiso;
            if(session.getAttribute("rol").toString().equals("D")){
                idUsuario=session.getAttribute("idUsuario").toString();
                rfc=session.getAttribute("rfc").toString();
            }else{
                idUsuario=session.getAttribute("idDocente").toString();                
                rfc=session.getAttribute("rfcDocente").toString();
            }
            
            //Seobtienen datos para validar que imagen se va a mostrar en la ficha de registro.
            String rutaImagen="";
            String entidadUsuario=session.getAttribute("entidad").toString();
            String subsistemaUsuario=session.getAttribute("subsistema").toString();
            
            if(subsistemaUsuario.equals("2")){
                rutaImagen="logos/cecyte/logo_cecyte+"+entidadUsuario+"+.jpg";
            }else{
                rutaImagen="logos/logo_dgeti.jpg";
            }
            
            idPermiso = session.getAttribute("permisoActual").toString();
            
            CriteriosValoracion cv=new CriteriosValoracion();
            docente=new Docente();
            docente.setIdUsuario(idUsuario);
            docente.consultaInfoAspirante();
            docente.consultaHoras();            
            docente.actualizaBanderaIngles();
            String[][] puntajes=cv.consultaPuntajes(idUsuario, idPermiso); 
            String[] puntajeEncuestas=cv.consultaPuntajeEncuestas(rfc);
            String[] parametros={idUsuario};            
            List<String[]> infoPlazas=new Metodos_sql().ejecutaSP("sp_consultaUsuarioPlaza",parametros);
            request.setAttribute("infoPlazas", infoPlazas);
            request.setAttribute("Docente", docente);            
            request.setAttribute("puntajes", puntajes);
            request.setAttribute("puntajeEncuestas", puntajeEncuestas);            
            request.setAttribute("cursos", cv.getFilasCursosFicha(idUsuario));
            request.setAttribute("aportaciones", cv.getFilasAportacionesFicha(idUsuario));
            request.setAttribute("participaciones", cv.getFilasParticipacionesFicha(idUsuario));
            request.setAttribute("tutorias", cv.getFilasTutoriasFicha(idUsuario));
            request.setAttribute("publicaciones", cv.getFilasPublicacionesFicha(idUsuario));
            request.setAttribute("resultados", cv.getFilasResultadosFicha(idUsuario));
            request.setAttribute("rutaimagen", rutaImagen);
            ServletContext sc = getServletContext();
            RequestDispatcher rd = sc.getRequestDispatcher("/FichaRegistro.jsp");
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
