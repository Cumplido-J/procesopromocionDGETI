package com.convocatoria.domain;

/**
 *
 * @author shetz
 */
public class Entidad {
    private int id;
    private String entidad;

    public Entidad(int id, String entidad) {
        this.id = id;
        this.entidad = entidad;
    }
    public Entidad(int id) {
        this.id = id;
    }

    public Entidad() {
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getEntidad() {
        return entidad;
    }

    public void setEntidad(String entidad) {
        this.entidad = entidad;
    }

    @Override
    public String toString() {
        return "Entidad{" + "id=" + id + ", entidad=" + entidad + '}';
    }

}

