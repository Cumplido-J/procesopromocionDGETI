/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.aplicacion.beans;

import java.util.List;

/**
 *
 * @author David Reyna
 */
public class Personal {
    private final String id_plantel;
    private final String id_periodo;
    private final String cct1;
    private final String cct2;
    private final String nombre;
    private final String agregado;
    private final String ausencia;
    private final String vigente_a_partir;
    private final String estatus;
    private final String motivo_inactivo;
    private final String administrativo;
    private final String clave_requerida;
    private final String horas;
    private final String docente;
    private final String autoplaneada;
    private final String otrasactividades;
    private final String horasfrentegrupo;
    private final String totalhorase;
    private final List<Plaza> plazas;
    private final List<Grupo> grupos;

    public Personal(String id_plantel, String id_periodo, String cct1, String cct2, String nombre, String agregado, String ausencia, String vigente_a_partir, String estatus, String motivo_inactivo, String administrativo, String clave_requerida, String horas, String docente, String autoplaneada, String otrasactividades, String horasfrentegrupo, String totalhorase, List<Plaza> plazas, List<Grupo> grupos) {
        this.id_plantel = id_plantel;
        this.id_periodo = id_periodo;
        this.cct1 = cct1;
        this.cct2 = cct2;
        this.nombre = nombre;
        this.agregado = agregado;
        this.ausencia = ausencia;
        this.vigente_a_partir = vigente_a_partir;
        this.estatus = estatus;
        this.motivo_inactivo = motivo_inactivo;
        this.administrativo = administrativo;
        this.clave_requerida = clave_requerida;
        this.horas = horas;
        this.docente = docente;
        this.autoplaneada = autoplaneada;
        this.otrasactividades = otrasactividades;
        this.horasfrentegrupo = horasfrentegrupo;
        this.totalhorase = totalhorase;
        this.plazas = plazas;
        this.grupos = grupos;
    }

    public String getId_plantel() {
        return id_plantel;
    }

    public String getId_periodo() {
        return id_periodo;
    }

    public String getCct1() {
        return cct1;
    }

    public String getCct2() {
        return cct2;
    }

    public String getNombre() {
        return nombre;
    }

    public String getAgregado() {
        return agregado;
    }

    public String getAusencia() {
        return ausencia;
    }

    public String getVigente_a_partir() {
        return vigente_a_partir;
    }

    public String getEstatus() {
        return estatus;
    }

    public String getMotivo_inactivo() {
        return motivo_inactivo;
    }

    public String getAdministrativo() {
        return administrativo;
    }

    public String getClave_requerida() {
        return clave_requerida;
    }

    public String getHoras() {
        return horas;
    }

    public String getDocente() {
        return docente;
    }

    public String getAutoplaneada() {
        return autoplaneada;
    }

    public String getOtrasactividades() {
        return otrasactividades;
    }

    public String getHorasfrentegrupo() {
        return horasfrentegrupo;
    }

    public String getTotalhorase() {
        return totalhorase;
    }

    public List<Plaza> getPlazas() {
        return plazas;
    }

    public List<Grupo> getGrupos() {
        return grupos;
    }
    
    
    
    
}
