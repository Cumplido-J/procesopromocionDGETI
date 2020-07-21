/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.aplicacion.beans;

import herramientas.WebService;
import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.URL;
import java.net.URLConnection;
import java.util.List;
import metodos_sql.Metodos_sql;

/**
 *
 * @author David Reyna
 */
public class Docente {
    private String idUsuario="";
    private String nombre="";
    private String primerApellido="";
    private String segundoApellido="";
    private String correo="";
    private String rfc="";
    private String idEntidad="";
    private String idTipoInstitucion="";
    private String idInstitucion="";
    private String idCCT="";
    private String idEscuela="";
    private String idGrado="";
    private String idCarrera="";
    private String anioEgreso="";
    private String idModalidadTitulacion="";
    private String anioTitulacion="";
    private String idComprobante="";
    private String cedula="";
    private Boolean cargaTitulo=false;
    private Boolean cargaCedula=false;
    private String horas="";
    
    public Docente() {
    }

    

    public String getIdUsuario() {
        return idUsuario;
    }

    public void setIdUsuario(String idUsuario) {
        this.idUsuario = idUsuario;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public String getPrimerApellido() {
        return primerApellido;
    }

    public void setPrimerApellido(String primerApellido) {
        this.primerApellido = primerApellido;
    }

    public String getSegundoApellido() {
        return segundoApellido;
    }

    public void setSegundoApellido(String segundoApellido) {
        this.segundoApellido = segundoApellido;
    }

    public String getCorreo() {
        return correo;
    }

    public void setCorreo(String correo) {
        this.correo = correo;
    }

    public String getRfc() {
        return rfc;
    }

    public void setRfc(String rfc) {
        this.rfc = rfc;
    }

    public String getIdEntidad() {
        return idEntidad;
    }

    public void setIdEntidad(String idEntidad) {
        this.idEntidad = idEntidad;
    }

    public String getIdTipoInstitucion() {
        return idTipoInstitucion;
    }

    public void setIdTipoInstitucion(String idTipoInstitucion) {
        this.idTipoInstitucion = idTipoInstitucion;
    }

    public String getIdInstitucion() {
        return idInstitucion;
    }

    public void setIdInstitucion(String idInstitucion) {
        this.idInstitucion = idInstitucion;
    }

    public String getIdCCT() {
        return idCCT;
    }

    public void setIdCCT(String idCCT) {
        this.idCCT = idCCT;
    }

    public String getIdEscuela() {
        return idEscuela;
    }

    public void setIdEscuela(String idEscuela) {
        this.idEscuela = idEscuela;
    }

    public String getIdGrado() {
        return idGrado;
    }

    public void setIdGrado(String idGrado) {
        this.idGrado = idGrado;
    }

    public String getIdCarrera() {
        return idCarrera;
    }

    public void setIdCarrera(String idCarrera) {
        this.idCarrera = idCarrera;
    }

    public String getAnioEgreso() {
        return anioEgreso;
    }

    public void setAnioEgreso(String anioEgreso) {
        this.anioEgreso = anioEgreso;
    }

    public String getIdModalidadTitulacion() {
        return idModalidadTitulacion;
    }

    public void setIdModalidadTitulacion(String idModalidadTitulacion) {
        this.idModalidadTitulacion = idModalidadTitulacion;
    }

    public String getAnioTitulacion() {
        return anioTitulacion;
    }

    public void setAnioTitulacion(String anioTitulacion) {
        this.anioTitulacion = anioTitulacion;
    }

    public String getIdComprobante() {
        return idComprobante;
    }

    public void setIdComprobante(String idComprobante) {
        this.idComprobante = idComprobante;
    }

    public String getCedula() {
        return cedula;
    }

    public void setCedula(String cedula) {
        this.cedula = cedula;
    }

    public Boolean getCargaTitulo() {
        return cargaTitulo;
    }

    public void setCargaTitulo(Boolean cargaTitulo) {
        this.cargaTitulo = cargaTitulo;
    }

    public Boolean getCargaCedula() {
        return cargaCedula;
    }

    public void setCargaCedula(Boolean cargaCedula) {
        this.cargaCedula = cargaCedula;
    }
    
    public void consultaPreRegistro(){
        Metodos_sql metodo = new Metodos_sql();
        String[] parametros={idUsuario};
        List<String[]> datos=metodo.ejecutaSP("sp_selectUsuario",parametros);
        if(!datos.isEmpty()){
            nombre=datos.get(0)[0];
            primerApellido=datos.get(0)[1];
            segundoApellido=datos.get(0)[2];
            correo=datos.get(0)[3];
            rfc=datos.get(0)[4];
        }
    }
    public void consumeWSCatalogoDocentes(){
        WebService ws;
        ws=new WebService("http://200.77.238.19/develop/protected/pages/herramientas/estructuras/promocion/catalogo_docentes.php?rfc="+rfc);
        ws.consumeWS();
        horas=ws.getData();
        horas.replaceAll("'", "");
    }
    
    public String getHoras() {
        return horas;
    }
    
}
