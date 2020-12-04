/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.aplicacion.beans;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import herramientas.RutaConfig;
import herramientas.WebService;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileReader;
import java.lang.reflect.Type;
import java.util.List;
import java.util.Properties;
import java.util.Random;
import javax.servlet.http.HttpSession;
import metodos_sql.Metodos_sql;

/**
 *
 * @author David Reyna
 */
public class Docente {
    private final static String rutaConfig=RutaConfig.getRutaConfig();
    private String idUsuario="";    
    private String rfc="";    
    private String jsonHoras=null;
    private String jsonPersonal=null;
    private List<String[]> listaHoras=null;
    private List<String[]> listaDocumentos=null;
    private Boolean banderaIngles=false;
    private String[]infoRegistro=null;
    private List<HoraGrupo> horas=null;
    private List<Personal> personal=null;
    private List<String[]> encuestados=null;
    private int totalEncuestados=0;
    private String idConvocatoria=null;
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

    public String getRfc() {
        return rfc;
    }

    public void setRfc(String rfc) {
        this.rfc = rfc;
    }
    
    public String[] getInfoRegistro() {
        return infoRegistro;
    }

    public void setInfoRegistro(String[] infoRegistro) {
        this.infoRegistro = infoRegistro;
    }
    
    
    public void consumeWSCatalogoDocentes(){
        WebService ws;
        try{
            Properties p = new Properties();
            p.load(new FileReader(rutaConfig));
            String url=p.getProperty("urlWSHoras");
            ws=new WebService(url+rfc);
            ws.consumeWS(); 
            jsonHoras=ws.getData();  
            jsonHoras=jsonHoras.toLowerCase();
        }catch(Exception e){
            System.out.println(e.toString());
        }
    }
    public void consumeWSCatalogoPersonal(){
        WebService ws;
        try{
            Properties p = new Properties();
            p.load(new FileReader(rutaConfig));
            String url=p.getProperty("urlWSPersonal");
            ws=new WebService(url+rfc);
            ws.consumeWS(); 
            jsonPersonal=ws.getData();  
            jsonPersonal=jsonPersonal.toLowerCase();
        }catch(Exception e){
            System.out.println(e.toString());
        }
    }
    
