package com.convocatoria.servlet;

import com.google.gson.Gson;
import com.convocatoria.datos.*;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author ja1000
 */
@WebServlet("/ServletControlador")
public class ServletControlador extends HttpServlet {


    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
            this.accionDefault(request, response);
            

    }


    private void accionDefault(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException{
        response.sendRedirect("convocatorias.jsp");
    }



}
