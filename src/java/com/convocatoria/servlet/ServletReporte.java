/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package web;

import com.google.gson.Gson;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import reporte.ReporteConvocatoria;

/**
 *
 * @author ja1000
 */
@WebServlet("/ServletReporte")
public class ServletReporte extends HttpServlet {
        protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
            PrintWriter out = response.getWriter();
            Gson gson = new Gson();
            response.setContentType("application/json; charset=UTF-8");
            String[] strings = {"error", "error"};
            int idplantel = Integer.parseInt(request.getParameter("plantel"));
            int idconvocatoria = Integer.parseInt(request.getParameter("convocatoria"));
            if(idplantel>0 && idconvocatoria>0){
                String nombre_reporte="convocatoria"+idplantel+idconvocatoria;
                String url = new ReporteConvocatoria().pdf(idplantel, idconvocatoria,nombre_reporte);
                strings[0]="ok";
                strings[1]=url;
                out.print(gson.toJson(strings));
            }else{
                out.print(gson.toJson(strings));
            }
            out.flush();
        }
    
}