    public void procesaJsonHoras() {         
        Gson gson=new Gson();
        Type tipo=new TypeToken<List<HoraGrupo>>(){}.getType();
        horas=gson.fromJson(jsonHoras, tipo);
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
    public String mostrarHoras(){
        String respuesta="";
        for(String[] hora:listaHoras){
                respuesta+="<tr><td>";
                respuesta+="Periodo: "+hora[2]+"<br/>";                
                if(hora[7].equals("A")){
                    respuesta+="Componente básico y/o propedéutico: ";
                }else if(hora[7].equals("S")){
                    respuesta+="Componente profesional:  ";
                }else if(hora[7].equals("T")){
                    respuesta+="Taller: ";
                }                
                if(hora[5]!=null){
                    respuesta+=hora[5]+" - ";
                }
                respuesta+=hora[4]+"<br/>";                                                              
                respuesta+="Grupo: "+hora[10]+"<br/>"; 
                respuesta+="Semestre: "+hora[6]+"<br/>"; 
                respuesta+="Horas: "+hora[9]+"<br/>";
                respuesta+="</td>";
                respuesta+="<td class='text-center'>";
                if(hora[11].equals("F")){
                    respuesta+="<button type='button' class='btn btn-sm' title='Borrar' onclick='borrarHoraGrupo("+hora[0]+")'>";
                    respuesta+="<span class='glyphicon glyphicon-trash'></span>";
                    respuesta+="</button>";   
                }
                else if(hora[12]==null){
                    respuesta+="<button type='button' class='btn btn-sm' title='Confirmar como correcta' onclick='confirmarHoraGrupo("+hora[0]+")'>";
                    respuesta+="<span class='glyphicon glyphicon-ok completo'></span>";
                    respuesta+="</button>";
                    respuesta+="<button type='button' class='btn btn-sm' title='Confirmar como incorrecta' onclick='rechazarHoraGrupo("+hora[0]+")'>";
                    respuesta+="<span class='glyphicon glyphicon-remove incompleto'></span>";                    
                    respuesta+="</button>";
                    respuesta+="<span class='glyphicon glyphicon-exclamation-sign incompleto' title='Sección incompleta'></span>";
                }
                else if(hora[11].equals("V")&&hora[12].equals("V")){
                    respuesta+="<button type='button' class='btn btn-sm' disabled title='Esta información no puede borrarse'>";
                    respuesta+="<span class='glyphicon glyphicon-trash'></span>";
                    respuesta+="</button>";   
                }                                              
                respuesta+="</td></tr>";                
            }
        return respuesta;
    }
    public void registraHorasWS(){
        if(horas!=null){                        
            for(HoraGrupo hora:horas){
                registraHorasWS(hora.getId_periodo(), hora.getClave_materia(), hora.getNumero_horas(), hora.getGrupo(),hora.getSemestre());
            }            
        }
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
            idConvocatoria=infoRegistro[65];
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
                    for(String[]dato:listaHoras){
                        if(dato[12]==null){
                            retorno=false;
                            break;
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
    public void procesaJsonPersonal(){        
        Gson gson=new Gson();
        Type tipo=new TypeToken<List<Personal>>(){}.getType();
        personal=gson.fromJson(jsonPersonal, tipo);        
    }

    public String getJsonPersonal() {
        return jsonPersonal;
    }

    public List<Personal> getPersonal() {
        return personal;
    }

    public List<HoraGrupo> getHoras() {
        return horas;
    }
    
    public void consultaEncuestados(){
        Metodos_sql metodos=new Metodos_sql();
        String[] parametros={rfc};
        encuestados= metodos.ejecutaSPEncuestas("sp_selectLecturaUrlRFC",parametros);
        totalEncuestados=encuestados.size();
    }

    public int getTotalEncuestados() {
        return totalEncuestados;
    }
    
    
    public String[][] generaFilasEncuestados(){
        String[][] retorno={{"","0"},{"","0"},{"","0"}};
        String fila="";
        int c1=0,c2=0,c3=0;
        if(totalEncuestados>0){
            for(String[] encuestado:encuestados){
                fila="<tr><td>"+encuestado[2]+"</td><td>"+encuestado[4]+"</td><td>";
                System.out.println(encuestado[5]);
                if(encuestado[5].equals("PENDIENTE")){
                    fila+="<button type='button' class='btn btn-sm' title='Borrar' onclick='borrarEncuestado("+encuestado[0]+","+encuestado[3]+")'>";
                    fila+="<span class='glyphicon glyphicon-trash'></span>";
                    fila+="</button>";
                }else if(encuestado[5].equals("CONCLUIDO")){
                    fila+="<button type='button' class='btn btn-sm' disabled title='Esta información no puede borrarse'>";
                    fila+="<span class='glyphicon glyphicon-trash'></span>";
                    fila+="</button>";
                }
                
                fila+="<td></tr>";
                switch(encuestado[3]){
                    case "1":
                        retorno[0][0]+=fila;
                        c1++;
                        break;
                    case "2":
                        retorno[1][0]+=fila;
                        c2++;
                        break;
                    case "3":
                        retorno[2][0]+=fila;
                        c3++;
                        break;
                    default:
                        break;                
                }
            }            
        }
        retorno[0][1]=""+c1;
        retorno[1][1]=""+c2;
        retorno[2][1]=""+c3;
        return retorno;
    }
    
    public String[] generaFilasEncuestados(String tipoEncuesta){
        String[] retorno={"","0"};
        String fila="";
        int c=0;
        if(totalEncuestados>0){
            for(String[] encuestado:encuestados){
                if(encuestado[3].equals(tipoEncuesta)){
                    fila+="<tr><td>"+encuestado[2]+"</td><td>"+encuestado[4]+"</td><td>";
                    if(encuestado[5].equals("PENDIENTE")){
                        fila+="<button type='button' class='btn btn-sm' title='Borrar' onclick='borrarEncuestado("+encuestado[0]+","+encuestado[3]+")'>";
                        fila+="<span class='glyphicon glyphicon-trash'></span>";
                        fila+="</button>";
                    }else if(encuestado[5].equals("CONCLUIDO")){
                        fila+="<button type='button' class='btn btn-sm' disabled title='Esta información no puede borrarse'>";
                        fila+="<span class='glyphicon glyphicon-trash'></span>";
                        fila+="</button>";
                    }                
                    fila+="<td></tr>";
                    c++;
                }                
            }            
        }        
        retorno[0]=fila;
        retorno[1]=""+c;
        return retorno;
    }

    public String getIdConvocatoria() {
        return idConvocatoria;
    }
    public boolean documentoCargado2(String idDocumento){
        boolean retorno=false;
        try{        
            String rutaConfig = RutaConfig.getRutaConfig();
            Properties p = new Properties();
            p.load(new FileReader(rutaConfig));
            String ruta=p.getProperty("rutaEvidenciasRegistro");
            ruta+="/"+idUsuario+"_"+idDocumento+".pdf";    
            File documento;            
            documento=new File(ruta);
            retorno= documento.exists();
        }catch(Exception e){
            System.out.println(e.toString());
        }finally{
            return retorno;
        }
    }
    
    public boolean documentoCargado3(String idDocumento){
        boolean retorno=false;
        try{        
            String rutaConfig = RutaConfig.getRutaConfig();
            Properties p = new Properties();
            p.load(new FileReader(rutaConfig));
            String ruta=p.getProperty("rutaCartaAceptacion");
            ruta+="/"+idUsuario+"_"+idDocumento+".pdf";  
            File documento;            
            documento=new File(ruta);
            retorno= documento.exists();
        }catch(Exception e){
            System.out.println(e.toString());
        }finally{
            return retorno;
        }
    }
    
}
