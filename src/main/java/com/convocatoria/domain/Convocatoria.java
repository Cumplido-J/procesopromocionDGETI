/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.convocatoria.domain;

/**
 *
 * @author ja1000
 */
public class Convocatoria {
    int id;
    String nombre;
    String url;

    @Override
    public String toString() {
        return "Convocatoria{" + "id=" + id + ", nombre=" + nombre + ", url=" + url + '}';
    }

    public Convocatoria() {
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public String getUrl() {
        return url;
    }

    public void setUrl(String url) {
        this.url = url;
    }
    
    
}
