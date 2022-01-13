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
 * @author jtrinidadl
 */
@WebServlet(name = "FichaDictamen", urlPatterns = {"/FichaDictamen"})
public class Servlet_cbFichaDictamen extends HttpServlet {

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
            out.println("<title>Servlet Servlet_cbFechaRegistroIncompleto</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet Servlet_cbFechaRegistroIncompleto at " + request.getContextPath() + "</h1>");
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
         Catalogos catalgo=new Catalogos();
        if(session.getAttribute("rol")!=null){
            String idUsuario,rfc,idPermiso,permisoEdicion;
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
            
            String rutaImagenInc="";
            String entidadUsuario=session.getAttribute("entidad").toString();
            String subsistemaUsuario=session.getAttribute("subsistema").toString();
            idPermiso = session.getAttribute("permisoActual").toString();
            permisoEdicion = session.getAttribute("permisoActualEdicion").toString();
            
            if(subsistemaUsuario.equals("2")){
                rutaImagenInc="logos/cecyte/logo_cecyte"+entidadUsuario+".jpg";
                System.out.println(rutaImagenInc);
            }else{
                rutaImagenInc="logos/logo_dgeti.jpg";
            }
            
            ArrayList<String> datosUser=catalgo.getSelectUsuarioByID(idUsuario);
            String idUsuarioPadre=datosUser.get(16);

            docente=new Docente();
            docente.setIdUsuario(idUsuario);
            docente.consultaInfoAspirante();
            docente.setIdUsuario( idUsuarioPadre !=null ? idUsuarioPadre: idUsuario);// se reinicia el id en caso de que exista un idUsuarioPadre
            docente.consultaHoras();            
            docente.actualizaBanderaIngles();
            if( !session.getAttribute("rol").toString().equals("D")){
                session.setAttribute("programa",docente.getInfoRegistro()[64]);
            }
            idUsuario = idUsuarioPadre != null ? idUsuarioPadre: idUsuario;
            
            CriteriosValoracion cv=new CriteriosValoracion();
            String[][] puntajesDictaminador=cv.consultaPuntajesDictaminador(idUsuario);
           
            request.setAttribute("puntajesDictaminador", puntajesDictaminador);
            request.setAttribute("resultados", cv.getFilasResultados2(idUsuario,vistaAdmin, idPermiso));
            String permisoTablaUsuarioEdicion=session.getAttribute("permisoTablaUsuarioEdicion").toString();
            request.setAttribute("cursos", cv.getFilasCursos(idUsuario,vistaAdmin,idPermiso,permisoEdicion,permisoTablaUsuarioEdicion));
            request.setAttribute("aportaciones", cv.getFilasAportaciones(idUsuario,vistaAdmin,idPermiso,permisoEdicion, permisoTablaUsuarioEdicion));
            request.setAttribute("tutorias", cv.getFilasTutorias(idUsuario,vistaAdmin,idPermiso,permisoEdicion, permisoTablaUsuarioEdicion));
            request.setAttribute("participaciones", cv.getFilasParticipaciones(idUsuario,vistaAdmin,idPermiso,permisoEdicion, permisoTablaUsuarioEdicion));
            request.setAttribute("publicaciones", cv.getFilasPublicaciones(idUsuario,vistaAdmin,idPermiso,permisoEdicion, permisoTablaUsuarioEdicion));
            
            //docente=new Docente();
            //docente.setIdUsuario(idUsuario);
            //docente.consultaInfoAspirante();
            //docente.consultaHoras();            
            //docente.actualizaBanderaIngles();
            //docente.setIdUsuario( idUsuarioPadre !=null ? idUsuarioPadre: idUsuario);// se reinicia el id en caso de que exista un idUsuarioPadre
            //Catalogos catalogos=new Catalogos();
            //ArrayList<String> datosUser=catalogos.getSelectUsuarioByID(idUsuario);
            String[] puntajeEncuestas=null;
            if(idUsuarioPadre !=null ){
                ArrayList<String> datosUser2=catalgo.getSelectUsuarioByID(idUsuarioPadre);
                puntajeEncuestas=cv.consultaPuntajeEncuestas(rfc,datosUser2.get(15));
            }else{
                puntajeEncuestas=cv.consultaPuntajeEncuestas(rfc,datosUser.get(15));
            }
            //puntajeEncuestas=cv.consultaPuntajeEncuestas(rfc,datosUser.get(15));
            request.setAttribute("puntajeEncuestas", puntajeEncuestas);
            
            String[] parametros={idUsuario};            
            List<String[]> infoPlazas=new Metodos_sql().ejecutaSP("sp_consultaUsuarioPlaza",parametros);
            request.setAttribute("infoPlazas", infoPlazas);
            request.setAttribute("Docente", docente);
            request.setAttribute("rutaImagenInc", rutaImagenInc);
            request.setAttribute("observacionesR", catalgo.getSelectObservacionPaso1(idUsuario));
            request.setAttribute("uPadre",idUsuarioPadre !=null ? "1": "2");
            ServletContext sc = getServletContext();
            RequestDispatcher rd = sc.getRequestDispatcher("/FichaDictamen.jsp");
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
