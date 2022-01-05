/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package herramientas;

import java.util.ArrayList;
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
    public String[] getFilasCursos(String idUsuario,boolean vistaAdmin, String idPermiso,String permisoActualEdicion){   
        String[] respuesta={"","",""}; 
        String valido;
        int puntaje=0;
        int horas=0;
        int puntajeD=0;
        int horasD=0;
        String[] parametros={idUsuario};
        String permisoEdicion = permisoActualEdicion.equals("F") ? "disabled" : "";
        List<String[]> datos=metodo.ejecutaSP("sp_selectCursos_v2",parametros);
        if(datos.isEmpty()){
            respuesta[0]="<tr><td colspan='8'>Sin información</td></tr>";
        }else{
            respuesta[0]="";
            for(String[] dato:datos){
                puntaje = Integer.parseInt(dato[11]);
                puntajeD = Integer.parseInt(dato[12]);
                respuesta[0]+="<tr>";
                if(dato[2].equals("CU")){
                    /*
                    if(dato[10]!=null)
                    {
                        if(dato[10].equals("V"))
                        {horasD+=Integer.parseInt(dato[7]);}
                    }
                    if(dato[9]!=null)
                    {
                        if(dato[9].equals("V"))
                        {horas+=Integer.parseInt(dato[7]);}
                    }
                    //System.out.println(horas);
                    */
                    respuesta[0]+="<td>Curso de actualización</td>"; 
                }else if(dato[2].equals("CE")){
                    /*
                    if(dato[10]!=null)
                    {
                        if(dato[10].equals("V"))
                        {puntajeD=10;}
                    }
                    if(dato[9]!=null)
                    {
                        if(dato[9].equals("V"))
                        {puntaje=10;}
                    }
                    */
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
                if (idPermiso.equals("6"))
                {
                    if(dato[9]==null){
                        respuesta[0]+="<span class='glyphicon glyphicon-exclamation-sign incompleto' title='Sección incompleta'></span>";
                    }else if (dato[9].equals("V")){
                        respuesta[0]+="<span class='glyphicon glyphicon-ok completo' title='Aprobado'></span>";
                    }else{
                        respuesta[0]+="<span class='glyphicon glyphicon-remove incompleto' title='No cumple con la evidencia'></span>";
                    }
                    valido = dato[10];
                    respuesta[0]+="</td><td>";
                }
                else
                {valido = dato[9];}
                if(vistaAdmin){
                    if(valido==null){
                        respuesta[0]+="<button type='button' class='btn btn-sm  " + permisoEdicion + "' title='Aprobar' onclick='aprobarCurso("+dato[0]+")'>";
                        respuesta[0]+="<span class='glyphicon glyphicon-ok completo'></span>";
                        respuesta[0]+="</button>";
                        respuesta[0]+="<button type='button' class='btn btn-sm  " + permisoEdicion + "' title='No cumple con la evidencia' onclick='rechazarCurso("+dato[0]+")'>";
                        respuesta[0]+="<span class='glyphicon glyphicon-remove incompleto'></span>";                    
                        respuesta[0]+="</button>";
                        respuesta[0]+="<span class='glyphicon glyphicon-exclamation-sign incompleto' title='Sección incompleta'></span>";
                    }else{
                        //Nuevo código
                        respuesta[0]+="<button id='cursoAprueba" + dato[0] + "' name='cursoAprueba" + dato[0] + "' type='button' class='btn btn-sm  " + permisoEdicion + " hidden' title='Aprobar' onclick='aprobarCurso("+dato[0]+")'>";
                        respuesta[0]+="<span class='glyphicon glyphicon-ok completo'></span>";
                        respuesta[0]+="</button>";
                        respuesta[0]+="<button id='cursoRechaza" + dato[0] + "' name='cursoRechaza" + dato[0] + "' type='button' class='btn btn-sm  " + permisoEdicion + " hidden' title='No cumple con la evidencia' onclick='rechazarCurso("+dato[0]+")'>";
                        respuesta[0]+="<span class='glyphicon glyphicon-remove incompleto'></span>";                    
                        respuesta[0]+="</button>";
                        ////respuesta[0]+="<span id='cursoIncompleto" + dato[0] + "' name='cursoIncompleto" + dato[0] + "' class='glyphicon glyphicon-exclamation-sign incompleto hidden disabled' title='Sección incompleta'></span>";

                        if(valido.equals("V")){
                            respuesta[0]+="<button type='button' id='cursoAprobado" + dato[0] + "' name='cursoAprobado" + dato[0] + "' class='btn btn-sm  " + permisoEdicion + "' title='Aprobado/Editar' onclick='activarEditarCurso(" + dato[0] + ")'>";
                            respuesta[0]+="<span class='glyphicon glyphicon-ok completo'></span>";
                            respuesta[0]+="</button>";

                            //respuesta[0]+="<span class='glyphicon glyphicon-ok completo' title='Aprobado'></span>";
                        }else{
                            respuesta[0]+="<button type='button' id='cursoRechazado" + dato[0] + "' name='cursoRechazado" + dato[0] + "' class='btn btn-sm  " + permisoEdicion + "' title='No cumple con la evidencia/Editar' onclick='activarEditarCurso(" + dato[0] + ")'>";
                            respuesta[0]+="<span class='glyphicon glyphicon-remove incompleto'></span>";                    
                            respuesta[0]+="</button>";
                            
                            //respuesta[0]+="<span class='glyphicon glyphicon-remove incompleto' title='No cumple con la evidencia'></span>";
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
        /*
        if(horas>=120 && horas<=160){
            puntaje+=40;
        }else if(horas>=161 && horas<=199){
            puntaje+=50;
        }else if(horas>=200){
            puntaje+=60;
        }
        
        if(horasD>=120 && horasD<=160){
            puntajeD+=40;
        }else if(horasD>=161 && horasD<=199){
            puntajeD+=50;
        }else if(horasD>=200){
            puntajeD+=60;
        }
        */
        
        respuesta[1]=""+puntaje;
        respuesta[2]=""+puntajeD;
        return respuesta;
    }
    public String[] getFilasAportaciones(String idUsuario,boolean vistaAdmin, String idPermiso,String permisoActualEdicion){   
        String respuesta;
        String puntaje, puntajeD;
        String valido;
        String[] retorno={"","0","0"};
        String[] parametros={idUsuario};
        String permisoEdicion = permisoActualEdicion.equals("F") ? "disabled" : "";
        int validos=0;
        int validosD=0;
        puntaje="0";
        puntajeD="0";        
        List<String[]> datos=metodo.ejecutaSP("sp_consultaAportaciones_v2",parametros);
        if(datos.isEmpty()){
            respuesta="<tr><td colspan='6'>Sin información</td></tr>";
            puntaje="0";
            puntajeD="0";
        }else{
            respuesta="";
            for(String[] dato:datos){
                puntaje = dato[10];
                puntajeD = dato[11];                
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
                /*
                if(dato[9]!=null)
                {    
                    if(dato[9].equals("V"))
                    {validosD++;}
                }
                if(dato[8]!=null)
                {    
                    if(dato[8].equals("V"))
                    {validos++;}
                }
               */
                if (idPermiso.equals("6"))
                {
                    if(dato[8]==null){
                        respuesta+="<span class='glyphicon glyphicon-exclamation-sign incompleto' title='Sección incompleta'></span>";
                    }else if (dato[8].equals("V")){
                        respuesta+="<span class='glyphicon glyphicon-ok completo' title='Aprobado'></span>";
                    }else{
                        respuesta+="<span class='glyphicon glyphicon-remove incompleto' title='No cumple con la evidencia'></span>";
                    }
                    valido = dato[9];
                    respuesta+="</td><td>";
                }
                else
                {valido = dato[8];}
                if(vistaAdmin){
                    if(valido==null){
                        respuesta+="<button type='button' class='btn btn-sm " + permisoEdicion + "' title='Aprobar' onclick='aprobarAportacion("+dato[0]+")'>";
                        respuesta+="<span class='glyphicon glyphicon-ok completo'></span>";
                        respuesta+="</button>";
                        respuesta+="<button type='button' class='btn btn-sm " + permisoEdicion + "' title='No cumple con la evidencia' onclick='rechazarAportacion("+dato[0]+")'>";
                        respuesta+="<span class='glyphicon glyphicon-remove incompleto'></span>";                    
                        respuesta+="</button>";
                        respuesta+="<span class='glyphicon glyphicon-exclamation-sign incompleto' title='Sección incompleta'></span>";
                    }else{
                        respuesta+="<button id='aportacionAprueba" + dato[0] + "' name='aportacionAprueba" + dato[0] + "' type='button' class='btn btn-sm " + permisoEdicion + " hidden' title='Aprobar' onclick='aprobarAportacion("+dato[0]+")'>";
                        respuesta+="<span class='glyphicon glyphicon-ok completo'></span>";
                        respuesta+="</button>";
                        respuesta+="<button id='aportacionRechaza" + dato[0] + "' name='aportacionRechaza" + dato[0] + "' type='button' class='btn btn-sm " + permisoEdicion + " hidden' title='No cumple con la evidencia' onclick='rechazarAportacion("+dato[0]+")'>";
                        respuesta+="<span class='glyphicon glyphicon-remove incompleto'></span>";                    
                        respuesta+="</button>";
                        ////respuesta+="<span id='aportacionIncompleto" + dato[0] + "' name='aportacionIncompleto" + dato[0] + "' class='glyphicon glyphicon-exclamation-sign incompleto hidden' title='Sección incompleta'></span>";
                        
                        if(valido.equals("V")){
                             respuesta+="<button type='button' id='aportacionAprobado" + dato[0] + "' name='aportacionAprobado" + dato[0] + "' class='btn btn-sm  " + permisoEdicion + "' title='Aprobado/Editar' onclick='activarEditarAportacion(" + dato[0] + ")'>";
                             respuesta+="<span class='glyphicon glyphicon-ok completo'></span>";
                             respuesta+="</button>";                        
                            
                            //respuesta+="<span class='glyphicon glyphicon-ok completo' title='Aprobado'></span>";
                        }else{
                             respuesta+="<button type='button' id='aportacionRechazado" + dato[0] + "' name='aportacionRechazado" + dato[0] + "' class='btn btn-sm  " + permisoEdicion + "' title='No cumple con la evidencia/Editar' onclick='activarEditarAportacion(" + dato[0] + ")'>";
                             respuesta+="<span class='glyphicon glyphicon-remove incompleto'></span>";                    
                             respuesta+="</button>";
                            
                            //respuesta+="<span class='glyphicon glyphicon-remove incompleto' title='No cumple con la evidencia'></span>";
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
            /*
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
 
            switch(validosD){
                case 0:
                    puntajeD="0";
                    break;
                case 1:
                    puntajeD="30";
                    break;
                case 2:
                    puntajeD="55";
                    break;
                case 3:
                    puntajeD="80";
                    break;
                case 4:
                    puntajeD="105";
                    break;
                default:
                    puntajeD="130";
                    break;                
            }
            */
        }
        retorno[0]=respuesta;
        retorno[1]=puntaje;
        retorno[2]=puntajeD;
        return retorno;
    }
    public String[] getFilasParticipaciones(String idUsuario,boolean vistaAdmin, String idPermiso,String permisoActualEdicion){   
        String[] retorno={"","0","0"};
        String respuesta;
        String puntaje, valido, puntajeD;
        String[] parametros={idUsuario};
        String permisoEdicion = permisoActualEdicion.equals("F") ? "disabled" : "";
        List<String[]> datos=metodo.ejecutaSP("sp_consultaParticipaciones_v2",parametros);
        int validos=0;
        int validosD=0;
        puntaje="0";
        puntajeD="0"; 
        if(datos.isEmpty()){
            respuesta="<tr><td colspan='6'>Sin información</td></tr>";
            puntaje="0";
            puntajeD="0";
        }else{
            respuesta="";
            for(String[] dato:datos){
                puntaje = dato[10];
                puntajeD = dato[11];                 
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
                /*
                if(dato[9]!=null)
                {    
                    if(dato[9].equals("V"))
                    {validosD++;}
                }
                if(dato[8]!=null)
                {    
                    if(dato[8].equals("V"))
                    {validos++;}
                }
                */                 
                if (idPermiso.equals("6"))
                {
                    if(dato[8]==null){
                        respuesta+="<span class='glyphicon glyphicon-exclamation-sign incompleto' title='Sección incompleta'></span>";
                    }else if (dato[8].equals("V")){
                        respuesta+="<span class='glyphicon glyphicon-ok completo' title='Aprobado'></span>";
                    }else{
                        respuesta+="<span class='glyphicon glyphicon-remove incompleto' title='No cumple con la evidencia'></span>";
                    }                
                    valido = dato[9];
                    respuesta+="</td><td>";
                }
                else
                {valido = dato[8];}                
                if(vistaAdmin){
                    if(valido==null){
                        respuesta+="<button type='button' class='btn btn-sm " + permisoEdicion + "' title='Aprobar' onclick='aprobarParticipacion("+dato[0]+")'>";
                        respuesta+="<span class='glyphicon glyphicon-ok completo'></span>";
                        respuesta+="</button>";
                        respuesta+="<button type='button' class='btn btn-sm " + permisoEdicion + "' title='No cumple con la evidencia' onclick='rechazarParticipacion("+dato[0]+")'>";
                        respuesta+="<span class='glyphicon glyphicon-remove incompleto'></span>";                    
                        respuesta+="</button>";
                        respuesta+="<span class='glyphicon glyphicon-exclamation-sign incompleto' title='Sección incompleta'></span>";
                    }else{
                        respuesta+="<button id='participacionAprueba" + dato[0] + "' name='participacionAprueba" + dato[0] + "' type='button' class='btn btn-sm " + permisoEdicion + " hidden' title='Aprobar' onclick='aprobarParticipacion("+dato[0]+")'>";
                        respuesta+="<span class='glyphicon glyphicon-ok completo'></span>";
                        respuesta+="</button>";
                        respuesta+="<button id='participacionRechaza" + dato[0] + "' name='participacionRechaza" + dato[0] + "' type='button' class='btn btn-sm " + permisoEdicion + " hidden' title='No cumple con la evidencia' onclick='rechazarParticipacion("+dato[0]+")'>";
                        respuesta+="<span class='glyphicon glyphicon-remove incompleto'></span>";                    
                        respuesta+="</button>";
                        ////respuesta+="<span id='participacionIncompleto" + dato[0] + "' name='participacionIncompleto" + dato[0] + "' class='glyphicon glyphicon-exclamation-sign incompleto hidden' title='Sección incompleta'></span>";
                        
                        if(valido.equals("V")){
                             respuesta+="<button type='button' id='participacionAprobado" + dato[0] + "' name='participacionAprobado" + dato[0] + "' class='btn btn-sm  " + permisoEdicion + "' title='Aprobado/Editar' onclick='activarEditarParticipacion(" + dato[0] + ")'>";
                             respuesta+="<span class='glyphicon glyphicon-ok completo'></span>";
                             respuesta+="</button>";                               

                            //respuesta+="<span class='glyphicon glyphicon-ok completo' title='Aprobado'></span>";
                        }else{
                             respuesta+="<button type='button' id='participacionRechazado" + dato[0] + "' name='participacionRechazado" + dato[0] + "' class='btn btn-sm  " + permisoEdicion + "' title='No cumple con la evidencia/Editar' onclick='activarEditarParticipacion(" + dato[0] + ")'>";
                             respuesta+="<span class='glyphicon glyphicon-remove incompleto'></span>";                    
                             respuesta+="</button>";                            
                            
                            //respuesta+="<span class='glyphicon glyphicon-remove incompleto' title='No cumple con la evidencia'></span>";
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
            /*
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
            
            switch(validosD){
                case 0:
                    puntajeD="0";
                    break;
                case 1:
                    puntajeD="30";
                    break;
                case 2:
                    puntajeD="55";
                    break;
                case 3:
                    puntajeD="80";
                    break;
                case 4:
                    puntajeD="105";
                    break;
                default:
                    puntajeD="130";
                    break;                
            } 
            */
        }
        retorno[0]=respuesta;
        retorno[1]=puntaje;
        retorno[2]=puntajeD;
        return retorno;
    }
    public String[] getFilasTutorias(String idUsuario,boolean vistaAdmin, String idPermiso,String permisoActualEdicion){   
        String respuesta, valido;
        String[] retorno={"","0","0"};
        String puntaje="0", puntajeD="0";
        String[] parametros={idUsuario};
        String permisoEdicion = permisoActualEdicion.equals("F") ? "disabled" : "";
        List<String[]> datos=metodo.ejecutaSP("sp_selectTutorias_v2",parametros);
        int validos=0;
        int validosD=0;
        if(datos.isEmpty()){
            respuesta="<tr><td colspan='4'>Sin información</td></tr>";
            puntaje="0";
            puntajeD="0";
        }else{
            respuesta="";
            for(String[] dato:datos){
                puntaje = dato[7];
                puntajeD = dato[8];                
                respuesta+="<tr>";                  
                if(dato[2].equals(dato[3])){
                    respuesta+="<td>"+fecha.formatoImprimir(dato[2])+"</td>";                                
                }else{
                    respuesta+="<td>"+fecha.formatoImprimir(dato[2])+"-"+fecha.formatoImprimir(dato[3])+"</td>";
                }
                respuesta+="<td>"+dato[4]+"</td>";
                respuesta+="<td>";
                /*
                if(dato[6]!=null)
                {    
                    if(dato[6].equals("V"))
                    {validosD++;}
                }
                if(dato[5]!=null)
                {    
                    if(dato[5].equals("V"))                
                    {validos++;}
                }
                */                
                if (idPermiso.equals("6"))
                {
                    if(dato[5]==null){
                        respuesta+="<span class='glyphicon glyphicon-exclamation-sign incompleto' title='Sección incompleta'></span>";
                    }else if (dato[5].equals("V")){
                        respuesta+="<span class='glyphicon glyphicon-ok completo' title='Aprobado'></span>";
                    }else{
                        respuesta+="<span class='glyphicon glyphicon-remove incompleto' title='No cumple con la evidencia'></span>";
                    }                
                    valido = dato[6];
                    respuesta+="</td><td>";
                }
                else
                {valido = dato[5];}                 
                if(vistaAdmin){
                    if(valido==null){
                        respuesta+="<button type='button' class='btn btn-sm " + permisoEdicion + "' title='Aprobar' onclick='aprobarTutoria("+dato[0]+")'>";
                        respuesta+="<span class='glyphicon glyphicon-ok completo'></span>";
                        respuesta+="</button>";
                        respuesta+="<button type='button' class='btn btn-sm " + permisoEdicion + "' title='No cumple con la evidencia' onclick='rechazarTutoria("+dato[0]+")'>";
                        respuesta+="<span class='glyphicon glyphicon-remove incompleto'></span>";                    
                        respuesta+="</button>";
                        respuesta+="<span class='glyphicon glyphicon-exclamation-sign incompleto' title='Sección incompleta'></span>";
                    }else{
                        respuesta+="<button id='tutoriaAprueba" + dato[0] + "' name='tutoriaAprueba" + dato[0] + "' type='button' class='btn btn-sm " + permisoEdicion + " hidden' title='Aprobar' onclick='aprobarTutoria("+dato[0]+")'>";
                        respuesta+="<span class='glyphicon glyphicon-ok completo'></span>";
                        respuesta+="</button>";
                        respuesta+="<button id='tutoriaRechaza" + dato[0] + "' name='tutoriaRechaza" + dato[0] + "' type='button' class='btn btn-sm " + permisoEdicion + " hidden' title='No cumple con la evidencia' onclick='rechazarTutoria("+dato[0]+")'>";
                        respuesta+="<span class='glyphicon glyphicon-remove incompleto'></span>";                    
                        respuesta+="</button>";
                        ////respuesta+="<span id='tutoriaIncompleto" + dato[0] + "' name='tutoriaIncompleto" + dato[0] + "' class='glyphicon glyphicon-exclamation-sign incompleto hidden' title='Sección incompleta'></span>";
                       
                        if(valido.equals("V")){
                             respuesta+="<button type='button' id='tutoriaAprobado" + dato[0] + "' name='tutoriaAprobado" + dato[0] + "' class='btn btn-sm  " + permisoEdicion + "' title='Aprobado/Editar' onclick='activarEditarTutoria(" + dato[0] + ")'>";
                             respuesta+="<span class='glyphicon glyphicon-ok completo'></span>";
                             respuesta+="</button>";                               
                            
                            //respuesta+="<span class='glyphicon glyphicon-ok completo' title='Aprobado'></span>";
                        }else{
                             respuesta+="<button type='button' id='tutoriaRechazado" + dato[0] + "' name='tutoriaRechazado" + dato[0] + "' class='btn btn-sm  " + permisoEdicion + "' title='No cumple con la evidencia/Editar' onclick='activarEditarTutoria(" + dato[0] + ")'>";
                             respuesta+="<span class='glyphicon glyphicon-remove incompleto'></span>";                    
                             respuesta+="</button>";                            
                            
                            //respuesta+="<span class='glyphicon glyphicon-remove incompleto' title='No cumple con la evidencia'></span>";
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
            /*
            if(validos==0){
                puntaje="0";
            }if(validos==1){
                puntaje="35";
            }else if(validos>1){
                puntaje="70";
            }
            
            if(validosD==0){
                puntajeD="0";
            }if(validosD==1){
                puntajeD="35";
            }else if(validosD>1){
                puntajeD="70";
            }
            */
        }
        retorno[0]=respuesta;
        retorno[1]=puntaje;
        retorno[2]=puntajeD;
        return retorno;
    }
    public String[] getFilasPublicaciones(String idUsuario,boolean vistaAdmin, String idPermiso,String permisoActualEdicion){   
        String respuesta, valido;
        String puntaje="0", puntajeD="0";
        String[] retorno={"","0","0"};
        String[] parametros={idUsuario};
        int validos=0;
        int validosD=0;
        String permisoEdicion = permisoActualEdicion.equals("F") ? "disabled" : "";
        List<String[]> datos=metodo.ejecutaSP("sp_selectPublicaciones_v2",parametros);
        if(datos.isEmpty()){
            respuesta="<tr><td colspan='6'>Sin información</td></tr>";
            puntaje="0";
            puntajeD="0";
        }else{
            respuesta="";
            for(String[] dato:datos){
                puntaje = dato[8];
                puntajeD = dato[9];                
                respuesta+="<tr>"; 
                respuesta+="<td>"+dato[2]+"</td>";
                respuesta+="<td>"+dato[3]+"</td>";
                respuesta+="<td>"+fecha.formatoImprimir(dato[4])+"</td>"; 
                respuesta+="<td>"+dato[5]+"</td>";
                respuesta+="<td>";
                /*
                if(dato[7]!=null)
                {    
                    if(dato[7].equals("V"))
                    {validosD++;}
                }
                if(dato[6]!=null)
                {    
                    if(dato[6].equals("V"))
                    {validos++;} 
                }
                */                
                if (idPermiso.equals("6"))
                {
                    if(dato[6]==null){
                        respuesta+="<span class='glyphicon glyphicon-exclamation-sign incompleto' title='Sección incompleta'></span>";
                    }else if (dato[6].equals("V")){
                        respuesta+="<span class='glyphicon glyphicon-ok completo' title='Aprobado'></span>";
                    }else{
                        respuesta+="<span class='glyphicon glyphicon-remove incompleto' title='No cumple con la evidencia'></span>";
                    }                
                    valido = dato[7];
                    respuesta+="</td><td>";                
                }
                else
                {valido = dato[6];}                  
                if(vistaAdmin){
                    if(valido==null){
                        respuesta+="<button type='button' class='btn btn-sm " + permisoEdicion + "' title='Aprobar' onclick='aprobarPublicacion("+dato[0]+")'>";
                        respuesta+="<span class='glyphicon glyphicon-ok completo'></span>";
                        respuesta+="</button>";
                        respuesta+="<button type='button' class='btn btn-sm " + permisoEdicion + "' title='No cumple con la evidencia' onclick='rechazarPublicacion("+dato[0]+")'>";
                        respuesta+="<span class='glyphicon glyphicon-remove incompleto'></span>";                    
                        respuesta+="</button>";
                        respuesta+="<span class='glyphicon glyphicon-exclamation-sign incompleto' title='Sección incompleta'></span>";
                    }else{
                        respuesta+="<button id='publicacionAprueba" + dato[0] + "' name='publicacionAprueba" + dato[0] + "' type='button' class='btn btn-sm " + permisoEdicion + " hidden' title='Aprobar' onclick='aprobarPublicacion("+dato[0]+")'>";
                        respuesta+="<span class='glyphicon glyphicon-ok completo'></span>";
                        respuesta+="</button>";
                        respuesta+="<button id='publicacionRechaza" + dato[0] + "' name='publicacionRechaza" + dato[0] + "' type='button' class='btn btn-sm " + permisoEdicion + " hidden' title='No cumple con la evidencia' onclick='rechazarPublicacion("+dato[0]+")'>";
                        respuesta+="<span class='glyphicon glyphicon-remove incompleto'></span>";                    
                        respuesta+="</button>";
                        ////respuesta+="<span id='publicacionIncompleto" + dato[0] + "' name='publicacionIncompleto" + dato[0] + "' class='glyphicon glyphicon-exclamation-sign incompleto hidden' title='Sección incompleta'></span>";
                        
                        if(valido.equals("V")){
                            respuesta+="<button type='button' id='publicacionAprobado" + dato[0] + "' name='publicacionAprobado" + dato[0] + "' class='btn btn-sm  " + permisoEdicion + "' title='Aprobado/Editar' onclick='activarEditarPublicacion(" + dato[0] + ")'>";
                            respuesta+="<span class='glyphicon glyphicon-ok completo'></span>";
                            respuesta+="</button>";                               
                            
                            //respuesta+="<span class='glyphicon glyphicon-ok completo' title='Aprobado'></span>";
                        }else{
                            respuesta+="<button type='button' id='publicacionRechazado" + dato[0] + "' name='publicacionRechazado" + dato[0] + "' class='btn btn-sm  " + permisoEdicion + "' title='No cumple con la evidencia/Editar' onclick='activarEditarPublicacion(" + dato[0] + ")'>";
                            respuesta+="<span class='glyphicon glyphicon-remove incompleto'></span>";                    
                            respuesta+="</button>";                            
                            
                            //respuesta+="<span class='glyphicon glyphicon-remove incompleto' title='No cumple con la evidencia'></span>";
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
            /*
            if(validos==0){
                puntaje="0";
            }else if(validos==1){
                puntaje="25";
            }else if(validos>1){
                puntaje="50";
            }
            
            if(validosD==0){
                puntajeD="0";
            }else if(validosD==1){
                puntajeD="25";
            }else if(validosD>1){
                puntajeD="50";
            }
            */
        }
        retorno[0]=respuesta;
        retorno[1]=puntaje;
        retorno[2]=puntajeD;
        return retorno;
    }
    public String[] getFilasResultados(String idUsuario,boolean vistaAdmin, String idPermiso,String permisoActualEdicion){   
        String respuesta, valido;
        String puntaje="0", puntajeD="0";
        String[] retorno=new String[3];
        String[] parametros={idUsuario};
        String permisoEdicion = permisoActualEdicion.equals("F") ? "disabled" : "";
        int validos=0;
        int validosD=0;
        List<String[]> datos=metodo.ejecutaSP("sp_consultaResultados_v2",parametros);
        if(datos.isEmpty()){
            respuesta="<tr><td colspan='5'>Sin información</td></tr>";
            puntaje="0";
            puntajeD="0";
        }else{
            respuesta="";
            for(String[] dato:datos){
                puntaje = dato[9];
                puntajeD = dato[10];                
                respuesta+="<tr>"; 
                respuesta+="<td>"+dato[3]+"</td>";
                if(dato[4].equals(dato[5])){
                    respuesta+="<td>"+fecha.formatoImprimir(dato[4])+"</td>";                                
                }else{
                    respuesta+="<td>"+fecha.formatoImprimir(dato[4])+"-"+fecha.formatoImprimir(dato[5])+"</td>";
                }
                respuesta+="<td>"+dato[6]+"</td>";
                respuesta+="<td>";
                /*
                if(dato[8]!=null)
                {    
                    if(dato[8].equals("V"))
                    {validosD++;}
                }
                if(dato[7]!=null)
                {    
                    if(dato[7].equals("V"))
                    {validos++;}
                }
                */
                if (idPermiso.equals("6"))
                {
                    if(dato[7]==null){
                        respuesta+="<span class='glyphicon glyphicon-exclamation-sign incompleto' title='Sección incompleta'></span>";
                    }else if (dato[7].equals("V")){
                        respuesta+="<span class='glyphicon glyphicon-ok completo' title='Aprobado'></span>";
                    }else{
                        respuesta+="<span class='glyphicon glyphicon-remove incompleto' title='No cumple con la evidencia'></span>";
                    }                
                    valido = dato[8];
                    respuesta+="</td><td>";                    
                }
                else
                {valido = dato[7];}                 
                if(vistaAdmin){
                    if(valido==null){
                        respuesta+="<button type='button' class='btn btn-sm " + permisoEdicion + "' title='Aprobar' onclick='aprobarResultado("+dato[0]+")'>";
                        respuesta+="<span class='glyphicon glyphicon-ok completo'></span>";
                        respuesta+="</button>";
                        respuesta+="<button type='button' class='btn btn-sm " + permisoEdicion + "' title='No cumple con la evidencia' onclick='rechazarResultado("+dato[0]+")'>";
                        respuesta+="<span class='glyphicon glyphicon-remove incompleto'></span>";                    
                        respuesta+="</button>";
                        respuesta+="<span class='glyphicon glyphicon-exclamation-sign incompleto' title='Sección incompleta'></span>";
                    }else{
                        respuesta+="<button id='resultadoAprueba" + dato[0] + "' name='resultadoAprueba" + dato[0] + "' type='button' class='btn btn-sm " + permisoEdicion + " hidden' title='Aprobar' onclick='aprobarResultado("+dato[0]+")'>";
                        respuesta+="<span class='glyphicon glyphicon-ok completo'></span>";
                        respuesta+="</button>";
                        respuesta+="<button id='resultadoRechaza" + dato[0] + "' name='resultadoRechaza" + dato[0] + "' type='button' class='btn btn-sm " + permisoEdicion + " hidden' title='No cumple con la evidencia' onclick='rechazarResultado("+dato[0]+")'>";
                        respuesta+="<span class='glyphicon glyphicon-remove incompleto'></span>";                    
                        respuesta+="</button>";
                        ////respuesta+="<span id='resultadoIncompleto" + dato[0] + "' name='resultadoIncompleto" + dato[0] + "' class='glyphicon glyphicon-exclamation-sign incompleto hidden' title='Sección incompleta'></span>";
                        
                        if(valido.equals("V")){
                            respuesta+="<button type='button' id='resultadoAprobado" + dato[0] + "' name='resultadoAprobado" + dato[0] + "' class='btn btn-sm  " + permisoEdicion + "' title='Aprobado/Editar' onclick='activarEditarResultado(" + dato[0] + ")'>";
                            respuesta+="<span class='glyphicon glyphicon-ok completo'></span>";
                            respuesta+="</button>";                               
                            
                            //respuesta+="<span class='glyphicon glyphicon-ok completo' title='Aprobado'></span>";
                        }else{
                            respuesta+="<button type='button' id='resultadoRechazado" + dato[0] + "' name='resultadoRechazado" + dato[0] + "' class='btn btn-sm  " + permisoEdicion + "' title='No cumple con la evidencia/Editar' onclick='activarEditarResultado(" + dato[0] + ")'>";
                            respuesta+="<span class='glyphicon glyphicon-remove incompleto'></span>";                    
                            respuesta+="</button>";                            
                            
                            //respuesta+="<span class='glyphicon glyphicon-remove incompleto' title='No cumple con la evidencia'></span>";
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
            /*
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
            
            aux=validosD;
            if(aux==1 || aux==2){
                puntajeD="30";
            }else if(aux==3 || aux==4){
                puntajeD="55";
            }else if(aux==5 || aux==6){
                puntajeD="80";
            }else if(aux==7 || aux==8){
                puntajeD="105";
            }else if(aux==9 || aux==10){
                puntajeD="130";
            }else if(aux>10){
                puntajeD="150";
            }
            */
        }
        retorno[0]=respuesta;
        retorno[1]=puntaje;
        retorno[2]=puntajeD;
        return retorno;
    }
    public String[] getFilasResultados2(String idUsuario,boolean vistaAdmin, String idPermiso){   
        String respuesta, valido;
        String puntaje="0", puntajeD="0";
        String[] retorno=new String[3];
        String[] parametros={idUsuario};
        int validos=0;
        int validosD=0;
        List<String[]> datos=metodo.ejecutaSP("sp_consultaResultados_v2",parametros);
        if(datos.isEmpty()){
            puntaje="0";
            puntajeD="0";
        }else{
            respuesta="";
            for(String[] dato:datos){
                puntaje = dato[9];
                puntajeD = dato[10];   
                /*
                if(dato[8]!=null)
                {    
                    if(dato[8].equals("V"))
                    {validosD++;}
                }
                if(dato[7]!=null)
                {    
                    if(dato[7].equals("V"))
                    {validos++;}
                }
                */
            }
            /*
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
            
            aux=validosD;
            if(aux==1 || aux==2){
                puntajeD="30";
            }else if(aux==3 || aux==4){
                puntajeD="55";
            }else if(aux==5 || aux==6){
                puntajeD="80";
            }else if(aux==7 || aux==8){
                puntajeD="105";
            }else if(aux==9 || aux==10){
                puntajeD="130";
            }else if(aux>10){
                puntajeD="150";
            }
            */
        }
        retorno[0]="";
        retorno[1]=puntaje;
        retorno[2]=puntajeD;
        return retorno;
    }
    public String[][] consultaPuntajes(String idUsuario){
        String[][] respuesta;
        int c,d;
        /*for(c=0;c<15;c++){
            for(d=0;d<7;d++){
                respuesta[c][d]="";
            }
            respuesta[c][4]="0";
        }*/
        String[] parametros={idUsuario};
        List<String[]> datos=metodo.ejecutaSP("sp_consultaConstanciasProceso_v2",parametros);
        
        if(datos.size() == 12)
        {
            respuesta=new String[12][8];
            d=16;
        }
        else
        {
            respuesta=new String[15][8];
            d=1;
        }
                 
        if(!datos.isEmpty()){             
            for(String[] dato:datos){
                c=Integer.parseInt(dato[2]);
                respuesta[c-d]=dato;
            }            
        }        
        return respuesta;
    }
    public String[][] consultaPuntajesDictaminador(String idUsuario){
        String[][] respuesta;
        int c,d;

        String[] parametros={idUsuario};
        List<String[]> datos=metodo.ejecutaSP("sp_consultaConstanciasProcesoDictaminador_v2",parametros);
        
        if(datos.size() == 12)
        {
            respuesta=new String[12][8];
            d=16;
        }
        else
        {
            respuesta=new String[15][8];
            d=1;
        }
        
        if(!datos.isEmpty()){             
            for(String[] dato:datos){
                c=Integer.parseInt(dato[2]);
                respuesta[c-d]=dato;
            }            
        }        
        return respuesta;
    }
    public String[] consultaPuntajeEncuestas(String rfc, String idPeriodo){
        String[] respuesta={"","","0","0","0","0"};
        String[] parametros={rfc, idPeriodo};
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
    public String getFilasResultadosConstancias(String idUsuario){   
        String respuesta;
        
        String[] parametros={idUsuario};
        List<String[]> datos=metodo.ejecutaSP("sp_consultaEvidenciasDocente",parametros);
        if(datos.isEmpty()){
            respuesta="<tr><td class='borde' colspan='3'>Sin información</td></tr>";
            
        }else{
            respuesta="";
            List<String> arrC = new ArrayList<String>();
            for(String[] dato:datos){
                arrC.add(dato[0]);
            }
            
            if(arrC.contains("2")){
                    respuesta+="<tr>"; 
                    respuesta+="<td class='borde'>Criterio 1</td>";
                    respuesta+="<td class='borde'>Constancia de antiguedad</td>";
                    respuesta+="<td class='borde'>Si</td>";
                    respuesta+="</tr>";
            }else{
                    respuesta+="<tr>"; 
                    respuesta+="<td class='borde'>Criterio 1</td>";
                    respuesta+="<td class='borde'>Constancia de antiguedad</td>";
                    respuesta+="<td class='borde'>No</td>";
                    respuesta+="</tr>";
            }
            
            if(arrC.contains("10")){
                    respuesta+="<tr>"; 
                    respuesta+="<td class='borde'>Criterio 2</td>";
                    respuesta+="<td class='borde'>Constancia de experiencia</td>";
                    respuesta+="<td class='borde'>Si</td>";
                    respuesta+="</tr>";
                    respuesta+="<tr>"; 
                    respuesta+="<td class='borde'>Criterio 3</td>";
                    respuesta+="<td class='borde'>No aplica</td>";
                    respuesta+="<td class='borde'>No aplica</td>";
                    respuesta+="</tr>";
            }else{
                    respuesta+="<tr>"; 
                    respuesta+="<td class='borde'>Criterio 2</td>";
                    respuesta+="<td class='borde'>Constancia de experiencia</td>";
                    respuesta+="<td class='borde'>No</td>";
                    respuesta+="</tr>";
                    respuesta+="<tr>"; 
                    respuesta+="<td class='borde'>Criterio 3</td>";
                    respuesta+="<td class='borde'>No aplica</td>";
                    respuesta+="<td class='borde'>No aplica</td>";
                    respuesta+="</tr>";
            }
            
            if(arrC.contains("1")){
                    respuesta+="<tr>"; 
                    respuesta+="<td class='borde'>Criterio 4</td>";
                    respuesta+="<td class='borde'>Constancia de Máximo grado académico</td>";
                    respuesta+="<td class='borde'>Si</td>";
                    respuesta+="</tr>";
            }else{
                    respuesta+="<tr>"; 
                    respuesta+="<td class='borde'>Criterio 4</td>";
                    respuesta+="<td class='borde'>Constancia de Máximo grado académico</td>";
                    respuesta+="<td class='borde'>No</td>";
                    respuesta+="</tr>";
            }
            
            if(arrC.contains("13")){
                    respuesta+="<tr>"; 
                    respuesta+="<td class='borde'>Criterio 5</td>";
                    respuesta+="<td class='borde'>Carga de evidencia documental</td>";
                    respuesta+="<td class='borde'>Si</td>";
                    respuesta+="</tr>";
            }else{
                    respuesta+="<tr>"; 
                    respuesta+="<td class='borde'>Criterio 5</td>";
                    respuesta+="<td class='borde'>Carga de evidencia documental</td>";
                    respuesta+="<td class='borde'>No</td>";
                    respuesta+="</tr>";
            }
            
            if(arrC.contains("14")){
                    respuesta+="<tr>"; 
                    respuesta+="<td class='borde'>Criterio 6</td>";
                    respuesta+="<td class='borde'>Carga de evidencia documental</td>";
                    respuesta+="<td class='borde'>Si</td>";
                    respuesta+="</tr>";
            }else{
                    respuesta+="<tr>"; 
                    respuesta+="<td class='borde'>Criterio 6</td>";
                    respuesta+="<td class='borde'>Carga de evidencia documental</td>";
                    respuesta+="<td class='borde'>No</td>";
                    respuesta+="</tr>";
            }
            
            if(arrC.contains("15")){
                    respuesta+="<tr>"; 
                    respuesta+="<td class='borde'>Criterio 7</td>";
                    respuesta+="<td class='borde'>Carga de evidencia documental</td>";
                    respuesta+="<td class='borde'>Si</td>";
                    respuesta+="</tr>";
            }else{
                    respuesta+="<tr>"; 
                    respuesta+="<td class='borde'>Criterio 7</td>";
                    respuesta+="<td class='borde'>Carga de evidencia documental</td>";
                    respuesta+="<td class='borde'>No</td>";
                    respuesta+="</tr>";
            }
            
            if(arrC.contains("16")){
                    respuesta+="<tr>"; 
                    respuesta+="<td class='borde'>Criterio 8</td>";
                    respuesta+="<td class='borde'>Carga de evidencia documental</td>";
                    respuesta+="<td class='borde'>Si</td>";
                    respuesta+="</tr>";
            }else{
                    respuesta+="<tr>"; 
                    respuesta+="<td class='borde'>Criterio 8</td>";
                    respuesta+="<td class='borde'>Carga de evidencia documental</td>";
                    respuesta+="<td class='borde'>No</td>";
                    respuesta+="</tr>";
            }
            
            if(arrC.contains("17")){
                    respuesta+="<tr>"; 
                    respuesta+="<td class='borde'>Criterio 9</td>";
                    respuesta+="<td class='borde'>Carga de evidencia documental</td>";
                    respuesta+="<td class='borde'>Si</td>";
                    respuesta+="</tr>";
            }else{
                    respuesta+="<tr>"; 
                    respuesta+="<td class='borde'>Criterio 9</td>";
                    respuesta+="<td class='borde'>Carga de evidencia documental</td>";
                    respuesta+="<td class='borde'>No</td>";
                    respuesta+="</tr>";
            }
            
            if(arrC.contains("18")){
                    respuesta+="<tr>"; 
                    respuesta+="<td class='borde'>Criterio 10</td>";
                    respuesta+="<td class='borde'>Carga de evidencia documental</td>";
                    respuesta+="<td class='borde'>Si</td>";
                    respuesta+="</tr>";
            }else{
                    respuesta+="<tr>"; 
                    respuesta+="<td class='borde'>Criterio 10</td>";
                    respuesta+="<td class='borde'>Carga de evidencia documental</td>";
                    respuesta+="<td class='borde'>No</td>";
                    respuesta+="</tr>";
            }
        }
        return respuesta;
    }
    public String getFilasResultadosRegistro(String idUsuario){   
        String respuesta;
        
        String[] parametros={idUsuario};
        List<String[]> datos=metodo.ejecutaSP("sp_consultaEvidenciasDocente",parametros);
        if(datos.isEmpty()){
            respuesta="<tr><td class='borde' colspan='3'>Sin información</td></tr>";
            
        }else{
            respuesta="";
            List<String> arr = new ArrayList<String>();
            for(String[] dato:datos){
                arr.add(dato[0]);
            }
            
            if(arr.contains("1")){
                    respuesta+="<tr>"; 
                    respuesta+="<td class='borde'>Informaciòn Acadèmica</td>";
                    respuesta+="<td class='borde'>Documento comprobatorio</td>";
                    respuesta+="<td class='borde'>Si</td>";
                    respuesta+="</tr>";
            }else{
                    respuesta+="<tr>"; 
                    respuesta+="<td class='borde'>Informaciòn Acadèmica</td>";
                    respuesta+="<td class='borde'>Documento comprobatorio</td>";
                    respuesta+="<td class='borde'>No</td>";
                    respuesta+="</tr>";
            }
            
            if(arr.contains("2")){
                    respuesta+="<tr>"; 
                    respuesta+="<td class='borde'>Informaciòn Laboral</td>";
                    respuesta+="<td class='borde'>Constancia de antiguedad</td>";
                    respuesta+="<td class='borde'>Si</td>";
                    respuesta+="</tr>";
                    respuesta+="<tr>";
            }else{
                    respuesta+="<tr>"; 
                    respuesta+="<td class='borde'>Informaciòn Laboral</td>";
                    respuesta+="<td class='borde'>Constancia de antiguedad</td>";
                    respuesta+="<td class='borde'>No</td>";
                    respuesta+="</tr>";
                    respuesta+="<tr>";
            }
            
            if(arr.contains("3")){
                    respuesta+="<tr>"; 
                    respuesta+="<td class='borde'>Informaciòn Laboral</td>";
                    respuesta+="<td class='borde'>Constancia de nombramiento definitivo</td>";
                    respuesta+="<td class='borde'>Si</td>";
                    respuesta+="</tr>";
            }else{
                    respuesta+="<tr>"; 
                    respuesta+="<td class='borde'>Informaciòn Laboral</td>";
                    respuesta+="<td class='borde'>Constancia de nombramiento definitivo</td>";
                    respuesta+="<td class='borde'>No</td>";
                    respuesta+="</tr>";
            }
            
            if(arr.contains("6")){
                    respuesta+="<tr>"; 
                    respuesta+="<td class='borde'>Informaciòn Laboral</td>";
                    respuesta+="<td class='borde'>Constancia de nota favorable</td>";
                    respuesta+="<td class='borde'>Si</td>";
                    respuesta+="</tr>";
            }else{
                    respuesta+="<tr>"; 
                    respuesta+="<td class='borde'>Informaciòn Laboral</td>";
                    respuesta+="<td class='borde'>Constancia de nota favorable</td>";
                    respuesta+="<td class='borde'>No</td>";
                    respuesta+="</tr>";
            }
            
            if(arr.contains("4")){
                    respuesta+="<tr>"; 
                    respuesta+="<td class='borde'>Horas frente a grupo</td>";
                    respuesta+="<td class='borde'>Constancia de horas frente a grupo</td>";
                    respuesta+="<td class='borde'>Si</td>";
                    respuesta+="</tr>";
            }else{
                    respuesta+="<tr>"; 
                    respuesta+="<td class='borde'>Horas frente a grupo</td>";
                    respuesta+="<td class='borde'>Constancia de horas frente a grupo</td>";
                    respuesta+="<td class='borde'>No</td>";
                    respuesta+="</tr>";
            }
            
            if(arr.contains("7")){
                    respuesta+="<tr>"; 
                    respuesta+="<td class='borde'>Compatibilidad - Carta protesta</td>";
                    respuesta+="<td class='borde'>Archivo de evidencia</td>";
                    respuesta+="<td class='borde'>Si</td>";
                    respuesta+="</tr>";
            }else{
                    respuesta+="<tr>"; 
                    respuesta+="<td class='borde'>Compatibilidad - Carta protesta</td>";
                    respuesta+="<td class='borde'>Archivo de evidencia</td>";
                    respuesta+="<td class='borde'>No</td>";
                    respuesta+="</tr>";
            }
        }
        return respuesta;
    }
    public String setPuntajeEncuestas(String idUsuario, String puntaje){
        
        String respuesta = "";
        
        String[] parametros= {idUsuario, puntaje};
        List<String[]> datos=metodo.ejecutaSP("sp_insertReconocimientoDesempeno",parametros);
        if(datos.isEmpty()){
            respuesta="";
        }else{
            for(String[] dato:datos){
                respuesta = dato[0];
            }
        }
        
        return respuesta;
    }    
	
}
