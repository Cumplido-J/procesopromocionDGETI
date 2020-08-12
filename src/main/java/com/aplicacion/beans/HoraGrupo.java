/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.aplicacion.beans;

/**
 *
 * @author David Reyna
 */
public class HoraGrupo {
    
    private final String id_plantel;
    private final String id_periodo;
    private final String clave_materia;
    private final String nombre_materia;
    private final String turno;
    private final String grupo;
    private final String nombre_carrera;
    private final String semestre;
    private final String numero_horas;
    private final String id_plan;
    private final String nombre;

    public HoraGrupo(String id_plantel, String id_periodo, String clave_materia, String nombre_materia, String turno, String grupo, String nombre_carrera, String semestre, String numero_horas, String id_plan, String nombre) {
        this.id_plantel = id_plantel;
        this.id_periodo = id_periodo;
        this.clave_materia = clave_materia;
        this.nombre_materia = nombre_materia;
        this.turno = turno;
        this.grupo = grupo;
        this.nombre_carrera = nombre_carrera;
        this.semestre = semestre;
        this.numero_horas = numero_horas;
        this.id_plan = id_plan;
        this.nombre = nombre;
    }

    public String getId_plantel() {
        return id_plantel;
    }

    public String getId_periodo() {
        return id_periodo;
    }

    public String getClave_materia() {
        return clave_materia;
    }

    public String getNombre_materia() {
        return nombre_materia;
    }

    public String getTurno() {
        return turno;
    }

    public String getGrupo() {
        return grupo;
    }

    public String getNombre_carrera() {
        return nombre_carrera;
    }

    public String getSemestre() {
        return semestre;
    }

    public String getNumero_horas() {
        return numero_horas;
    }

    public String getId_plan() {
        return id_plan;
    }

    public String getNombre() {
        return nombre;
    }

       
}
