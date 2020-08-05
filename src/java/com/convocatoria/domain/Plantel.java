/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package domain;

/**
 *
 * @author ja1000
 */
public class Plantel {
    int id;
    int idEntidad;
    String cct;
    String planel;
    String nombre;
    String domicilio;
    char altaMarginacion;
    
    public Plantel(){}

    public Plantel(int id, int idEntidad, String cct, String planel, String nombre, String domicilio, char altaMarginacion) {
        this.id = id;
        this.idEntidad = idEntidad;
        this.cct = cct;
        this.planel = planel;
        this.nombre = nombre;
        this.domicilio = domicilio;
        this.altaMarginacion = altaMarginacion;
    }

    
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getIdEntidad() {
        return idEntidad;
    }

    public void setIdEntidad(int idEntidad) {
        this.idEntidad = idEntidad;
    }

    public String getCct() {
        return cct;
    }

    public void setCct(String cct) {
        this.cct = cct;
    }

    public String getPlanel() {
        return planel;
    }

    public void setPlanel(String planel) {
        this.planel = planel;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public String getDomicilio() {
        return domicilio;
    }

    public void setDomicilio(String domicilio) {
        this.domicilio = domicilio;
    }

    public char getAltaMarginacion() {
        return altaMarginacion;
    }

    public void setAltaMarginacion(char altaMarginacion) {
        this.altaMarginacion = altaMarginacion;
    }

    @Override
    public String toString() {
        return "Plantel{" + "id=" + id + ", idEntidad=" + idEntidad + ", cct=" + cct + ", planel=" + planel + ", nombre=" + nombre + ", domicilio=" + domicilio + ", altaMarginacion=" + altaMarginacion + '}';
    }
    
    
}
