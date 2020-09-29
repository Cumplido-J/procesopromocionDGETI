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
public class Comite {
    Metodos_sql metodos;   

    public Comite() {
        metodos = new Metodos_sql();
    }
    public  String registraComite(String idPlantel, String idPrograma, String tipo){        
        String respuesta="-1";        
        try{
            String[] parametros={idPlantel,idPrograma,tipo};
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
        String[] respuesta={"","","","","",""};        
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
            }
        }catch(Exception e){
            System.out.println(e.toString());
        }finally{
            return respuesta;        
        }
    }
    public  String desplegarComite(){ 
        return desplegarComite("","","");
    }
    public  String desplegarComite(String idPrograma,String idPlantel,String tipo){        
        String respuesta="<tr><td colspan='8' class='text-center'>Sin información</td></tr>";        
        try{
            String[] parametros={idPrograma,idPlantel,tipo};
            List<String[]> datos=metodos.ejecutaSP("sp_consultaComite",parametros);
            if(!datos.isEmpty()){
                respuesta="";
                for(String[] dato:datos)
                {
                    respuesta+="<tr><td>"+dato[8]+"</td><td>"+dato[4]+"</td><td>"+dato[2]+"</td><td>"+dato[6]+"</td><td>"+dato[9]+"</td><td>"+dato[11]+"</td><td>"+dato[10]+"</td><td>";
                    respuesta+="<form method='POST' action='RegistroComite'><input type='hidden' name='idComite' value='"+dato[0]+"'> <input class='btn btn-sm btn-primary' id='btnRegistrar' type='submit' value='Editar'/></form>";                   
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
                    respuesta+="<tr><td>"+dato[1]+"</td><td>"+dato[2]+"</td><td>"+dato[3]+"</td><td>"+dato[4]+"</td><td>"+dato[5]+"</td><td>"+dato[7]+"</td><td></td></tr>";
                }
            }
        }catch(Exception e){
            respuesta=e.toString();
        }finally{
            return respuesta;        
        }
    }
}
