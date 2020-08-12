/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.convocatoria.datos;

import com.convocatoria.domain.Plantel;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import metodos_sql.Metodos_sql;
//import static metodos_sql.Metodos_sql.conector;

/**
 *
 * @author ja1000
 */
public class PlantelJDBC {

    public static ResultSet rs;
    private static final String SP_BUSCAR_PLANTELES = "{ call sp_selectCatPlanteles(?) } ";

    /*public List<Plantel> select(int _entidad) {
        Connection conn = null;
        List<Plantel> planteles = new ArrayList<Plantel>();
        Plantel plantel = null;
        conn = conector();
        try {
            CallableStatement stmt = conn.prepareCall(SP_BUSCAR_PLANTELES);
            stmt.setInt(1, _entidad);
            rs = stmt.executeQuery();
            while (rs.next()) {
                plantel = new Plantel();
                int id = rs.getInt("id");
                String cct = rs.getString("cct");
                String plantel_ = rs.getString("plantel");
                String altaMarginacion_str = rs.getString("gradoMarginacion");
                plantel.setId(id);
                plantel.setCct(cct);
                plantel.setPlanel(plantel_);
                plantel.setAltaMarginacion(altaMarginacion_str);
                planteles.add(plantel);
            }
            conn.close();
        } catch (Exception ex) {
            System.out.println(ex.toString());

        }
        return planteles;
    }*/
    public List<Plantel> select(int _entidad) {
        Metodos_sql metodos=new Metodos_sql();
        Connection conn = null;
        List<Plantel> planteles = new ArrayList<Plantel>();
        Plantel plantel = null;
        //conn = conector();
        try {
            String[] parametros=new String[1];
            parametros[0]=""+_entidad;
            List<String[]>datos=metodos.ejecutaSP("sp_selectCatPlanteles", parametros);
            /*CallableStatement stmt = conn.prepareCall(SP_BUSCAR_PLANTELES);
            stmt.setInt(1, _entidad);
            rs = stmt.executeQuery();*/
            if(datos.size()>0){
                for(String[] dato:datos){
                    plantel = new Plantel();
                    int id = Integer.parseInt(dato[0]);
                    String cct = dato[1];
                    String plantel_ = dato[2];
                    String altaMarginacion_str = dato[3];
                    plantel.setId(id);
                    plantel.setCct(cct);
                    plantel.setPlanel(plantel_);
                    plantel.setAltaMarginacion(altaMarginacion_str);
                    planteles.add(plantel);
                }
            }
            
        } catch (Exception ex) {
            System.out.println(ex.toString());

        }
        return planteles;
    }
}
