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
    public String getFilasCursos(String idUsuario){   
        String respuesta;
        String[] parametros={idUsuario};
        List<String[]> datos=metodo.ejecutaSP("sp_selectCursos",parametros);
        if(datos.isEmpty()){
            respuesta="<tr><td colspan='6'>Sin información</td></tr>";
        }else{
            respuesta="";
            for(String[] dato:datos){
                respuesta+="<tr>";
                respuesta+="<td>"+dato[2]+"</td>";  
                respuesta+="<td>"+dato[3]+"</td>";  
                if(dato[4].equals(dato[5])){
                    respuesta+="<td>"+fecha.formatoImprimir(dato[4])+"</td>";                                
                }else{
                    respuesta+="<td>"+fecha.formatoImprimir(dato[4])+"-"+fecha.formatoImprimir(dato[5])+"</td>";
                }
                respuesta+="<td>"+dato[6]+"</td>";
                respuesta+="<td>"+dato[7]+"</td>";
                respuesta+="<td>";
                respuesta+="<button type='button' class='btn btn-sm' title='Borrar' onclick='confirmarCurso("+dato[0]+")'>";
                respuesta+="<span class='glyphicon glyphicon-trash'></span>";
                respuesta+="</button>";
                respuesta+="</td>";
                respuesta+="</tr>";
            }            
        }
        return respuesta;
    }
    public String getFilasAportaciones(String idUsuario){   
        String respuesta;
        String[] parametros={idUsuario};
        List<String[]> datos=metodo.ejecutaSP("sp_consultaAportaciones",parametros);
        if(datos.isEmpty()){
            respuesta="<tr><td colspan='4'>Sin información</td></tr>";
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
                respuesta+="<button type='button' class='btn btn-sm' title='Borrar' onclick='confirmarAportacion("+dato[0]+")'>";
                respuesta+="<span class='glyphicon glyphicon-trash'></span>";
                respuesta+="</button>";
                respuesta+="</td>";
                respuesta+="</tr>";
            }            
        }
        return respuesta;
    }
    public String getFilasParticipaciones(String idUsuario){   
        String respuesta;
        String[] parametros={idUsuario};
        List<String[]> datos=metodo.ejecutaSP("sp_consultaParticipaciones",parametros);
        if(datos.isEmpty()){
            respuesta="<tr><td colspan='4'>Sin información</td></tr>";
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
                respuesta+="<button type='button' class='btn btn-sm' title='Borrar' onclick='confirmarParticipacion("+dato[0]+")'>";
                respuesta+="<span class='glyphicon glyphicon-trash'></span>";
                respuesta+="</button>";
                respuesta+="</td>";
                respuesta+="</tr>";
            }            
        }
        return respuesta;
    }
    public String getFilasTutorias(String idUsuario){   
        String respuesta;
        String[] parametros={idUsuario};
        List<String[]> datos=metodo.ejecutaSP("sp_selectTutorias",parametros);
        if(datos.isEmpty()){
            respuesta="<tr><td colspan='2'>Sin información</td></tr>";
        }else{
            respuesta="";
            for(String[] dato:datos){
                respuesta+="<tr>";                  
                if(dato[2].equals(dato[3])){
                    respuesta+="<td>"+fecha.formatoImprimir(dato[2])+"</td>";                                
                }else{
                    respuesta+="<td>"+fecha.formatoImprimir(dato[2])+"-"+fecha.formatoImprimir(dato[3])+"</td>";
                }
                respuesta+="<td>";
                respuesta+="<button type='button' class='btn btn-sm' title='Borrar' onclick='confirmarTutoria("+dato[0]+")'>";
                respuesta+="<span class='glyphicon glyphicon-trash'></span>";
                respuesta+="</button>";
                respuesta+="</td>";
                respuesta+="</tr>";
            }            
        }
        return respuesta;
    }
    public String getFilasPublicaciones(String idUsuario){   
        String respuesta;
        String[] parametros={idUsuario};
        List<String[]> datos=metodo.ejecutaSP("sp_selectPublicaciones",parametros);
        if(datos.isEmpty()){
            respuesta="<tr><td colspan='5'>Sin información</td></tr>";
        }else{
            respuesta="";
            for(String[] dato:datos){
                respuesta+="<tr>"; 
                respuesta+="<td>"+dato[2]+"</td>";
                respuesta+="<td>"+dato[3]+"</td>";
                respuesta+="<td>"+fecha.formatoImprimir(dato[4])+"</td>"; 
                respuesta+="<td>"+dato[5]+"</td>";
                respuesta+="<td>";
                respuesta+="<button type='button' class='btn btn-sm' title='Borrar' onclick='confirmarPublicacion("+dato[0]+")'>";
                respuesta+="<span class='glyphicon glyphicon-trash'></span>";
                respuesta+="</button>";
                respuesta+="</td>";
                respuesta+="</tr>";
            }            
        }
        return respuesta;
    }
    public String getFilasResultados(String idUsuario){   
        String respuesta;
        String[] parametros={idUsuario};
        List<String[]> datos=metodo.ejecutaSP("sp_selectResultados",parametros);
        if(datos.isEmpty()){
            respuesta="<tr><td colspan='2'>Sin información</td></tr>";
        }else{
            respuesta="";
            for(String[] dato:datos){
                respuesta+="<tr>";                  
                if(dato[2].equals(dato[3])){
                    respuesta+="<td>"+fecha.formatoImprimir(dato[2])+"</td>";                                
                }else{
                    respuesta+="<td>"+fecha.formatoImprimir(dato[2])+"-"+fecha.formatoImprimir(dato[3])+"</td>";
                }
                respuesta+="<td>";
                respuesta+="<button type='button' class='btn btn-sm' title='Borrar' onclick='confirmarResultado("+dato[0]+")'>";
                respuesta+="<span class='glyphicon glyphicon-trash'></span>";
                respuesta+="</button>";
                respuesta+="</td>";
                respuesta+="</tr>";
            }            
        }
        return respuesta;
    }
}
