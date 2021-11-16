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
import herramientas.Datos;

/**
 *
 * @author LENOVO
 */
@WebServlet(name = "Servlet_buscarGanadores", urlPatterns = {"/BuscarGanadores"})
public class Servlet_buscarGanadores extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        //processRequest(request, response);
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        String programa = request.getParameter("programa");
        String subsistema = request.getParameter("subsistema");
        String entidad = request.getParameter("entidad");
        String plantel = request.getParameter("plantel");
        String nombre = request.getParameter("rfcNombre");
        //String estatus = request.getParameter("estatus");
        String periodo = request.getParameter("periodo");
        /*
        String salto = "\n";
        String consola =  programa + salto + subsistema + salto + entidad + salto + plantel + nombre + estatus + periodo + salto;
        out.print("Buscnado Ganadores" + salto + consola);
         */
        Datos d = new Datos();

        //Debe tener un programa
        if (!programa.equals("")) { //buscar por programa, subsistema
            out.print(d.desplegarGanadores(programa, subsistema, entidad, plantel, nombre, periodo));

        } else {
            System.out.println("No seleccionaron programa");
            out.print("noprograma");
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
