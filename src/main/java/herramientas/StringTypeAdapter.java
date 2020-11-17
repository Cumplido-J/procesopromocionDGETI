/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package herramientas;

import java.io.IOException;

import com.google.gson.TypeAdapter;
import com.google.gson.stream.JsonReader;
import com.google.gson.stream.JsonToken;
import com.google.gson.stream.JsonWriter;

/**
 *
 * @author jtrinidadl
 */
public class StringTypeAdapter extends TypeAdapter<String>{
    
	public void write(JsonWriter out, String value) throws IOException {
		if (value == null) {
			out.value("");
	         return;
	       }else{	    	   
	    	   out.value(value.trim());
	       }
	     }

	public String read(JsonReader in) throws IOException {
		if (in.peek() == JsonToken.NULL) {
			in.nextNull();
			return "";
		}else{
			String value = in.nextString();
			if(value==null){
				return "";				
			}else{				
				return value.trim();				
			}
		}
	}
}
