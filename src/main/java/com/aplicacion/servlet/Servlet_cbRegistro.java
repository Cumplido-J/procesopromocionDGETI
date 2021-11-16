/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.aplicacion.servlet;

import com.aplicacion.beans.Docente;
import com.aplicacion.beans.HoraGrupo;
import herramientas.Catalogos;
import herramientas.RutaConfig;
import java.io.FileReader;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import java.util.Properties;
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
@WebServlet(name = "Registro", urlPatterns = {"/Registro"})
public class Servlet_cbRegistro extends HttpServlet {
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
            out.println("<title>Servlet Servlet_cbregistro</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet Servlet_cbregistro at " + request.getContextPath() + "</h1>");
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
        String id="",rfc="";
        boolean vistaAdmin=false;
        Catalogos catalgo=new Catalogos();
        
        if(session.getAttribute("rol")!=null){
        if(session.getAttribute("rol").toString().equals("D")){
            id=session.getAttribute("idUsuario").toString();
            rfc=session.getAttribute("rfc").toString();
            vistaAdmin=false; 
            
        }else{
            id=session.getAttribute("idDocente").toString();
            rfc=session.getAttribute("rfcDocente").toString();
            vistaAdmin=true;
            request.setAttribute("observacionesR", catalgo.getSelectObservacionPaso1(id));
        }
        if(!id.equals("")&&!rfc.equals("")){
            docente=new Docente();
            docente.setIdUsuario(id);
            docente.setRfc(rfc);
            docente.consultaInfoAspirante();
            String datos[]=docente.getInfoRegistro();            
            //if(!datos[66].equalsIgnoreCase("1") || session.getAttribute("rol").toString().equals("A") || session.getAttribute("rol").toString().equals("S")){
                docente.consultaDocumentos();
                docente.consultaHoras();
                if( !session.getAttribute("rol").toString().equals("D")){
                    session.setAttribute("programa",docente.getInfoRegistro()[64]);
                }
                String rutaConfig = RutaConfig.getRutaConfig();
                Properties p = new Properties(); 
                p.load(new FileReader(rutaConfig));            
                Boolean consultarWS= Boolean.parseBoolean(p.getProperty("consultarWS"));
                if(docente.getListaHoras().isEmpty() && consultarWS){
                    docente.consumeWSCatalogoDocentes();
                    docente.procesaJsonHoras();
                    docente.registraHorasWS();
                    docente.consultaHoras();                    
                } 
                docente.actualizaBanderaIngles();
                request.setAttribute("Docente", docente);
                request.setAttribute("vistaAdmin", vistaAdmin);
                ServletContext sc = getServletContext();
                RequestDispatcher rd = sc.getRequestDispatcher("/registro.jsp");
                rd.forward(request,response);
            //}else{
//                response.sendRedirect("SesionDocente");
            //}

        }else{
            response.sendRedirect("login.jsp");
        }
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
