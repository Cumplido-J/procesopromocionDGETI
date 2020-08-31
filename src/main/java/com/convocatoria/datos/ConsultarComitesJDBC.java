/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.convocatoria.datos;

import com.convocatoria.domain.Comites;
import java.sql.Connection;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import metodos_sql.Metodos_sql;

/**
 *
 * @author jtrinidadl
 */
public class ConsultarComitesJDBC {
    public static ResultSet rs;
    private static final String SP_BUSCAR_PROGRAMAS_PLANTELES = "{ call sp_selectComite(?) } ";
    
    public List<Comites> select(int _programa) {
        Metodos_sql metodos=new Metodos_sql();
        Connection conn = null;
        List<Comites> comites = new ArrayList<Comites>();
        Comites programas = null;
        //conn = conector();
        try {
            String[] parametros=new String[1];
            parametros[0]=""+_programa;
            List<String[]>datos=metodos.ejecutaSP("sp_selectComite", parametros);
            
            if(datos.size()>0){
                for(String[] dato:datos){
                    programas = new Comites();
                    int id = Integer.parseInt(dato[0]);
                    String programas_ = dato[1];
                    programas.setId(id);
                    programas.setTipo(programas_);
                    
                    comites.add(programas);
                }
            }
            
        } catch (Exception ex) {
            System.out.println(ex.toString());

        }
        return comites;
    }
}
