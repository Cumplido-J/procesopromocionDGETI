/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.convocatoria.domain;

/**
 *
 * @author Iker Fernando
 */
public class ProgramasPlantel {
    int id;
    String programa;

    public ProgramasPlantel(){}
    
    public ProgramasPlantel(int id, String programa) {
        this.id = id;
        this.programa = programa;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getPrograma() {
        return programa;
    }

    public void setPrograma(String programa) {
        this.programa = programa;
    }

    @Override
    public String toString() {
        return "ProgramasPlantel{" + "id=" + id + ", programa=" + programa + '}';
    }
    
    
}
