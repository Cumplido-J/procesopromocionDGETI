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
public class Grupo {
    private final String carrera;
    private final String asignatura;
    private final String hsr_fgpo;
    private final String semestre;
    private final String grupo;
    private final String turno;

    public Grupo(String carrera, String asignatura, String hsr_fgpo, String semestre, String grupo, String turno) {
        this.carrera = carrera;
        this.asignatura = asignatura;
        this.hsr_fgpo = hsr_fgpo;
        this.semestre = semestre;
        this.grupo = grupo;
        this.turno = turno;
    }

    public String getCarrera() {
        return carrera;
    }

    public String getAsignatura() {
        return asignatura;
    }

    public String getHsr_fgpo() {
        return hsr_fgpo;
    }

    public String getSemestre() {
        return semestre;
    }

    public String getGrupo() {
        return grupo;
    }

    public String getTurno() {
        return turno;
    }

    
}
