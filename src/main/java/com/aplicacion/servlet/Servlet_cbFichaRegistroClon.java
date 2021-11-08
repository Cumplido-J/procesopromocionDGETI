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
 * @author Fernando
 */
@WebServlet(name = "FichaRegistroClon", urlPatterns = {"/FichaRegistroClon"})
public class Servlet_cbFichaRegistroClon extends HttpServlet {
    Docente docente;
    Docente docente1;
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
        response.setContentType("text/html;charset=UTF-8");
        HttpSession session= (HttpSession) request.getSession();
        PrintWriter out = response.getWriter();
        if(session.getAttribute("rol")!=null){
            String idUsuario,rfc,idPermiso;
            String entidadUsuario="";
            if(session.getAttribute("rol").toString().equals("D")){
                idUsuario=session.getAttribute("idUsuario").toString();
                rfc=session.getAttribute("rfc").toString();
                entidadUsuario=session.getAttribute("entidad").toString();
            }else{
                idUsuario=session.getAttribute("idDocente").toString();                
                rfc=session.getAttribute("rfcDocente").toString();
                entidadUsuario=session.getAttribute("entidadDocente").toString();
            }
            
            //Seobtienen datos para validar que imagen se va a mostrar en la ficha de registro.
            String rutaImagen="";
            String subsistemaUsuario=session.getAttribute("subsistema").toString();
            
            if(subsistemaUsuario.equals("2")){
                rutaImagen="logos/cecyte/logo_cecyte"+entidadUsuario+".jpg";
                System.out.println(rutaImagen);
            }else{
                rutaImagen="logos/logo_dgeti.jpg";
            }
            
            idPermiso = session.getAttribute("permisoActual").toString();
            
            
            Catalogos catalogos=new Catalogos();
            ArrayList<String> datosUser=catalogos.getSelectUsuarioByID(idUsuario);
            String idUsuarioPadre=datosUser.get(16);
            
            CriteriosValoracion cv=new CriteriosValoracion();
            List<String[]> infoCategoria=null;
            if( idUsuarioPadre !=null ){
                String[] parametros={idUsuario};   
                infoCategoria=new Metodos_sql().ejecutaSP("sp_consultaVacanciaDocente",parametros);
            }
            docente=new Docente();
            docente.setIdUsuario(idUsuario);
            docente.consultaInfoAspirante2();
            docente.setIdUsuario( idUsuarioPadre !=null ? idUsuarioPadre: idUsuario);// se reinicia el id en caso de que exista un idUsuarioPadre
            if(subsistemaUsuario.equals("2")){
                docente.consultaHorasCecyte();
            }else{
                docente.consultaHoras();
                docente.actualizaBanderaIngles();
            }

            docente1=new Docente();
            docente1.setIdUsuario(idUsuario);
            docente1.consultaInfoAspirante();
            
            if( !session.getAttribute("rol").toString().equals("D")){
                session.setAttribute("programa",docente.getInfoRegistro()[64]);
            }
                        
            idUsuario = idUsuarioPadre != null ? idUsuarioPadre: idUsuario;
            String[][] puntajes=cv.consultaPuntajes(idUsuario);
            String[] puntajeEncuestas=null;
           
            if(idUsuarioPadre !=null ){
                ArrayList<String> datosUser2=catalogos.getSelectUsuarioByID(idUsuarioPadre);
                puntajeEncuestas=cv.consultaPuntajeEncuestas(rfc,datosUser2.get(15));
            }else{
                puntajeEncuestas=cv.consultaPuntajeEncuestas(rfc,datosUser.get(15));
            }
            //String[] puntajeEncuestas=cv.consultaPuntajeEncuestas(rfc, datosUser.get(15));
            
            String[] parametros={idUsuario};            
            List<String[]> infoPlazas=new Metodos_sql().ejecutaSP("sp_consultaUsuarioPlaza",parametros);
            List<String[]> infoPlazasAspira=new Metodos_sql().ejecutaSP("sp_consultaUsuarioCategoriaAspira",parametros);
            request.setAttribute("infoPlazas", infoPlazas);
            request.setAttribute("infoPlazasAspira", infoPlazasAspira);
            request.setAttribute("Docente", docente);            
            request.setAttribute("puntajes", puntajes);
            request.setAttribute("puntajeEncuestas", puntajeEncuestas);            
            request.setAttribute("cursos", cv.getFilasCursosFicha(idUsuario));
            request.setAttribute("aportaciones", cv.getFilasAportacionesFicha(idUsuario));
            request.setAttribute("participaciones", cv.getFilasParticipacionesFicha(idUsuario));
            request.setAttribute("tutorias", cv.getFilasTutoriasFicha(idUsuario));
            request.setAttribute("publicaciones", cv.getFilasPublicacionesFicha(idUsuario));
            request.setAttribute("resultados", cv.getFilasResultadosFicha(idUsuario));
            request.setAttribute("evidencias", cv.getFilasResultadosConstancias(idUsuario));
            request.setAttribute("registroEvidencias", cv.getFilasResultadosRegistro(idUsuario));
            request.setAttribute("rutaimagen", rutaImagen);
            request.setAttribute("banderaIdUsuarioPadre", (idUsuarioPadre != null));
            request.setAttribute("Docente1", docente1);
            request.setAttribute( "infoCategoria", idUsuarioPadre != null ? infoCategoria : null );
            request.setAttribute( "idUsuarioPadrePeriodo", idUsuarioPadre != null ? 1 : 0 );
            ServletContext sc = getServletContext();
            RequestDispatcher rd = sc.getRequestDispatcher("/FichaRegistroClon.jsp");
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
