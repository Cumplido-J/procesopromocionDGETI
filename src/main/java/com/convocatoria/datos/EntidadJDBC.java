/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.convocatoria.datos;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import com.convocatoria.domain.Entidad;
import java.sql.CallableStatement;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import metodos_sql.Metodos_sql;
import static metodos_sql.Metodos_sql.conector;
import static metodos_sql.Metodos_sql.resultado;

/**
 *
 * @author ja1000
 */
public class EntidadJDBC {

    PreparedStatement ps;
    public static ResultSet rs;
    private static final String SP_BUSCAR_ENTIDADES = "{ call sp_selectCatEntidades()} ";

    public  List<Entidad> select() {
        Connection conn = null;
        List<Entidad> entidades = new ArrayList<Entidad>();
        conn = conector();
        try {
            CallableStatement stmt = conn.prepareCall(SP_BUSCAR_ENTIDADES);
            rs = stmt.executeQuery();
            while (rs.next()) {
                int _id = rs.getInt("id");
                String _entidad = rs.getString("entidad");
                Entidad entidad = new Entidad();
                entidad.setId(_id);
                entidad.setEntidad(_entidad);
                entidades.add(entidad); 
            }
            conn.close();
        } catch (Exception ex) {
            System.out.println(ex.toString());

        }

        return entidades;
    }

}
