/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.convocatoria.servlet;

import com.convocatoria.datos.ConvocatoriaJDBC;
import com.convocatoria.domain.Convocatoria;
import com.google.gson.Gson;
import com.convocatoria.datos.VacanciaJDBC;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author ja1000
 */
@WebServlet("/ServletControladorVacancia")
public class ServletControladorVacancia extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        PrintWriter out = response.getWriter();
        List<Integer> filtrar_convocatorias = null;
        String str_id = request.getParameter("id");
        Gson gson = new Gson();
        int id = Integer.parseInt(str_id);
        //Todas ls convocatorias vigentes
        List<Convocatoria> convocatorias_tmp = new ConvocatoriaJDBC().select(""+id);

        if (convocatorias_tmp != null) {
            List<Convocatoria> convocatorias = new ArrayList<>();
            //Filtrando vacancias de convocatorias vigentes
            for(Convocatoria c : convocatorias_tmp){
                System.out.println(c.getNombre());
               int vac_tot = new VacanciaJDBC().selectPorConvocatoria(c.getId(), id);
               if(vac_tot>0){
                           
                   convocatorias.add(c);
               }
            }
                out.print(gson.toJson(convocatorias));

        }else{
        
        out.print(gson.toJson("No convocatorias vigentes"));
        }
    }

}
