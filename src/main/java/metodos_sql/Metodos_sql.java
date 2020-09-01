/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package metodos_sql;

import java.io.FileReader;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.util.ArrayList;
import java.util.List;
import java.util.Properties;
import java.sql.Date;
import java.sql.Connection;

/**
 *
 * @author charl
 */
public class Metodos_sql {

    PreparedStatement sentencia_preparada;
    public static ResultSet resultado;
    public static String sql;
    public static int resultado_numero = 0;

    public Metodos_sql() {
    }

//------------------------------------------------------- CONEXION BASE DE DATOS    
    private static Connection conexion;

    public static Connection conector() {
        String driver, user, pass, url;
//        Properties p = new Properties();        
        conexion = null;
        try {
//            p.load(new FileReader("C:/ArchivosPromocion/config.properties"));
//            
//            driver=p.getProperty("driver");
//            user=p.getProperty("user");
//            pass=p.getProperty("pass");
//            url=p.getProperty("url");            
            Class.forName("com.mysql.cj.jdbc.Driver");
            conexion = (Connection) DriverManager.getConnection("jdbc:mysql://localhost/bdpromocion?useTimeZone=true&serverTimezone=UTC&autoReconnect=true&useSSL=false", "root", "1234567");

            if (conexion != null) {
                System.out.println("conexion establecida");
            }
        } catch (Exception ex) {
            System.out.println("Error de conexion:" + ex.toString());
        }
        return conexion;
    }

    //----------GUARDAR DATOS WORKBENCH, SERVLET CREAR CUENTA*
    public int guardar2(int id, String programa, String entidad, String plantel, String nombre, String primerApellido, String segundoApellido, String correo, String clave, String rfc, String telfijo, String telcel, String perfil, String consideraciones) {
        int resultado = 0;

        conexion = null;
        String guardar = "INSERT INTO usuario(id,programa,entidad,plantel,nombre,primerApellido,segundoApellido,correo,clave,curp,telfijo,telcel,perfil,consideraciones) VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
        conexion = conector();
        try {
            sentencia_preparada = conexion.prepareStatement(guardar);
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
            sentencia_preparada.setString(14, consideraciones);
            resultado = sentencia_preparada.executeUpdate();
            sentencia_preparada.close();
            conexion.close();
        } catch (Exception ex) {
            System.out.println(ex.toString());
        }
        return resultado;
    }//fin metodo guardar

    //------------------------------------------------------- GUARDAR DATOS WORKBENCH
    public int guardar3(int idUsuario, String telfijo, String telcel, String Consideracion) {
        int resultado = 0;
        Date fecha = new Date(20, 05, 31);
        conexion = null;

        String guardar = "INSERT INTO aspirantes(id,idUsuario,folio,idPlantelParticipacion,fijo,movil,Consideracion,idEscuelaEstudio,idCarrera,anioEgreso,idGradoAcademico,idModalidadTitulacion,anioTitulacion,cedula,activo,ingresoSubsistema,ingresoPlantel,idCategoria,fechaPlaza,idTipoNombramiento,horasFrenteGrupo,fechaUltimaPromocion,tipoUltimaPromocion,idCategoriaAspira,idPerfilRequerido,notaSancion,compatibilidad,horasOtroSubsistema,nivelCENNI,folioCENNI) VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
        conexion = conector();
        try {
            sentencia_preparada = conexion.prepareStatement(guardar);
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
            conexion.close();
        } catch (Exception ex) {
            System.out.println(ex.toString());
        }
        return resultado;
    }//fin metodo guardar 

    //----------GUARDAR DATOS, SERVLET AGREGAR USUARIO*
    public int guardar4(int id, String entidad, String plantel, String nombre, String primerApellido, String segundoApellido, String correo, String clave, String usuario, String telfijo, String telcel, String perfil, String nivel) {
        int resultado = 0;

        conexion = null;
        String guardar = "INSERT INTO usuario(id,programa,entidad,plantel,nombre,primerApellido,segundoApellido,correo,clave,curp,telfijo,telcel,perfil,consideraciones,nacional) VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
        conexion = conector();
        try {
            sentencia_preparada = conexion.prepareStatement(guardar);
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
            sentencia_preparada.setString(15, nivel);

            resultado = sentencia_preparada.executeUpdate();
            sentencia_preparada.close();
            conexion.close();
        } catch (Exception ex) {
        }
        return resultado;
    }//fin metodo guardar

