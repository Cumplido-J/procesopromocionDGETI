/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.aplicacion.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import herramientas.Catalogos;
/**
 *
 * @author David Reyna
 */
@WebServlet(name = "ConsultaCatalogos", urlPatterns = {"/ConsultaCatalogos"})
public class Servlet_consultaCatalogos extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    
    Catalogos catalogo=new Catalogos();
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        try {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet Servlet_consultaCatalogos</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet Servlet_consultaCatalogos at " + request.getContextPath() + "</h1>");
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
        PrintWriter out = response.getWriter();
        try {
            /* TODO output your page here. You may use following sample code. */
            String key=request.getParameter("k");
            String respuesta;
            switch(key)
            {    
               case "1":
                  respuesta=catalogo.desplegarOpcionesInstituciones(request.getParameter("i"),request.getParameter("t"));
               break;
               case "2":
                  respuesta=catalogo.desplegarOpcionesEscuelas(request.getParameter("i"));
               break; 
               case "3":
                  respuesta=catalogo.desplegarVersionesCompBP();
               break; 
               case "4":
                  respuesta=catalogo.desplegarVersionesCompP();
               break;
               case "5":
                  respuesta=catalogo.desplegarAsignaturasCompBP(request.getParameter("v"),request.getParameter("s"));
               break; 
               case "6":
                  respuesta=catalogo.desplegarCarrerasCompP(request.getParameter("v"),request.getParameter("s"));
               break; 
               case "7":
                  respuesta=catalogo.desplegarModulosCompP(request.getParameter("v"),request.getParameter("s"),request.getParameter("c"));
               break;
               case "8":
                  respuesta=catalogo.desplegarSubmodulosCompP(request.getParameter("v"),request.getParameter("s"),request.getParameter("c"),request.getParameter("m"));
               break;
               case "9":
                  respuesta=catalogo.desplegarOpcionesJornada(request.getParameter("i"));
               break;
               case "10":
                  respuesta=catalogo.desplegarRequisitosCategoria(request.getParameter("i"));
               break;
               case "11":
                  respuesta=catalogo.desplegarOpcionesTipoInstitucion(request.getParameter("i"));
               break;
               case "12":
                  respuesta=catalogo.desplegarOpcionesCCT(request.getParameter("i"));
               break;
               case "13":
                   respuesta=catalogo.desplegarOpcionesPlanteles(request.getParameter("i"));                   
               break;
               case "14":
                  respuesta=catalogo.desplegarOpcionesJornadaVacante(request.getParameter("i"),request.getParameter("pl"),request.getParameter("pr"));
               break;
               case "15":
                  respuesta=catalogo.desplegarOpcionesConvocatoria(request.getParameter("i"));
               break;
               case "16":
                   respuesta=catalogo.desplegarOpcionesPlanteles2(request.getParameter("s"),request.getParameter("e"));                   
               break;
               case "17":
                   respuesta=catalogo.desplegarOpcionesJornadaVacante(request.getParameter("i"),request.getParameter("pl"),request.getParameter("pr"));
                   respuesta+="|"+catalogo.desplegarRequisitosCategoria(request.getParameter("i"));
               break;
               case "18":
                   respuesta=catalogo.desplegarOpcionesVacancia(request.getParameter("e"),request.getParameter("s"),request.getParameter("i"),request.getParameter("m"));                   
               break;
               case "19":
                   respuesta=catalogo.desplegarOpcionesJornada(request.getParameter("e"),request.getParameter("s"),request.getParameter("i"),request.getParameter("m"),request.getParameter("n"));                   
               break;
               case "20":
                   respuesta=catalogo.desplegarNumeroPlazas(request.getParameter("e"),request.getParameter("s"),request.getParameter("i"),request.getParameter("m"),request.getParameter("n"),request.getParameter("p"));                   
               break;
               default : 
                   respuesta="<option value=''>-Seleccione-</option>";
                  break;
            }
                    
            
            out.println(respuesta);
                      
        }catch(Exception e){
            out.println(e);
        } 
        finally {
            out.close();
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
