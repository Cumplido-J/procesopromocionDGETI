/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package datos;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import domain.Entidad;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import metodos_sql.Metodos_sql;

/**
 *
 * @author ja1000
 */
public class EntidadJDBC {

    private static final String SQL_SELECT = "SELECT id, entidad FROM catEntidades";

    /*public List<Entidad> select(){
        Connection conn =null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        Entidad entidad = null;
        List<Entidad> entidades = new ArrayList<Entidad>();
        
        try {
            conn =  Conexion.getConnection();
            conn= Metodos_sql.conector();
            ps = conn.prepareStatement(SQL_SELECT);
            rs = ps.executeQuery();
            while(rs.next()){
                int idEntidad = rs.getInt("id");
                String nombreEntidad = rs.getString("entidad");
                entidad = new Entidad(idEntidad, nombreEntidad);
                entidades.add(entidad);
            }
        } catch (SQLException e) {
            e.printStackTrace(System.out);
        }finally{
            Conexion.close(rs);
            Conexion.close(ps);
            Conexion.close(conn);
        }
        return entidades;
    }*/

    public List<Entidad> select() {
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        Entidad entidad = null;
        List<Entidad> entidades = new ArrayList<Entidad>();

        try {
            conn = Conexion.getConnection();
            conn = Metodos_sql.conector();
            ps = conn.prepareStatement(SQL_SELECT);
            rs = ps.executeQuery();
            while (rs.next()) {
                int idEntidad = rs.getInt("id");
                String nombreEntidad = rs.getString("entidad");
                entidad = new Entidad(idEntidad, nombreEntidad);
                entidades.add(entidad);
            }
        } catch (SQLException e) {
            e.printStackTrace(System.out);
        } finally {
            Conexion.close(rs);
            Conexion.close(ps);
            Conexion.close(conn);
        }
        return entidades;
    }

}