    //----------- GUARDAR VACANTES, SERVLET AGREGAR VACANTES*
    public int guardar5(String entidad, String plantel, String plaza, String cantidad, String tipo, String jornada, String grado_academico, String vacancia1, String convocatoria) {
        int resultado = 0;
        conexion = null;

        //String guardar = "INSERT INTO vacancia(id,idPlantel,idCategoria,idCarrera,idConvocatoria,entidad,plantel,plaza,tipocategoria,jornada,grado,vacancia) VALUES(?,?,?,?,?,?,?,?,?,?,?,?)";
        String guardar = "INSERT INTO vacancia(entidad,plantel,plaza,cantidadplazas,tipocategoria,jornada,vacancia,idConvocatoria) VALUES(?,?,?,?,?,?,?,?)";
        conexion = conector();
        try {
            sentencia_preparada = conexion.prepareStatement(guardar);
            //sentencia_preparada.setString(1, String.valueOf(id));
//            sentencia_preparada.setInt(2, 2);
//            sentencia_preparada.setInt(3, 4);
//            sentencia_preparada.setInt(4, 1);
//            sentencia_preparada.setInt(5, 1);
            sentencia_preparada.setString(1, entidad);
            sentencia_preparada.setString(2, plantel);
            sentencia_preparada.setString(3, plaza);
            sentencia_preparada.setString(4, cantidad);
            sentencia_preparada.setString(5, tipo);
            sentencia_preparada.setString(6, jornada);
            sentencia_preparada.setString(7, vacancia1);
            sentencia_preparada.setString(8, convocatoria);
            resultado = sentencia_preparada.executeUpdate();
            sentencia_preparada.close();
            conexion.close();
        } catch (Exception ex) {
            System.out.println(ex.toString());
        }
        return resultado;
    }//fin metodo guardar 

    //----------- GUARDAR PERMISOS, SERVLET AGREGAR USUARIO*
    public int guardar6(int id, int idusuario, int idpermiso) {
        int resultado = 0;
        conexion = null;

        String guardar = "INSERT INTO usuariopermiso(id,idUsuario,idPermiso) VALUES(?,?,?)";

        conexion = conector();
        try {
            sentencia_preparada = conexion.prepareStatement(guardar);
            sentencia_preparada.setString(1, String.valueOf(id));
            sentencia_preparada.setInt(2, idusuario);
            sentencia_preparada.setInt(3, idpermiso);

            resultado = sentencia_preparada.executeUpdate();
            sentencia_preparada.close();
            conexion.close();
        } catch (Exception ex) {
            System.out.println(ex.toString());
        }
        return resultado;
    }//fin metodo guardar 

