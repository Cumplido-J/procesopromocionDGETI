/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package datos;


import domain.Vacancia;
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
public class VacanciaJDBC {
         private static final String SQL_SELECT = "SELECT vac.id, vac.vacancia, plantel.plantel, plaza.categoria, "
                 + "carrera.carrera FROM vacancia vac INNER JOIN catPlanteles plantel ON vac.idPlantel= plantel.id "
                 + "INNER JOIN catCategoriasPlaza plaza ON vac.idCategoria= plaza.id "
                 + "INNER JOIN  catCarreras carrera ON vac.idCarrera= carrera.id "
                 + "WHERE idPlantel=?;";
         
    public List<Vacancia> select(int idPlantel){
        Connection conn =null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        Vacancia vacancia = null;
        List<Vacancia> vacancias = new ArrayList<Vacancia>();
        
        try {
            conn =  Conexion.getConnection();
            ps = conn.prepareStatement(SQL_SELECT);
            ps.setInt(1, idPlantel);
            rs = ps.executeQuery();
            while(rs.next()){
                int id = rs.getInt("id");
                int nvacancia = rs.getInt("vacancia");
                String plantel = rs.getString("plantel");
                String categoria = rs.getString("categoria");
                String carrera = rs.getString("carrera");
                vacancia = new Vacancia(id,nvacancia,plantel,categoria,carrera);
                vacancias.add(vacancia);
            }
        } catch (SQLException ex) {
            ex.printStackTrace(System.out);
        }finally{
            Conexion.close(rs);
            Conexion.close(ps);
            Conexion.close(conn);
        }
        return vacancias;
    }
}
