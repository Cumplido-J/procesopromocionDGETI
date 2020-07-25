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
    public String formatoImprimirFH(String cadena){
        String respuesta="";
        String aux1[]=cadena.split(" ");
        if(aux1.length==2){
            String aux2[]=aux1[0].split("-");
            if(aux2.length==3){
                respuesta=aux2[2]+"/"+aux2[1]+"/"+aux2[0]+" "+aux1[1].substring(0, 5);

            }
        }
        return respuesta;
    }
}