    //----------- GUARDAR CONVOCATORIA, SERVLET GIARDAR CONVOCATORIA*
    public int guardar7(Date publicacion1, Date periodo_registro_inicio1, Date periodo_registro_fin1, Date periodo_valoracion_inicio1, Date periodo_valoracion_fin1, Date periodo_dictaminacion_inicio1, Date periodo_dictaminacion_fin1, Date publicacion_resultados1, String pla1, String programa, String estatus) {
        int resultado = 0;
        conexion = null;
        String guardar = "INSERT INTO convocatoria(idPrograma,publicacion,inicioRegistro,finRegistro,inicioValoracion,finValoracion,inicioDictaminacion,finDictaminacion,resultados,idPlantel,estatus) VALUES(?,?,?,?,?,?,?,?,?,?,?)";

        conexion = conector();
        try {
            sentencia_preparada = conexion.prepareStatement(guardar);
            sentencia_preparada.setInt(1, Integer.parseInt(programa));
            sentencia_preparada.setDate(2, publicacion1);
            sentencia_preparada.setDate(3, periodo_registro_inicio1);
            sentencia_preparada.setDate(4, periodo_registro_fin1);
            sentencia_preparada.setDate(5, periodo_valoracion_inicio1);
            sentencia_preparada.setDate(6, periodo_valoracion_fin1);
            sentencia_preparada.setDate(7, periodo_dictaminacion_inicio1);
            sentencia_preparada.setDate(8, periodo_dictaminacion_fin1);
            sentencia_preparada.setDate(9, publicacion_resultados1);
            sentencia_preparada.setInt(10, Integer.parseInt(pla1));
            sentencia_preparada.setString(11, estatus);
            resultado = sentencia_preparada.executeUpdate();
            sentencia_preparada.close();
            conexion.close();
        } catch (Exception ex) {
            System.out.println(ex.toString());
        }
        return resultado;
    }//fin metodo guardar 

    //----------BUSCAR NOMBRE REGISTRADO, SERVLET INICIO SESION* 
    public String buscar(String rfc) {
        String nombre = null;
        conexion = null;
        String buscar = "SELECT nombre FROM usuario WHERE curp='" + rfc + "'";
        conexion = conector();
        try {
            sentencia_preparada = conexion.prepareStatement(buscar);
            resultado = sentencia_preparada.executeQuery();
            if (resultado.next()) {
                nombre = resultado.getString("nombre");
            }
            conexion.close();
        } catch (Exception e) {
            System.out.println(e.toString());

        }
        return nombre;
    }//fin metodo buscar

    //----------BUSCAR RFC ADMINISTRADOR REGISTRADO, SERVLET INICIO SESION ADMINISTRADOR* 
    public String[] buscaradmin2(String rfc) {
        String nombre[] = new String[6];
        conexion = null;
        String buscar = "SELECT * FROM usuario WHERE curp='" + rfc + "'";
        conexion = conector();
        try {
            sentencia_preparada = conexion.prepareStatement(buscar);
            resultado = sentencia_preparada.executeQuery();
            if (resultado.next()) {
                nombre[0] = resultado.getString("entidad");
                nombre[1] = resultado.getString("plantel");
                nombre[2] = resultado.getString("nombre");
                nombre[3] = resultado.getString("curp");
                nombre[4] = resultado.getString("id");
                nombre[5] = resultado.getString("perfil");
            }
            conexion.close();
        } catch (Exception e) {

        }
        return nombre;
    }//fin metodo buscar

    //----------BUSCAR RFC VACANCIA REGISTRADO, SERVLET INICIO SESION VACANCIA*  
    public String buscarvacancia(String rfc) {
        String nombre = null;
        conexion = null;
        String buscar = "SELECT nombre FROM usuario WHERE rfc='" + rfc + "'";
        conexion = conector();
        try {
            sentencia_preparada = conexion.prepareStatement(buscar);
            resultado = sentencia_preparada.executeQuery();
            if (resultado.next()) {
                nombre = resultado.getString("nombre");
            }
            conexion.close();
        } catch (Exception ex) {
            System.out.println(ex.toString());

        }
        return nombre;
    }//fin metodo buscar

    //----------BUSCAR RFC PARA VER SI ESTA REGISTRADO, SERVLET INICIO DE SESION ADMINISTRADOR*
    public String buscar_rfc(String rfc) {
        String usuario = null;
        conexion = null;
        String buscar = "SELECT * FROM usuario WHERE curp='" + rfc + "'";
        conexion = conector();
        try {
            sentencia_preparada = conexion.prepareStatement(buscar);
            resultado = sentencia_preparada.executeQuery();
            if (resultado.next()) {
                usuario = "RFC ENCONTRADO";
            } else {
                usuario = "RFC NO ENCONTRADO";
            }
            conexion.close();
        } catch (Exception e) {

        }
        return usuario;
    }

