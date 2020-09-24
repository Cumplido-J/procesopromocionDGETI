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
