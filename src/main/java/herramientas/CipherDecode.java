/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package herramientas;

import org.bouncycastle.crypto.engines.AESEngine;
import org.bouncycastle.crypto.params.KeyParameter;

/**
 *
 * @author jtrinidadl
 */
public class CipherDecode {
    public String encode(String clave, String texto) throws Exception {
		AESEngine engine = new AESEngine();
		byte[] inputs;
		int i;
		byte[] inputs2;
		int blockSize;
		String string;
		byte[] bytes;
		byte[] tmp;
		int length;
		try {
			bytes = new byte[1024];
			engine.init(true, new KeyParameter(clave.getBytes("utf-8")));

			string = texto;
			inputs = string.getBytes("utf-8");
			tmp = new byte[(inputs.length / 16 + 1) * 16];
			System.arraycopy(inputs, 0, tmp, 0, inputs.length);
			for (i = inputs.length; i < tmp.length; i++) {
				tmp[i] = (byte) (16 - inputs.length % 16);
			}
			inputs = tmp;
			inputs2 = new byte[blockSize = engine.getBlockSize()];
			length = 0;
			for (i = 0; i < inputs.length; i += blockSize) {
				System.arraycopy(inputs, i, inputs2, 0, blockSize);
				length += engine.processBlock(inputs2, 0, bytes, length);
			}
			string = Base64.encodeBytes(bytes, 0, length);

			return string;

		} catch (Exception e) {
			/* e.printStackTrace(); */
			throw new Exception("[ Implementacion no soportada ]");
		}

	}

	/**
	 * descifra datos
	 * 
	 * @param clave de longitud 16
	 * @param texto a decifrar
	 * @return
	 * @throws BusinessException
	 */
	public String decode(String clave, String texto) throws Exception {
		AESEngine engine = new AESEngine();
		byte[] inputs;
		int i;
		int length;
		byte[] inputs2;
		int blockSize;
		byte[] bytes;
		String string;
		try {
			string = texto;
			bytes = new byte[1024];
			engine.init(false, new KeyParameter(clave.getBytes("utf-8")));
			inputs = string.getBytes("utf-8");
			inputs = Base64.decode(inputs, 0, inputs.length);
			inputs2 = new byte[blockSize = engine.getBlockSize()];
			length = 0;
			for (i = 0; i < inputs.length; i += blockSize) {
				int j;
				j = i + blockSize < inputs.length ? blockSize : inputs.length - i;
				System.arraycopy(inputs, i, inputs2, 0, j);
				length += engine.processBlock(inputs2, 0, bytes, length);
			}

			return new String(bytes, 0, length - bytes[length - 1], "utf-8");

		} catch (Exception e) {
			throw new Exception("[ No se logro decodificar la cadena ]");
		}

	}
}