    //----------BUSCAR USUARIO Y CLAVE PARA VER SI ESTA REGISTRADO, SERVLET INICIO DE SESION ADMINISTRADOR*
    public String[] buscar_clave(String rfc, String clave) {
        String usuario[] = new String[3];//AGREGAR
        conexion = null;
        String buscar = "SELECT * FROM usuario WHERE curp='" + rfc + "' && clave='" + clave + "'";
        conexion = conector();
        try {
            sentencia_preparada = conexion.prepareStatement(buscar);
            resultado = sentencia_preparada.executeQuery();
            if (resultado.next()) {
                usuario[0] = "USUARIO ENCONTRADO";
                usuario[1] = resultado.getString("id");
                usuario[2] = resultado.getString("nacional");//AGREGAR
            } else {
                usuario[0] = "USUARIO NO ENCONTRADO";
            }
            conexion.close();
        } catch (Exception e) {

        }
        return usuario;
    }

    //----------BUSCAR CORREO REGISTRADO, SERVLET RECUEPRAR CLAVE* 
    public String buscarclave(String correo) {
        String clave = null;
        conexion = null;
        String buscar = "SELECT clave FROM usuario WHERE correo='" + correo + "'";
        conexion = conector();
        try {
            sentencia_preparada = conexion.prepareStatement(buscar);
            resultado = sentencia_preparada.executeQuery();
            if (resultado.next()) {
                clave = resultado.getString("clave");
            }
            conexion.close();
        } catch (Exception ex) {
            System.out.println(ex.toString());

        }
        return clave;
    }//fin metodo buscar

    //----------RECUPERAR CLAVE ADMINISTRADOR, SERVLET RECUPERAR CLAVE ADMINISTRADOR*
    public String buscarclaveadmin(String correo) {
        String clave = null;
        conexion = null;
        String buscar = "SELECT clave FROM usuario WHERE correo='" + correo + "'";
        System.out.println(buscar);
        conexion = conector();
        try {
            sentencia_preparada = conexion.prepareStatement(buscar);
            resultado = sentencia_preparada.executeQuery();
            if (resultado.next()) {
                clave = resultado.getString("clave");
            }
            conexion.close();
        } catch (Exception e) {
            System.out.println(e.toString());

        }
        return clave;
    }//fin metodo buscar

