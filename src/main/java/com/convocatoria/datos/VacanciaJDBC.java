/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.convocatoria.datos;

import com.convocatoria.domain.Vacancia;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import metodos_sql.Metodos_sql;
import static metodos_sql.Metodos_sql.conector;

/**
 *
 * @author ja1000
 */
public class VacanciaJDBC {

    public static ResultSet rs;
    private static final String SP_BUSCAR_VACANCIAS = "{ call sp_selectVacanciaPlantelConvocatoriaVigente(?,?) } ";

    /*public int selectPorConvocatoria(int _idConvocatoria, int _plantel) {
        Connection conn = null;
        Vacancia vacancia = null;
        int total = 0;
        conn = conector();
        try {
            CallableStatement stmt = conn.prepareCall(SP_BUSCAR_VACANCIAS);
            stmt.setInt(1, _idConvocatoria);
            stmt.setInt(2, _plantel);
            rs = stmt.executeQuery();
            if (rs.next()) {
                total = rs.getInt("total");

            }
            conn.close();
        } catch (Exception ex) {
            System.out.println(ex.toString());

        }
        return total;
    }*/
    public int selectPorConvocatoria(int _idConvocatoria, int _plantel) {
        Metodos_sql m=new Metodos_sql();
        //Connection conn = null;
        Vacancia vacancia = null;
        int total = 0;
        //conn = conector();
        try {
            String[] parametros=new String[2];
            parametros[0]=""+_idConvocatoria;
            parametros[1]=""+_plantel;       
            List<String[]>datos=m.ejecutaSP("sp_selectVacanciaPlantelConvocatoriaVigente", parametros);
            if(datos.size()>0){
                for(String[] dato:datos){
                    total=Integer.parseInt(dato[0]);
                }
            }
            /*CallableStatement stmt = conn.prepareCall(SP_BUSCAR_VACANCIAS);
            stmt.setInt(1, _idConvocatoria);
            stmt.setInt(2, _plantel);
            rs = stmt.executeQuery();
            if (rs.next()) {
                total = rs.getInt("total");

            }*/
            //conn.close();
        } catch (Exception ex) {
            System.out.println(ex.toString());

        }
        return total;
    }
}
