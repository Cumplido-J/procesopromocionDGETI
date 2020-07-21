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
public class HorasGrupo {
    
    public String id_plantel;
    public String id_periodo;
    public String clave_materia;
    public String nombre_materia;
    public String turno;
    public String grupo;
    public String nombre_carrera;
    public String semestre;
    public String numero_horas;
    public String id_plan;
    public String nombre;

    public HorasGrupo(String id_plantel, String id_periodo, String clave_materia, String nombre_materia, String turno, String grupo, String nombre_carrera, String semestre, String numero_horas, String id_plan, String nombre) {
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

    public void setId_plantel(String id_plantel) {
        this.id_plantel = id_plantel;
    }

    public String getId_periodo() {
        return id_periodo;
    }

    public void setId_periodo(String id_periodo) {
        this.id_periodo = id_periodo;
    }

    public String getClave_materia() {
        return clave_materia;
    }

    public void setClave_materia(String clave_materia) {
        this.clave_materia = clave_materia;
    }

    public String getNombre_materia() {
        return nombre_materia;
    }

    public void setNombre_materia(String nombre_materia) {
        this.nombre_materia = nombre_materia;
    }

    public String getTurno() {
        return turno;
    }

    public void setTurno(String turno) {
        this.turno = turno;
    }

    public String getGrupo() {
        return grupo;
    }

    public void setGrupo(String grupo) {
        this.grupo = grupo;
    }

    public String getNombre_carrera() {
        return nombre_carrera;
    }

    public void setNombre_carrera(String nombre_carrera) {
        this.nombre_carrera = nombre_carrera;
    }

    public String getSemestre() {
        return semestre;
    }

    public void setSemestre(String semestre) {
        this.semestre = semestre;
    }

    public String getNumero_horas() {
        return numero_horas;
    }

    public void setNumero_horas(String numero_horas) {
        this.numero_horas = numero_horas;
    }

    public String getId_plan() {
        return id_plan;
    }

    public void setId_plan(String id_plan) {
        this.id_plan = id_plan;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }
    
    
}
