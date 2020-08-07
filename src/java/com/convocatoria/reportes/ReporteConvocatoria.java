/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.convocatoria.reporte;

import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.sql.Connection;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.Properties;
import java.util.logging.Level;
import java.util.logging.Logger;

import javax.servlet.ServletContext;
import static metodos_sql.Metodos_sql.conector;
import net.sf.jasperreports.engine.JRException;
import net.sf.jasperreports.engine.JasperCompileManager;
import net.sf.jasperreports.engine.JasperExportManager;
import net.sf.jasperreports.engine.JasperFillManager;
import net.sf.jasperreports.engine.JasperPrint;

/*
import net.sf.jasperreports.engine.JRException;
import net.sf.jasperreports.engine.JasperCompileManager;
import net.sf.jasperreports.engine.JasperExportManager;
import net.sf.jasperreports.engine.JasperFillManager;
import net.sf.jasperreports.engine.JasperPrint;
 */
/**
 *
 * @author ja1000
 */
public class ReporteConvocatoria {

    Connection conn = null;
    private static final String pathr = "/Users/ja1000/reportes/";
    private static final String path_pdfs = "/Users/ja1000/NetBeansProjects/convocatorias/web/recursos/archivos/";
    Properties config = new Properties();
    InputStream input = null;

    public ReporteConvocatoria() {
        try {
            input = new FileInputStream("/Users/ja1000/config.properties");
            config.load(input);
            //pathr=config.getProperty("ruta.jrxml");
            //path_pdfs=config.getProperty("ruta.pdfs");
        } catch (FileNotFoundException ex) {
            ex.printStackTrace();
        } catch (IOException ex) {
            Logger.getLogger(ReporteConvocatoria.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    private static void compilarReporte() {
        try {
            String jrxmls[] = new String[17];
            jrxmls[16] = "mainreport";
            jrxmls[15] = "vacancias";
            for (int i = 0; i < jrxmls.length - 2; i++) {
                jrxmls[i] = "pagina" + (i + 1);
            }
            for (String s : jrxmls) {
                String jrxmlfile = pathr + s + ".jrxml";
                String jasperfile = pathr + s + ".jasper";

                JasperCompileManager.compileReportToFile(jrxmlfile, jasperfile);
            }
        } catch (JRException e) {
            System.out.println(e);
        }
    }

    public void generar(ServletContext context, int plantel, int convocatoria, String nombre) throws JRException {
        compilarReporte();
        String jasperFileName = "mainreport.jasper";
        String jasperFile = pathr + jasperFileName;
        conn = conector();
        String pdfFileName = "convocatoria" + plantel + convocatoria + ".pdf";
        try {
            HashMap<String, Object> hm = new HashMap<>();
            hm.put("plantel", plantel);
            hm.put("convocatoria", convocatoria);
            JasperPrint jprint = (JasperPrint) JasperFillManager.fillReport(jasperFile, hm,conn);
            JasperExportManager.exportReportToPdfFile(jprint, path_pdfs + pdfFileName);
            System.out.println("Done exporting reports to pdf");
        } catch (Exception e) {
            System.out.print("Exception:" + e);
        }

    }

    public String pdf(int plantel, int convocatoria, String nombre) {
        compilarReporte();
               conn = conector();
        String jasperFileName = "mainreport.jasper";
        String jasperFile = pathr + jasperFileName;
        String pdfFileName = "convocatoria" + plantel + convocatoria + ".pdf";
        try {
            HashMap<String, Object> hm = new HashMap<>();
            hm.put("plantel", plantel);
            hm.put("convocatoria", convocatoria);
            JasperPrint jprint = (JasperPrint) JasperFillManager.fillReport(jasperFile, hm, conn);
            JasperExportManager.exportReportToPdfFile(jprint, path_pdfs + pdfFileName);
            System.out.println("Done exporting reports to pdf");
            return pdfFileName;
        } catch (JRException e) {
            System.out.print("Exception:" + e);
        }
        return path_pdfs + "404.pdf";

    }

}
