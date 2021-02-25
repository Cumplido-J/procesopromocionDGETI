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
public class RutaConfig {
//    private static final String rutaCarpeta="C:/ArchivosPromocion/";
//    private static final String rutaConfig="C:/ArchivosPromocion/config.properties";
    private final static String rutaCarpeta="/home/pdadmin/configDocente/ArchivosPromocion/";
    private final static String rutaConfig="/home/pdadmin/configDocente/ArchivosPromocion/configLinux.properties";
    
    public static String getRutaConfig() {
        return rutaConfig;
    }

    public static String getRutaCarpeta() {
        return rutaCarpeta;
    }
    
}
