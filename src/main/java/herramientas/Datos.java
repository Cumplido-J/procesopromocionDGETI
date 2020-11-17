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
public class Datos {
    Metodos_sql metodos;

    public Datos() {
        metodos = new Metodos_sql();
    }
    public  String desplegarUsuarios(String idPrograma,String idSubsistema,String idEntidad,String idPlantel,String usuario){        
        String respuesta="<tr><td colspan='7' class='text-center'>Sin información</td></tr>";        
        try{
            String[] parametros={idPrograma,idSubsistema,idEntidad,idPlantel,usuario};
            List<String[]> datos=metodos.ejecutaSP("sp_consultaUsuarios",parametros);
            if(!datos.isEmpty()){
                respuesta="";
                for(String[] dato:datos)
                {
                    respuesta+="<tr><td>"+dato[2]+"</td><td>"+dato[4]+"</td><td>"+dato[6]+"</td><td>"+dato[8]+"</td><td>"+dato[9]+"</td><td>"+dato[10]+"</td><td>"; 
                    respuesta+="<form method='POST' action='AltaUsuario'><input type='hidden' name='idUsuario' value='"+dato[0]+"'><input class='btn btn-sm btn-link' type='submit' value='Editar'/></form>";                                                                                  
                    respuesta+="</td></tr>";
                }
            }
        }catch(Exception e){
            respuesta=e.toString();
        }finally{
            return respuesta;        
        }
    }
    public  String desplegarConvocatorias(String idPrograma,String idSubsistema,String idEntidad,String idPlantel,String estatus){        
        String respuesta="<tr><td colspan='6' class='text-center'>Sin información</td></tr>";        
        try{
            String[] parametros={idPrograma,idSubsistema,idEntidad,idPlantel,estatus};
            List<String[]> datos=metodos.ejecutaSP("sp_consultaConvocatorias",parametros);
            if(!datos.isEmpty()){
                respuesta="";
                for(String[] dato:datos)
                {
                    respuesta+="<tr><td>"+dato[2]+"</td><td>"+dato[4]+"</td><td>"+dato[6]+"</td><td>"+dato[8]+"</td><td>"+dato[9]+"</td><td>"; 
                    respuesta+="<form method='POST' action='AltaConvocatoria'><input type='hidden' name='idConvocatoria' value='"+dato[0]+"'><input class='btn btn-sm btn-link' type='submit' value='Editar'/></form>";                                                                                  
                    respuesta+="</td></tr>";
                }
            }
        }catch(Exception e){
            respuesta=e.toString();
        }finally{
            return respuesta;        
        }
    }
    public  String desplegarVacancias(String idPrograma,String idSubsistema,String idEntidad,String idPlantel,String tipoCategoria){        
        String respuesta="<tr><td colspan='6' class='text-center'>Sin información</td></tr>"; 
        String aux="";
        try{
            String[] parametros={idPrograma,idSubsistema,idEntidad,idPlantel,tipoCategoria};
            List<String[]> datos=metodos.ejecutaSP("sp_consultaVacancias",parametros);
            if(!datos.isEmpty()){
                respuesta="";
                for(String[] dato:datos)
                {
                    if(dato[11].equals("1")){
                        aux=" ("+dato[16]+")";
                    }else{
                        aux="";
                    }
                    respuesta+="<tr><td>"+dato[2]+"</td><td>"+dato[4]+"</td><td>"+dato[6]+"</td><td>"+dato[8]+"</td><td>"+dato[10]+"</td><td>"+dato[12]+aux+"</td><td>"+dato[13]+"</td><td>"+dato[14]+"</td>"; 
                    //respuesta+="<form method='POST' action='AltaVacancia'><input type='hidden' name='idConvocatoria' value='"+dato[0]+"'><input class='btn btn-sm btn-link' type='submit' value='Editar'/></form>";                                                                                  
                    respuesta+="</tr>";
                }
            }
        }catch(Exception e){
            respuesta=e.toString();
        }finally{
            return respuesta;        
        }
    }
    public  String desplegarDocentes(String idPrograma,String idSubsistema,String idEntidad,String idPlantel,String nombreRFC,String estatus){        
        String respuesta="<tr><td colspan='9' class='text-center'>Sin información</td></tr>";        
        try{
            String[] parametros={idPrograma,idSubsistema,idEntidad,idPlantel,nombreRFC,estatus};
            List<String[]> datos=metodos.ejecutaSP("sp_consultaDocentes",parametros);
            if(!datos.isEmpty()){
                respuesta="";
                for(String[] dato:datos)
                {
                    respuesta+="<tr><td>"+dato[12]+"</td><td>"+dato[10]+"</td><td>"+dato[2]+"</td><td>"+dato[4]+"</td><td>"+dato[6]+"</td><td>"+dato[5]+"</td><td>"+dato[8]+"</td><td>"+dato[13]+"</td><td>"; 
                    if(!dato[13].equals("")){
                        respuesta+="<span class='glyphicon glyphicon-ok-sign completo' title='Aspirante evaluado'></span>";
                    }else{
                        respuesta+="<form method='POST' action='VistaDocente'><input type='hidden' name='idUsuario' value='"+dato[0]+"'><input type='hidden' name='rfc' value='"+dato[6]+"'><input class='btn btn-sm btn-link' type='submit' value='Ver información'/></form>";                                                               
                    }
                    
                    respuesta+="</td></tr>";
                }
            }
        }catch(Exception e){
            respuesta=e.toString();
        }finally{
            return respuesta;        
        }
    }
    
    public  String desplegarPlazas(String idUsuario){        
        String respuesta="<tr><td colspan='6' class='text-center'>Sin información</td></tr>";        
        try{
            String[] parametros={idUsuario};
            List<String[]> datos=metodos.ejecutaSP("sp_consultaUsuarioPlaza",parametros);
            if(!datos.isEmpty()){
                respuesta="";
                for(String[] dato:datos)
                {
                    respuesta+="<tr><td>"+dato[11]+"</td><td>"+new Fecha().formatoImprimir(dato[7])+"</td><td>"+dato[9]+":"+dato[10]+"</td><td class='hidden'>"+dato[2]+"</td><td>"+dato[3]+"</td><td class='hidden'>"+dato[4]+"</td><td>"+dato[5];
                    if(dato[4].equals("1")){
                        respuesta+="("+dato[6]+")";
                    }                    
                    respuesta+="</td><td>"; 
                    respuesta+="<button type='button' class='btn btn-sm' title='Borrar' onclick='confirmarPlaza("+dato[0]+")'><span class='glyphicon glyphicon-trash'></span></button>";  
                    respuesta+="</td></tr>";
                }
            }
        }catch(Exception e){
            respuesta=e.toString();
        }finally{
            return respuesta;        
        }
    }
}
