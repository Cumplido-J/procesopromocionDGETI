/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package datos;


import domain.Convocatoria;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class ConvocatoriaJDBC {
         private static final String SQL_SELECT = "SELECT id,nombre from convocatoria where id=?;";
         
    public Convocatoria select(int idPlantel){
        Connection conn =null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        Convocatoria convocatoria = null;
        
        
        try {
            conn =  Conexion.getConnection();
            ps = conn.prepareStatement(SQL_SELECT);
            ps.setInt(1, idPlantel);
            rs = ps.executeQuery();
            if(rs.next()){
                int id = rs.getInt("id");
                String nombre = rs.getString("nombre");
                convocatoria = new Convocatoria();
                convocatoria.setId(id);
                convocatoria.setNombre(nombre);
            }
        } catch (SQLException ex) {
            ex.printStackTrace(System.out);
        }finally{
            Conexion.close(rs);
            Conexion.close(ps);
            Conexion.close(conn);
        }
        return convocatoria;
    }
}