/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.convocatoria.servlet;

import com.convocatoria.reportes.ReporteConvocatoria;
import java.io.DataInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import net.sf.jasperreports.engine.JRException;

/**
 *
 * @author ja1000
 */
@WebServlet(name = "ReportePlantelesRegistradorPrograma", urlPatterns = {"/rptestatusconvocatoria"})
public class ReportePlantelesRegistradorPrograma extends HttpServlet {

    private final int ARBITARY_SIZE = 1048;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            
            response.setContentType("application/vnd.ms-excel");
            response.setHeader("Content-Disposition", "attachment; filename=reporteplanteles.xls");
            ReporteConvocatoria rpt = new ReporteConvocatoria();
            File elreporte= rpt.xls();
            try (
                    InputStream in = new DataInputStream(new FileInputStream(elreporte));
                    OutputStream out = response.getOutputStream()) {
                
                byte[] buffer = new byte[ARBITARY_SIZE];
                
                int numBytesRead;
                while ((numBytesRead = in.read(buffer)) > 0) {
                    out.write(buffer, 0, numBytesRead);
                }
            }
        }   catch (JRException ex) {
            Logger.getLogger(ReportePlantelesRegistradorPrograma.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
}
