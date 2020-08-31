/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.convocatoria.datos;

import com.convocatoria.domain.ProgramasPlantel;
import java.sql.Connection;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import metodos_sql.Metodos_sql;

/**
 *
 * @author Iker Fernando
 */
public class ProgramasPlantelJDBC {
    public static ResultSet rs;
    private static final String SP_BUSCAR_PROGRAMAS_PLANTELES = "{ call sp_consultaProgramasPlantel(?) } ";
    
    public List<ProgramasPlantel> select(int _entidad) {
        Metodos_sql metodos=new Metodos_sql();
        Connection conn = null;
        List<ProgramasPlantel> planteles = new ArrayList<ProgramasPlantel>();
        ProgramasPlantel programas = null;
        //conn = conector();
        try {
            String[] parametros=new String[1];
            parametros[0]=""+_entidad;
            List<String[]>datos=metodos.ejecutaSP("sp_consultaProgramasPlantel", parametros);
            
            if(datos.size()>0){
                for(String[] dato:datos){
                    programas = new ProgramasPlantel();
                    int id = Integer.parseInt(dato[0]);
                    String programas_ = dato[1];
                    programas.setId(id);
                    programas.setPrograma(programas_);
                    
                    planteles.add(programas);
                }
            }
            
        } catch (Exception ex) {
            System.out.println(ex.toString());

        }
        return planteles;
    }
}
