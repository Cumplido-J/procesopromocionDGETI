package com.convocatoria.domain;

/**
 *
 * @author shetz
 */
public class Vacancia {
    private int id;
    private int vacancia;
    private String plantel;
    private int idVacancia;
    private int entidad;

    public Vacancia() {
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getVacancia() {
        return vacancia;
    }

    public void setVacancia(int vacancia) {
        this.vacancia = vacancia;
    }

    public String getPlantel() {
        return plantel;
    }

    public void setPlantel(String plantel) {
        this.plantel = plantel;
    }

    public int getIdVacancia() {
        return idVacancia;
    }

    public void setIdVacancia(int idVacancia) {
        this.idVacancia = idVacancia;
    }

    public int getEntidad() {
        return entidad;
    }

    public void setEntidad(int entidad) {
        this.entidad = entidad;
    }

    @Override
    public String toString() {
        return "Vacancia{" + "id=" + id + ", vacancia=" + vacancia + ", plantel=" + plantel + ", idVacancia=" + idVacancia + ", entidad=" + entidad + '}';
    }


  

}
