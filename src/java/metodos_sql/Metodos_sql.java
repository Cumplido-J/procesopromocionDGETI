/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package metodos_sql;

import com.mysql.jdbc.Connection;
import java.io.FileReader;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.util.ArrayList;
import java.util.List;
import java.util.Properties;

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
    
    public static Connection conector() {
        String driver,user,pass,url;
        Properties p = new Properties();        
        conexion = null;
        try {
            p.load(new FileReader("C:/Users/David Reyna/Desktop/Repositorios/procesopromocion/src/conf/config.properties"));
            
            driver=p.getProperty("driver");
            user=p.getProperty("user");
            pass=p.getProperty("pass");
            url=p.getProperty("url");
            Class.forName(driver);
            conexion = (Connection) DriverManager.getConnection(url, user, pass);
            if (conexion != null) {
                System.out.println("conexion establecida");
            }
        } catch (Exception ex) {
            System.out.println("Error de conexion:"+ex.toString());
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
    
    private List convertir(ResultSet rs)
    {
        List<String[]> datos = null; 
        String[] tupla=null;
        try
        { 
            rs.last();
            ResultSetMetaData rsmd = rs.getMetaData(); 
            int numCols = rsmd.getColumnCount(); 
            datos=new ArrayList<String[]>();   
            rs.beforeFirst(); 
            while (rs.next())
            {
                tupla=new String[numCols];
                for (int i=0;i<numCols;i++)
                {
                    tupla[i]=rs.getString(i+1);
                }   
                datos.add(tupla);
            } 
        }
        catch(Exception e)
        {
            System.out.println(e.toString());
        }         
        return datos;
        
    }
    
    public List ejecutaSP(String sp){
        List<String[]> datos = new ArrayList<String[]>();
        String[] tupla;
        conexion = null;
        
        String buscar = "call "+sp+"();";
        conexion = conector();
        try {
            sentencia_preparada = conexion.prepareStatement(buscar);
            resultado = sentencia_preparada.executeQuery();
            datos=convertir(resultado);
            sentencia_preparada.close();
            conexion.close();
        } catch (Exception e) {
            System.out.println(e.toString());
        }
        return datos;
    }
    
    public List ejecutaSP(String sp,String[] parametros){
        List<String[]> datos = new ArrayList<String[]>();
        String[] tupla;
        conexion = null;
        String aux="";        
        for(String parametro:parametros){
            if(!parametro.equals("")){
                aux+="'"+parametro+"',";
            }else{
                aux+="NULL,";
            }
        }
        if(aux!=""){
            aux = aux.substring(0, aux.length() - 1);
        }          
        String buscar = "call "+sp+"("+aux+");";
        System.out.println(buscar);
        conexion = conector();
        try {
            sentencia_preparada = conexion.prepareStatement(buscar);
            resultado = sentencia_preparada.executeQuery();
            datos=convertir(resultado);            
            sentencia_preparada.close();
            conexion.close();
        } catch (Exception e) {
            System.out.println(e.toString());
        }
        return datos;
    }
}//fin clase metodos_sql
