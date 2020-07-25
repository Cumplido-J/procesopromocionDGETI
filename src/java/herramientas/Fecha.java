/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package herramientas;

/**
 *
 * @author David Reyna
 */
public class Fecha {

    public Fecha() {
    }
    
    public String formatoAlmacenar(String cadena){
        String respuesta="";        
        String aux[]=cadena.split("/");
        if(aux.length==3){
            respuesta=aux[2]+"-"+aux[1]+"-"+aux[0];
        }
        return respuesta;
    }
    public String formatoImprimir(String cadena){
        String respuesta="";
        String aux[]=cadena.split("-");
        if(aux.length==3){
            respuesta=aux[2]+"/"+aux[1]+"/"+aux[0];
        }
        return respuesta;
    }
}
