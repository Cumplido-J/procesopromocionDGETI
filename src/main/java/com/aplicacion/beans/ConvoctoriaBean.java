/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.aplicacion.beans;

/**
 *
 * @author jtrinidadl
 */
public class ConvoctoriaBean {
    private final String estado;
    private final String plantel;
    private final String rfc;
    private final String nombre;
    private final String tipoConvocatoria;
    private final String estatus;
    private final String opciones;

    public ConvoctoriaBean(String estado, String plantel, String rfc, String nombre, String tipoConvocatoria, String estatus, String opciones) {
        this.estado = estado;
        this.plantel = plantel;
        this.rfc = rfc;
        this.nombre = nombre;
        this.tipoConvocatoria = tipoConvocatoria;
        this.estatus = estatus;
        this.opciones = opciones;
    }

    public String getEstado() {
        return estado;
    }

    public String getPlantel() {
        return plantel;
    }

    public String getRfc() {
        return rfc;
    }

    public String getNombre() {
        return nombre;
    }

    public String getTipoConvocatoria() {
        return tipoConvocatoria;
    }

    public String getEstatus() {
        return estatus;
    }

    public String getOpciones() {
        return opciones;
    }
    
    
}
