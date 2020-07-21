/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package herramientas;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.URL;
import java.net.URLConnection;

/**
 *
 * @author David Reyna
 */
public class WebService {
    String url;
    String data;
    String status;
    String mensaje;

    public WebService(String url) {
        this.url = url;
    }    

    public String getData() {
        return data;
    }
    
    public String getStatus() {
        return status;
    }

    public String getMensaje() {
        return mensaje;
    }

    public void consumeWS(){
        try {
                // Realizando la petición GET
                URLConnection con = new URL(url).openConnection();
                // Leyendo el resultado
                BufferedReader in = new BufferedReader(new InputStreamReader(
                                con.getInputStream()));
                String datos=in.readLine();
                String[] aux=datos.split(";");                
                data=aux[0].substring(aux[0].indexOf("'"));
                data=data.replaceAll("'", "");
                status=aux[1].substring(aux[1].indexOf("'"));
                mensaje=aux[2].substring(aux[2].indexOf("'"));   
        } catch (Exception e) {
                System.out.println(e.getMessage());
        }
    } 
    
    
    
    
}
