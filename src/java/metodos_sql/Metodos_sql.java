/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package metodos_sql;

//import com.mysql.jdbc.Connection;
import com.sun.faces.el.ChainAwareVariableResolver;
import java.sql.Date;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
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

    //----------- CONEXION BASE DE DATOS WORKBENCH*    
    public static Connection conexion2;
    private static final String DRIVER2 = "com.mysql.jdbc.Driver";
    //private static final String driver2 = "org.gjt.mm.mysql.Driver";
    private static final String USER2 = "root";
    private static final String PASS2 = "1234567";
    private static final String URL2 = "jdbc:mysql://localhost/bdpromocion";

    public static Connection conector2() {
        conexion2 = null;
        try {
            Class.forName(DRIVER2);
            conexion2 = (Connection) DriverManager.getConnection(URL2 + "?useSSL=false", USER2, PASS2);
            if (conexion2 != null) {
                System.out.println("conexion establecida");
            }
        } catch (ClassNotFoundException | SQLException ex) {
            System.out.println("Error de conexion");
        }
        return conexion2;
    }

    //----------GUARDAR DATOS WORKBENCH, SERVLET CREAR CUENTA*
    public int guardar2(int id, String programa, String entidad, String plantel, String nombre, String primerApellido, String segundoApellido, String correo, String clave, String rfc, String telfijo, String telcel, String perfil, String consideraciones) {
        int resultado = 0;

        conexion2 = null;
        String guardar = "INSERT INTO usuario(id,programa,entidad,plantel,nombre,primerApellido,segundoApellido,correo,clave,curp,telfijo,telcel,perfil,consideraciones) VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
        conexion2 = conector2();
        try {
            sentencia_preparada = conexion2.prepareStatement(guardar);
            sentencia_preparada.setString(1, String.valueOf(id));
            sentencia_preparada.setString(2, programa);
            sentencia_preparada.setString(3, entidad);
            sentencia_preparada.setString(4, plantel);
            sentencia_preparada.setString(5, nombre);
            sentencia_preparada.setString(6, primerApellido);
            sentencia_preparada.setString(7, segundoApellido);
            sentencia_preparada.setString(8, correo);
            sentencia_preparada.setString(9, clave);
            sentencia_preparada.setString(10, rfc);
            sentencia_preparada.setString(11, telfijo);
            sentencia_preparada.setString(12, telcel);
            sentencia_preparada.setString(13, perfil);
//            sentencia_preparada.setString(14, null);
            sentencia_preparada.setString(14, consideraciones);
            resultado = sentencia_preparada.executeUpdate();
            sentencia_preparada.close();
            conexion2.close();
        } catch (Exception ex) {
        }
        return resultado;
    }//fin metodo guardar

    //------------------------------------------------------- GUARDAR DATOS WORKBENCH
    public int guardar3(int idUsuario, String telfijo, String telcel, String Consideracion) {
        int resultado = 0;
        Date fecha = new Date(20, 05, 31);
        conexion2 = null;

        String guardar = "INSERT INTO aspirantes(id,idUsuario,folio,idPlantelParticipacion,fijo,movil,Consideracion,idEscuelaEstudio,idCarrera,anioEgreso,idGradoAcademico,idModalidadTitulacion,anioTitulacion,cedula,activo,ingresoSubsistema,ingresoPlantel,idCategoria,fechaPlaza,idTipoNombramiento,horasFrenteGrupo,fechaUltimaPromocion,tipoUltimaPromocion,idCategoriaAspira,idPerfilRequerido,notaSancion,compatibilidad,horasOtroSubsistema,nivelCENNI,folioCENNI) VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
        conexion2 = conector2();
        try {
            sentencia_preparada = conexion2.prepareStatement(guardar);
            sentencia_preparada.setInt(1, 0);//int
            sentencia_preparada.setInt(2, 0);
            sentencia_preparada.setString(3, "");
            sentencia_preparada.setInt(4, 0);
            sentencia_preparada.setString(5, telfijo);
            sentencia_preparada.setString(6, telcel);
            sentencia_preparada.setString(7, Consideracion);
            sentencia_preparada.setInt(8, 0);
            sentencia_preparada.setInt(9, 0);
            sentencia_preparada.setInt(10, 0);
            sentencia_preparada.setInt(11, 0);
            sentencia_preparada.setInt(12, 0);
            sentencia_preparada.setInt(13, 0);
            sentencia_preparada.setString(14, "");
            sentencia_preparada.setString(15, "S");  //char
            sentencia_preparada.setDate(16, fecha);
            sentencia_preparada.setDate(17, fecha);
            sentencia_preparada.setInt(18, 0);
            sentencia_preparada.setDate(19, fecha);
            sentencia_preparada.setInt(20, 0);
            sentencia_preparada.setInt(21, 0);
            sentencia_preparada.setDate(22, fecha);
            sentencia_preparada.setString(23, "SS");//char
            sentencia_preparada.setInt(24, 0);
            sentencia_preparada.setInt(25, 0);
            sentencia_preparada.setString(26, "N");//char1
            sentencia_preparada.setString(27, "S");//char1
            sentencia_preparada.setInt(28, 0);
            sentencia_preparada.setInt(29, 0);
            sentencia_preparada.setString(30, "");
            resultado = sentencia_preparada.executeUpdate();
            sentencia_preparada.close();
            conexion2.close();
        } catch (Exception ex) {
        }
        return resultado;
    }//fin metodo guardar 

    //----------GUARDAR DATOS, SERVLET AGREGAR USUARIO*
    public int guardar4(int id, String entidad, String plantel, String usuario, String nombre, String primerApellido, String segundoApellido, String telfijo, String telcel, String correo, String clave, String perfil, String permisos) {
        int resultado = 0;

        conexion2 = null;
        String guardar = "INSERT INTO usuario(id,programa,entidad,plantel,nombre,primerApellido,segundoApellido,correo,clave,curp,telfijo,telcel,perfil,consideraciones) VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
        conexion2 = conector2();
        try {
            sentencia_preparada = conexion2.prepareStatement(guardar);
            sentencia_preparada.setString(1, String.valueOf(id));
            sentencia_preparada.setString(2, null);
            sentencia_preparada.setString(3, entidad);
            sentencia_preparada.setString(4, plantel);
            sentencia_preparada.setString(5, nombre);
            sentencia_preparada.setString(6, primerApellido);
            sentencia_preparada.setString(7, segundoApellido);
            sentencia_preparada.setString(8, correo);
            sentencia_preparada.setString(9, clave);
            sentencia_preparada.setString(10, usuario);
            sentencia_preparada.setString(11, telfijo);
            sentencia_preparada.setString(12, telcel);
            sentencia_preparada.setString(13, perfil);
//            sentencia_preparada.setString(14, permisos);
            sentencia_preparada.setString(14, null);

            resultado = sentencia_preparada.executeUpdate();
            sentencia_preparada.close();
            conexion2.close();
        } catch (Exception ex) {
        }
        return resultado;
    }//fin metodo guardar

    //----------- GUARDAR VACANTES, SERVLET AGREGAR VACANTES*
    public int guardar5(int id, String entidad, String plantel, String plaza, String cantidad, String tipo, String jornada, String grado_academico, String vacancia1) {
        int resultado = 0;
        conexion2 = null;

        //String guardar = "INSERT INTO vacancia(id,idPlantel,idCategoria,idCarrera,idConvocatoria,entidad,plantel,plaza,tipocategoria,jornada,grado,vacancia) VALUES(?,?,?,?,?,?,?,?,?,?,?,?)";
        String guardar = "INSERT INTO vacancia(id,entidad,plantel,plaza,cantidadplazas,tipocategoria,jornada,grado,vacancia) VALUES(?,?,?,?,?,?,?,?,?)";
        conexion2 = conector2();
        try {
            sentencia_preparada = conexion2.prepareStatement(guardar);
            sentencia_preparada.setString(1, String.valueOf(id));
//            sentencia_preparada.setInt(2, 2);
//            sentencia_preparada.setInt(3, 4);
//            sentencia_preparada.setInt(4, 1);
//            sentencia_preparada.setInt(5, 1);
            sentencia_preparada.setString(2, entidad);
            sentencia_preparada.setString(3, plantel);
            sentencia_preparada.setString(4, plaza);
            sentencia_preparada.setString(5, cantidad);
            sentencia_preparada.setString(6, tipo);
            sentencia_preparada.setString(7, jornada);
            sentencia_preparada.setString(8, grado_academico);
            sentencia_preparada.setString(9, vacancia1);
            resultado = sentencia_preparada.executeUpdate();
            sentencia_preparada.close();
            conexion2.close();
        } catch (Exception ex) {
        }
        return resultado;
    }//fin metodo guardar 

    //----------- GUARDAR PERMISOS, SERVLET AGREGAR USUARIO*
    public int guardar6(int id, int idusuario, int idpermiso) {
        int resultado = 0;
        conexion2 = null;

        String guardar = "INSERT INTO usuariopermiso(id,idUsuario,idPermiso) VALUES(?,?,?)";

        conexion2 = conector2();
        try {
            sentencia_preparada = conexion2.prepareStatement(guardar);
            sentencia_preparada.setString(1, String.valueOf(id));
            sentencia_preparada.setInt(2, idusuario);
            sentencia_preparada.setInt(3, idpermiso);

            resultado = sentencia_preparada.executeUpdate();
            sentencia_preparada.close();
            conexion2.close();
        } catch (Exception ex) {
        }
        return resultado;
    }//fin metodo guardar 

    //----------- GUARDAR CONVOCATORIA, SERVLET GIARDAR CONVOCATORIA*
    public int guardar7(int id, int logosems1, int logouemstis1, String textarea1, Date publicacion1, Date periodo_registro_inicio1, Date periodo_registro_fin1, Date periodo_valoracion_inicio1, Date periodo_valoracion_fin1, Date periodo_dictaminacion_inicio1, Date periodo_dictaminacion_fin1, Date publicacion_resultados1) {
        int resultado = 0;
        conexion2 = null;
        Date fecha = new Date(20, 05, 31);
        String guardar = "INSERT INTO convocatoria(id,idLogoSEMS,idLogoSubsistema,nombre,publicacion,inicioRegistro,finRegistro,inicioValoracion,finValoracion,inicioDictaminacion,finDictaminacion,resultados) VALUES(?,?,?,?,?,?,?,?,?,?,?,?)";
        //String guardar = "INSERT INTO convocatoria(id,nombre,publicacion,inicioRegistro,finRegistro,inicioValoracion,finValoracion,inicioDictaminacion,finDictaminacion,resultados) VALUES(?,?,?,?,?,?,?,?,?,?)";

        conexion2 = conector2();
        try {
            sentencia_preparada = conexion2.prepareStatement(guardar);
            sentencia_preparada.setString(1, String.valueOf(id));
            sentencia_preparada.setInt(2, 0);
            sentencia_preparada.setInt(3, 0);
            sentencia_preparada.setString(4, textarea1);
            sentencia_preparada.setDate(5, publicacion1);
            sentencia_preparada.setDate(6, periodo_registro_inicio1);
            sentencia_preparada.setDate(7, periodo_registro_fin1);
            sentencia_preparada.setDate(8, periodo_valoracion_inicio1);
            sentencia_preparada.setDate(9, periodo_valoracion_fin1);
            sentencia_preparada.setDate(10, periodo_dictaminacion_inicio1);
            sentencia_preparada.setDate(11, periodo_dictaminacion_fin1);
            sentencia_preparada.setDate(12, publicacion_resultados1);
            resultado = sentencia_preparada.executeUpdate();
            sentencia_preparada.close();
            conexion2.close();
        } catch (Exception ex) {
        }
        return resultado;
    }//fin metodo guardar 

    //----------BUSCAR NOMBRE REGISTRADO, SERVLET INICIO SESION* 
    public String buscar(String rfc) {
        String nombre = null;
        conexion2 = null;
        String buscar = "SELECT nombre FROM usuario WHERE curp='" + rfc + "'";
        conexion2 = conector2();
        try {
            sentencia_preparada = conexion2.prepareStatement(buscar);
            resultado = sentencia_preparada.executeQuery();
            if (resultado.next()) {
                nombre = resultado.getString("nombre");
            }
            conexion2.close();
        } catch (Exception e) {

        }
        return nombre;
    }//fin metodo buscar

    //----------BUSCAR RFC ADMINISTRADOR REGISTRADO, SERVLET INICIO SESION ADMINISTRADOR* 
    public String[] buscaradmin2(String rfc) {
        String nombre[] = new String[5];
        conexion2 = null;
        String buscar = "SELECT * FROM usuario WHERE (perfil='A' || perfil='S') && curp='" + rfc + "'";
        conexion2 = conector2();
        try {
            sentencia_preparada = conexion2.prepareStatement(buscar);
            resultado = sentencia_preparada.executeQuery();
            if (resultado.next()) {
                nombre[0] = resultado.getString("entidad");
                nombre[1] = resultado.getString("plantel");
                nombre[2] = resultado.getString("nombre");
                nombre[3] = resultado.getString("curp");
                nombre[4] = resultado.getString("id");
            }
            conexion2.close();
        } catch (Exception e) {

        }
        return nombre;
    }//fin metodo buscar

    //----------BUSCAR RFC VACANCIA REGISTRADO, SERVLET INICIO SESION VACANCIA*  
    public String buscarvacancia(String rfc) {
        String nombre = null;
        conexion2 = null;
        String buscar = "SELECT nombre FROM usuario WHERE rfc='" + rfc + "'";
        conexion2 = conector2();
        try {
            sentencia_preparada = conexion2.prepareStatement(buscar);
            resultado = sentencia_preparada.executeQuery();
            if (resultado.next()) {
                nombre = resultado.getString("nombre");
            }
            conexion2.close();
        } catch (Exception e) {

        }
        return nombre;
    }//fin metodo buscar

    //----------BUSCAR CORREO REGISTRADO, SERVLET RECUEPRAR CLAVE* 
    public String buscarclave(String correo) {
        String clave = null;
        conexion2 = null;
        String buscar = "SELECT clave FROM usuario WHERE correo='" + correo + "'";
        conexion2 = conector2();
        try {
            sentencia_preparada = conexion2.prepareStatement(buscar);
            resultado = sentencia_preparada.executeQuery();
            if (resultado.next()) {
                clave = resultado.getString("clave");
            }
            conexion2.close();
        } catch (Exception e) {

        }
        return clave;
    }//fin metodo buscar

    //----------RECUPERAR CLAVE ADMINISTRADOR, SERVLET RECUPERAR CLAVE ADMINISTRADOR*
    public String buscarclaveadmin(String correo) {
        String clave = null;
        conexion2 = null;
        String buscar = "SELECT clave FROM usuario WHERE correo='" + correo + "'";
        conexion2 = conector2();
        try {
            sentencia_preparada = conexion2.prepareStatement(buscar);
            resultado = sentencia_preparada.executeQuery();
            if (resultado.next()) {
                clave = resultado.getString("clave");
            }
            conexion2.close();
        } catch (Exception e) {

        }
        return clave;
    }//fin metodo buscar

    //----------BUSCAR USUARIO REGISTRADO, SERVLET INICIO SESION* 
    public String buscarusuario(String rfc, String clave) {
        String usuario = null;
        conexion2 = null;
        String buscar = "SELECT nombre,primerApellido,clave FROM usuario WHERE (perfil='D' || perfil='S') && curp='" + rfc + "' && clave='" + clave + "'";
        conexion2 = conector2();
        try {
            sentencia_preparada = conexion2.prepareStatement(buscar);
            resultado = sentencia_preparada.executeQuery();
            if (resultado.next()) {
                usuario = "USUARIO ENCONTRADO";
            } else {
                usuario = "USUARIO NO ENCONTRADO";
            }
            conexion2.close();
        } catch (Exception e) {

        }
        return usuario;
    }

    //----------BUSCAR ADMINISTRADOR REGISTRADO, SERVLET INICIO DE SESION ADMINISTRADOR*
    public String buscaradmin(String rfc, String clave) {
        String usuario = null;
        conexion2 = null;
        String buscar = "SELECT nombre,primerApellido,clave FROM usuario WHERE (perfil='A' || perfil='S') && curp='" + rfc + "' && clave='" + clave + "'";
        conexion2 = conector2();
        try {
            sentencia_preparada = conexion2.prepareStatement(buscar);
            resultado = sentencia_preparada.executeQuery();
            if (resultado.next()) {
                usuario = "USUARIO ENCONTRADO";
            } else {
                usuario = "USUARIO NO ENCONTRADO";
            }
            conexion2.close();
        } catch (Exception e) {

        }
        return usuario;
    }

    //----------BUSCAR RFC Y CLAVE VACANCIA, SERVLET INICIO SESION VACANCIA* 
    public String buscarvacancia(String rfc, String clave) {
        String usuario = null;
        conexion2 = null;
        String buscar = "SELECT nombre,primerApellido,clave FROM usuario WHERE rfc='" + rfc + "' && clave='" + clave + "'";
        conexion2 = conector2();
        try {
            sentencia_preparada = conexion2.prepareStatement(buscar);
            resultado = sentencia_preparada.executeQuery();
            if (resultado.next()) {
                usuario = "USUARIO ENCONTRADO";
            } else {
                usuario = "USUARIO NO ENCONTRADO";
            }
            conexion2.close();
        } catch (Exception e) {

        }
        return usuario;
    }

    //----------BUSCAR CORREO REGISTRADO, SERVLET RECUPERAR CLAVE* 
    public String buscarcorreo(String correo) {
        String usuario = null;
        conexion2 = null;
        String buscar = "SELECT nombre,primerApellido,clave FROM usuario WHERE correo='" + correo + "'";
        conexion2 = conector2();
        try {
            sentencia_preparada = conexion2.prepareStatement(buscar);
            resultado = sentencia_preparada.executeQuery();
            if (resultado.next()) {
                usuario = "USUARIO ENCONTRADO";
            } else {
                usuario = "USUARIO NO ENCONTRADO";
            }
            conexion2.close();
        } catch (Exception e) {

        }
        return usuario;
    }

    //----------BUSCAR CORREO REGISTRADO, SERVLET RECUEPRAR CLAVE ADMINISTRADOR*
    public String buscarcorreoadmin(String correo) {
        String usuario = null;
        conexion2 = null;
        String buscar = "SELECT nombre,primerApellido,clave FROM usuario WHERE perfil='A' && correo='" + correo + "'";
        conexion2 = conector2();
        try {
            sentencia_preparada = conexion2.prepareStatement(buscar);
            resultado = sentencia_preparada.executeQuery();
            if (resultado.next()) {
                usuario = "USUARIO ENCONTRADO";
            } else {
                usuario = "USUARIO NO ENCONTRADO";
            }
            conexion2.close();
        } catch (Exception e) {

        }
        return usuario;
    }

    //-------BUSCAR PERMISOS, SERVLET INICIO DE SESION ADMINISRADOR*
    public String[] buscarpermisos(int id_usuario) {
        String permisos[] = new String[5];
        int i = 0;
        ResultSet rs = null;
        conexion2 = null;
        String buscar = "SELECT * FROM usuariopermiso WHERE idUsuario='" + id_usuario + "'";

        conexion2 = conector2();
        try {
            sentencia_preparada = conexion2.prepareStatement(buscar);
            resultado = sentencia_preparada.executeQuery();

            rs = mostrar_usuarios(buscar);
            while (rs.next()) {
                permisos[i] = resultado.getString("idPermiso");
                ++i;
            }

            conexion2.close();
        } catch (Exception e) {

        }
        return permisos;
    }

    //--------------------------------------mostrar informacion a los combobox*
    public ResultSet mostrar(String buscar) {
        conexion2 = null;

        conexion2 = conector2();
        try {
            sentencia_preparada = conexion2.prepareStatement(buscar);
            resultado = sentencia_preparada.executeQuery();

        } catch (Exception e) {

        }
        return resultado;
    }

    //--------------------------------------mostrar informacion a los combobox*
    public ResultSet mostrar_usuarios(String buscar) {
        conexion2 = null;

        conexion2 = conector2();
        try {
            sentencia_preparada = conexion2.prepareStatement(buscar);
            resultado = sentencia_preparada.executeQuery();

        } catch (Exception e) {

        }
        return resultado;
    }

    //-----------BUSCAR NOMBRE, SERVLET AGREGAR USUARIO* 
    public int buscarid() {
        int id = 0;
        conexion2 = null;
        String buscar = "SELECT MAX(id) AS id FROM usuario";
        conexion2 = conector2();
        try {
            sentencia_preparada = conexion2.prepareStatement(buscar);
            resultado = sentencia_preparada.executeQuery();
            if (resultado.next()) {
                id = resultado.getInt("id");
            }
            conexion2.close();
        } catch (Exception e) {

        }
        return id;
    }//fin metodo buscar
    
    
    
     //-----------BUSCAR RFC PARA INICIO DE SESION
    public int buscarId(String rfc) {
        int id = 0;
        conexion2 = null;
        String buscar = "SELECT id FROM usuario WHERE (perfil='A' || perfil='S') && curp='"+rfc+"'";
        conexion2 = conector2();
        try {
            sentencia_preparada = conexion2.prepareStatement(buscar);
            resultado = sentencia_preparada.executeQuery();
            if (resultado.next()) {
                id = resultado.getInt("id");
            }
            conexion2.close();
        } catch (Exception e) {

        }
        return id;
    }//fin metodo buscar
    
    
    public String buscarentidad(String id_entidad) {
        String entidad = "";
        conexion2 = null;
        conexion2 = conector2();
        try {
            sentencia_preparada = conexion2.prepareStatement(id_entidad);
            resultado = sentencia_preparada.executeQuery();
            if (resultado.next()) {
                entidad = resultado.getString("entidad");
            }
            conexion2.close();
        } catch (Exception e) {

        }
        return entidad;
    }//fin metodo buscar
    
    
    public String buscarplantel(String id_plantel) {
        String plantel = "";
        conexion2 = null;
        conexion2 = conector2();
        try {
            sentencia_preparada = conexion2.prepareStatement(id_plantel);
            resultado = sentencia_preparada.executeQuery();
            if (resultado.next()) {
                plantel = resultado.getString("plantel");
            }
            conexion2.close();
        } catch (Exception e) {

        }
        return plantel;
    }//fin metodo buscar

    public String buscartipocategoria(String id_tipo) {
        String tipo = "";
        conexion2 = null;
        conexion2 = conector2();
        try {
            sentencia_preparada = conexion2.prepareStatement(id_tipo);
            resultado = sentencia_preparada.executeQuery();
            if (resultado.next()) {
                tipo = resultado.getString("categoria");
            }
            conexion2.close();
        } catch (Exception e) {

        }
        return tipo;
    }//fin metodo buscar
    
    public String buscarjornada(String id_jornada) {
        String jornada = "";
        conexion2 = null;
        conexion2 = conector2();
        try {
            sentencia_preparada = conexion2.prepareStatement(id_jornada);
            resultado = sentencia_preparada.executeQuery();
            if (resultado.next()) {
                jornada = resultado.getString("jornada");
            }
            conexion2.close();
        } catch (Exception e) {

        }
        return jornada;
    }//fin metodo buscar
    
    
}//fin clase metodos_sql
