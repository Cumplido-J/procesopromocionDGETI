/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package herramientas;

import java.io.File;
import java.io.FileInputStream;
import java.util.Base64;

/**
 *
 * @author David Reyna
 */
public class Imagen {
    public static String muestraImagen(String ruta){
        String retorno="";
        File documento; 
        try{                       
            documento=new File(ruta);
            if(documento.exists()){
                FileInputStream fis=new FileInputStream(documento.getPath());
                int tamanio=fis.available();
                byte[] datos=new byte[tamanio];
                fis.read(datos,0,tamanio);                                
                StringBuilder imageString = new StringBuilder();
                imageString.append("data:image/jpg;base64,");
                imageString.append(Base64.getEncoder().encodeToString(datos));
                retorno = imageString.toString();
            }
            
        }catch(Exception e){
            System.out.println(e.toString());
        }finally{
            return retorno;
        }
    }
}
