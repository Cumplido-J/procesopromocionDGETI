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
import java.util.ArrayList;
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
    private List<String[]> listaHorasCecyte=null;
    private List<String[]> listaDocumentos=null;
    private Boolean banderaIngles=false;
    private String[]infoRegistro=null;
    private List<HoraGrupo> horas=null;
    private List<Personal> personal=null;
    private List<String[]> encuestados=null;
    private int totalEncuestados=0;
    private String idConvocatoria=null;
    private String idPeriodoRegistro=null;
     
    public String getIdPeriodoRegistro() {
        return idPeriodoRegistro;
    }

    public void setIdPeriodoRegistro(String idPeriodoRegistro) {
        this.idPeriodoRegistro = idPeriodoRegistro;
    } 
    
    public Docente() {
    }

    public String getJsonHoras() {
        return jsonHoras;
    }
    

    public List<String[]> getListaHoras() {
        return listaHoras;
    }

    public List<String[]> getListaHorasCecyte() {
        return listaHorasCecyte;
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
                
                if(hora[3]!=null){
                    if(hora[7].equals("A")){
                        respuesta+="Componente b??sico y/o proped??utico: ";
                    }else if(hora[7].equals("S")){
                        respuesta+="Componente profesional:  ";
                    }else if(hora[7].equals("T")){
                        respuesta+="Taller: ";
                    }                
                    if(hora[5]!=null){
                        respuesta+=hora[5]+" - ";
                    }
                    respuesta+=hora[4]+"<br/>";
                }
                
                String auxClave2=hora[15]+" - "+hora[16];
                if(hora[13]!=null){
                    if(hora[14].equals("A")){
                        respuesta+="Componente b??sico y/o proped??utico: "+(hora[15]!=null ? auxClave2  : hora[16])+"<br/>";
                    }else if(hora[14].equals("S")){
                        respuesta+="Componente profesional:  "+(hora[15]!=null ? auxClave2  : hora[16])+"<br/>";
                    }else if(hora[14].equals("T")){
                        respuesta+="Taller: "+(hora[15]!=null ? auxClave2  : hora[16])+"<br/>";
                    }
                }
                
                String auxClave3=hora[19]+" - "+hora[20];
                if(hora[17]!=null){

                    if(hora[18].equals("A")){
                        respuesta+="Componente b??sico y/o proped??utico: "+(hora[19]!=null ? auxClave3  : hora[20])+"<br/>";
                    }else if(hora[18].equals("S")){
                        respuesta+="Componente profesional:  "+(hora[19]!=null ? auxClave3  : hora[20])+"<br/>";
                    }else if(hora[18].equals("T")){
                        respuesta+="Taller: "+(hora[19]!=null ? auxClave3  : hora[20])+"<br/>";
                    }
                }
                
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
                    respuesta+="<span class='glyphicon glyphicon-exclamation-sign incompleto' title='Secci??n incompleta'></span>";
                }
                else if(hora[11].equals("V")&&hora[12].equals("V")){
                    respuesta+="<button type='button' class='btn btn-sm' disabled title='Esta informaci??n no puede borrarse'>";
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
    public void registraHorasDGETI(String idPeriodo,String idAsignatura,String horas,String grupo,String semestre,String idAsignatura2,String idAsignatura3){
        Metodos_sql metodo = new Metodos_sql();
        String[] parametros={idUsuario,idPeriodo,idAsignatura,horas,grupo,semestre,idAsignatura2,idAsignatura3};
        List<String[]> datos=metodo.ejecutaSP("sp_registroHorasGrupoDGETI",parametros);          
    }
    public void borraHoras(String idHoraGrupo){
        Metodos_sql metodo = new Metodos_sql();
        String[] parametros={idHoraGrupo};
        List<String[]> datos=metodo.ejecutaSP("sp_deleteHorasGrupo",parametros);          
    }
    public void borraHorascCecyte(String idHoraGrupo){
        Metodos_sql metodo = new Metodos_sql();
        String[] parametros={idHoraGrupo};
        List<String[]> datos=metodo.ejecutaSP("sp_deleteHorasGrupoCecyte",parametros);       
    }
    public void registraHorasCecyte(String idPeriodo,String grupo,String semestre,String tipoInfo,String version,String carrera,String modulo,String submodulo,String horas,String idAsignatura){
        Metodos_sql metodo = new Metodos_sql();
        String[] parametros={idUsuario,idPeriodo,grupo,semestre,tipoInfo,version,carrera,modulo,submodulo,horas,idAsignatura};
        List<String[]> datos=metodo.ejecutaSP("sp_registroHorasGrupoCecyte",parametros);          
    }
    public int getTotalHorasCecyte(){
        consultaHorasCecyte();
        int totalHoras=0;
        //HorasGrupo[] aux=getArrayHoras();
        if(listaHorasCecyte.size()>0){
            for(String[] hora:listaHorasCecyte){
                totalHoras+=Integer.parseInt(hora[10]);
            }
        }
        return totalHoras;
    }
    public int getNumGruposCecyte(){
        return listaHorasCecyte.size();
    }
    public void consultaHorasCecyte(){
        Metodos_sql metodo = new Metodos_sql();
        String[] parametros={idUsuario};
        listaHorasCecyte=metodo.ejecutaSP("sp_selectHorasGrupoCecyte",parametros);          
    } 
    public String mostrarHorasCecyte(){
        consultaHorasCecyte();
        String respuesta="";
        for(String[] hora:listaHorasCecyte){
                respuesta+="<tr><td>";
                respuesta+="Periodo: "+hora[2]+"<br/>";                
                //tipoInfo
                respuesta+=hora[5];                
                //clave
                respuesta+=" - ";
                //carrera
                respuesta+=hora[7]+"-"+hora[11]+"<br/>";                                                              
                respuesta+="Grupo: "+hora[3]+"<br/>"; 
                respuesta+="Semestre: "+hora[4]+"<br/>"; 
                respuesta+="Horas: "+hora[10]+"<br/>";
                respuesta+="</td>";
                respuesta+="<td class='text-center'>";
                respuesta+="<button type='button' class='btn btn-sm' title='Borrar' onclick='borrarHoraGrupoCecyte("+hora[0]+")'>";
                respuesta+="<span class='glyphicon glyphicon-trash'></span>";
                respuesta+="</button>";                                             
                respuesta+="</td></tr>";                
            }
        return respuesta;
    }
    public Boolean getBanderaIngles() {
        return banderaIngles;
    }

    public void setBanderaIngles(Boolean banderaIngles) {
        this.banderaIngles = banderaIngles;
    }
    public void actualizaBanderaIngles(){
        for(String[] dato:listaHoras){
            if(dato[4]!=null){
                if(dato[4].contains("INGL??S")||dato[4].contains("INGLES")||dato[4].contains("CENNI")){
                    banderaIngles=true;
                }
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
            idPeriodoRegistro=infoRegistro[84];
        }
    }
    public void consultaInfoAspirante2(){
        Metodos_sql metodo = new Metodos_sql();
        String[] parametros={idUsuario};
        List<String[]> datos=metodo.ejecutaSP("sp_consultaRegistro2",parametros);
        if(!datos.isEmpty()){
            infoRegistro=datos.get(0);
            idConvocatoria=infoRegistro[65];
            idPeriodoRegistro=infoRegistro[82];
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
                try{
                    if(infoRegistro[14]!=null){
                        if(documentoCargado("1")){//Si ya se registr?? la informaci??n academica y se cargo el titulo                        
                            if(infoRegistro[24]==null){//Si no se registr?? informaci??n de C??dula
                                retorno=true;                            
                            }else{
                                if(documentoCargado("8")){//Si s?? se registr?? la informaci??n de C??dula y se cargo el documento
                                    retorno=true;
                                }
                            }  
                        }
                    }
                }catch(Exception e){
                    System.out.println(e.toString());
                }
                break;
            case "2":
                try{
                    if(infoRegistro[26]!=null){
                    if(documentoCargado("2")&&documentoCargado("3")){//Si ya se registr?? la informaci??n laboral  y se cargo la constancia de antiguedad y nombramiento                       
                        if(infoRegistro[48].equals("S")){//Si cuenta con nota desfavorable
                            retorno=true;                            
                        }else{
                            if(documentoCargado("6")){//Si no cuenta con nota desfavorable y se cargo el documento
                                retorno=true;
                            }
                        }  
                    }
                }
                }catch(Exception e){
                    System.out.println(e.toString());
                }
                break;
            case "3":
                try{
                    if(listaHoras.size()>0){                    
                    if(documentoCargado("4")){//Si ya se registr?? la informaci??n de horas frente a grupo  y se cargo la constancia                       
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
                }catch(Exception e){
                    System.out.println(e.toString());
                }
                break;
            case "4":
                try{
                   if(infoRegistro[60]!=null){
                    if(infoRegistro[60].equals("S")){//Si marco la casilla de funciones en otro subsistema
                        if(infoRegistro[49].equals("S")){//Si marc?? la casilla de compatibilidad 
                            if(documentoCargado("7")){//Si carg?? la constancia de compatibilidad                              
                                retorno=true;                        
                            }                    
                        }
                    }else{
                        retorno=true; 
                    }
                } 
                }catch(Exception e){
                    System.out.println(e.toString());
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
        String[] parametros={rfc,idPeriodoRegistro};
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
                    fila+="<button type='button' class='btn btn-sm' title='Borrar' onclick='borrarEncuestado("+encuestado[0]+","+encuestado[3]+","+encuestado[7]+")'>";
                    fila+="<span class='glyphicon glyphicon-trash'></span>";
                    fila+="</button>";
                }else if(encuestado[5].equals("CONCLUIDO")){
                    fila+="<button type='button' class='btn btn-sm' disabled title='Esta informaci??n no puede borrarse'>";
                    fila+="<span class='glyphicon glyphicon-trash'></span>";
                    fila+="</button>";
                }
                fila+="<td>"+encuestado[6]+"</td><td>";
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
                        fila+="<button type='button' class='btn btn-sm' title='Borrar' onclick='borrarEncuestado("+encuestado[0]+","+encuestado[3]+","+encuestado[7]+")'>";
                        fila+="<span class='glyphicon glyphicon-trash'></span>";
                        fila+="</button>";
                    }else if(encuestado[5].equals("CONCLUIDO")){
                        fila+="<button type='button' class='btn btn-sm' disabled title='Esta informaci??n no puede borrarse'>";
                        fila+="<span class='glyphicon glyphicon-trash'></span>";
                        fila+="</button>";
                    }
                    fila+="<td>"+encuestado[6]+"</td><td>";
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
            System.out.println(ruta);
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
            System.out.println(ruta);
            ruta+="/"+idUsuario+"_"+idDocumento+".pdf";
            System.out.println(ruta);
            File documento;            
            documento=new File(ruta);
            retorno= documento.exists();
        }catch(Exception e){
            System.out.println(e.toString());
        }finally{
            return retorno;
        }
    }
    
    public boolean documentoCargado4(String idDocumento){
        boolean retorno=false;
        try{        
            String rutaConfig = RutaConfig.getRutaConfig();
            Properties p = new Properties();
            p.load(new FileReader(rutaConfig));
            String ruta=p.getProperty("rutaCartaAceptacionRevisor");
            System.out.println(ruta);
            ruta+="/"+idUsuario+"_"+idDocumento+".pdf";
            System.out.println(ruta);
            File documento;            
            documento=new File(ruta);
            retorno= documento.exists();
        }catch(Exception e){
            System.out.println(e.toString());
        }finally{
            return retorno;
        }
    }
    
    public void consultaEncuestados2(String idPeriodoRegistro){
        Metodos_sql metodos=new Metodos_sql();
        String[] parametros={rfc,idPeriodoRegistro};
        encuestados= metodos.ejecutaSPEncuestas("sp_selectLecturaUrlRFC",parametros);
        totalEncuestados=encuestados.size();
    }
    
    public ArrayList<String> getValidaAccionPorConvocatoria(String idUsuario){ 
               Metodos_sql metodo=new Metodos_sql();
               ArrayList<String> lista=new ArrayList<>();
               List<String[]> datos=null;
           try{
               String[] parametros={idUsuario};
              datos=metodo.ejecutaSP("sp_selectValidaAccionPorConvocatoria", parametros);

               for(String[] dato:datos){
                   lista.add(dato[0]);
               }
           }catch(Exception e){

           }finally{
               return lista;        
           }
    }
        
    public ArrayList<String> getInfoMotivoFichaIncompleta(String idUsuario){ 
               Metodos_sql metodo=new Metodos_sql();
               ArrayList<String> lista=new ArrayList<>();
               List<String[]> datos=null;
           try{
               String[] parametros={idUsuario};
              datos=metodo.ejecutaSP("sp_selectMotivoFichaIncompleta", parametros);

               for(String[] dato:datos){
                   lista.add(dato[0]);
               }
           }catch(Exception e){

           }finally{
               return lista;        
           }
    }    
}
