/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package datos;

import domain.Entidad;
import domain.Plantel;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author ja1000
 */
public class PlantelJDBC {
     private static final String SQL_SELECT = "SELECT id, idEntidad, cct, plantel, nombre, domicilio, altaMarginacion FROM catPlanteles where idEntidad=?";
    public List<Plantel> select(Entidad e){
        Connection conn =null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        Plantel plantel = null;
        List<Plantel> planteles = new ArrayList<Plantel>();
        
        try {
            conn =  Conexion.getConnection();
            ps = conn.prepareStatement(SQL_SELECT);
            ps.setInt(1, e.getId());
            rs = ps.executeQuery();
            while(rs.next()){
                int id = rs.getInt("id");
                int nombreEntidad = rs.getInt("idEntidad");
                String cct = rs.getString("cct");
                String plantel_ = rs.getString("plantel");
                String nombre = rs.getString("nombre");
                String domicilio = rs.getString("domicilio");
                String altaMarginacion_str =  rs.getString("altaMarginacion");
                char altaMarginacion =  altaMarginacion_str.charAt(0);
                plantel = new Plantel(id,nombreEntidad,cct,plantel_,nombre,domicilio,altaMarginacion);
                planteles.add(plantel);
            }
        } catch (SQLException ex) {
            ex.printStackTrace(System.out);
        }finally{
            Conexion.close(rs);
            Conexion.close(ps);
            Conexion.close(conn);
        }
        return planteles;
    }
    
}
