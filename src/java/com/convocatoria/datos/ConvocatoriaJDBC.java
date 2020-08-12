/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.convocatoria.datos;

import com.convocatoria.domain.*;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.Date;
import java.sql.ResultSet;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;
import metodos_sql.Metodos_sql;
import static metodos_sql.Metodos_sql.conector;

public class ConvocatoriaJDBC {

    public static ResultSet rs;
    private static final String SP_BUSCAR_CONVOCATORIAS = "{ call sp_selectConvocatoriasVigentes(?) } ";

    /*public List<Convocatoria> select() {
       LocalDate _fecha = LocalDate.now();
   
        Connection conn = null;
        List<Convocatoria> convocatorias = new ArrayList<Convocatoria>();
        Convocatoria convocatoria = null;
        conn = conector();
        try {
            CallableStatement stmt = conn.prepareCall(SP_BUSCAR_CONVOCATORIAS);
            stmt.setString(1, _fecha.toString());
            System.out.printf("%s", _fecha.toString());
            rs = stmt.executeQuery();
            while (rs.next()) {
                convocatoria = new Convocatoria();
                int id = rs.getInt("id");
                String nombre = rs.getString("nombre");
                convocatoria.setId(id);
                convocatoria.setNombre(nombre);
                convocatorias.add(convocatoria);
            }
            conn.close();
        } catch (Exception ex) {
            System.out.println(ex.toString());

        }
        return convocatorias;
    }*/
    public List<Convocatoria> select(String idPlantel) {
       Metodos_sql m=new Metodos_sql();
       //LocalDate _fecha = LocalDate.now();   
        //Connection conn = null;
        List<Convocatoria> convocatorias = new ArrayList<Convocatoria>();
        Convocatoria convocatoria = null;
        //conn = conector();
        try {
            
            //CallableStatement stmt = conn.prepareCall(SP_BUSCAR_CONVOCATORIAS);
            //stmt.setString(1, _fecha.toString());
            //System.out.printf("%s", _fecha.toString());
            //rs = stmt.executeQuery();
            String[] parametros=new String[1];
            parametros[0]=idPlantel;
            List<String[]>datos=m.ejecutaSP("sp_consultaConvocatoriasVigentes", parametros);
            /*CallableStatement stmt = conn.prepareCall(SP_BUSCAR_PLANTELES);
            stmt.setInt(1, _entidad);
            rs = stmt.executeQuery();*/
            if(datos.size()>0){
                for(String[] dato:datos){
                    convocatoria = new Convocatoria();
                    int id = Integer.parseInt(dato[0]);
                    String nombre = dato[1];
                    convocatoria.setId(id);
                    convocatoria.setNombre(nombre);
                    convocatorias.add(convocatoria);
                }
            }
            
            //conn.close();
        } catch (Exception ex) {
            System.out.println(ex.toString());

        }
        return convocatorias;
    }

}
