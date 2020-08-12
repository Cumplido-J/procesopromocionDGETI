/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.convocatoria.servlet;

import com.google.gson.Gson;
import com.convocatoria.datos.PlantelJDBC;
import com.convocatoria.domain.Plantel;
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
@WebServlet("/ServletControladorPlantel")
public class ServletControladorPlantel extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        PrintWriter out = response.getWriter();
        response.setContentType("application/json; charset=UTF-8");
        Gson gson = new Gson();
        List<Plantel> planteles = null;
        //Entidad entidad = null;
        String id_str = request.getParameter("id");
        System.out.println(id_str);
        int id = Integer.parseInt(id_str);
        if (id > 0) {

            try {
                //entidad = new Entidad(id);
                planteles = new PlantelJDBC().select(id);
                if(planteles.size()>0){
                    
                out.print(gson.toJson(planteles));
                out.flush();
                }
            } catch (Exception e) {
            }
        }
    }

}
