/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package web;

import com.google.gson.Gson;
import datos.ConvocatoriaJDBC;
import datos.VacanciaJDBC;
import domain.Convocatoria;
import domain.Vacancia;
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
        int idplantel = Integer.parseInt(request.getParameter("id"));
        ServletContext ctx = request.getServletContext();
        if (idplantel > 0) {
            List<Vacancia> vacancias = new VacanciaJDBC().select(idplantel);
            response.setContentType("application/json; charset=UTF-8");
            if (vacancias.size() > 0) {
                List<Convocatoria> convoc = new ArrayList<Convocatoria>();
                filtrar_convocatorias = buscarVacancias(vacancias);
                Convocatoria cv = null;
                
                for(int i=0;i<filtrar_convocatorias.size();i++){
                    cv =  new ConvocatoriaJDBC().select(filtrar_convocatorias.get(i));
                    convoc.add(cv);
                }
                Gson gson = new Gson();
                out.print(gson.toJson(convoc));

            } 
            out.flush();
        }
    }

    public List<Integer> buscarVacancias(List<Vacancia> vacancias) {
        List<Integer> lista = new ArrayList<Integer>();
        for (Vacancia vacancia : vacancias) {
            System.out.printf("%d", vacancia.getVacancia());
            lista.add(vacancia.getVacancia());
        };
        return lista.stream().distinct().collect(Collectors.toList());
    }

}
