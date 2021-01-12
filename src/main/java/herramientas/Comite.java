/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package herramientas;

import constants.ConstantsWS;
import java.util.List;
import metodos_sql.Metodos_sql;

/**
 *
 * @author David Reyna
 */
public class Comite {
    Metodos_sql metodos;   

    public Comite() {
        metodos = new Metodos_sql();
    }
    public  String registraComite(String idPrograma, String tipo,String idSubsistema,String idEntidad,String idPlantel ){        
        String respuesta="-1";        
        try{
            String[] parametros={idPrograma,tipo,idSubsistema,idEntidad,idPlantel};
            List<String[]> datos=metodos.ejecutaSP("sp_insertComite",parametros);
            if(!datos.isEmpty()){
                respuesta=datos.get(0)[0];
            }
        }catch(Exception e){
            System.out.println(e.toString());
        }finally{
            return respuesta;        
        }
    }
    public  String[] consultaComite(String id){        
        String[] respuesta={"","","","","","","",""};        
        try{
            String[] parametros={id};
            List<String[]> datos=metodos.ejecutaSP("sp_consultaComitePorId",parametros);
            if(!datos.isEmpty()){
                respuesta[0]=datos.get(0)[0];
                respuesta[1]=datos.get(0)[4];
                respuesta[2]=datos.get(0)[2];
                respuesta[3]=datos.get(0)[1];
                respuesta[4]=datos.get(0)[3];
                respuesta[5]=datos.get(0)[5];
                respuesta[6]=datos.get(0)[6];
                respuesta[7]=datos.get(0)[7];
            }
        }catch(Exception e){
            System.out.println(e.toString());
        }finally{
            return respuesta;        
        }
    }
    public  String desplegarComite(){ 
        return desplegarComite("","","","","");
    }
    public  String desplegarComite(String idPrograma, String tipo,String idSubsistema,String idEntidad,String idPlantel){        
        String respuesta="<tr><td colspan='8' class='text-center'>Sin información</td></tr>";        
        try{
            String[] parametros={idPrograma,tipo,idSubsistema,idEntidad,idPlantel};
            List<String[]> datos=metodos.ejecutaSP("sp_consultaComite",parametros);
            if(!datos.isEmpty()){
                respuesta="";
                for(String[] dato:datos)
                {
                    respuesta+="<tr id='comite"+dato[0]+"'><td>"+dato[8]+"</td><td>"+dato[4]+"</td><td>"+dato[2]+"</td><td>"+dato[6]+"</td><td>"+dato[9]+"</td><td>"+dato[11]+"</td><td>"+dato[10]+"</td><td>";
                    if(dato[12].equals("F")){
                        respuesta+="<form method='POST' action='RegistroComite'><input type='hidden' name='idComite' value='"+dato[0]+"'><input class='btn btn-sm btn-link' id='btnEditar' type='submit' value='Editar'/><input class='btn btn-sm btn-link' id='btnBorrar' type='button' value='Borrar' onClick='confirmacion("+dato[0]+")'/></form>";                   
                    }
                    if(dato[12].equals("V")){
                        respuesta+="<form method='POST' action='RegistroComite'><input type='hidden' name='idComite' value='"+dato[0]+"'><input class='btn btn-sm btn-link' id='btnVisualizar' type='submit' value='Ver integrantes'/></form>";                   
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
    public  String desplegarIntegrantesComite(String id){        
        String respuesta="<td colspan='6' class='text-center'>Sin información</td>";        
        try{
            String[] parametros={id};
            List<String[]> datos=metodos.ejecutaSP("sp_consultaMiembrosComite",parametros);
            if(!datos.isEmpty()){
                respuesta="";
                for(String[] dato:datos)
                {
                    respuesta+="<tr id='integrante"+dato[0]+"'><td>"+dato[1]+"</td><td>"+dato[2]+"</td><td>"+dato[3]+"</td><td>"+dato[4]+"</td><td>"+dato[5]+"</td><td>"+dato[7]+"</td><td><input class='btn btn-sm btn-link' id='btnBorrar' type='button' value='Borrar' onClick='confirmacion("+dato[0]+")'/></td></tr>";
                }
            }
        }catch(Exception e){
            respuesta=e.toString();
        }finally{
            return respuesta;        
        }
    }
    public  String borrarComite(String id){        
        String respuesta="";        
        try{
            String[] parametros={id};
            List<String[]> datos=metodos.ejecutaSP("sp_deleteComite",parametros);
            if(!datos.isEmpty()){
                respuesta=datos.get(0)[0];                
            }           
        }catch(Exception e){
            respuesta=e.toString();
        }finally{
            return respuesta;        
        }
    }
    public  String borrarIntegrante(String id){        
        String respuesta="";        
        try{
            String[] parametros={id};
            List<String[]> datos=metodos.ejecutaSP("sp_deleteMiembroComite",parametros);
            if(!datos.isEmpty()){
                respuesta=datos.get(0)[0];                
            }           
        }catch(Exception e){
            respuesta=e.toString();
        }finally{
            return respuesta;        
        }
    }
    public  String finalizarComite(String idComite,String idRol,String pass){        
        String respuesta="";  
        String permiso="";
        String nivel="";
        String tipoComite="";
        try{
            UtileriasHelper utilerias = new UtileriasHelper();
            String encriptarPass = utilerias.encriptarCodigo(pass, ConstantsWS.LLAVE_CIFRADO);
            String[] parametros={idComite,idRol};
            List<String[]> datos=metodos.ejecutaSP("sp_finalizarComite",parametros);
            if(!datos.isEmpty()){ 
                
                if(datos.get(0)[1]!=""){
                    nivel="P";
                }else if(datos.get(0)[0]!=""){
                    nivel="E";
                }else{
                    nivel="N";
                }
                tipoComite=datos.get(0)[9];
                if(tipoComite.equals("R")){
                    permiso="5";
                }else if(tipoComite.equals("D")){
                    permiso="6";                
                }
                String usuario=datos.get(0)[6];
                String correo=datos.get(0)[5];
                String[] parametros2={datos.get(0)[0],datos.get(0)[1],datos.get(0)[2],datos.get(0)[3],datos.get(0)[4],correo,encriptarPass,usuario,"","","A","",nivel,datos.get(0)[7],datos.get(0)[8],""};                                      
                datos=metodos.ejecutaSP("sp_insertUsuario",parametros2);            
                if(!datos.isEmpty()){
                    respuesta=datos.get(0)[0]; 
                    parametros=new String[3];
                    parametros[0]="";
                    parametros[1]=usuario;  
                    parametros[2]=permiso;
                    if(respuesta.equals("ok")){                       
                        Correo c=new Correo();
                        c.enviarCorreo("Envío de contraseña","Usted ha sido registrado en el Sistema de Promoción Docente (disponible en https://www.promociondocente.sep.gob.mx) <br/> Sus datos de acceso son: <br/> Usuario: <b>"+usuario+"</b><br/>Contrase&ntilde;a:<b>"+pass+"</b>", correo);
                        datos=metodos.ejecutaSP("sp_insertUsuarioPermiso",parametros); 
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
