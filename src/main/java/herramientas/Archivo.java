/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package herramientas;

import java.io.File;
import java.io.FileReader;
import java.util.Properties;

/**
 *
 * @author David Reyna
 */
public class Archivo {

    public Archivo() {
    }
    
    public boolean documentoCargado(String idDocumento){
        boolean retorno=false;
        try{        
            String rutaConfig = RutaConfig.getRutaConfig();
            Properties p = new Properties();
            p.load(new FileReader(rutaConfig));
            String ruta=p.getProperty("rutaEvidenciasRegistro");
            ruta+="/"+idDocumento+".pdf";    
            File documento;            
            documento=new File(ruta);
            retorno= documento.exists();
        }catch(Exception e){
            System.out.println(e.toString());
        }finally{
            return retorno;
        }
    }
}
