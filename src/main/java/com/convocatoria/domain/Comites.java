/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.convocatoria.domain;

/**
 *
 * @author jtrinidadl
 */
public class Comites {
    int id;
    String tipo;

    public Comites() {
    }

    public Comites(int id, String tipo) {
        this.id = id;
        this.tipo = tipo;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getTipo() {
        return tipo;
    }

    public void setTipo(String tipo) {
        this.tipo = tipo;
    }

    @Override
    public String toString() {
        return "Comites{" + "id=" + id + ", tipo=" + tipo + '}';
    }
    
}
