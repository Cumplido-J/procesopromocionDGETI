/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package herramientas;

import java.io.FileReader;
import java.util.Properties;
import java.util.Random;

/**
 *
 * @author David Reyna
 */
public class Pin {
       
    public static String generaPin(){
        String pin="";
        try{            
            Properties p = new Properties();
            p.load(new FileReader("C:/ArchivosPromocion/config.properties"));            
            int longitudPin=Integer.parseInt(p.getProperty("longitudPin"));
            for(int c=0;c<longitudPin;c++){
                pin+=generaDigito();
            }
        }catch(Exception e){
            System.out.println(e.toString());
        }
        finally{
            return pin;
        }
    }
    public static String generaDigito(){
        String digito;
        Random r = new Random();
        int aux = r.nextInt(2);//Para indicar si se genera 0:Numero o 1:Caracter
        int numero;
        if(aux==0){
            numero=r.nextInt(10);//Genera un numero entre 0 y 9
            digito=""+numero;
        }else{
            numero=r.nextInt(26);//Genera un numero entre 0 y 26
            numero+=65;//Se suma 65 pues el numero obtenido se utilizará como el valor ASCII una letra mayuscula (ASCII 65 a 90)
            digito=""+(char)numero;
        }
        return digito;
    }
    
    
    
}
