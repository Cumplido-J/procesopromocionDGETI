/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.aplicacion.beans;

import com.google.gson.Gson;
import herramientas.WebService;
import java.util.List;
import metodos_sql.Metodos_sql;

/**
 *
 * @author David Reyna
 */
public class Docente {
    private String idUsuario="";
    /*private String nombre="";
    private String primerApellido="";
    private String segundoApellido="";
    private String correo="";*/
    private String rfc="";
    /*private String idEntidad="";
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
    private Boolean cargaCedula=false;*/
    private String jsonHoras=null;
    private List<String[]> listaHoras=null;
    private List<String[]> listaDocumentos=null;
    private Boolean banderaIngles=false;
    private String[]infoRegistro=null;
    
    public Docente() {
    }

    public String getJsonHoras() {
        return jsonHoras;
    }
    

    public List<String[]> getListaHoras() {
        return listaHoras;
    }

    public List<String[]> getListaDocumentos() {
        return listaDocumentos;
    }
    
    public String getIdUsuario() {
        return idUsuario;
    }

    public void setIdUsuario(String idUsuario) {
        this.idUsuario = idUsuario;
    }

    /*public String getNombre() {
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
    }*/

    public String getRfc() {
        return rfc;
    }

    public void setRfc(String rfc) {
        this.rfc = rfc;
    }

    /*public String getIdEntidad() {
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
    }*/

    public String[] getInfoRegistro() {
        return infoRegistro;
    }

    public void setInfoRegistro(String[] infoRegistro) {
        this.infoRegistro = infoRegistro;
    }
    
    /*public void consultaPreRegistro(){
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
    }*/
    public void consumeWSCatalogoDocentes(){
        WebService ws;
        ws=new WebService("http://200.77.238.19/develop/protected/pages/herramientas/estructuras/promocion/catalogo_docentes.php?rfc="+rfc);
        ws.consumeWS(); 
        jsonHoras=ws.getData();
        System.out.println("|"+jsonHoras+"|");
    }
    
    public HorasGrupo[] getArrayHoras() {        
        HorasGrupo[] aux=null;
        if(jsonHoras.length()>0){            
            Gson gson = new Gson();
            aux = gson.fromJson(jsonHoras,HorasGrupo[].class);            
        }        
        return aux;    
    }
    
    public int getTotalHoras(){
        int totalHoras=0;
        //HorasGrupo[] aux=getArrayHoras();
        if(listaHoras.size()>0){
            for(String[] hora:listaHoras){
                totalHoras+=Integer.parseInt(hora[9]);
            }
        }
        return totalHoras;
    }
    public int getNumGrupos(){
        return listaHoras.size();
    }
    public void consultaHoras(){
        Metodos_sql metodo = new Metodos_sql();
        String[] parametros={idUsuario};
        listaHoras=metodo.ejecutaSP("sp_selectHorasGrupo",parametros);          
    } 
    public void registraHorasWS(String idPeriodo,String claveAsignatura,String horas,String grupo,String semestre){
        Metodos_sql metodo = new Metodos_sql();
        String[] parametros={idUsuario,idPeriodo,claveAsignatura,horas,grupo,semestre};
        List<String[]> datos=metodo.ejecutaSP("sp_registroHorasGrupoWS",parametros);          
    }
    public void registraHoras(String idPeriodo,String idAsignatura,String horas,String grupo,String semestre){
        Metodos_sql metodo = new Metodos_sql();
        String[] parametros={idUsuario,idPeriodo,idAsignatura,horas,grupo,semestre};
        List<String[]> datos=metodo.ejecutaSP("sp_registroHorasGrupo",parametros);          
    }
    public void borraHoras(String idHoraGrupo){
        Metodos_sql metodo = new Metodos_sql();
        String[] parametros={idHoraGrupo};
        List<String[]> datos=metodo.ejecutaSP("sp_deleteHorasGrupo",parametros);          
    }

    public Boolean getBanderaIngles() {
        return banderaIngles;
    }

    public void setBanderaIngles(Boolean banderaIngles) {
        this.banderaIngles = banderaIngles;
    }
    public void actualizaBanderaIngles(){
        for(String[] dato:listaHoras){
            if(dato[4].contains("INGLÉS")||dato[4].contains("INGLES")||dato[4].contains("CENNI")){
                banderaIngles=true;
            }
        }
    }
    public void consultaInfoAspirante(){
        Metodos_sql metodo = new Metodos_sql();
        String[] parametros={idUsuario};
        List<String[]> datos=metodo.ejecutaSP("sp_consultaRegistro",parametros);
        if(!datos.isEmpty()){
            infoRegistro=datos.get(0);
            rfc=infoRegistro[5];
        }
    }
    public void consultaDocumentos(){
        Metodos_sql metodo = new Metodos_sql();
        String[] parametros={idUsuario,""};
        listaDocumentos=metodo.ejecutaSP("sp_selectConstanciasRegistro",parametros);        
    }
    public boolean documentoCargado(String idDocumento){
        boolean retorno=false;
        for(String[] dato:listaDocumentos){
            if(dato[2].equals(idDocumento)){
                retorno=true;
                break;
            }
        }
        return retorno;
    }
    public boolean verificaSeccion(String idSeccion){
        boolean retorno=false;
        switch(idSeccion){
            case "1":
                if(infoRegistro[14]!=null){
                    if(documentoCargado("1")){//Si ya se registró la información academica y se cargo el titulo                        
                        if(infoRegistro[24]==null){//Si no se registró información de Cédula
                            retorno=true;                            
                        }else{
                            if(documentoCargado("8")){//Si sí se registró la información de Cédula y se cargo el documento
                                retorno=true;
                            }
                        }  
                    }
                }
                break;
            case "2":
                if(infoRegistro[26]!=null){
                    if(documentoCargado("2")&&documentoCargado("3")){//Si ya se registró la información laboral  y se cargo la constancia de antiguedad y nombramiento                       
                        if(infoRegistro[48].equals("S")){//Si cuenta con nota desfavorable
                            retorno=true;                            
                        }else{
                            if(documentoCargado("6")){//Si no cuenta con nota desfavorable y se cargo el documento
                                retorno=true;
                            }
                        }  
                    }
                }
                break;
            case "3":
                if(listaHoras.size()>0){
                    if(documentoCargado("4")){//Si ya se registró la información de horas frente a grupo  y se cargo la constancia                       
                        if(infoRegistro[52]==null){//Si no requiere registrar CENNI
                            retorno=true;                            
                        }else{
                            if(documentoCargado("5")){//Si requiere registrar CENNI y se cargo el documento
                                retorno=true;
                            }
                        }  
                    }
                }
                break;
            case "4": 
                if(infoRegistro[60]!=null){
                    if(infoRegistro[60].equals("S")){//Si marco la casilla de funciones en otro subsistema
                        if(infoRegistro[49].equals("S")){//Si marcó la casilla de compatibilidad 
                            if(documentoCargado("7")){//Si cargó la constancia de compatibilidad                              
                                retorno=true;                        
                            }                    
                        }
                    }else{
                        retorno=true; 
                    }
                }
                break;
            default:
                break;
        }
        return retorno;
    }
    
}
