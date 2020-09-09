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
    //private static final String rutaConfig="C:/ArchivosPromocion/config.properties";
    private final static String rutaConfig="/home/david/configDocente/ArchivosPromocion/configLinuxLocal.properties";
    
    public static String getRutaConfig() {
        return rutaConfig;
    }
}
