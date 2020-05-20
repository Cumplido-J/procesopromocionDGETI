/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package correos;

import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
 *
 * @author charl
 */
public class Validar_correo {

    public Matcher validar_correo(String correo) {
        Pattern pattern = Pattern
                .compile("^[_A-Za-z0-9-\\+]+(\\.[_A-Za-z0-9-]+)*@"
                        + "[A-Za-z0-9-]+(\\.[A-Za-z0-9]+)*(\\.[A-Za-z]{2,})$");

        Matcher comparar = pattern.matcher(correo);
        
        return comparar;
    }//fin del metodo validar_correo

}