    //----------BUSCAR USUARIO REGISTRADO, SERVLET INICIO SESION* 
    public String buscarusuario(String rfc, String clave) {
        String usuario = null;
        conexion = null;
        String buscar = "SELECT nombre,primerApellido,clave FROM usuario WHERE (perfil='D' || perfil='S') && curp='" + rfc + "' && clave='" + clave + "'";
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
            System.out.println(e.toString());
        }
        return usuario;
    }

    //----------BUSCAR ADMINISTRADOR REGISTRADO, SERVLET INICIO DE SESION ADMINISTRADOR*
    public String buscaradmin(String rfc, String clave) {
        String usuario = null;
        conexion = null;

        String buscar = "SELECT nombre,primerApellido,clave FROM usuario WHERE (perfil='A' || perfil='S') && curp='" + rfc + "' && clave='" + clave + "'";
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
        } catch (Exception ex) {
            System.out.println(ex.toString() + "NO HAY CONEXION");

        }
        return usuario;
    }

    //----------BUSCAR RFC Y CLAVE VACANCIA, SERVLET INICIO SESION VACANCIA* 
    public String buscarvacancia(String rfc, String clave) {
        String usuario = null;
        conexion = null;
        String buscar = "SELECT nombre,primerApellido,clave FROM usuario WHERE rfc='" + rfc + "' && clave='" + clave + "'";
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
        } catch (Exception ex) {
            System.out.println(ex.toString());

        }
        return usuario;
    }

    //----------BUSCAR CORREO REGISTRADO, SERVLET RECUPERAR CLAVE* 
    public String buscarcorreo(String correo) {
        String usuario = null;
        conexion = null;
        String buscar = "SELECT nombre,primerApellido,clave FROM usuario WHERE correo='" + correo + "'";
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
        } catch (Exception ex) {
            System.out.println(ex.toString());

        }
        return usuario;
    }

    //----------BUSCAR CORREO REGISTRADO, SERVLET RECUEPRAR CLAVE ADMINISTRADOR*
    public String buscarcorreoadmin(String correo) {
        String usuario = null;
        conexion = null;
        String buscar = "SELECT nombre,primerApellido,clave FROM usuario WHERE perfil='A' && correo='" + correo + "'";
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
        } catch (Exception ex) {
            System.out.println(ex.toString());

        }
        return usuario;
    }

    //-------BUSCAR PERMISOS, SERVLET INICIO DE SESION ADMINISRADOR*
    public String[] buscarpermisos(int id_usuario) {
        String permisos[] = new String[5];
        int i = 0;
        ResultSet rs = null;
        conexion = null;
        String buscar = "SELECT * FROM usuariopermiso WHERE idUsuario='" + id_usuario + "'";
        //System.out.println(buscar);
        conexion = conector();
        try {
            sentencia_preparada = conexion.prepareStatement(buscar);
            resultado = sentencia_preparada.executeQuery();

            rs = mostrar_usuarios(buscar);
            while (rs.next()) {
                permisos[i] = resultado.getString("idPermiso");
                ++i;
            }

            conexion.close();
        } catch (Exception ex) {
            System.out.println(ex.toString());

        }
        return permisos;
    }

    //--------------------------------------mostrar informacion a los combobox*
    public ResultSet mostrar(String buscar) {
        conexion = null;

        conexion = conector();
        try {
            sentencia_preparada = conexion.prepareStatement(buscar);
            resultado = sentencia_preparada.executeQuery();

        } catch (Exception ex) {
            System.out.println(ex.toString());

        }
        return resultado;
    }

    //--------------------------------------mostrar informacion a los combobox*
    public ResultSet mostrar_usuarios(String buscar) {
        conexion = null;

        conexion = conector();
        try {
            sentencia_preparada = conexion.prepareStatement(buscar);
            resultado = sentencia_preparada.executeQuery();

        } catch (Exception ex) {
            System.out.println(ex.toString());

        }
        return resultado;
    }

    //-----------BUSCAR NOMBRE, SERVLET AGREGAR USUARIO* 
    public int buscarid() {
        int id = 0;
        conexion = null;
        String buscar = "SELECT MAX(id) AS id FROM usuario";
        conexion = conector();
        try {
            sentencia_preparada = conexion.prepareStatement(buscar);
            resultado = sentencia_preparada.executeQuery();
            if (resultado.next()) {
                id = resultado.getInt("id");
            }
            conexion.close();
        } catch (Exception ex) {
            System.out.println(ex.toString());

        }
        return id;
    }//fin metodo buscar

    //-----------BUSCAR RFC PARA INICIO DE SESION
    public int buscarId(String rfc) {
        int id = 0;
        conexion = null;
        String buscar = "SELECT id FROM usuario WHERE curp='" + rfc + "'";
        //System.out.println(buscar);
        conexion = conector();
        try {
            sentencia_preparada = conexion.prepareStatement(buscar);
            resultado = sentencia_preparada.executeQuery();
            if (resultado.next()) {
                id = resultado.getInt("id");
            }
            conexion.close();
        } catch (Exception ex) {
            System.out.println(ex.toString());

        }
        return id;
    }//fin metodo buscar

    public String buscarentidad(String id_entidad) {
        String entidad = "";
        conexion = null;
        conexion = conector();
        try {
            sentencia_preparada = conexion.prepareStatement(id_entidad);
            resultado = sentencia_preparada.executeQuery();
            if (resultado.next()) {
                entidad = resultado.getString("entidad");
            }
            conexion.close();
        } catch (Exception ex) {
            System.out.println(ex.toString());

        }
        return entidad;
    }//fin metodo buscar

    public String buscarplantel(String id_plantel) {
        String plantel = "";
        conexion = null;
        conexion = conector();
        try {
            sentencia_preparada = conexion.prepareStatement(id_plantel);
            resultado = sentencia_preparada.executeQuery();
            if (resultado.next()) {
                plantel = resultado.getString("plantel");
            }
            conexion.close();
        } catch (Exception e) {
            System.out.println(e.toString());

        }
        return plantel;
    }//fin metodo buscar

    public String buscartipocategoria(String id_tipo) {
        String tipo = "";
        conexion = null;
        conexion = conector();
        try {
            sentencia_preparada = conexion.prepareStatement(id_tipo);
            resultado = sentencia_preparada.executeQuery();
            if (resultado.next()) {
                tipo = resultado.getString("categoria");
            }
            conexion.close();
        } catch (Exception e) {
            System.out.println(e.toString());

        }
        return tipo;
    }//fin metodo buscar

    public String buscarjornada(String id_jornada) {
        String jornada = "";
        conexion = null;
        conexion = conector();
        try {
            sentencia_preparada = conexion.prepareStatement(id_jornada);
            resultado = sentencia_preparada.executeQuery();
            if (resultado.next()) {
                jornada = resultado.getString("jornada");
            }
            conexion.close();
        } catch (Exception e) {
            System.out.println(e.toString());

        }
        return jornada;
    }//fin metodo buscar

    private List convertir(ResultSet rs) {
        List<String[]> datos = null;
        String[] tupla = null;
        try {
            //rs.last();
            ResultSetMetaData rsmd = rs.getMetaData();
            int numCols = rsmd.getColumnCount();
            datos = new ArrayList<String[]>();
            //rs.beforeFirst(); 
            while (rs.next()) {
                tupla = new String[numCols];
                for (int i = 0; i < numCols; i++) {
                    tupla[i] = rs.getString(i + 1);
                }
                datos.add(tupla);
            }
        } catch (Exception e) {
            System.out.println(e.toString());
        }
        return datos;

    }

    public List ejecutaSP(String sp) {
        List<String[]> datos = new ArrayList<String[]>();
        String[] tupla;
        conexion = null;

        String buscar = "call " + sp + "();";
        conexion = conector();
        try {
            sentencia_preparada = conexion.prepareStatement(buscar);
            resultado = sentencia_preparada.executeQuery();
            datos = convertir(resultado);
            sentencia_preparada.close();
            conexion.close();
        } catch (Exception e) {
            System.out.println(e.toString());
        }
        return datos;
    }

    public List ejecutaSP(String sp, String[] parametros) {
        List<String[]> datos = new ArrayList<String[]>();
        String[] tupla;
        conexion = null;
        String aux = "";
        for (String parametro : parametros) {
            if (!parametro.equals("")) {
                aux += "'" + parametro + "',";
            } else {
                aux += "NULL,";
            }
        }
        if (aux != "") {
            aux = aux.substring(0, aux.length() - 1);
        }
        String buscar = "call " + sp + "(" + aux + ");";
        System.out.println(buscar);
        conexion = conector();
        try {
            sentencia_preparada = conexion.prepareStatement(buscar);
            resultado = sentencia_preparada.executeQuery();
            datos = convertir(resultado);
            sentencia_preparada.close();
            conexion.close();
        } catch (Exception e) {
            System.out.println(e.toString());
        }
        return datos;
    }

    public static Connection conectorEncuestas() {
        String driver, user, pass, url;
        Properties p = new Properties();
        conexion = null;
        try {
            p.load(new FileReader("C:/ArchivosPromocion/config.properties"));

            driver = p.getProperty("driver");
            user = p.getProperty("userEncuestas");
            pass = p.getProperty("passEncuestas");
            url = p.getProperty("urlEncuestas");
            Class.forName(driver);
            conexion = (Connection) DriverManager.getConnection(url, user, pass);
            if (conexion != null) {
                //System.out.println("conexion establecida");
            }
        } catch (Exception ex) {
            System.out.println("Error de conexion:" + ex.toString());
        }
        return conexion;
    }

    public List ejecutaSPEncuestas(String sp, String[] parametros) {
        List<String[]> datos = new ArrayList<String[]>();
        String[] tupla;
        conexion = null;
        String aux = "";
        //System.out.println(parametros.length);
        for (String parametro : parametros) {
            if (!parametro.equals("")) {
                aux += "'" + parametro + "',";
            } else {
                aux += "NULL,";
            }
        }
        if (aux != "") {
            aux = aux.substring(0, aux.length() - 1);
        }
        String buscar = "call " + sp + "(" + aux + ");";
        //System.out.println(buscar);
        conexion = conectorEncuestas();
        try {
            sentencia_preparada = conexion.prepareStatement(buscar);
            resultado = sentencia_preparada.executeQuery();
            datos = convertir(resultado);
            sentencia_preparada.close();
            conexion.close();
        } catch (Exception e) {
            System.out.println(e.toString());
        }
        return datos;
    }

    public int guardarAntiguedad(int id, String idusuario, String idpermiso) {
        int resultado = 0;
        conexion = null;

        String guardar = "INSERT INTO usuariopermiso(id,idUsuario,idPermiso) VALUES(?,?,?)";

        conexion = conector();
        try {
            sentencia_preparada = conexion.prepareStatement(guardar);
            sentencia_preparada.setString(1, String.valueOf(id));
            sentencia_preparada.setString(2, idusuario);
            sentencia_preparada.setString(3, idpermiso);

            resultado = sentencia_preparada.executeUpdate();
            sentencia_preparada.close();
            conexion.close();
        } catch (Exception ex) {
            System.out.println(ex.toString());
        }
        return resultado;
    }

    public String[] buscar_convocatoria(String entidad, String plantel, String programa) {
        String datos[] = new String[12];
        conexion = null;
        String buscar = "SELECT * FROM convocatoria WHERE idPlantel='" + plantel + "' && idPrograma='" + programa + "'";
        conexion = conector();
        try {
            sentencia_preparada = conexion.prepareStatement(buscar);
            resultado = sentencia_preparada.executeQuery();
            if (resultado.next()) {
                datos[0] = resultado.getString("publicacion");
                datos[1] = resultado.getString("inicioRegistro");
                datos[2] = resultado.getString("finRegistro");
                datos[3] = resultado.getString("inicioValoracion");
                datos[4] = resultado.getString("finValoracion");
                datos[5] = resultado.getString("inicioDictaminacion");
                datos[6] = resultado.getString("finDictaminacion");
                datos[7] = resultado.getString("resultados");
                datos[8] = resultado.getString("idPlantel");
                datos[9] = resultado.getString("idPrograma");
                datos[10] = resultado.getString("estatus");
                datos[11] = resultado.getString("id");
            }
            conexion.close();
        } catch (Exception e) {

        }
        return datos;
    }

    public int modificar_convocatoria(String id, Date publicacion1, Date periodo_registro_inicio1, Date periodo_registro_fin1, Date periodo_valoracion_inicio1, Date periodo_valoracion_fin1, Date periodo_dictaminacion_inicio1, Date periodo_dictaminacion_fin1, Date publicacion_resultados1, String estatus) {
        int resultado = 0;
        conexion = null;
        Date fecha = new Date(20, 05, 31);
        String guardar = "UPDATE convocatoria SET publicacion='" + publicacion1 + "',"
                + "inicioRegistro='" + periodo_registro_inicio1 + "',"
                + "finRegistro='" + periodo_registro_fin1 + "',"
                + "inicioValoracion='" + periodo_valoracion_inicio1 + "',"
                + "finValoracion='" + periodo_valoracion_fin1 + "',"
                + "inicioDictaminacion='" + periodo_dictaminacion_inicio1 + "',"
                + "finDictaminacion='" + periodo_dictaminacion_fin1 + "',"
                + "resultados='" + publicacion_resultados1 + "',"
                + "estatus='" + estatus + "' WHERE id='" + Integer.parseInt(id) + "'";
        conexion = conector();
        try {
            sentencia_preparada = conexion.prepareStatement(guardar);
            resultado = sentencia_preparada.executeUpdate();
            sentencia_preparada.close();
            conexion.close();
        } catch (Exception ex) {
            System.out.println(ex.toString());
        }
        return resultado;
    }//fin metodo guardar 

    public int modificar_usuarios_A(String id, String entidad, String plantel, String nombre, String primerApellido, String segundoApellido, String correo, String clave, String usuario, String telfijo, String telcel, String perfil, String nivel) {
        int resultado = 0;
        conexion = null;
    String guardar2 = "UPDATE usuario SET programa="+ null +", entidad ="+entidad+", plantel ="+plantel+", nombre = '"+nombre+"', primerApellido='"+primerApellido+"',segundoApellido='"+segundoApellido+"',correo='"+correo+"',clave='"+clave+"',curp='"+usuario+"',telfijo='"+telfijo+"',telcel='"+telcel+"',perfil='"+perfil+"',consideraciones='null',nacional='"+nivel+"' WHERE id = '"+id+"'";
//        String guardar2 = "UPDATE usuario SET programa='" + null + "',"
//                + "entidad='" + entidad + "',"
//                + "plantel='" + 158 + "',"
//                + "nombre='" + nombre + "',"
//                + "primerApellido='" + primerApellido + "',"
//                + "segundoApellido='" + segundoApellido + "',"
//                + "correo='" + correo + "',"
//                + "clave='" + clave + "',"
//                + "curp='" + usuario + "',"
//                + "telfijo='" + telfijo + "',"
//                + "telcel='" + telcel + "',"
//                + "perfil='" + perfil + "',"
//                + "consideraciones='" + null + "',"
//                + "nacional='" + nivel + "' WHERE id='" + 29 + "'";
        
//    String guardar2 = "UPDATE usuario SET programa= null, entidad = 15, plantel = null, nombre = CARLOS, primerApellido=MADRID,segundoApellido=TREJO,correo=CHARLYC2K@HOTMAIL.COM,clave=1,curp=HOLA,telfijo=1111111111,telcel=1111111111,perfil=A,consideraciones=null,nacional=1 WHERE id = 29";

        
        
        conexion = conector();
        try {
            sentencia_preparada = conexion.prepareStatement(guardar2);
            resultado = sentencia_preparada.executeUpdate();
            sentencia_preparada.close();
            conexion.close();
        } catch (Exception ex) {
        }
        return resultado;
    }//fin metodo guardar

    
