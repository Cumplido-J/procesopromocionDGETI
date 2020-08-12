/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.convocatoria.servlet;
import com.convocatoria.datos.EntidadJDBC;
import com.google.gson.Gson;
import com.convocatoria.domain.Entidad;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author ja1000
 */
@WebServlet("/ServletControladorEntidad")
public class ServletControladorEntidad extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        PrintWriter out = response.getWriter();
        response.setContentType("application/json; charset=UTF-8");

        List<Entidad> entidades = null;
        Gson gson = new Gson();

        try {
            entidades = new EntidadJDBC().select();
            if (entidades.size() > 0) {
                out.print(gson.toJson(entidades));
                out.flush();
            }

        } catch (Exception e) {
        }

    }

}
