/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.convocatoria.reportes;

import herramientas.RutaConfig;
import java.io.File;
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
import net.sf.jasperreports.engine.*;
import net.sf.jasperreports.engine.export.JRXlsExporter;
import net.sf.jasperreports.engine.util.JRLoader;
import net.sf.jasperreports.engine.util.JRSaver;
import net.sf.jasperreports.export.SimpleExporterInput;
import net.sf.jasperreports.export.SimpleOutputStreamExporterOutput;
import net.sf.jasperreports.export.SimpleXlsReportConfiguration;

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
    private final static String rutaConfig=RutaConfig.getRutaConfig();
    Connection conn = null;
    //private static final String pathr = "/Users/ja1000/reportes/";
    //private static final String path_pdfs = "/Users/ja1000/NetBeansProjects/convocatorias/web/recursos/archivos/";
    private static String pathr;
    private static  String path_pdfs;
    Properties config = new Properties();
    InputStream input = null;

    public ReporteConvocatoria() {
        try {
            input = new FileInputStream(rutaConfig);
            config.load(input);
            pathr=config.getProperty("pathr");
            path_pdfs=config.getProperty("path_pdfs");
        } catch (FileNotFoundException ex) {
            ex.printStackTrace();
        } catch (IOException ex) {
            Logger.getLogger(ReporteConvocatoria.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    private static void compilarReporte() {
        try {
            String jrxmls[] = new String[10];
            jrxmls[9] = "mainreport";
            //jrxmls[15] = "vacancias";
            for (int i = 0; i < jrxmls.length - 1; i++) {
                jrxmls[i] = "pagina" + (i + 1);
            }
            for (String s : jrxmls) {
                String jrxmlfile = pathr + s + ".jrxml";
                String jasperfile = pathr + s + ".jasper";
                System.out.println(jrxmlfile+"\n"+jasperfile);
                JasperCompileManager.compileReportToFile(jrxmlfile,jasperfile);
            }
        } catch (JRException e) {
            System.out.println(e);
        }
    }

    public String pdf(int plantel, int convocatoria, String nombre) {
        compilarReporte();
               conn = conector();
        String jasperFileName = "mainreport.jasper";
        String jasperFile = pathr + jasperFileName;
        String pdfFileName = "convocatoria" + plantel + convocatoria + ".pdf";
        try {
            //System.out.println("Entre");
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
        //return path_pdfs + "404.pdf";
        return "404.pdf";
    }
    
    
       public File xls() throws JRException {
        System.out.println("Iniciando reporte");
        conn = conector();
        String jasperFileJrxml = pathr + "listado_estatus_convocatoria.jrxml";
        String jasperFile = pathr + "listado_estatus_convocatoria.jrprint";
        JasperReport report = JasperCompileManager.compileReport(jasperFileJrxml);
        HashMap<String, Object> params = new HashMap<String, Object>();
        JasperPrint myJRprintReportObject = JasperFillManager.fillReport(report, params, conn);
        JRSaver.saveObject(myJRprintReportObject, jasperFile);
        long start = System.currentTimeMillis();
        File sourceFile = new File(jasperFile);

        JasperPrint jasperPrint = (JasperPrint) JRLoader.loadObject(sourceFile);

        File destFile = new File(sourceFile.getParent(), jasperPrint.getName() + ".xls");

        JRXlsExporter exporter = new JRXlsExporter();

        exporter.setExporterInput(new SimpleExporterInput(jasperPrint));
        exporter.setExporterOutput(new SimpleOutputStreamExporterOutput(destFile));
        SimpleXlsReportConfiguration configuration = new SimpleXlsReportConfiguration();
        configuration.setOnePagePerSheet(false);
        exporter.setConfiguration(configuration);

        exporter.exportReport();

        System.err.println("XLS creation time : " + (System.currentTimeMillis() - start));
        return destFile;

    }

}
