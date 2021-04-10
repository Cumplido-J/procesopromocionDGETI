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
    public  String desplegarUsuarios(String idPrograma,String idSubsistema,String idEntidad,String idPlantel,String usuario,String tusuario){        
        String respuesta="<tr><td colspan='7' class='text-center'>Sin información</td></tr>";        
        try{
            String[] parametros={idPrograma,idSubsistema,idEntidad,idPlantel,usuario,tusuario};
            if(idEntidad.isEmpty() && idPlantel.isEmpty() && tusuario.isEmpty()){
                return respuesta;
            }else if(!idEntidad.isEmpty() && !idPlantel.isEmpty() && tusuario.isEmpty()){
                return respuesta;
            }else{
                List<String[]> datos=metodos.ejecutaSP("sp_consultaUsuarios",parametros);
                if(!datos.isEmpty()){
                    respuesta="";
                    for(String[] dato:datos)
                    {   
                        String nombreUsuario=dato[10]==null?"":dato[10];
                        
                        respuesta+="<tr><td>"+dato[2]+"</td><td>"+dato[4]+"</td><td>"+dato[6]+"</td><td>"+dato[8]+"</td><td>"+dato[9]+"</td><td>"+nombreUsuario+"</td><td>"; 
                        respuesta+="<form method='POST' action='AltaUsuario'><input type='hidden' name='idUsuario' value='"+dato[0]+"'><input class='btn btn-sm btn-link' type='submit' value='Editar'/></form>";
                        respuesta+="<td><button type='button' class='btn btn-sm' title='Borrar' onclick='confirmarUsuario("+dato[0]+")'><span class='glyphicon glyphicon-trash'></span></button></td>";                                                                                  
                        respuesta+="</td></tr>";
                    }
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
            if(idEntidad==null && idPlantel==null){
                idEntidad="";
                idPlantel="";
            }else if(idEntidad==null){
                idEntidad="";
            }else if(idPlantel==null){
                idPlantel="";
            }
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
    public  String desplegarConvocatoriasBase(String idPrograma,String idSubsistema,String idEntidad,String idPlantel,String estatus,String tipoConvocatoria){        
        String respuesta="<tr><td colspan='6' class='text-center'>Sin información</td></tr>";        
        try{
            
            if(estatus.isEmpty()){
                estatus = "0";
            }
            
            if(tipoConvocatoria.equals("NACIONAL")){
                idEntidad="0";
                idPlantel="0";
            }else if(tipoConvocatoria.equals("ESTATAL")){
                idPlantel="0";
            }
            
            String[] parametros={idPrograma,idSubsistema,idEntidad,idPlantel,estatus,tipoConvocatoria};
            
                List<String[]> datos=metodos.ejecutaSP("sp_consultaConvocatoriasBase",parametros);
                if(!datos.isEmpty()){
                respuesta="";
                for(String[] dato:datos)
                {
                    respuesta+="<tr><td>"+dato[2]+"</td><td>"+dato[9]+"</td><td>"+dato[4]+"</td><td>"+dato[6]+"</td><td>"+dato[8]+"</td><td>"; 
                    respuesta+="<form method='POST' action='AltaConvocatoriaBase'><input type='hidden' name='idConvocatoria' value='"+dato[0]+"'><input class='btn btn-sm btn-link' type='submit' value='Editar'/></form>";                                                                                  
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
    public  String desplegarDocentes(String idPrograma,String idSubsistema,String idEntidad,String idPlantel,String nombreRFC,String estatus,String idPermiso,String idUsuario){        
        String respuesta="<tr><td colspan='9' class='text-center'>Sin información</td></tr>";        
        try{
            String[] parametros={idPrograma,idSubsistema,idEntidad,idPlantel,nombreRFC,estatus,idUsuario};
            if(idEntidad.isEmpty() && idPlantel.isEmpty() && nombreRFC.isEmpty() && estatus.isEmpty()){
                return respuesta;
            }else{
                List<String[]> datos=metodos.ejecutaSP("sp_consultaDocentes",parametros);
                
                if(!datos.isEmpty()){
                    respuesta="";
                    for(String[] dato:datos)
                    {
                        respuesta+="<tr><td>"+dato[12]+"</td><td>"+dato[10]+"</td><td>"+dato[2]+"</td><td>"+dato[4]+"</td><td>"+dato[6]+"</td><td>"+dato[5]+"</td><td>"+dato[8]+"</td><td>"+dato[13]+"</td><td>"; 
                        if (idPermiso.equals("6"))
                        {
                            respuesta+=dato[14]+"</td><td>";
                            if(!dato[14].equals("")){
                                respuesta+="<span class='glyphicon glyphicon-ok-sign completo' title='Aspirante evaluado'></span>";
                            }
                        }
                        else
                        {
                            if(!dato[13].equals("")){
                                respuesta+="<span class='glyphicon glyphicon-ok-sign completo' title='Aspirante evaluado'></span>";
                            }
                        } 
                        respuesta+="<form method='POST' action='VistaDocente'><input type='hidden' name='idUsuario' value='"+dato[0]+"'><input type='hidden' name='rfc' value='"+dato[6]+"'><input class='btn btn-sm btn-link' type='submit' value='Ver información'/></form>";                                                               


                        respuesta+="</td></tr>";
                    }
                }
            }
        }catch(Exception e){
            respuesta=e.toString();
        }finally{
            return respuesta;        
        }
    }
    
    
    public  String desplegarPlazas(String idUsuario){        
        String respuesta="<tr><td colspan='7' class='text-center'>Sin información</td></tr>";        
        try{
            String[] parametros={idUsuario};
            List<String[]> datos=metodos.ejecutaSP("sp_consultaUsuarioPlaza",parametros);
            if(!datos.isEmpty()){
                respuesta="";
                String seleccionado="";
                String cargo="";
                for(String[] dato:datos)
                {
                    if(dato[12].equals("V")){
                        seleccionado="checked";
                    }else{
                        seleccionado="";
                    }
                    respuesta+="<tr><td><center><input type='checkbox' onChange='seleccionarPlaza(this)' value='"+dato[0]+"' "+seleccionado+"/></center><td>"+dato[11]+"</td><td>"+dato[7]+"</td><td id="+"tipoNom"+">"+dato[9]+":"+dato[10]+"</td><td class='hidden'>"+dato[2]+"</td><td>"+dato[3]+"</td><td class='hidden'>"+dato[4]+"</td><td>"+dato[5];
                    if(dato[4].equals("1")){
                        respuesta+="("+dato[6]+")";
                    }                    
                    respuesta+="</td>";
                    switch(dato[13]){
                        case "D":
                            respuesta+="<td>Director<br/>Fecha renuncia:"+dato[14]+"</td>";
                            break;
                        case "S":
                            respuesta+="<td>Subdirector<br/>Fecha renuncia:"+dato[14]+"</td>";
                            break;
                        case "J":
                            respuesta+="<td>Jefe de Departamento<br/>Fecha renuncia:"+dato[14]+"</td>";
                            break;
                        default:
                            respuesta+="<td>No aplica</td>";                        
                    }
                     
                    respuesta+="<td><button type='button' class='btn btn-sm' title='Borrar' onclick='confirmarPlaza("+dato[0]+")'><span class='glyphicon glyphicon-trash'></span></button>";  
                    respuesta+="</td></tr>";
                }
            }
        }catch(Exception e){
            respuesta=e.toString();
        }finally{
            return respuesta;        
        }
    }
    public  String validarSeleccionadas(String idUsuario){        
        String respuesta="";   
        int horas=0,numPlazas=0;
        String idCategoria="-1",idJornada="-1",idCategoriaAux="",idJornadaAux="";
        String idNombramiento="",idNombramientoAux="";
        try{
            String[] parametros={idUsuario};
            List<String[]> datos=metodos.ejecutaSP("sp_consultaUsuarioPlaza",parametros);
            if(!datos.isEmpty()){
                respuesta="";                
                for(String[] dato:datos)
                {
                    if(dato[12].equals("V")){
                        idCategoria=dato[2];
                        idJornada=dato[4];
                        idNombramiento=dato[8];
                        if(dato[4].equals("1")){
                            horas+=Integer.parseInt(dato[6]);
                        }        
                        System.out.println(idCategoria+"-"+idCategoriaAux+"-"+idJornada+"-"+idJornadaAux);
                        
                        if(dato[15].equals("1")){//Para el programa 1:Cambio categoria solo puede sumar plazas con la misma categoria y jornada
                            if(!idCategoriaAux.isEmpty()){
                                if(!idCategoriaAux.equals(idCategoria)||!idJornadaAux.equals(idJornada)){
                                    respuesta="Solo puede seleccionar plazas de la misma categoria y jornada";
                                }
                            }
                        }else if(dato[15].equals("2")){//Para el programa 2:Horas adicionales solo puede sumar plazas con jornada de horas
                            if(!idJornada.equals("1")){
                                respuesta="Solo puede seleccionar plazas con jornada de horas";
                            }
                            if(horas>17){
                                respuesta="Solo puede acumular 17 horas como máximo";
                            }
                        }
                        
                        idCategoriaAux=idCategoria;
                        idJornadaAux=idJornada;
                        idNombramientoAux=idNombramiento;
                        numPlazas++;
                    }
                    
                }
                if(!idJornada.equals("1")&&numPlazas>1){
                    respuesta="Solo puede seleccionar una plaza con la que participará";
                }else{
                    if(respuesta.isEmpty()){
                        respuesta=idCategoria+","+idJornada+","+horas+","+idNombramiento;
                    }
                }
            }
        }catch(Exception e){
            respuesta=e.toString();
        }finally{
            return respuesta;        
        }
    }
}
