/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.aplicacion.servlet;

import constants.ConstantsWS;
import herramientas.Datos;
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
 * @author Fernando
 */
@WebServlet(name = "asignarCategoria", urlPatterns = {"/asignarCategoria"})
public class Servlet_asignarCategoria extends HttpServlet {

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
            out.println("<title>Servlet Servlet_buscarAspiranteGanador</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet Servlet_buscarAspiranteGanador at " + request.getContextPath() + "</h1>");
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
        try{
            PrintWriter out = response.getWriter();
            HttpSession session= (HttpSession) request.getSession();
                String id=request.getParameter("id");
                String z=request.getParameter("z");
                String idEstatus=request.getParameter("idEstatus");
                String programa=request.getParameter("programa");
                String subsistema=request.getParameter("subsistema");
                String entidad=request.getParameter("entidad");
                String plantel=request.getParameter("plantel");
                String categoria=request.getParameter("categoria");
                String jornada=request.getParameter("jornada");
                String vacancia=request.getParameter("vacancia");
                String periodo=request.getParameter("periodo");
                Datos d=new Datos();
                Metodos_sql metodo = new Metodos_sql();
                String[] parametros={id,idEstatus,ConstantsWS.RONDA_GANADOR_PLANTEL};
                String[] parametrosActualizaVacancia={programa,subsistema,plantel,categoria,jornada,vacancia,periodo,id,ConstantsWS.RONDA_GANADOR_PLANTEL};
                String[] parametrosActualizaVacanciaRechazo={programa,subsistema,plantel,categoria,jornada,vacancia,periodo,id,ConstantsWS.RONDA_GANADOR_PLANTEL,"2"};
                String[] parametrosActualizaVacanciaRechazo1={programa,subsistema,plantel,categoria,jornada,vacancia,periodo,id,ConstantsWS.RONDA_GANADOR_PLANTEL,"3"};
                
                //Acepto 2
                //Rechazo 3
                if(idEstatus.equals("1")){
                    List<String[]> datos;
                    datos=metodo.ejecutaSP("sp_updateGanadorVacancia",parametrosActualizaVacancia);
                    if(datos.get(0)[0].equals("No hay mas vacancias disponibles")){
                        out.print("No hay mas vacancias disponibles");
                    }else if(datos.get(0)[0].equals("El aspirante ya cuenta con una vacante asignada")){
                        out.print("El aspirante ya cuenta con una vacante asignada");
                    }else{
                        //datos=metodo.ejecutaSP("sp_updateEstatusAspirante",parametros);
                        //out.print(d.desplegarAspirantesAsignacion2(z, programa, subsistema, entidad, plantel, categoria, jornada, vacancia, periodo));
                        out.print(d.desplegarAspirantesAsignacionUpdate(id, programa, subsistema, entidad, plantel, categoria, jornada, vacancia, periodo));
                        
                    }
                    //out.print(d.desplegarAspirantesAsignacion(id, programa, subsistema, entidad, plantel, categoria, jornada, vacancia, periodo));
                //Se ejecutara un sp para actualizar el aspirante y la vacancia maracando el aspirante para que en la asignacion a nivel estal no se tome en cuenta.
                }else if(idEstatus.equals("2") || idEstatus.equals("3")){
                    List<String[]> datos;
                    if(idEstatus.equals("2")){
                        datos=metodo.ejecutaSP("sp_updateGanadorVacanciaRechazo",parametrosActualizaVacanciaRechazo);
                    }else{
                        datos=metodo.ejecutaSP("sp_updateGanadorVacanciaRechazo",parametrosActualizaVacanciaRechazo1);
                    }

                    if(datos.get(0)[0].equals("ok")){
                        //out.print("Se guardo correctamente");
                        out.print(d.desplegarAspirantesAsignacionUpdate(id, programa, subsistema, entidad, plantel, categoria, jornada, vacancia, periodo));
                    }
                    //Se ejecutara un sp para actualizar el aspirante y la vacancia maracando el aspirante para que en la asignacion a nivel estal no se tome en cuenta.
                }
                
        }catch(Exception e){
            System.out.println(e.toString());
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
