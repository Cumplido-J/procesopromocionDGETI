/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.aplicacion.beans;

import herramientas.RutaConfig;
import java.io.FileReader;
import java.util.Properties;

/**
 *
 * @author David Reyna
 */
public class Mensaje {
    private final static String rutaConfig=RutaConfig.getRutaConfig();
    private String registroCompleto;
    private String notaDesfavorable;
    private String inactivoServicio;
    private String noFrenteGrupo;
    private String noCompatibilidad;
    private String confirmacionHora;
    private String rechazoHora;
    

    public Mensaje() {
        try{
            Properties p = new Properties();
            p.load(new FileReader(rutaConfig));            
            this.registroCompleto = p.getProperty("mensajeRegistroCompleto");
            this.notaDesfavorable = p.getProperty("mensajeNotaDesfavorable");
            this.inactivoServicio = p.getProperty("mensajeInactivoServicio");
            this.noFrenteGrupo = p.getProperty("mensajeNoFrenteGrupo");
            this.noCompatibilidad = p.getProperty("mensajeNoCompatibilidad");
            this.confirmacionHora = p.getProperty("mensajeConfirmacionHora");
            this.rechazoHora = p.getProperty("mensajeRechazoHora");
        }catch(Exception e){
            System.out.println(e.toString());
        }
    }

    public String getRegistroCompleto() {
        return registroCompleto;
    }

    public String getNotaDesfavorable() {
        return notaDesfavorable;
    }

    public String getInactivoServicio() {
        return inactivoServicio;
    }

    public String getNoFrenteGrupo() {
        return noFrenteGrupo;
    }

    public String getNoCompatibilidad() {
        return noCompatibilidad;
    }

    public String getConfirmacionHora() {
        return confirmacionHora;
    }

    public String getRechazoHora() {
        return rechazoHora;
    }
    
}