//    public int modificar_usuarios_B() {
//        int resultado = 0;
//        conexion = null;  
//              
//String guardar2 = "UPDATE usuario SET programa= null, entidad = 1, plantel = '2', nombre = 'CARLOS', primerApellido='MADRID',segundoApellido='TREJO',correo='CHARLYC2K@HOTMAIL.COM',clave='1',curp='HOLA',telfijo='1111111111',telcel='1111111111',perfil='A',consideraciones='null',nacional='1' WHERE id = '29'";
//
//        conexion = conector();
//        try {
//            sentencia_preparada = conexion.prepareStatement(guardar2);
//            resultado = sentencia_preparada.executeUpdate();
//            sentencia_preparada.close();
//            conexion.close();
//        } catch (Exception ex) {
//        }
//        return resultado;
//    }//fin metodo guardar
    
    
       
    //----------- GUARDAR PERMISOS, SERVLET AGREGAR USUARIO*
    public int borrar_permisos_usuarios(int id, String idusuario) {
        int resultado = 0;
        conexion = null;

        String guardar = "DELETE FROM usuariopermiso WHERE idUsuario ='"+idusuario+"'";

        conexion = conector();
        try {
            sentencia_preparada = conexion.prepareStatement(guardar);
            resultado = sentencia_preparada.executeUpdate();
            sentencia_preparada.close();
            conexion.close();
        } catch (Exception ex) {
            System.out.println(ex.toString());
        }
        return resultado;
    }//fin metodo guardar 

}//fin clase metodos_sql
