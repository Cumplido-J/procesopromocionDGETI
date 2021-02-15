/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package herramientas;

import java.util.List;
import metodos_sql.Metodos_sql;

/**
 *
 * @author David Reyna
 */
public class CriteriosValoracion {
    Metodos_sql metodo;
    Fecha fecha;

    public CriteriosValoracion() {
        metodo=new Metodos_sql();
        fecha=new Fecha();
    }    
    public String[] getFilasCursos(String idUsuario,boolean vistaAdmin){   
        String[] respuesta={"",""};        
        int puntaje=0;
        int horas=0;
        String[] parametros={idUsuario};
        List<String[]> datos=metodo.ejecutaSP("sp_selectCursos",parametros);
        if(datos.isEmpty()){
            respuesta[0]="<tr><td colspan='7'>Sin información</td></tr>";
        }else{
            respuesta[0]="";
            for(String[] dato:datos){
                respuesta[0]+="<tr>";
                if(dato[2].equals("CU")){
                    if(dato[9]!=null){
                        if(dato[9].equals("V")){
                            horas+=Integer.parseInt(dato[7]);
                        }
                    }
                    //System.out.println(horas);
                    respuesta[0]+="<td>Curso de actualización</td>"; 
                }else if(dato[2].equals("CE")){
                    if(dato[9]!=null){
                        if(dato[9].equals("V")){
                        puntaje=10;
                        }
                    }
                    respuesta[0]+="<td>Certificación</td>"; 
                }
                respuesta[0]+="<td>"+dato[3]+"</td>";  
                if(dato[4].equals(dato[5])){
                    respuesta[0]+="<td>"+fecha.formatoImprimir(dato[4])+"</td>";                                
                }else{
                    respuesta[0]+="<td>"+fecha.formatoImprimir(dato[4])+"-"+fecha.formatoImprimir(dato[5])+"</td>";
                }
                respuesta[0]+="<td>"+dato[6]+"</td>";
                respuesta[0]+="<td>"+dato[7]+"</td>";
                respuesta[0]+="<td>"+dato[8]+"</td>";
                respuesta[0]+="<td>";
                if(vistaAdmin){
                    if(dato[9]==null){
                        respuesta[0]+="<button type='button' class='btn btn-sm' title='Aprobar' onclick='aprobarCurso("+dato[0]+")'>";
                        respuesta[0]+="<span class='glyphicon glyphicon-ok completo'></span>";
                        respuesta[0]+="</button>";
                        respuesta[0]+="<button type='button' class='btn btn-sm' title='No cumple con la evidencia' onclick='rechazarCurso("+dato[0]+")'>";
                        respuesta[0]+="<span class='glyphicon glyphicon-remove incompleto'></span>";                    
                        respuesta[0]+="</button>";
                        respuesta[0]+="<span class='glyphicon glyphicon-exclamation-sign incompleto' title='Sección incompleta'></span>";
                    }else{
                        if(dato[9].equals("V")){
                            respuesta[0]+="<span class='glyphicon glyphicon-ok completo' title='Aprobado'></span>";
                        }else{
                            respuesta[0]+="<span class='glyphicon glyphicon-remove incompleto' title='No cumple con la evidencia'></span>";
                        }
                    }
                }else{
                    respuesta[0]+="<button type='button' class='btn btn-sm' title='Borrar' onclick='confirmarCurso("+dato[0]+")'>";
                    respuesta[0]+="<span class='glyphicon glyphicon-trash'></span>";
                    respuesta[0]+="</button>";
                }                
                respuesta[0]+="</td>";
                respuesta[0]+="</tr>";
            }            
        }
        if(horas>=120 && horas<=160){
            puntaje+=40;
        }else if(horas>=161 && horas<=199){
            puntaje+=50;
        }else if(horas>=200){
            puntaje+=60;
        }
        respuesta[1]=""+puntaje;
        return respuesta;
    }
    public String[] getFilasAportaciones(String idUsuario,boolean vistaAdmin){   
        String respuesta;
        String puntaje;
        String[] retorno={"","0"};
        String[] parametros={idUsuario};
        int validos=0;
        List<String[]> datos=metodo.ejecutaSP("sp_consultaAportaciones",parametros);
        if(datos.isEmpty()){
            respuesta="<tr><td colspan='5'>Sin información</td></tr>";
            puntaje=null;
        }else{
            respuesta="";
            for(String[] dato:datos){
                respuesta+="<tr>"; 
                respuesta+="<td>"+dato[3]+"</td>";  
                if(dato[4].equals(dato[5])){
                    respuesta+="<td>"+fecha.formatoImprimir(dato[4])+"</td>";                                
                }else{
                    respuesta+="<td>"+fecha.formatoImprimir(dato[4])+"-"+fecha.formatoImprimir(dato[5])+"</td>";
                }
                respuesta+="<td>"+dato[6]+"</td>";
                respuesta+="<td>"+dato[7]+"</td>";
                respuesta+="<td>";
                if(vistaAdmin){
                    if(dato[8]==null){
                        respuesta+="<button type='button' class='btn btn-sm' title='Aprobar' onclick='aprobarAportacion("+dato[0]+")'>";
                        respuesta+="<span class='glyphicon glyphicon-ok completo'></span>";
                        respuesta+="</button>";
                        respuesta+="<button type='button' class='btn btn-sm' title='No cumple con la evidencia' onclick='rechazarAportacion("+dato[0]+")'>";
                        respuesta+="<span class='glyphicon glyphicon-remove incompleto'></span>";                    
                        respuesta+="</button>";
                        respuesta+="<span class='glyphicon glyphicon-exclamation-sign incompleto' title='Sección incompleta'></span>";
                    }else{
                        if(dato[8].equals("V")){
                            respuesta+="<span class='glyphicon glyphicon-ok completo' title='Aprobado'></span>";
                            validos++;
                        }else{
                            respuesta+="<span class='glyphicon glyphicon-remove incompleto' title='No cumple con la evidencia'></span>";
                        }
                    }
                }else{
                respuesta+="<button type='button' class='btn btn-sm' title='Borrar' onclick='confirmarAportacion("+dato[0]+")'>";
                respuesta+="<span class='glyphicon glyphicon-trash'></span>";
                respuesta+="</button>";
                }
                respuesta+="</td>";
                respuesta+="</tr>";
            }          
            switch(validos){
                case 0:
                    puntaje="0";
                    break;
                case 1:
                    puntaje="30";
                    break;
                case 2:
                    puntaje="55";
                    break;
                case 3:
                    puntaje="80";
                    break;
                case 4:
                    puntaje="105";
                    break;
                default:
                    puntaje="130";
                    break;                
            }
        }
        retorno[0]=respuesta;
        retorno[1]=puntaje;
        return retorno;
    }
    public String[] getFilasParticipaciones(String idUsuario,boolean vistaAdmin){   
        String[] retorno={"","0"};
        String respuesta;
        String puntaje;
        String[] parametros={idUsuario};
        List<String[]> datos=metodo.ejecutaSP("sp_consultaParticipaciones",parametros);
        int validos=0;
        if(datos.isEmpty()){
            respuesta="<tr><td colspan='5'>Sin información</td></tr>";
            puntaje="0";
        }else{
            respuesta="";
            for(String[] dato:datos){
                respuesta+="<tr>"; 
                respuesta+="<td>"+dato[3]+"</td>";  
                if(dato[4].equals(dato[5])){
                    respuesta+="<td>"+fecha.formatoImprimir(dato[4])+"</td>";                                
                }else{
                    respuesta+="<td>"+fecha.formatoImprimir(dato[4])+"-"+fecha.formatoImprimir(dato[5])+"</td>";
                }
                respuesta+="<td>"+dato[6]+"</td>";
                respuesta+="<td>"+dato[7]+"</td>";
                respuesta+="<td>";
                if(vistaAdmin){
                    if(dato[8]==null){
                        respuesta+="<button type='button' class='btn btn-sm' title='Aprobar' onclick='aprobarParticipacion("+dato[0]+")'>";
                        respuesta+="<span class='glyphicon glyphicon-ok completo'></span>";
                        respuesta+="</button>";
                        respuesta+="<button type='button' class='btn btn-sm' title='No cumple con la evidencia' onclick='rechazarParticipacion("+dato[0]+")'>";
                        respuesta+="<span class='glyphicon glyphicon-remove incompleto'></span>";                    
                        respuesta+="</button>";
                        respuesta+="<span class='glyphicon glyphicon-exclamation-sign incompleto' title='Sección incompleta'></span>";
                    }else{
                        if(dato[8].equals("V")){
                            respuesta+="<span class='glyphicon glyphicon-ok completo' title='Aprobado'></span>";
                            validos++;
                        }else{
                            respuesta+="<span class='glyphicon glyphicon-remove incompleto' title='No cumple con la evidencia'></span>";
                        }
                    }
                }else{
                respuesta+="<button type='button' class='btn btn-sm' title='Borrar' onclick='confirmarParticipacion("+dato[0]+")'>";
                respuesta+="<span class='glyphicon glyphicon-trash'></span>";
                respuesta+="</button>";
                }
                respuesta+="</td>";
                respuesta+="</tr>";
            }           
            switch(validos){
                case 0:
                    puntaje="0";
                    break;
                case 1:
                    puntaje="30";
                    break;
                case 2:
                    puntaje="55";
                    break;
                case 3:
                    puntaje="80";
                    break;
                case 4:
                    puntaje="105";
                    break;
                default:
                    puntaje="130";
                    break;                
            }
        }
        retorno[0]=respuesta;
        retorno[1]=puntaje;
        return retorno;
    }
    public String[] getFilasTutorias(String idUsuario,boolean vistaAdmin){   
        String respuesta;
        String[] retorno={"","0"};
        String puntaje="0";
        String[] parametros={idUsuario};
        List<String[]> datos=metodo.ejecutaSP("sp_selectTutorias",parametros);
        int validos=0;
        if(datos.isEmpty()){
            respuesta="<tr><td colspan='3'>Sin información</td></tr>";
            puntaje="0";
        }else{
            respuesta="";
            for(String[] dato:datos){
                respuesta+="<tr>";                  
                if(dato[2].equals(dato[3])){
                    respuesta+="<td>"+fecha.formatoImprimir(dato[2])+"</td>";                                
                }else{
                    respuesta+="<td>"+fecha.formatoImprimir(dato[2])+"-"+fecha.formatoImprimir(dato[3])+"</td>";
                }
                respuesta+="<td>"+dato[4]+"</td>";
                respuesta+="<td>";
                if(vistaAdmin){
                    if(dato[5]==null){
                        respuesta+="<button type='button' class='btn btn-sm' title='Aprobar' onclick='aprobarTutoria("+dato[0]+")'>";
                        respuesta+="<span class='glyphicon glyphicon-ok completo'></span>";
                        respuesta+="</button>";
                        respuesta+="<button type='button' class='btn btn-sm' title='No cumple con la evidencia' onclick='rechazarTutoria("+dato[0]+")'>";
                        respuesta+="<span class='glyphicon glyphicon-remove incompleto'></span>";                    
                        respuesta+="</button>";
                        respuesta+="<span class='glyphicon glyphicon-exclamation-sign incompleto' title='Sección incompleta'></span>";
                    }else{
                        if(dato[5].equals("V")){
                            respuesta+="<span class='glyphicon glyphicon-ok completo' title='Aprobado'></span>";
                            validos++;
                        }else{
                            respuesta+="<span class='glyphicon glyphicon-remove incompleto' title='No cumple con la evidencia'></span>";
                        }
                    }
                }else{
                respuesta+="<button type='button' class='btn btn-sm' title='Borrar' onclick='confirmarTutoria("+dato[0]+")'>";
                respuesta+="<span class='glyphicon glyphicon-trash'></span>";
                respuesta+="</button>";
                }
                respuesta+="</td>";
                respuesta+="</tr>";
            } 
            if(validos==0){
                puntaje="0";
            }if(validos==1){
                puntaje="35";
            }else if(validos>1){
                puntaje="70";
            }
        }
        retorno[0]=respuesta;
        retorno[1]=puntaje;
        return retorno;
    }
    public String[] getFilasPublicaciones(String idUsuario,boolean vistaAdmin){   
        String respuesta;
        String puntaje="0";
        String[] retorno={"","0"};
        String[] parametros={idUsuario};
        int validos=0;
        List<String[]> datos=metodo.ejecutaSP("sp_selectPublicaciones",parametros);
        if(datos.isEmpty()){
            respuesta="<tr><td colspan='5'>Sin información</td></tr>";
            puntaje="0";
        }else{
            respuesta="";
            for(String[] dato:datos){
                respuesta+="<tr>"; 
                respuesta+="<td>"+dato[2]+"</td>";
                respuesta+="<td>"+dato[3]+"</td>";
                respuesta+="<td>"+fecha.formatoImprimir(dato[4])+"</td>"; 
                respuesta+="<td>"+dato[5]+"</td>";
                respuesta+="<td>";
                if(vistaAdmin){
                    if(dato[6]==null){
                        respuesta+="<button type='button' class='btn btn-sm' title='Aprobar' onclick='aprobarPublicacion("+dato[0]+")'>";
                        respuesta+="<span class='glyphicon glyphicon-ok completo'></span>";
                        respuesta+="</button>";
                        respuesta+="<button type='button' class='btn btn-sm' title='No cumple con la evidencia' onclick='rechazarPublicacion("+dato[0]+")'>";
                        respuesta+="<span class='glyphicon glyphicon-remove incompleto'></span>";                    
                        respuesta+="</button>";
                        respuesta+="<span class='glyphicon glyphicon-exclamation-sign incompleto' title='Sección incompleta'></span>";
                    }else{
                        if(dato[6].equals("V")){
                            respuesta+="<span class='glyphicon glyphicon-ok completo' title='Aprobado'></span>";
                            validos++;
                        }else{
                            respuesta+="<span class='glyphicon glyphicon-remove incompleto' title='No cumple con la evidencia'></span>";
                        }
                    }
                }else{
                respuesta+="<button type='button' class='btn btn-sm' title='Borrar' onclick='confirmarPublicacion("+dato[0]+")'>";
                respuesta+="<span class='glyphicon glyphicon-trash'></span>";
                respuesta+="</button>";
                }
                respuesta+="</td>";
                respuesta+="</tr>";
            }           
            if(validos==0){
                puntaje="0";
            }else if(validos==1){
                puntaje="25";
            }else if(validos>1){
                puntaje="50";
            }
        }
        retorno[0]=respuesta;
        retorno[1]=puntaje;
        return retorno;
    }
    public String[] getFilasResultados(String idUsuario,boolean vistaAdmin){   
        String respuesta;
        String puntaje="0";
        String[] retorno=new String[2];
        String[] parametros={idUsuario};
        int validos=0;
        List<String[]> datos=metodo.ejecutaSP("sp_consultaResultados",parametros);
        if(datos.isEmpty()){
            respuesta="<tr><td colspan='4'>Sin información</td></tr>";
            puntaje="0";
        }else{
            respuesta="";
            for(String[] dato:datos){                
                respuesta+="<tr>"; 
                respuesta+="<td>"+dato[3]+"</td>";
                if(dato[4].equals(dato[5])){
                    respuesta+="<td>"+fecha.formatoImprimir(dato[4])+"</td>";                                
                }else{
                    respuesta+="<td>"+fecha.formatoImprimir(dato[4])+"-"+fecha.formatoImprimir(dato[5])+"</td>";
                }
                respuesta+="<td>"+dato[6]+"</td>";
                respuesta+="<td>";
                if(vistaAdmin){
                    if(dato[7]==null){
                        respuesta+="<button type='button' class='btn btn-sm' title='Aprobar' onclick='aprobarResultado("+dato[0]+")'>";
                        respuesta+="<span class='glyphicon glyphicon-ok completo'></span>";
                        respuesta+="</button>";
                        respuesta+="<button type='button' class='btn btn-sm' title='No cumple con la evidencia' onclick='rechazarResultado("+dato[0]+")'>";
                        respuesta+="<span class='glyphicon glyphicon-remove incompleto'></span>";                    
                        respuesta+="</button>";
                        respuesta+="<span class='glyphicon glyphicon-exclamation-sign incompleto' title='Sección incompleta'></span>";
                    }else{
                        if(dato[7].equals("V")){
                            respuesta+="<span class='glyphicon glyphicon-ok completo' title='Aprobado'></span>";
                            validos++;
                        }else{
                            respuesta+="<span class='glyphicon glyphicon-remove incompleto' title='No cumple con la evidencia'></span>";
                        }
                    }
                }else{
                respuesta+="<button type='button' class='btn btn-sm' title='Borrar' onclick='confirmarResultado("+dato[0]+")'>";
                respuesta+="<span class='glyphicon glyphicon-trash'></span>";
                respuesta+="</button>";
                }
                respuesta+="</td>";
                respuesta+="</tr>";
            }  
            int aux=validos;
            if(aux==1 || aux==2){
                puntaje="30";
            }else if(aux==3 || aux==4){
                puntaje="55";
            }else if(aux==5 || aux==6){
                puntaje="80";
            }else if(aux==7 || aux==8){
                puntaje="105";
            }else if(aux==9 || aux==10){
                puntaje="130";
            }else if(aux>10){
                puntaje="150";
            }
        }
        retorno[0]=respuesta;
        retorno[1]=puntaje;
        return retorno;
    }
    public String[][] consultaPuntajes(String idUsuario, String idPermiso){
        String[][] respuesta=new String[15][8];
        int c,d;
        /*for(c=0;c<15;c++){
            for(d=0;d<7;d++){
                respuesta[c][d]="";
            }
            respuesta[c][4]="0";
        }*/
        String[] parametros={idUsuario,idPermiso};
        List<String[]> datos=metodo.ejecutaSP("sp_consultaConstanciasProceso",parametros);
        if(!datos.isEmpty()){             
            for(String[] dato:datos){
                c=Integer.parseInt(dato[2]);
                respuesta[c-1]=dato;
            }            
        }        
        return respuesta;
    }
    public String[] consultaPuntajeEncuestas(String rfc){
        String[] respuesta={"","","0","0","0","0"};
        String[] parametros={rfc};
        List<String[]> datos=metodo.ejecutaSPEncuestas("sp_selectConsultaResultado",parametros);
        if(!datos.isEmpty()){ 
            respuesta=datos.get(0);
        }
        return respuesta;
    }
    public String getFilasCursosFicha(String idUsuario){   
        String retorno="";      
        int puntaje=0;
        int horas=0;
        String[] parametros={idUsuario};
        List<String[]> datos=metodo.ejecutaSP("sp_selectCursos",parametros);
        if(datos.isEmpty()){
            retorno="<tr><td class='borde' colspan='6'>Sin información</td></tr>";
        }else{
            for(String[] dato:datos){
                retorno+="<tr>";
                if(dato[2].equals("CU")){
                    horas+=Integer.parseInt(dato[7]);
                    
                    retorno+="<td class='borde'>Curso de actualización</td>"; 
                }else if(dato[2].equals("CE")){
                    
                    retorno+="<td class='borde'>Certificación</td>"; 
                }
               retorno+="<td class='borde'>"+dato[3]+"</td>";  
                if(dato[4].equals(dato[5])){
                    retorno+="<td class='borde'>"+fecha.formatoImprimir(dato[4])+"</td>";                                
                }else{
                    retorno+="<td class='borde'>"+fecha.formatoImprimir(dato[4])+"-"+fecha.formatoImprimir(dato[5])+"</td>";
                }
                retorno+="<td class='borde'>"+dato[6]+"</td>";
                retorno+="<td class='borde'>"+dato[7]+"</td>";
                retorno+="<td class='borde'>"+dato[8]+"</td>";
                
                retorno+="</tr>";
            }            
        }        
        return retorno;
    }
    public String getFilasAportacionesFicha(String idUsuario){   
        String respuesta;
        String puntaje;
        String[] retorno={"","0"};
        String[] parametros={idUsuario};
        List<String[]> datos=metodo.ejecutaSP("sp_consultaAportaciones",parametros);
        if(datos.isEmpty()){
            respuesta="<tr><td class='borde' colspan='4'>Sin información</td></tr>";
            
        }else{
            respuesta="";
            for(String[] dato:datos){
                respuesta+="<tr>"; 
                respuesta+="<td class='borde'>"+dato[3]+"</td>";  
                if(dato[4].equals(dato[5])){
                    respuesta+="<td class='borde'>"+fecha.formatoImprimir(dato[4])+"</td>";                                
                }else{
                    respuesta+="<td class='borde'>"+fecha.formatoImprimir(dato[4])+"-"+fecha.formatoImprimir(dato[5])+"</td>";
                }
                respuesta+="<td class='borde'>"+dato[6]+"</td>";
                respuesta+="<td class='borde'>"+dato[7]+"</td>";
               
                respuesta+="</tr>";
            }          
        }
        return respuesta;
    }
    public String getFilasParticipacionesFicha(String idUsuario){ 
        String respuesta;
        String puntaje;
        String[] parametros={idUsuario};
        List<String[]> datos=metodo.ejecutaSP("sp_consultaParticipaciones",parametros);
        if(datos.isEmpty()){
            respuesta="<tr><td class='borde' colspan='4'>Sin información</td></tr>";
            
        }else{
            respuesta="";
            for(String[] dato:datos){
                respuesta+="<tr>"; 
                respuesta+="<td class='borde'>"+dato[3]+"</td>";  
                if(dato[4].equals(dato[5])){
                    respuesta+="<td class='borde'>"+fecha.formatoImprimir(dato[4])+"</td>";                                
                }else{
                    respuesta+="<td class='borde'>"+fecha.formatoImprimir(dato[4])+"-"+fecha.formatoImprimir(dato[5])+"</td>";
                }
                respuesta+="<td class='borde'>"+dato[6]+"</td>";
                respuesta+="<td class='borde'>"+dato[7]+"</td>";
                
                respuesta+="</tr>";
            }           
        } 
        return respuesta;
    }
    public String getFilasTutoriasFicha(String idUsuario){   
        String respuesta;
        
        String puntaje;
        String[] parametros={idUsuario};
        List<String[]> datos=metodo.ejecutaSP("sp_selectTutorias",parametros);
        if(datos.isEmpty()){
            respuesta="<tr><td class='borde' colspan='2'>Sin información</td></tr>";            
        }else{
            respuesta="";
            for(String[] dato:datos){
                respuesta+="<tr>";                  
                if(dato[2].equals(dato[3])){
                    respuesta+="<td class='borde'>"+fecha.formatoImprimir(dato[2])+"</td>";                                
                }else{
                    respuesta+="<td class='borde'>"+fecha.formatoImprimir(dato[2])+"-"+fecha.formatoImprimir(dato[3])+"</td>";
                }
                respuesta+="<td class='borde'>"+dato[4]+"</td>";                
                respuesta+="</tr>";
            } 
            
        }
        
        return respuesta;
    }
    public String getFilasPublicacionesFicha(String idUsuario){   
        String respuesta;
        String puntaje="0";
        String[] parametros={idUsuario};
        List<String[]> datos=metodo.ejecutaSP("sp_selectPublicaciones",parametros);
        if(datos.isEmpty()){
            respuesta="<tr><td class='borde' colspan='4'>Sin información</td></tr>";
            
        }else{
            respuesta="";
            for(String[] dato:datos){
                respuesta+="<tr>"; 
                respuesta+="<td class='borde'>"+dato[2]+"</td>";
                respuesta+="<td class='borde'>"+dato[3]+"</td>";
                respuesta+="<td class='borde'>"+fecha.formatoImprimir(dato[4])+"</td>"; 
                respuesta+="<td class='borde'>"+dato[5]+"</td>";                
                respuesta+="</tr>";
            }           
            
        }
        
        return respuesta;
    }
    public String getFilasResultadosFicha(String idUsuario){   
        String respuesta;
        
        String[] parametros={idUsuario};
        List<String[]> datos=metodo.ejecutaSP("sp_consultaResultados",parametros);
        if(datos.isEmpty()){
            respuesta="<tr><td class='borde' colspan='3'>Sin información</td></tr>";
            
        }else{
            respuesta="";
            for(String[] dato:datos){                
                respuesta+="<tr>"; 
                respuesta+="<td class='borde'>"+dato[3]+"</td>";
                if(dato[4].equals(dato[5])){
                    respuesta+="<td class='borde'>"+fecha.formatoImprimir(dato[4])+"</td>";                                
                }else{
                    respuesta+="<td class='borde'>"+fecha.formatoImprimir(dato[4])+"-"+fecha.formatoImprimir(dato[5])+"</td>";
                }
                respuesta+="<td class='borde'>"+dato[6]+"</td>";
                
                respuesta+="</tr>";
            }
        }
        return respuesta;
    }
    
}
