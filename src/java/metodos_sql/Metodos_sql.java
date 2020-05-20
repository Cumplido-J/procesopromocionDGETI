/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package metodos_sql;

import com.mysql.jdbc.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.jsp.jstl.sql.Result;
import javax.swing.JOptionPane;

/**
 *
 * @author charl
 */
public class Metodos_sql {

    PreparedStatement sentencia_preparada;
    public static ResultSet resultado;
    public static String sql;
    public static int resultado_numero = 0;

//------------------------------------------------------- CONEXION BASE DE DATOS    
    private static Connection conexion;
    private static final String driver = "com.mysql.jdbc.Driver";
    private static final String user = "root";
    private static final String pass = "123456";
    //private static final String pass = "123456";
    private static final String url = "jdbc:mysql://localhost/usuarios";

    public static Connection conector() {
        conexion = null;
        try {
            Class.forName(driver);
            conexion = (Connection) DriverManager.getConnection(url, user, pass);
            if (conexion != null) {
                System.out.println("conexion establecida");
            }
        } catch (ClassNotFoundException | SQLException ex) {
            System.out.println("Error de conexion");
        }
        return conexion;
    }

//------------------------------------------------------- GUARDAR DATOS
    public int guardar(int id, String nombre, String apellido, String correo, String clave) {
        int resultado = 0;

        conexion = null;
        String guardar = "INSERT INTO categoria(id,nombre,apellido,correo,clave) VALUES(?,?,?,?,?)";
        conexion = conector();
        try {
            sentencia_preparada = conexion.prepareStatement(guardar);
            sentencia_preparada.setString(1, String.valueOf(id));
            sentencia_preparada.setString(2, nombre);
            sentencia_preparada.setString(3, apellido);
            sentencia_preparada.setString(4, correo);
            sentencia_preparada.setString(5, clave);
            resultado = sentencia_preparada.executeUpdate();
            sentencia_preparada.close();
            conexion.close();
        } catch (Exception ex) {
        }
        return resultado;
    }//fin metodo guardar

    //------------------------------------------------------- BUSCAR NOMBRE 
    public String buscar(String correo) {
        String nombre = null;
        conexion = null;
        String buscar = "SELECT nombre FROM categoria WHERE correo='" + correo + "'";
        conexion = conector();
        try {
            sentencia_preparada = conexion.prepareStatement(buscar);
            resultado = sentencia_preparada.executeQuery();
            if (resultado.next()) {
                nombre = resultado.getString("nombre");
            }
            conexion.close();
        } catch (Exception e) {

        }
        return nombre;
    }//fin metodo buscar
    
    
    
     //------------------------------------------------------- BUSCAR CLAVE 
    public String buscarclave(String correo) {
        String clave = null;
        conexion = null;
        String buscar = "SELECT clave FROM categoria WHERE correo='" + correo + "'";
        conexion = conector();
        try {
            sentencia_preparada = conexion.prepareStatement(buscar);
            resultado = sentencia_preparada.executeQuery();
            if (resultado.next()) {
                clave = resultado.getString("clave");
            }
            conexion.close();
        } catch (Exception e) {

        }
        return clave;
    }//fin metodo buscar

    //----------------------------------------------- BUSCAR USUARIO REGISTRADO
    public String buscarusuario(String correo, String clave) {
        String usuario = null;
        conexion = null;
        String buscar = "SELECT nombre,apellido,clave FROM categoria WHERE correo='" + correo + "' && clave='" + clave + "'";
        conexion = conector();
        try {
            sentencia_preparada = conexion.prepareStatement(buscar);
            resultado = sentencia_preparada.executeQuery();
            if (resultado.next()) {
                usuario = "USUARIO ENCONTRADO";
            } else {
                usuario = "USUARIO NO ENCONTRADO";
            }
            conexion.close();
        } catch (Exception e) {

        }
        return usuario;
    }

    
    
    //----------------------------------------------- BUSCAR CORREO REGISTRADO
    public String buscarcorreo(String correo) {
        String usuario = null;
        conexion = null;
        String buscar = "SELECT nombre,apellido,clave FROM categoria WHERE correo='" + correo + "'";
        conexion = conector();
        try {
            sentencia_preparada = conexion.prepareStatement(buscar);
            resultado = sentencia_preparada.executeQuery();
            if (resultado.next()) {
                usuario = "USUARIO ENCONTRADO";
            } else {
                usuario = "USUARIO NO ENCONTRADO";
            }
            conexion.close();
        } catch (Exception e) {

        }
        return usuario;
    }
    
}//fin clase metodos_sql
