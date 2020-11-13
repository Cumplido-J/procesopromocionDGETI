/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package herramientas;

/**
 *
 * @author jtrinidadl
 */
public class UtileriasHelper {
    
    public String encriptarCodigo(String cadena, String subKey) {
		String cadenaEncriptada = "";
		String key = subKey;
		try {
			CipherDecode cdr = new CipherDecode();
			while (key.length() < 16 && !subKey.equals("")) {
				key = key + subKey;
			}
			if (key.length() >= 16) {
				key = key.substring(0, 16);
			} else {
				return "";
			}
			cadenaEncriptada = cdr.encode(key, cadena);
		} catch (Exception e) {
			return "";
		}
		return cadenaEncriptada;
	}

	public String desencriptarCodigo(String cadenaEncriptada, String subKey) {
		String cadenaDesencriptada = "";
		String subLlave = subKey;
		try {
			CipherDecode cdr = new CipherDecode();
			while (subLlave.length() < 16 && !subKey.equals("")) {
				subLlave = subLlave + subKey;
			}
			if (subLlave.length() >= 16) {
				subLlave = subLlave.substring(0, 16);
			} else {
				return null;
			}
			cadenaDesencriptada = cdr.decode(subLlave, cadenaEncriptada);
		} catch (Exception e) {
			return null;
		}
		return cadenaDesencriptada;
	}
}
