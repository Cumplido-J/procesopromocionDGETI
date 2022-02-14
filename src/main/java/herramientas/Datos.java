/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package herramientas;

import com.aplicacion.beans.ModelReporte;
import com.aplicacion.beans.ModelReporteEstatal;
import constants.ConstantsWS;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import metodos_sql.Metodos_sql;

/**
 *
 * @author David Reyna
 */
public class Datos {

    Metodos_sql metodos;
    ConstantsWS constants;

    public Datos() {
        metodos = new Metodos_sql();
    }

    public String desplegarUsuarios(String idPrograma, String idSubsistema, String idEntidad, String idPlantel, String usuario, String tusuario) {
        String respuesta = "<tr><td colspan='7' class='text-center'>Sin información</td></tr>";
        try {
            String[] parametros = {idPrograma, idSubsistema, idEntidad, idPlantel, usuario, tusuario};
            if (idEntidad.isEmpty() && idPlantel.isEmpty() && tusuario.isEmpty()) {
                return respuesta;
            } else if (!idEntidad.isEmpty() && !idPlantel.isEmpty() && tusuario.isEmpty()) {
                return respuesta;
            } else {
                List<String[]> datos = metodos.ejecutaSP("sp_consultaUsuarios", parametros);
                if (!datos.isEmpty()) {
                    respuesta = "";
                    for (String[] dato : datos) {
                        String nombreUsuario = dato[10] == null ? "" : dato[10];

                        respuesta += "<tr><td>" + dato[2] + "</td><td>" + dato[4] + "</td><td>" + dato[6] + "</td><td>" + dato[8] + "</td><td>" + dato[9] + "</td><td>" + nombreUsuario + "</td><td>";
                        respuesta += "<form method='POST' action='AltaUsuario'><input type='hidden' name='idUsuario' value='" + dato[0] + "'><input class='btn btn-sm btn-link' type='submit' value='Editar'/></form>";
                        respuesta += "<td><button type='button' class='btn btn-sm' title='Borrar' onclick='confirmarUsuario(" + dato[0] + ")'><span class='glyphicon glyphicon-trash'></span></button></td>";
                        respuesta += "</td></tr>";
                    }
                }
            }
        } catch (Exception e) {
            respuesta = e.toString();
        } finally {
            return respuesta;
        }
    }

    public String desplegarConvocatorias(String idPrograma, String idSubsistema, String idEntidad, String idPlantel, String estatus) {
        String respuesta = "<tr><td colspan='6' class='text-center'>Sin información</td></tr>";
        try {
            if (idEntidad == null && idPlantel == null) {
                idEntidad = "";
                idPlantel = "";
            } else if (idEntidad == null) {
                idEntidad = "";
            } else if (idPlantel == null) {
                idPlantel = "";
            }
            String[] parametros = {idPrograma, idSubsistema, idEntidad, idPlantel, estatus};
            List<String[]> datos = metodos.ejecutaSP("sp_consultaConvocatorias", parametros);
            if (!datos.isEmpty()) {
                respuesta = "";
                for (String[] dato : datos) {
                    respuesta += "<tr><td>" + dato[2] + "</td><td>" + dato[4] + "</td><td>" + dato[6] + "</td><td>" + dato[8] + "</td><td>" + dato[9] + "</td><td>";
                    respuesta += "<form method='POST' action='AltaConvocatoria'><input type='hidden' name='idConvocatoria' value='" + dato[0] + "'><input class='btn btn-sm btn-link' type='submit' value='Editar'/></form>";
                    respuesta += "</td></tr>";
                }
            }
        } catch (Exception e) {
            respuesta = e.toString();
        } finally {
            return respuesta;
        }
    }

    public String desplegarConvocatoriasBase(String idPrograma, String idSubsistema, String idEntidad, String idPlantel, String estatus, String tipoConvocatoria) {
        String respuesta = "<tr><td colspan='6' class='text-center'>Sin información</td></tr>";
        try {

            if (estatus.isEmpty()) {
                estatus = "0";
            }

            if (tipoConvocatoria.equals("NACIONAL")) {
                idEntidad = "0";
                idPlantel = "0";
            } else if (tipoConvocatoria.equals("ESTATAL")) {
                idPlantel = "0";
            }

            String[] parametros = {idPrograma, idSubsistema, idEntidad, idPlantel, estatus, tipoConvocatoria};

            List<String[]> datos = metodos.ejecutaSP("sp_consultaConvocatoriasBase", parametros);
            if (!datos.isEmpty()) {
                respuesta = "";
                for (String[] dato : datos) {
                    respuesta += "<tr><td>" + dato[2] + "</td><td>" + dato[9] + "</td><td>" + dato[4] + "</td><td>" + dato[6] + "</td><td>" + dato[8] + "</td><td>";
                    respuesta += "<form method='POST' action='AltaConvocatoriaBase'><input type='hidden' name='idConvocatoria' value='" + dato[0] + "'><input class='btn btn-sm btn-link' type='submit' value='Editar'/></form>";
                    respuesta += "</td></tr>";
                }
            }

        } catch (Exception e) {
            respuesta = e.toString();
        } finally {
            return respuesta;
        }
    }

    public String desplegarVacancias(String idPrograma, String idSubsistema, String idEntidad, String idPlantel, String tipoCategoria) {
        String respuesta = "<tr><td colspan='6' class='text-center'>Sin información</td></tr>";
        String aux = "";
        try {
            String[] parametros = {idPrograma, idSubsistema, idEntidad, idPlantel, tipoCategoria};
            List<String[]> datos = metodos.ejecutaSP("sp_consultaVacancias", parametros);

            if (idEntidad.isEmpty() && idPlantel.isEmpty() && tipoCategoria.isEmpty()) {
                return respuesta;
            } else {
                if (!datos.isEmpty()) {
                    respuesta = "";
                    for (String[] dato : datos) {
                        if (dato[11].equals("1")) {
                            aux = " (" + dato[16] + ")";
                        } else {
                            aux = "";
                        }
                        respuesta += "<tr><td>" + dato[2] + "</td><td>" + dato[4] + "</td><td>" + dato[6] + "</td><td>" + dato[8] + "</td><td>" + dato[10] + "</td><td>" + dato[12] + aux + "</td><td>" + dato[13] + "</td><td>" + dato[14] + "</td>";
                        //respuesta+="<form method='POST' action='AltaVacancia'><input type='hidden' name='idConvocatoria' value='"+dato[0]+"'><input class='btn btn-sm btn-link' type='submit' value='Editar'/></form>";                                                                                  
                        respuesta += "</tr>";
                    }
                }

            }
        } catch (Exception e) {
            respuesta = e.toString();
        } finally {
            return respuesta;
        }
    }

    public String desplegarDocentes(String idPrograma, String idSubsistema, String idEntidad, String idPlantel, String nombreRFC, String estatus, String idPermiso, String idUsuario, String idPeriodo) {
        String respuesta = "<tr><td colspan='9' class='text-center'>Sin información</td></tr>";
        try {
            String[] parametros = {idPrograma, idSubsistema, idEntidad, idPlantel, nombreRFC, estatus, idUsuario, idPeriodo, idPermiso};
            if (idEntidad.isEmpty() && idPlantel.isEmpty() && nombreRFC.isEmpty() && estatus.isEmpty()) {
                return respuesta;
            } else {
                List<String[]> datos = metodos.ejecutaSP("sp_consultaDocentes", parametros);

                if (!datos.isEmpty()) {
                    respuesta = "";
                    for (String[] dato : datos) {
                        String[] parametros1 = {dato[0]};
                        List<String[]> datos1 = metodos.ejecutaSP("sp_consultaListaCotejo", parametros1);
                        String listaCotejo = "";
                        if (!datos1.isEmpty()) {
                            listaCotejo = "Si";
                        } else {
                            listaCotejo = "No";
                        }
                        respuesta += "<tr><td>" + dato[12] + "</td><td>" + dato[10] + "</td><td>" + dato[2] + "</td><td>" + dato[4] + "</td><td>" + dato[6] + "</td><td>" + dato[5] + "</td><td>" + dato[8] + "</td><td>" + dato[13] + "</td><td>";
                        if (idPermiso.equals("6")) {
                            respuesta += dato[14] + "</td><td>";
                            if (!dato[14].equals("")) {
                                respuesta += "<span class='glyphicon glyphicon-ok-sign completo' title='Aspirante evaluado'></span>";
                            }
                        } else {
                            if (!dato[13].equals("")) {
                                respuesta += "<span class='glyphicon glyphicon-ok-sign completo' title='Aspirante evaluado'></span>";
                            }
                        }
                        if (!dato[15].equals("")) {
                            respuesta += "<form method='POST' action='VistaDocente'><input type='hidden' name='idUsuario' value='" + dato[0] + "'><input type='hidden' name='rfc' value='" + dato[6] + "'><input disabled class='btn btn-sm btn-link' type='submit' value='Ver información'/></form>";
                        } else {
                            respuesta += "<form method='POST' action='VistaDocente'><input type='hidden' name='idUsuario' value='" + dato[0] + "'><input type='hidden' name='rfc' value='" + dato[6] + "'><input class='btn btn-sm btn-link' type='submit' value='Ver información'/></form>";
                        }

                        respuesta += "</td><<td class='text-center'>" + listaCotejo + "</td></tr>";
                    }
                }
            }
        } catch (Exception e) {
            respuesta = e.toString();
        } finally {
            return respuesta;
        }
    }

    public String desplegarPlazas(String idUsuario) {
        String respuesta = "<tr><td colspan='7' class='text-center'>Sin información</td></tr>";
        try {
            String[] parametros = {idUsuario};
            List<String[]> datos = metodos.ejecutaSP("sp_consultaUsuarioPlaza", parametros);
            if (!datos.isEmpty()) {
                respuesta = "";
                String seleccionado = "";
                String cargo = "";
                for (String[] dato : datos) {
                    if (dato[12].equals("V") && dato[15].equals("1")) {
                        seleccionado = "checked";
                    } else if (dato[4].equals("1") && dato[15].equals("2")) {
                        seleccionado = "checked";
                    } else {
                        seleccionado = "";
                    }

                    if (dato[15].equals("1")) {
                        respuesta += "<tr><td><center><input type='checkbox' onChange='seleccionarPlaza(this)' value='" + dato[0] + "' " + seleccionado + "/></center><td>" + dato[11] + "</td><td>" + dato[7] + "</td><td id=" + "tipoNom" + ">" + dato[9] + ":" + dato[10] + "</td><td class='hidden'>" + dato[2] + "</td><td>" + dato[3] + "</td><td class='hidden'>" + dato[4] + "</td><td>" + dato[5];
                    } else {
                        respuesta += "<tr><td><center><input type='checkbox' onChange='seleccionarPlaza(this)' value='" + dato[0] + "' " + seleccionado + " disabled/></center><td>" + dato[11] + "</td><td>" + dato[7] + "</td><td id=" + "tipoNom" + ">" + dato[9] + ":" + dato[10] + "</td><td class='hidden'>" + dato[2] + "</td><td>" + dato[3] + "</td><td class='hidden'>" + dato[4] + "</td><td>" + dato[5];
                    }

                    if (dato[4].equals("1")) {
                        respuesta += "(" + dato[6] + ")";
                    }
                    respuesta += "</td>";
                    switch (dato[13]) {
                        case "D":
                            respuesta += "<td>Director<br/>Fecha renuncia:" + dato[14] + "</td>";
                            break;
                        case "S":
                            respuesta += "<td>Subdirector<br/>Fecha renuncia:" + dato[14] + "</td>";
                            break;
                        case "J":
                            respuesta += "<td>Jefe de Departamento<br/>Fecha renuncia:" + dato[14] + "</td>";
                            break;
                        default:
                            respuesta += "<td>No aplica</td>";
                    }

                    respuesta += "<td><button type='button' class='btn btn-sm' title='Borrar' onclick='confirmarPlaza(" + dato[0] + ")'><span class='glyphicon glyphicon-trash'></span></button>";
                    respuesta += "</td></tr>";
                }
            }
        } catch (Exception e) {
            respuesta = e.toString();
        } finally {
            return respuesta;
        }
    }

    public String validarSeleccionadas(String idUsuario) {
        String respuesta = "";
        int horas = 0, numPlazas = 0;
        String idCategoria = "-1", idJornada = "-1", idCategoriaAux = "", idJornadaAux = "";
        String idNombramiento = "", idNombramientoAux = "";
        try {
            String[] parametros = {idUsuario};
            List<String[]> datos = metodos.ejecutaSP("sp_consultaUsuarioPlaza", parametros);
            if (!datos.isEmpty()) {
                respuesta = "";
                for (String[] dato : datos) {
                    if (dato[12].equals("V")) {
                        idCategoria = dato[2];
                        idJornada = dato[4];
                        idNombramiento = dato[8];
                        if (dato[4].equals("1")) {
                            horas += Integer.parseInt(dato[6]);
                        }
                        System.out.println(idCategoria + "-" + idCategoriaAux + "-" + idJornada + "-" + idJornadaAux);

                        if (dato[15].equals("1")) {//Para el programa 1:Cambio categoria solo puede sumar plazas con la misma categoria y jornada
                            if (!idCategoriaAux.isEmpty()) {
                                if (!idCategoriaAux.equals(idCategoria) || !idJornadaAux.equals(idJornada)) {
                                    respuesta = "Solo puede seleccionar plazas de la misma categoria y jornada";
                                }
                            }
                        } else if (dato[15].equals("2")) {//Para el programa 2:Horas adicionales solo puede sumar plazas con jornada de horas
                            if (!idJornada.equals("1")) {
                                respuesta = "Solo puede seleccionar plazas de horas";
                            }
                            if (horas > 19) {
                                respuesta = "Solo puede acumular 19 horas como máximo";
                            }
                        }

                        idCategoriaAux = idCategoria;
                        idJornadaAux = idJornada;
                        idNombramientoAux = idNombramiento;
                        numPlazas++;
                    }

                }
                if (!idJornada.equals("1") && numPlazas > 1) {
                    respuesta = "Solo puede seleccionar una plaza con la que participará";
                } else {
                    if (respuesta.isEmpty()) {
                        respuesta = idCategoria + "," + idJornada + "," + horas + "," + idNombramiento;
                    }
                }
            }
        } catch (Exception e) {
            respuesta = e.toString();
        } finally {
            return respuesta;
        }
    }

    public String desplegarAspirantesVacancia(String id, String idPrograma, String idSubsistema, String idEntidad, String idPlantel, String categoria, String jornada, String vacancia, String periodo) {
        String respuesta = "<tr><td colspan='9' class='text-center'>Sin información</td></tr>";
        try {
            String[] parametros = {idPrograma, idSubsistema, idEntidad, idPlantel, categoria, jornada, vacancia, periodo};
            if (idEntidad.isEmpty() && idPlantel.isEmpty()) {
                return respuesta;
            } else {
                if (id.contains("b")) {
                    List<String[]> datos = metodos.ejecutaSP(constants.SP_CONSULTA_GANADOR_ASPIRANTE, parametros);

                    if (!datos.isEmpty()) {
                        respuesta = "";
                        for (String[] dato : datos) {
                            respuesta += "<tr><td>" + dato[2] + "</td><td>" + dato[4] + "</td><td>" + dato[6] + "</td><td>" + dato[8] + "</td><td>" + dato[12] + "</td><td>" + dato[16] + "</td><td>" + dato[11] + "</td><td>" + dato[13] + "</td><td>" + (dato[10] == null ? "0" : dato[10]) + "</td>";
                            if (dato[10] == null || dato[15] == null) {
                                respuesta += "<td>" + "***" + "</td>" + "</tr>";
                            } else {
                                //respuesta+="<td>"+(datos.indexOf(dato)+1)+"</td>"+"</tr>";
                                respuesta += "<td>" + dato[15] + "</td>" + "</tr>";
                            }
                        }
                        return respuesta;
                    }
                } else {
                    if (id.contains("r")) {
                        String[] parametrosPlazas = {idPrograma, idSubsistema, idEntidad, idPlantel, "D", categoria, jornada, periodo};
                        List<String[]> datosPlazas = metodos.ejecutaSP(constants.SP_CONSULTA_NUMERO_PLAZAS, parametrosPlazas);
                        int numeroPlazas = Integer.parseInt(datosPlazas.get(0)[8]);
                        String[] parametrosGanador = {idPrograma, idSubsistema, idEntidad, idPlantel, categoria, jornada, vacancia, periodo};
                        List<String[]> datosGanador = metodos.ejecutaSP(constants.SP_CONSULTA_GANADOR_ASPIRANTE, parametrosGanador);
                        if (!datosGanador.isEmpty()) {
                            int contador = 0;
                            for (String[] datoGanador : datosGanador) {
                                int posicionGanador = 1;
//                                    if(numeroPlazas>(datosGanador.indexOf(datoGanador))){
//                                        String[] parametrosGanador1={datoGanador[0],Integer.toString(posicionGanador)};
//                                        metodos.ejecutaSP(constants.SP_INSERT_POSICION,parametrosGanador1);
//                                    }else{
//                                        contador++;
//                                        String[] parametrosGanador1={datoGanador[0],Integer.toString(contador)};
//                                        metodos.ejecutaSP(constants.SP_INSERT_POSICION,parametrosGanador1);
//                                    }
                                contador++;
                                String[] parametrosGanador1 = {datoGanador[0], Integer.toString(contador)};
                                metodos.ejecutaSP("sp_insertPosicion", parametrosGanador1);
                            }
                        }
                    }

                    List<String[]> datos = metodos.ejecutaSP(constants.SP_CONSULTA_GANADOR_ASPIRANTE, parametros);
                    if (!datos.isEmpty()) {
                        respuesta = "";
                        for (String[] dato : datos) {
                            respuesta += "<tr><td>" + dato[2] + "</td><td>" + dato[4] + "</td><td>" + dato[6] + "</td><td>" + dato[8] + "</td><td>" + dato[12] + "</td><td>" + dato[16] + "</td><td>" + dato[11] + "</td><td>" + dato[13] + "</td><td>" + (dato[10] == null ? "0" : dato[10]) + "</td>";
                            if (dato[10] == null) {
                                respuesta += "<td>" + "***" + "</td>" + "</tr>";
                            } else {
                                respuesta += "<td>" + dato[15] + "</td>" + "</tr>";
                            }
                        }
                        return respuesta;
                    }
                }
            }
        } catch (Exception e) {
            respuesta = e.toString();
        } finally {
            return respuesta;
        }
    }

    public String generarResultadosCentrales(String programa, String idSubsistema, String entidad, String plantel, String vacancia , String periodo){        
        String respuesta="<tr><td colspan='9' class='text-center'>Sin información</td></tr>";        
        try{
            List<String[]> datosEntidades=metodos.ejecutaSP("sp_selectCatEntidades");
            for(String[] dato:datosEntidades){
                String[] parametros={idSubsistema,dato[0]};
                List<String[]> datos=metodos.ejecutaSP("sp_selectCatPlanteles",parametros);
                for(String[] datoPlanteles:datos){
                    String idEntidad=dato[0];
                    String idPlantel=datoPlanteles[0];
                    String[] parametros1={programa, idSubsistema, idEntidad, idPlantel,vacancia,periodo};
                    List<String[]> datosProgramas=metodos.ejecutaSP("sp_consultaVacanciasResultados",parametros1);
                    if(datosProgramas.size()>0){
                        for(String[] datoPrograma:datosProgramas){
                            
                            if(datoPrograma[4].contains("TD")){
                                System.out.println("Hola");
                            }
                            
                            String[] parametrosPlazas={programa, idSubsistema, idEntidad, idPlantel, datoPrograma[4], datoPrograma[0], datoPrograma[2], periodo};
                            List<String[]> datosPlazas=metodos.ejecutaSP("sp_consultaNumeroPlazas",parametrosPlazas);
                            if(datosPlazas.size()>0){
                                int numeroPlazas=Integer.parseInt(datosPlazas.get(0)[8]);
                                String[] parametrosGanador={programa, idSubsistema, idEntidad, idPlantel, datoPrograma[0], datoPrograma[2],vacancia, periodo};
//                                List<String[]> datosGanador=metodos.ejecutaSP("sp_consultaGanadorAspirante",parametrosGanador);
                                List<String[]> datosGanador=metodos.ejecutaSP("sp_consultaAspirante0001",parametrosGanador);
                                    if(!datosGanador.isEmpty()){
                                        int contador = 0;
                                        for(String[] datoGanador:datosGanador){
                                            int posicionGanador=1;
            //                                if(numeroPlazas>(datosGanador.indexOf(datoGanador))){
            //                                    String[] parametrosGanador1={datoGanador[0],Integer.toString(posicionGanador)};
            //                                    metodos.ejecutaSP("sp_insertPosicion",parametrosGanador1);
            //                                }else{
            //                                    contador++;
            //                                    String[] parametrosGanador1={datoGanador[0],Integer.toString(contador)};
            //                                    metodos.ejecutaSP("sp_insertPosicion",parametrosGanador1);
            //                                }
                                                contador++;
                                                String[] parametrosGanador1={datoGanador[0],Integer.toString(contador)};
                                                metodos.ejecutaSP("sp_insertPosicion",parametrosGanador1);
                                        }
                                    }
                            }
                        }
                    }
                }
            }
            return respuesta;
        }catch(Exception e){
            respuesta=e.toString();
        }finally{
            return respuesta;  
        }
    }

    public String desplegarAspirantesAsignacion(String id,String idPrograma,String idSubsistema,String idEntidad,String idPlantel,String categoria,String jornada,String vacancia, String periodo){        
        String respuesta="<tr><td colspan='9' class='text-center'>Sin información</td></tr>";        
        try{
            String[] parametros={idPrograma,idSubsistema,idEntidad,idPlantel,categoria,jornada,vacancia,periodo};
            if(idEntidad.isEmpty() && idPlantel.isEmpty()){
                return respuesta;
            }else{
                if(id.contains("b")){
                    List<String[]> datos=metodos.ejecutaSP(constants.SP_CONSULTA_GANADOR_ASPIRANTE,parametros);
                    List<String[]> datosCatAsignacion=metodos.ejecutaSP(constants.SP_SELECT_CAT_ASIGNACION);
                    String estatus1=datosCatAsignacion.get(0)[0];
                    String estatus2=datosCatAsignacion.get(1)[0];
                    String estatus3=datosCatAsignacion.get(2)[0];
                    
                    String estatusDesc1=datosCatAsignacion.get(0)[1];
                    String estatusDesc2=datosCatAsignacion.get(1)[1];
                    String estatusDesc3=datosCatAsignacion.get(2)[1];
                    
                    
                    if(!datos.isEmpty()){
                        respuesta="";
                        for(String[] dato:datos)
                        {
    //                        respuesta+="<tr><td>"+dato[4]+"</td><td>"+dato[6]+"</td><td>"+dato[8]+"</td><td>"+dato[12]+"</td><td>"+dato[16]+"</td><td>"+dato[11]+"</td><td>"+dato[13]+"</td><td>"+(dato[10]==null?"0":dato[10])+"</td>";
                            respuesta+="<tr><td>"+dato[4]+"</td><td>"+dato[6]+"</td><td>"+dato[8]+"</td><td>"+dato[17]+"</td><td>"+dato[18]+"</td><td>"+dato[11]+"</td><td>"+dato[13]+"</td><td>"+(dato[10]==null?"0":dato[10])+"</td>";
                            if(dato[10]==null || dato[15]==null){
                                respuesta+="<td>"+"***"+"</td>"+"</tr>";
                            }else{
                                //respuesta+="<td>"+(datos.indexOf(dato)+1)+"</td>"+"</tr>";
                                respuesta+="<td>"+dato[15]+"</td>";
                            }
                            
                            String tvacancia="tvacancia"+dato[0].toString();
                            if(dato[19]==null){
                                respuesta+="<td><div class=\"form-group col-md-24\">  \n" +
            "                            <select class=\"form-control input-sm\" id="+tvacancia+" name=\"tvacancia2\" required>\n" +
            "                                <option value=\"\" selected>Seleccionar una opción</option>\n" +
            "                                <option value="+estatus1+">"+estatusDesc1+"</option>\n" +
            "                                <option value="+estatus2+">"+estatusDesc2+"</option>\n" +
            "                                <option value="+estatus3+">"+estatusDesc3+"</option>\n" +
            "                            </select>\n" +
            "                        </div></td><td><button type='button' class='btn btn-sm' title='Borrar' onclick='confirmarCategoria("+dato[0]+")'><span class='glyphicon glyphicon-floppy-disk incompleto2'></span></button></td>"+"</tr>";
                            }else{
                                if(dato[19].equals("1") && dato[20]==null){
                                    respuesta+="<td><div class=\"form-group col-md-24\">  \n" +
            "                            <select class=\"form-control input-sm\" id="+tvacancia+" name=\"tvacancia2\" required>\n" +
            "                                <option value=\"\" selected>Seleccionar una opción</option>\n" +
            "                                <option value="+estatus1+" selected>"+estatusDesc1+"</option>\n" +
            "                                <option value="+estatus2+">"+estatusDesc2+"</option>\n" +
            "                                <option value="+estatus3+">"+estatusDesc3+"</option>\n" +
            "                            </select>\n" +
            "                        </div></td><td><button type='button' class='btn btn-sm' title='Borrar' onclick='confirmarCategoria("+dato[0]+")'><span class='glyphicon glyphicon-floppy-disk incompleto2'></span></button></td>"+"</tr>";
                                    }else if(dato[19].equals("2") && dato[20]==null){
                                        respuesta+="<td><div class=\"form-group col-md-24\">  \n" +
            "                            <select class=\"form-control input-sm\" id="+tvacancia+" name=\"tvacancia2\" required>\n" +
            "                                <option value=\"\" selected>Seleccionar una opción</option>\n" +
            "                                <option value="+estatus1+">"+estatusDesc1+"</option>\n" +
            "                                <option value="+estatus2+" selected>"+estatusDesc2+"</option>\n" +
            "                                <option value="+estatus3+">"+estatusDesc3+"</option>\n" +
            "                            </select>\n" +
            "                        </div></td><td><button type='button' class='btn btn-sm' title='Borrar' onclick='confirmarCategoria("+dato[0]+")'><span class='glyphicon glyphicon-floppy-disk incompleto2'></span></button></td>"+"</tr>";
                                    }else if(dato[19].equals("3") && dato[20]==null){
                                        respuesta+="<td><div class=\"form-group col-md-24\">  \n" +
            "                            <select class=\"form-control input-sm\" id="+tvacancia+" name=\"tvacancia2\" required>\n" +
            "                                <option value=\"\">Seleccionar una opción</option>\n" +
            "                                <option value="+estatus1+">"+estatusDesc1+"</option>\n" +
            "                                <option value="+estatus2+">"+estatusDesc2+"</option>\n" +
            "                                <option value="+estatus3+" selected>"+estatusDesc3+"</option>\n" +
            "                            </select>\n" +
            "                        </div></td><td><button type='button' class='btn btn-sm' title='Borrar' onclick='confirmarCategoria("+dato[0]+")'><span class='glyphicon glyphicon-floppy-disk incompleto2'></span></button></td>"+"</tr>";
                                    }else if(dato[20]!=null){
                                        respuesta+="<td><div class=\"form-group col-md-24\">  \n" +
            "                            <select class=\"form-control input-sm\" id="+tvacancia+" name=\"tvacancia2\" disabled>\n" +
            "                                <option value=\"\">Seleccionar una opción</option>\n" +
            "                                <option value="+estatus1+">"+estatusDesc1+"</option>\n" +
            "                                <option value="+estatus2+">"+estatusDesc2+"</option>\n" +
            "                                <option value="+estatus3+" selected>"+estatusDesc3+"</option>\n" +
            "                            </select>\n" +
            "                        </div></td><td><button type='button' class='btn btn-sm' title='Borrar' onclick='confirmarCategoria("+dato[0]+")'><span class='glyphicon glyphicon-floppy-disk incompleto2'></span></button></td>"+"</tr>";
                                    }
                            }
                        }
                        return respuesta;
                    }
                }
            }
        }catch(Exception e){
            respuesta=e.toString();
        }finally{
            return respuesta;        
        }
    }
    public String desplegarAspirantesAsignacion2(String id,String idPrograma,String idSubsistema,String idEntidad,String idPlantel,String categoria,String jornada,String vacancia, String periodo){        
        String respuesta="<tr><td colspan='9' class='text-center'>Sin información</td></tr>";        
        try{
            String[] parametros={idPrograma,idSubsistema,idEntidad,idPlantel,categoria,jornada,vacancia,periodo};
            if(idEntidad.isEmpty() && idPlantel.isEmpty()){
                return respuesta;
            }else{
                if(id.contains("b")){
                    List<String[]> datos=metodos.ejecutaSP(constants.SP_CONSULTA_GANADOR_ASPIRANTE2,parametros);
                    List<String[]> datosCatAsignacion=metodos.ejecutaSP(constants.SP_SELECT_CAT_ASIGNACION);
                    String estatus1=datosCatAsignacion.get(0)[0];
                    String estatus2=datosCatAsignacion.get(1)[0];
                    String estatus3=datosCatAsignacion.get(2)[0];
                    
                    String estatusDesc1=datosCatAsignacion.get(0)[1];
                    String estatusDesc2=datosCatAsignacion.get(1)[1];
                    String estatusDesc3=datosCatAsignacion.get(2)[1];
                    
                    if(!datos.isEmpty()){
                        respuesta="";
                        for(String[] dato:datos)
                        {
    //                        respuesta+="<tr><td>"+dato[4]+"</td><td>"+dato[6]+"</td><td>"+dato[8]+"</td><td>"+dato[12]+"</td><td>"+dato[16]+"</td><td>"+dato[11]+"</td><td>"+dato[13]+"</td><td>"+(dato[10]==null?"0":dato[10])+"</td>";
                            respuesta+="<tr><td>"+dato[4]+"</td><td>"+dato[6]+"</td><td>"+dato[8]+"</td><td>"+dato[17]+"</td><td>"+dato[18]+"</td><td>"+dato[11]+"</td><td>"+dato[13]+"</td><td>"+(dato[10]==null?"0":dato[10])+"</td>";
                            if(dato[10]==null || dato[15]==null){
                                respuesta+="<td>"+"***"+"</td>"+"</tr>";
                            }else{
                                //respuesta+="<td>"+(datos.indexOf(dato)+1)+"</td>"+"</tr>";
                                respuesta+="<td>"+dato[15]+"</td>";
                            }
                            
                            String tvacancia="tvacancia"+dato[0].toString();
                            if(dato[19]==null){
                                respuesta+="<td><div class=\"form-group col-md-24\">  \n" +
            "                            <select class=\"form-control input-sm\" id="+tvacancia+" name=\"tvacancia2\" required>\n" +
            "                                <option value=\"\" selected>Seleccionar una opción</option>\n" +
            "                                <option value="+estatus1+">"+estatusDesc1+"</option>\n" +
            "                                <option value="+estatus2+">"+estatusDesc2+"</option>\n" +
            "                                <option value="+estatus3+">"+estatusDesc3+"</option>\n" +
            "                            </select>\n" +
            "                        </div></td><td><button type='button' class='btn btn-sm' title='Borrar' onclick='confirmarCategoria("+dato[0]+")'><span class='glyphicon glyphicon-floppy-disk incompleto2'></span></button></td>"+"</tr>";
                            }else{
                                if(dato[19].equals("1")){
                                    respuesta+="<td><div class=\"form-group col-md-24\">  \n" +
            "                            <select class=\"form-control input-sm\" id="+tvacancia+" name=\"tvacancia2\" required>\n" +
            "                                <option value=\"\" selected>Seleccionar una opción</option>\n" +
            "                                <option value="+estatus1+" selected>"+estatusDesc1+"</option>\n" +
            "                                <option value="+estatus2+">"+estatusDesc2+"</option>\n" +
            "                                <option value="+estatus3+">"+estatusDesc3+"</option>\n" +
            "                            </select>\n" +
            "                        </div></td><td><button type='button' class='btn btn-sm' title='Borrar' onclick='confirmarCategoria("+dato[0]+")'><span class='glyphicon glyphicon-floppy-disk incompleto2'></span></button></td>"+"</tr>";
                                    }else if(dato[19].equals("2")){
                                        respuesta+="<td><div class=\"form-group col-md-24\">  \n" +
            "                            <select class=\"form-control input-sm\" id="+tvacancia+" name=\"tvacancia2\" required>\n" +
            "                                <option value=\"\" selected>Seleccionar una opción</option>\n" +
            "                                <option value="+estatus1+">"+estatusDesc1+"</option>\n" +
            "                                <option value="+estatus2+" selected>"+estatusDesc2+"</option>\n" +
            "                                <option value="+estatus3+">"+estatusDesc3+"</option>\n" +
            "                            </select>\n" +
            "                        </div></td><td><button type='button' class='btn btn-sm' title='Borrar' onclick='confirmarCategoria("+dato[0]+")'><span class='glyphicon glyphicon-floppy-disk incompleto2'></span></button></td>"+"</tr>";
                                    }else if(dato[19].equals("3")){
                                        respuesta+="<td><div class=\"form-group col-md-24\">  \n" +
            "                            <select class=\"form-control input-sm\" id="+tvacancia+" name=\"tvacancia2\" required>\n" +
            "                                <option value=\"\">Seleccionar una opción</option>\n" +
            "                                <option value="+estatus1+">"+estatusDesc1+"</option>\n" +
            "                                <option value="+estatus2+">"+estatusDesc2+"</option>\n" +
            "                                <option value="+estatus3+" selected>"+estatusDesc3+"</option>\n" +
            "                            </select>\n" +
            "                        </div></td><td><button type='button' class='btn btn-sm' title='Borrar' onclick='confirmarCategoria("+dato[0]+")'><span class='glyphicon glyphicon-floppy-disk incompleto2'></span></button></td>"+"</tr>";
                                    }
                            }
                        }
                        return respuesta;
                    }
                }
            }
        }catch(Exception e){
            respuesta=e.toString();
        }finally{
            return respuesta;       
        }
    }
    public String generarReporte(String idPrograma, String idSubsistema, String entidad, String periodo) {
        String respuesta = "<table><tr><th >id</th><th >nombre</th><th >primerApellido</th><th >segundoApellido</th><th >correo</th><th >curp</th><th >idPlantel</th><th >idEntidad</th><th >entidad</th><th >cct</th><th >plantel</th><th >telfijo</th><th >telcel</th><th >consideraciones</th><th >idEscuelaEstudio</th><th >escuela</th><th >idCarrera</th><th >carrera</th><th >anioEgreso</th><th >idGradoAcademico</th><th >grado</th><th >idModalidadTitulacion</th><th >modalidad</th><th >anioTitulacion</th><th >cedula</th><th >activo</th><th >ingresoSubsistema</th><th >ingresoPlantel</th><th >idCategoriaJornada</th><th >clave</th><th >idCategoria</th><th >categoria</th><th >idJornada</th><th >jornada</th><th >fechaPlaza</th><th >idTipoNombramiento</th><th >clave</th><th >codigo</th><th >descripcion</th><th >tipo</th><th >fechaUltimaPromocion</th><th >idCategoriaJornadaAspira</th><th >clave as claveAspira</th><th >idCategoriaAspira</th><th >categoriaAspira</th>        <th >idJornadaAspira</th><th >jornadaAspira</th><th >idPerfilRequerido</th><th >requisito</th><th >notaSancion</th><th >compatibilidad</th><th >horasOtroSubsistema</th><th >nivelCENNI</th><th >folioCENNI</th><th >idCCT</th><th >cct</th><th >idEntidadEstudio</th><th >idInstitucion</th><th >idTipoInstitucion</th><th >gradoMarginacion</th><th >frenteGrupo</th><th >funcionesOtro</th><th >finRegistro</th><th >consideraciones</th><th >publico</th><th >idPrograma</th><th >idConvocatoria</th><th >idEstatus</th><th >observacionInfo</th><th >observacionEncuestados</th><th >observacionCriterios</th><th >institucion</th><th >cct</th><th >escuela</th><th >carreraOtra</th><th >observacionCriterios2</th><th >idSubsistema</th><th >folio</th><th >tipoVacanciaAspira</th><th >idEstatus</th><th >estatus</th><th >puntaje1</th><th >puntaje2</th><th >observacionInfo</th><th >observacionEncuestados</th><th >observacionCriterios</th><th >posicion</th>"
                + "<th >observacion1</th><th >observacion2</th><th >observacion3</th><th >observacion4</th><th >observacion5</th><th >observacion6</th><th >observacion7</th><th >observacion8</th></tr>";
        ModelReporte reporte = new ModelReporte();
        UtileriasHelper utilerias = new UtileriasHelper();
        String jsonReporte = "";
        try {
            String[] parametros = {idPrograma, idSubsistema, entidad, periodo};
//                List<String[]> datos=metodos.ejecutaSP("sp_reporteAsignacion",parametros);
            reporte.setReporte(metodos.ejecutaSP("sp_reporteAsignacion", parametros));
//                if(!datos.isEmpty()){
//                    long startTimeFor = System.currentTimeMillis();
//                    for(String[] dato:datos)
//                    {   
//                        respuesta+="<tr><th >"+(dato[0]==null?"":dato[0])+"</th><th >"+(dato[1]==null?"":dato[1])+"</th><th >"+(dato[2]==null?"":dato[2])+"</th><th >"+(dato[3]==null?"":dato[3])+"</th><th >"+(dato[4]==null?"":dato[4])+"</th><th >"+(dato[5]==null?"":dato[5])+"</th><th >"+(dato[6]==null?"":dato[6])+"</th><th >"+(dato[7]==null?"":dato[7])+"</th><th >"+(dato[8]==null?"":dato[8])+"</th><th >"+(dato[9]==null?"":dato[9])+"</th><th >"+(dato[10]==null?"":dato[10])+"</th><th >"+dato[11]+"</th><th >"+dato[12]+"</th><th >"+dato[13]+"</th><th >"+dato[14]+"</th><th >"+dato[15]+"</th><th >"+dato[16]+"</th><th >"+dato[17]+"</th><th >"+dato[18]+"</th><th >"+dato[19]+"</th><th >"+dato[20]+"</th><th >"+dato[21]+"</th><th >"+dato[22]+"</th><th >"+dato[23]+"</th><th >"+dato[24]+"</th><th >"+dato[25]+"</th><th >"+dato[26]+"</th><th >"+dato[27]+"</th><th >"+dato[28]+"</th><th >"+dato[29]+"</th><th >"+dato[30]+"</th><th >"+dato[31]+"</th><th >"+dato[32]+"</th><th >"+dato[33]+"</th><th >"+dato[34]+"</th><th >"+dato[35]+"</th><th >"+dato[36]+"</th><th >"+dato[37]+"</th><th >"+dato[38]+"</th><th >"+dato[39]+"</th><th >"+dato[40]+"</th><th >"+dato[41]+"</th><th >"+dato[42]+"</th><th >"+dato[43]+"</th><th >"+dato[44]+"</th><th >"+dato[45]+"</th><th >"+dato[46]+"</th><th >"+dato[47]+"</th><th >"+dato[48]+"</th><th >"+dato[49]+"</th><th >"+dato[50]+"</th><th >"+dato[51]+"</th><th >"+dato[52]+"</th><th >"+dato[53]+"</th><th >"+dato[54]+"</th><th >"+dato[55]+"</th><th >"+dato[56]+"</th><th >"+dato[57]+"</th><th >"+dato[58]+"</th><th >"+dato[59]+"</th><th >"+dato[60]+"</th><th >"+dato[61]+"</th><th >"+dato[62]+"</th><th >"+dato[63]+"</th><th >"+dato[64]+"</th><th >"+dato[65]+"</th><th >"+dato[66]+"</th><th >"+dato[67]+"</th><th >"+dato[68]+"</th><th >"+dato[69]+"</th><th >"+dato[70]+"</th><th >"+dato[71]+"</th><th >"+dato[72]+"</th><th >"+dato[73]+"</th><th >"+dato[74]+"</th><th >"+dato[75]+"</th><th >"+dato[76]+"</th><th >"+dato[77]+"</th><th >"+dato[78]+"</th><th >"+dato[79]+"</th><th >"+dato[80]+"</th><th >"+dato[81]+"</th><th >"+dato[82]+"</th><th >"+dato[83]+"</th><th >"+dato[84]+"</th><th >"+dato[85]+"</th><th >"+dato[86]+"</th>"
//                                + "<th >"+(dato[87]==null?"":dato[87])+"</th><th >"+(dato[88]==null?"":dato[88])+"</th><th >"+(dato[89]==null?"":dato[89])+"</th><th >"+(dato[90]==null?"":dato[90])+"</th><th >"+(dato[91]==null?"":dato[91])+"</th><th >"+(dato[92]==null?"":dato[92])+"</th><th >"+(dato[93]==null?"":dato[93])+"</th><th >"+(dato[94]==null?"":dato[94])+"</th></tr>";
//                    }
//                    endTimeFor = System.currentTimeMillis() - startTimeFor;
//                }
//                respuesta+="</table>";
//                System.out.println("Duración consulta " + endTime + " milisegundos.");
//                System.out.println("Duración for " + endTimeFor + " milisegundos.");

//                return respuesta;
            jsonReporte = utilerias.convertObjectToJson(reporte);
            return jsonReporte;
        } catch (Exception e) {
            respuesta = e.toString();
        } finally {
//            return respuesta;
            return jsonReporte;
        }
    }

    public String generarReporteEstatal(String idPrograma,String idSubsistema,String periodo) {
        String respuesta = "<table><tr><th >id</th><th >nombre</th><th >primerApellido</th><th >segundoApellido</th><th >correo</th><th >curp</th><th >idPlantel</th><th >idEntidad</th><th >entidad</th><th >cct</th><th >plantel</th><th >telfijo</th><th >telcel</th><th >consideraciones</th><th >idEscuelaEstudio</th><th >escuela</th><th >idCarrera</th><th >carrera</th><th >anioEgreso</th><th >idGradoAcademico</th><th >grado</th><th >idModalidadTitulacion</th><th >modalidad</th><th >anioTitulacion</th><th >cedula</th><th >activo</th><th >ingresoSubsistema</th><th >ingresoPlantel</th><th >idCategoriaJornada</th><th >clave</th><th >idCategoria</th><th >categoria</th><th >idJornada</th><th >jornada</th><th >fechaPlaza</th><th >idTipoNombramiento</th><th >clave</th><th >codigo</th><th >descripcion</th><th >tipo</th><th >fechaUltimaPromocion</th><th >idCategoriaJornadaAspira</th><th >clave as claveAspira</th><th >idCategoriaAspira</th><th >categoriaAspira</th>        <th >idJornadaAspira</th><th >jornadaAspira</th><th >idPerfilRequerido</th><th >requisito</th><th >notaSancion</th><th >compatibilidad</th><th >horasOtroSubsistema</th><th >nivelCENNI</th><th >folioCENNI</th><th >idCCT</th><th >cct</th><th >idEntidadEstudio</th><th >idInstitucion</th><th >idTipoInstitucion</th><th >gradoMarginacion</th><th >frenteGrupo</th><th >funcionesOtro</th><th >finRegistro</th><th >consideraciones</th><th >publico</th><th >idPrograma</th><th >idConvocatoria</th><th >idEstatus</th><th >observacionInfo</th><th >observacionEncuestados</th><th >observacionCriterios</th><th >institucion</th><th >cct</th><th >escuela</th><th >carreraOtra</th><th >observacionCriterios2</th><th >idSubsistema</th><th >folio</th><th >tipoVacanciaAspira</th><th >idEstatus</th><th >estatus</th><th >puntaje1</th><th >puntaje2</th><th >observacionInfo</th><th >observacionEncuestados</th><th >observacionCriterios</th><th >posicion</th>"
                + "<th >observacion1</th><th >observacion2</th><th >observacion3</th><th >observacion4</th><th >observacion5</th><th >observacion6</th><th >observacion7</th><th >observacion8</th></tr>";
        ModelReporteEstatal reporteEstatal = new ModelReporteEstatal();
        UtileriasHelper utilerias = new UtileriasHelper();
        String jsonReporte = "";
        try {
            String[] parametros = {idPrograma,idSubsistema,periodo};
            reporteEstatal.setReporte(metodos.ejecutaSP("sp_reporteAsignacionEstatal", parametros));
            
            jsonReporte = utilerias.convertObjectToJson(reporteEstatal);
            return jsonReporte;
        } catch (Exception e) {
            respuesta = e.toString();
        } finally {
//            return respuesta;
            return jsonReporte;
        }
    }

    public String validarSeleccionadasAdd(String idUsuario) {
        String respuesta = "";
        int horas = 0, totalHoras = 0, numPlazas = 0;
        String idCategoria = "-1", idJornada = "-1", idCategoriaAux = "", idJornadaAux = "";
        String idNombramiento = "", idNombramientoAux = "";
        try {
            String[] parametros = {idUsuario};
            List<String[]> datos = metodos.ejecutaSP("sp_consultaUsuarioPlaza", parametros);
            if (!datos.isEmpty()) {
                respuesta = "";
                for (String[] dato : datos) {
                    if (dato[4].equals("1")) {
                        idCategoria = dato[2];
                        idJornada = dato[4];
                        idNombramiento = dato[8];
                        if (dato[4].equals("1")) {
                            horas += Integer.parseInt(dato[6]);
                        }
                        System.out.println(idCategoria + "-" + idCategoriaAux + "-" + idJornada + "-" + idJornadaAux);

                        if (dato[15].equals("1")) {//Para el programa 1:Cambio categoria solo puede sumar plazas con la misma categoria y jornada
                            if (!idCategoriaAux.isEmpty()) {
                                if (!idCategoriaAux.equals(idCategoria) || !idJornadaAux.equals(idJornada)) {
                                    respuesta = "Solo puede seleccionar plazas de la misma categoria y jornada";
                                }
                            }
                        } else if (dato[15].equals("2")) {//Para el programa 2:Horas adicionales solo puede sumar plazas con jornada de horas
                            if (!idJornada.equals("1")) {
                                respuesta = "Solo puede seleccionar plazas con jornada de horas";
                            }
//                            if(horas>19){
//                                respuesta="Solo puede acumular 19 horas como máximo";
//                            }
                        }

                        idCategoriaAux = idCategoria;
                        idJornadaAux = idJornada;
                        idNombramientoAux = idNombramiento;
                        numPlazas++;
                        totalHoras = horas;
                    }

                }
                if (!idJornada.equals("1") && numPlazas > 1) {
                    respuesta = "Solo puede seleccionar una plaza con la que participará";
                } else {
                    if (respuesta.isEmpty()) {
                        respuesta = idCategoria + "," + idJornada + "," + horas + "," + idNombramiento + "," + totalHoras;
                    }
                }
            }
        } catch (Exception e) {
            respuesta = e.toString();
        } finally {
            return respuesta;
        }
    }

    public String validarSeleccionadasAdd1(String idUsuario) {
        String respuesta = "";
        int horas = 0, totalHoras = 0, numPlazas = 0;
        String idCategoria = "-1", idJornada = "-1", idCategoriaAux = "", idJornadaAux = "";
        String idNombramiento = "", idNombramientoAux = "";
        try {
            String[] parametros = {idUsuario};
            List<String[]> datos = metodos.ejecutaSP("sp_consultaUsuarioPlaza", parametros);
            if (!datos.isEmpty()) {
                respuesta = "0";
                for (String[] dato : datos) {
                    if (!dato[4].equals("1")) {
                        idCategoria = dato[2];
                        idJornada = dato[4];
                        if (dato[15].equals("2")) {//Para el programa 2:Horas adicionales solo puede sumar plazas con jornada de horas
                            if (!idJornada.equals("1")) {
                                respuesta = "1";
                            }
                        }
                    }
                }
            }

        } catch (Exception e) {
            respuesta = e.toString();
        } finally {
            return respuesta;
        }
    }

    public String desplegarCategoriasAspira(String idUsuario) {
        String respuesta = "<tr><td colspan='7' class='text-center'>Sin información</td></tr>";
        try {
            String[] parametros = {idUsuario};
            List<String[]> datos = metodos.ejecutaSP("sp_consultaUsuarioCategoriaAspira", parametros);
            if (!datos.isEmpty()) {
                respuesta = "";
                for (String[] dato : datos) {
                    respuesta += "<tr><td>" + dato[3] + "</td><td>" + dato[5] + "</td><td>" + dato[6] + "</td>";
                    respuesta += "<td><button type='button' class='btn btn-sm' title='Borrar' onclick='confirmarCategoriaAspira(" + dato[0] + ")'><span class='glyphicon glyphicon-trash'></span></button>";
                    respuesta += "</td></tr>";
                }
            }
        } catch (Exception e) {
            respuesta = e.toString();
        } finally {
            return respuesta;
        }
    }

    public String validarHorasAspira(String idUsuario) {
        String respuesta = "0";

        try {
            String[] parametros = {idUsuario};
            List<String[]> datos = metodos.ejecutaSP("sp_consultaUsuarioCategoriaAspira", parametros);
            if (!datos.isEmpty()) {
                int suma = 0;
                for (String[] dato : datos) {
                    suma += Integer.parseInt(dato[6]);
                }
                respuesta = "" + suma;
            }

        } catch (Exception e) {
            respuesta = e.toString();
        } finally {
            return respuesta;
        }
    }

    public String validarSeleccionadasCambioDeCategoria(String idUsuario) {
        String respuesta = "";
        String idCategoria = "-1", idJornada = "-1";
        String[] docenteCambioCategoria = {"1", "2"};
        String[] tecnicoDdocente = {"10", "11"};
        List<String> dCambio = new ArrayList<>(Arrays.asList(docenteCambioCategoria));
        List<String> td = new ArrayList<>(Arrays.asList(tecnicoDdocente));
        try {
            String[] parametros = {idUsuario};
            List<String[]> datos = metodos.ejecutaSP("sp_consultaUsuarioPlaza", parametros);
            if (!datos.isEmpty()) {
                respuesta = "";
                for (String[] dato : datos) {
                    if (dato[12].equals("V")) {
                        idCategoria = dato[2];
                        idJornada = dato[4];
                        if (dato[15].equals("1")) {
                            if (td.contains(idCategoria) || dCambio.contains(idCategoria)) {
                                //respuesta="Solo puede seleccionar plazas de horas C E4523";
                                respuesta = "1A-E4523";
                            }
                        }
                    }
                }
            }
        } catch (Exception e) {
            respuesta = e.toString();
        } finally {
            return respuesta;
        }
    }

    public String desplegarGanadores(String programa, String subsistema,
            String estado, String plantel, String rfc, String periodo) {
        String respuesta = "<tr><td colspan='10' class='text-center'>Sin información</td></tr>";
        try {
            SimpleDateFormat sp = new SimpleDateFormat("dd/MM/yyyy");
            String[] parametros = {programa, subsistema, estado, plantel, rfc, periodo};
            List<String[]> datos = metodos.ejecutaSP("sp_consultaGanadores_v2", parametros);
            if (!datos.isEmpty()) {
                respuesta = "";
                for (String[] dato : datos) {
                    String vacancia= dato[11] != null ? dato[11] : "";
                    if (dato[9] == null) {
                        dato[9] = "NA ";
                    }
                    String dato1 = "1";
                    respuesta += "<tr>"
                            + "<td>" + dato[0] + "</td>"
                            + "<td>" + dato[1] + "</td>"
                            + "<td>" + dato[2] + "</td>"
                            + "<td>" + dato[3] + "</td>"
                            + "<td>" + dato[4] + "</td>"
                            + "<td>" + dato[5] + "</td>"
                            + "<td>" + dato[7] + "</td>"
                            + "<td>" + dato[8] + "</td>"
                            + "<td>" + dato1 + "</td>"
                            + "<td id='" + dato[10] + "'>" + 
                            dato[9] + " <a id='" 
                            + dato[4] 
                            + "' onClick='mostrarDatePicker(this.id);'><i class='fa fa-edit' style='color:#9d2449;'></i></a></td>"
                            + "<td>" +vacancia+ "</td>";
                    respuesta += "</tr>";
                }
            }

        } catch (Exception e) {
            respuesta = e.toString();
        } finally {
            return respuesta;
        }
    }

    public String consultaFechaAplicacion(String id) {
        //Aqui tambien este lee ese misma fecha
        String respuesta = "";
        try {
            String[] parametros = {id};
            List<String[]> datos = metodos.ejecutaSP("sp_consultaFechaAplicacion", parametros);
            if (!datos.isEmpty()) {
                respuesta = "";
                respuesta = datos.get(0)[0];
                if (respuesta == null) {
                    respuesta = "NA ";
                }
            }

        } catch (Exception e) {
            respuesta = e.toString();
        } finally {
            return respuesta;
        }
    }

    public String actualizaFechaAplicacion(String id, String fecha) {
        String respuesta = "";
        try {
            String[] parametros = {id, fecha};
            List<String[]> datos = metodos.ejecutaSP("sp_actualizaFechaAplicacion", parametros);
            if (!datos.isEmpty()) {
                respuesta = "";
                respuesta = datos.get(0)[0];
            }

        } catch (Exception e) {
            respuesta = e.toString();
        } finally {
            return respuesta;
        }
    }
    
    public ArrayList<String> validacionComboPlazaQueParticipaCDC(String idUsuario){ 
        Metodos_sql metodo = new Metodos_sql(); 
        ArrayList<String> lista=new ArrayList<>();
        boolean bandera=false;
        int totalHoras=0;
        String horas="0", idJornada="", idCategoria="", idCategoriaAspira="",idTipoNombramiento="", auxM="",idJornadaAspira;
        
        String[] parametros={idUsuario};
        
        List<String[]> datosRegistro=metodo.ejecutaSP("sp_consultaRegistro",parametros);
        if ( !datosRegistro.isEmpty() ) {
            if ( datosRegistro.get(0)[85] != null ) {
                idJornadaAspira=datosRegistro.get(0)[44];
                idCategoriaAspira=datosRegistro.get(0)[42];
                String respuesta=new Datos().validarSeleccionadas(idUsuario);
                if(respuesta.contains(",")){
                    String[] aux=respuesta.split(",");
                    idCategoria=aux[0];
                    idJornada=aux[1];
                    horas=aux[2];
                    if(aux.length==4){
                        idTipoNombramiento=aux[3];   
                    }
                }
                //String[] categoria;
                //categoria = categoriaNombre.split("-");
                //idCategoriaAspira=categoria[0];
                //idJornadaAspira=request.getParameter("jornadaAspira");
                if(idJornadaAspira.equals("")){
                    idJornadaAspira="0";
                }

                if(idTipoNombramiento.equals(ConstantsWS.ALTA_DEFINITIVA) || idTipoNombramiento.equals(ConstantsWS.ALTA_PROVICIONAL)){
                    int categoriaActual=Integer.parseInt(idCategoria);
                    int categoriaAspira=Integer.parseInt(idCategoriaAspira);
                    int jornadaActual=Integer.parseInt(idJornada);
                    int jornadaAspira=Integer.parseInt(idJornadaAspira);
                    String respuestaValidacionCDC=new Datos().validarSeleccionadasCambioDeCategoria(idUsuario);
                    if((categoriaActual==3 && categoriaAspira==4 && idJornadaAspira.equals("2"))||
                      (categoriaActual==2 && categoriaAspira==4 && idJornadaAspira.equals("2")) ||
                      (categoriaActual==1 && categoriaAspira==4 && idJornadaAspira.equals("2"))
                        //((categoriaActual==11 && categoriaAspira==12))
                      ){
                        if(Integer.parseInt(horas)>=18 && Integer.parseInt(horas)<=19){
                            bandera=true;}
                    }else{
                        if(categoriaAspira==categoriaActual && jornadaAspira==jornadaActual+1){
                            bandera=true;
                        }else if(categoriaAspira==categoriaActual+1 && jornadaAspira==jornadaActual){
                            bandera=true;
                        }else if(categoriaAspira==categoriaActual+1 && jornadaAspira==jornadaActual+1){
                            bandera=true;
                        }
                    }
                    totalHoras=Integer.parseInt(horas);
                    if(totalHoras>19 && (jornadaAspira==3 || jornadaAspira==4 || jornadaAspira==2)){
                        bandera=false;
                    }else if(respuestaValidacionCDC.equals("1A-E4523")){
                        //out.println("Solo puede seleccionar plazas de horas C E4523");
                        bandera=false;
                    }
                }else{
                    auxM="-El tipo de nombramiento no es valido para esta convocatoria solo puedes partipar con Alta definitiva o Alta provisional-";      
                }
                if(bandera==true){
                    String[] parametros2={ idCategoria, idJornada, idUsuario};
                    metodo.ejecutaSP("sp_actualizaCategoriayJornada",parametros2); 
                }
            }else{
                bandera=true;
            }
        }
        lista.add(""+bandera);
        lista.add(auxM);
        return lista;
    }
    public String generarResultadosZonaEconomica(String programa,String idSubsistema,String entidad,String plantel,String vacancia,String periodo){        
        String respuesta="<tr><td colspan='9' class='text-center'>Sin información</td></tr>";        
        try{
            ///Consulta catalogo de Zona Economica
            List<String[]> datosZonaEconomica=metodos.ejecutaSP("sp_selectCatZonaEconomica");
            for(String[] idZonaEconomica:datosZonaEconomica){
                String zonaEconomica=idZonaEconomica[0];
                ///Consulta el catalogo de entidades
                List<String[]> datosEntidades=metodos.ejecutaSP("sp_selectCatEntidades");
                for(String[] dato:datosEntidades){
                        String idEntidad=dato[0];
//                        String[] parametrosVacancia={programa, idSubsistema, idEntidad,vacancia,periodo,zonaEconomica};
                        String[] parametrosVacancia={programa, idSubsistema, idEntidad,"",periodo,zonaEconomica};
                        //Se obtiene la vacancia de acuerdo a entidad y que esta no haya sido asignada sin importar la categoria ni jornada
                        //Realizar Mejora en el proceso de asignacion
                        List<String[]> datosVacancias=metodos.ejecutaSP("sp_consultaVacanciasZonaEconomica",parametrosVacancia);
                        if(datosVacancias.size()>0){
                            //Se iteran las vacancias previamente consultadas.
                            for(String[] datosVacancia:datosVacancias){
                                    String[] parametrosGanador={programa, idSubsistema, idEntidad, datosVacancia[0], datosVacancia[2],vacancia, periodo, zonaEconomica};
                                    //Consulta los aspirantes que particpan para esta ronda.
                                    //Consultar en sp_consultaAspirantePorZona los que existen en la tabla de ganadores.
                                    List<String[]> datosGanador=metodos.ejecutaSP("sp_consultaAspirantePorZona",parametrosGanador);
                                        if(!datosGanador.isEmpty()){
                                            int posicion=0;
                                            for(String[] datoGanador:datosGanador){
                                                posicion++;
                                                //Se valida que el parcticipante no exista en la tabla de ganadores al menos para el periodo en el que se esta ejecutando el proceso.
//                                                String[] parametrosGanadorE={datoGanador[0],periodo};
//                                                List<String[]> datosGanadorE=metodos.ejecutaSP("sp_consultaGanadores",parametrosGanadorE);
//                                                int isGanador=Integer.parseInt(datosGanadorE.get(0)[0]);
//                                                if(isGanador==0){
                                                    
//                                                  String[] parametrosGanador1={datoGanador[0],Integer.toString(1)};
                                                    String[] parametrosGanador1={datoGanador[0],Integer.toString(posicion)};
                                                    //String[] parametrosRonda={datoGanador[0],"2"};
                                                    //String[] parametrosActualizarVacancia={datosVacancia[9]};
                                                    String[] parametrosInsertGanador={datoGanador[0],idSubsistema,programa,periodo,"2",datosVacancia[9]};
                                                    metodos.ejecutaSP("sp_insertPosicionZona",parametrosGanador1);
                                                    //inserta en el la tabla de aspirante la ronda en la que se le asigno la plaza.
                                                    //metodos.ejecutaSP("sp_actualizaRondaGanador",parametrosRonda);
                                                    //Se actualiza la vacancia cuando esta es asignada. Revisar fuera del for.
                                                    //metodos.ejecutaSP("sp_actualizarPlazaAsignada",parametrosActualizarVacancia);
                                                    //Se inserta el usuario en la tabla de ganadoresasignacion.
                                                    metodos.ejecutaSP(constants.SP_INSERT_GANADORES_ASIGNACION,parametrosInsertGanador); 
                                                    //break;
//                                                }
                                            }
                                        }
                            }
                        }
                }
            }
            return respuesta;
        }catch(Exception e){
            respuesta=e.toString();
        }finally{
            return respuesta;  
        }
    }
    public String generarResultadosZonaEconomicaPorEntidad(String programa,String idSubsistema,String entidad,String plantel,String vacancia,String periodo){        
        String respuesta="<tr><td colspan='9' class='text-center'>Sin información</td></tr>";        
        try{
            ///Consulta catalogo de Zona Economica
            List<String[]> datosZonaEconomica=metodos.ejecutaSP("sp_selectCatZonaEconomica");
            for(String[] idZonaEconomica:datosZonaEconomica){
                String zonaEconomica=idZonaEconomica[0];
                ///Consulta el catalogo de entidades
//                List<String[]> datosEntidades=metodos.ejecutaSP("sp_selectCatEntidades");
//                for(String[] dato:datosEntidades){
                        String idEntidad=entidad;
//                        String[] parametrosVacancia={programa, idSubsistema, idEntidad,vacancia,periodo,zonaEconomica};
                        String[] parametrosVacancia={programa, idSubsistema, idEntidad,"",periodo,zonaEconomica};
                        //Se obtiene la vacancia de acuerdo a entidad y que esta no haya sido asignada sin importar la categoria ni jornada
                        //Realizar Mejora en el proceso de asignacion
                        List<String[]> datosVacancias=metodos.ejecutaSP("sp_consultaVacanciasZonaEconomica",parametrosVacancia);
                        if(datosVacancias.size()>0){
                            //Se iteran las vacancias previamente consultadas.
                            for(String[] datosVacancia:datosVacancias){
                                    String[] parametrosGanador={programa, idSubsistema, idEntidad, datosVacancia[0], datosVacancia[2],vacancia, periodo, zonaEconomica};
                                    //Consulta los aspirantes que particpan para esta ronda.
                                    //Consultar en sp_consultaAspirantePorZona los que existen en la tabla de ganadores.
                                    List<String[]> datosGanador=metodos.ejecutaSP("sp_consultaAspirantePorZona",parametrosGanador);
                                        if(!datosGanador.isEmpty()){
                                            int posicion=0;
                                            for(String[] datoGanador:datosGanador){
                                                posicion++;
                                                //Se valida que el parcticipante no exista en la tabla de ganadores al menos para el periodo en el que se esta ejecutando el proceso.
//                                                String[] parametrosGanadorE={datoGanador[0],periodo};
//                                                List<String[]> datosGanadorE=metodos.ejecutaSP("sp_consultaGanadores",parametrosGanadorE);
//                                                int isGanador=Integer.parseInt(datosGanadorE.get(0)[0]);
//                                                if(isGanador==0){
                                                    
//                                                  String[] parametrosGanador1={datoGanador[0],Integer.toString(1)};
                                                    String[] parametrosGanador1={datoGanador[0],Integer.toString(posicion)};
                                                    //String[] parametrosRonda={datoGanador[0],"2"};
                                                    //String[] parametrosActualizarVacancia={datosVacancia[9]};
                                                    String[] parametrosInsertGanador={datoGanador[0],idSubsistema,programa,periodo,"2",datosVacancia[9]};
                                                    metodos.ejecutaSP("sp_insertPosicionZona",parametrosGanador1);
                                                    //inserta en el la tabla de aspirante la ronda en la que se le asigno la plaza.
                                                    //metodos.ejecutaSP("sp_actualizaRondaGanador",parametrosRonda);
                                                    //Se actualiza la vacancia cuando esta es asignada. Revisar fuera del for.
                                                    //metodos.ejecutaSP("sp_actualizarPlazaAsignada",parametrosActualizarVacancia);
                                                    //Se inserta el usuario en la tabla de ganadoresasignacion.
                                                    metodos.ejecutaSP(constants.SP_INSERT_GANADORES_ASIGNACION,parametrosInsertGanador); 
                                                    //break;
//                                                }
                                            }
                                        }
                            }
                        }
//                }
            }
            return respuesta;
        }catch(Exception e){
            respuesta=e.toString();
        }finally{
            return respuesta;  
        }
    }
    public String desplegarAspirantesPorZona(String id,String idPrograma,String idSubsistema,String idEntidad,String idPlantel,String categoria,String jornada,String vacancia, String periodo){        
        String respuesta="<tr><td colspan='9' class='text-center'>Sin información</td></tr>";        
        try{
            String[] parametros={idPrograma,idSubsistema,idEntidad,idPlantel,categoria,jornada,vacancia,periodo};
            if(idEntidad.isEmpty() && idPlantel.isEmpty()){
                return respuesta;
            }else{
                if(id.contains("b")){
                    List<String[]> datos=metodos.ejecutaSP("sp_consultaGanadorPorZona",parametros);
                
                    if(!datos.isEmpty()){
                        respuesta="";
                        for(String[] dato:datos)
                        {
                            respuesta+="<tr><td>"+dato[2]+"</td><td>"+dato[4]+"</td><td>"+dato[6]+"</td><td>"+dato[8]+"</td><td>"+dato[12]+"</td><td>"+dato[16]+"</td><td>"+dato[11]+"</td><td>"+dato[13]+"</td><td>"+(dato[10]==null?"0":dato[10])+"</td>";
                            if(dato[10]==null || dato[15]==null){
                                respuesta+="<td>"+"***"+"</td><td>"+dato[17]+"</td></tr>";
                            }else{
                                respuesta+="<td>"+dato[15]+"</td>"+"+<td>"+dato[17]+"</td></tr>";
                            }
                        }
                        return respuesta;
                    }
                }
            }
        }catch(Exception e){
            respuesta=e.toString();
        }finally{
            return respuesta;        
        }
    }
    public String desplegarAspirantesZona(String id,String idPrograma,String idSubsistema,String idEntidad,String periodo,String vacancia,String zonaEconomica,String idCategoria){        
        String respuesta="<tr><td colspan='9' class='text-center'>Sin información</td></tr>";        
        try{
            String[] parametros={idPrograma,idSubsistema,idEntidad,periodo,vacancia,zonaEconomica,idCategoria};
            if(idEntidad.isEmpty()){
                return respuesta;
            }else{
                if(id.contains("b")){
                    List<String[]> datos=metodos.ejecutaSP("sp_consultaGanadorZona",parametros);
                    List<String[]> datosCatAsignacion=metodos.ejecutaSP(constants.SP_SELECT_CAT_ASIGNACION);
                    String estatus1=datosCatAsignacion.get(0)[0];
                    String estatus2=datosCatAsignacion.get(1)[0];
                    String estatus3=datosCatAsignacion.get(2)[0];
                    String estatus4=datosCatAsignacion.get(3)[0];
                    
                    String estatusDesc1=datosCatAsignacion.get(0)[1];
                    String estatusDesc2=datosCatAsignacion.get(1)[1];
                    String estatusDesc3=datosCatAsignacion.get(2)[1];
                    String estatusDesc4=datosCatAsignacion.get(3)[1];
                    
                    if(!datos.isEmpty()){
                        respuesta="";
                        for(String[] dato:datos)
                        {
                            respuesta+="<tr><td>"+dato[4]+"</td><td>"+dato[6]+"</td><td>"+dato[8]+"</td><td>"+dato[18]+"</td><td>"+dato[19]+"</td><td>"+dato[11]+" "+(dato[21]==null?"":dato[21])+" "+(dato[22]==null?"":dato[22])+"</td><td>"+dato[13]+"</td><td>"+(dato[10]==null?"0":dato[10])+"</td><td>"+dato[17]+"</td>";
                            if(dato[10]==null || dato[15]==null){
                                respuesta+="<td>"+"***"+"</td>"+"</tr>";
                            }else{
                                //respuesta+="<td>"+(datos.indexOf(dato)+1)+"</td>"+"</tr>";
                                respuesta+="<td>"+dato[15]+"</td>";
                            }
                            String tvacancia="tvacancia"+dato[0].toString();
                            if(dato[20]==null){
                                respuesta+="<td><div class=\"form-group col-md-24\">  \n" +
            "                            <select class=\"form-control input-sm\" id="+tvacancia+" name=\"tvacancia2\" required>\n" +
            "                                <option value=\"\" selected>Seleccionar una opción</option>\n" +
            "                                <option value="+estatus1+">"+estatusDesc1+"</option>\n" +
            "                                <option value="+estatus2+">"+estatusDesc2+"</option>\n" +
            "                                <option value="+estatus3+">"+estatusDesc3+"</option>\n" +
            "                            </select>\n" +
            "                        </div></td><td><button type='button' class='btn btn-sm' title='Borrar' onclick='confirmarCategoriaZona("+dato[0]+")'><span class='glyphicon glyphicon-floppy-disk incompleto2'></span></button></td>"+"</tr>";
                            }else{
                                if(dato[20].equals("1")){
                                    respuesta+="<td><div class=\"form-group col-md-24\">  \n" +
            "                            <select class=\"form-control input-sm\" id="+tvacancia+" name=\"tvacancia2\" required>\n" +
            "                                <option value=\"\" selected>Seleccionar una opción</option>\n" +
            "                                <option value="+estatus1+" selected>"+estatusDesc1+"</option>\n" +
            "                                <option value="+estatus2+">"+estatusDesc2+"</option>\n" +
            "                                <option value="+estatus3+">"+estatusDesc3+"</option>\n" +
            "                                <option value="+estatus4+">"+estatusDesc4+"</option>\n" +
            "                            </select>\n" +
            "                        </div></td><td><button type='button' class='btn btn-sm' title='Borrar' onclick='confirmarCategoriaZona("+dato[0]+")'><span class='glyphicon glyphicon-floppy-disk incompleto2'></span></button></td>"+"</tr>";
                                    }else if(dato[20].equals("2")){
                                        respuesta+="<td><div class=\"form-group col-md-24\">  \n" +
            "                            <select class=\"form-control input-sm\" id="+tvacancia+" name=\"tvacancia2\" required>\n" +
            "                                <option value=\"\" selected>Seleccionar una opción</option>\n" +
            "                                <option value="+estatus1+">"+estatusDesc1+"</option>\n" +
            "                                <option value="+estatus2+" selected>"+estatusDesc2+"</option>\n" +
            "                                <option value="+estatus3+">"+estatusDesc3+"</option>\n" +
            "                                <option value="+estatus4+">"+estatusDesc4+"</option>\n" +
            "                            </select>\n" +
            "                        </div></td><td><button type='button' class='btn btn-sm' title='Borrar' onclick='confirmarCategoriaZona("+dato[0]+")'><span class='glyphicon glyphicon-floppy-disk incompleto2'></span></button></td>"+"</tr>";
                                    }else if(dato[20].equals("3")){
                                        respuesta+="<td><div class=\"form-group col-md-24\">  \n" +
            "                            <select class=\"form-control input-sm\" id="+tvacancia+" name=\"tvacancia2\" required>\n" +
            "                                <option value=\"\">Seleccionar una opción</option>\n" +
            "                                <option value="+estatus1+">"+estatusDesc1+"</option>\n" +
            "                                <option value="+estatus2+">"+estatusDesc2+"</option>\n" +
            "                                <option value="+estatus3+" selected>"+estatusDesc3+"</option>\n" +
            "                                <option value="+estatus4+">"+estatusDesc4+"</option>\n" +
            "                            </select>\n" +
            "                        </div></td><td><button type='button' class='btn btn-sm' title='Borrar' onclick='confirmarCategoriaZona("+dato[0]+")'><span class='glyphicon glyphicon-floppy-disk incompleto2'></span></button></td>"+"</tr>";
                                    }else if(dato[20].equals("4")){
                                        respuesta+="<td><div class=\"form-group col-md-24\">  \n" +
            "                            <select class=\"form-control input-sm\" id="+tvacancia+" name=\"tvacancia2\" required>\n" +
            "                                <option value=\"\">Seleccionar una opción</option>\n" +
            "                                <option value="+estatus1+">"+estatusDesc1+"</option>\n" +
            "                                <option value="+estatus2+">"+estatusDesc2+"</option>\n" +
            "                                <option value="+estatus3+">"+estatusDesc3+"</option>\n" +
            "                                <option value="+estatus4+" selected>"+estatusDesc4+"</option>\n" +
            "                            </select>\n" +
            "                        </div></td><td><button type='button' class='btn btn-sm' title='Borrar' onclick='confirmarCategoriaZona("+dato[0]+")'><span class='glyphicon glyphicon-floppy-disk incompleto2'></span></button></td>"+"</tr>";
                                    }
                            }
                            
                        }
                        return respuesta;
                    }else{
                        respuesta="<tr><td colspan='9' class='text-center'>Sin información</td></tr>";
                    }
                }
            }
        }catch(Exception e){
            respuesta=e.toString();
        }finally{
            return respuesta;       
        }
    }
    public String desplegarAspirantesAsignacionUpdate(String id,String idPrograma,String idSubsistema,String idEntidad,String idPlantel,String categoria,String jornada,String vacancia, String periodo){        
        String respuesta="";        
        try{
            String[] parametros={idPrograma,idSubsistema,idEntidad,idPlantel,categoria,jornada,vacancia,periodo};
                    List<String[]> datos=metodos.ejecutaSP(constants.SP_CONSULTA_GANADOR_ASPIRANTE,parametros);
                    List<String[]> datosCatAsignacion=metodos.ejecutaSP(constants.SP_SELECT_CAT_ASIGNACION);
                    String estatus1=datosCatAsignacion.get(0)[0];
                    String estatus2=datosCatAsignacion.get(1)[0];
                    String estatus3=datosCatAsignacion.get(2)[0];
                    
                    String estatusDesc1=datosCatAsignacion.get(0)[1];
                    String estatusDesc2=datosCatAsignacion.get(1)[1];
                    String estatusDesc3=datosCatAsignacion.get(2)[1];
                    
                    
                    if(!datos.isEmpty()){
                        respuesta="";
                        for(String[] dato:datos)
                        {
    //                        respuesta+="<tr><td>"+dato[4]+"</td><td>"+dato[6]+"</td><td>"+dato[8]+"</td><td>"+dato[12]+"</td><td>"+dato[16]+"</td><td>"+dato[11]+"</td><td>"+dato[13]+"</td><td>"+(dato[10]==null?"0":dato[10])+"</td>";
                            respuesta+="<tr><td>"+dato[4]+"</td><td>"+dato[6]+"</td><td>"+dato[8]+"</td><td>"+dato[17]+"</td><td>"+dato[18]+"</td><td>"+dato[11]+"</td><td>"+dato[13]+"</td><td>"+(dato[10]==null?"0":dato[10])+"</td>";
                            if(dato[10]==null || dato[15]==null){
                                respuesta+="<td>"+"***"+"</td>"+"</tr>";
                            }else{
                                //respuesta+="<td>"+(datos.indexOf(dato)+1)+"</td>"+"</tr>";
                                respuesta+="<td>"+dato[15]+"</td>";
                            }
                            String tvacancia="tvacancia"+dato[0].toString();
                            if(dato[19]==null){
                                respuesta+="<td><div class=\"form-group col-md-24\">  \n" +
            "                            <select class=\"form-control input-sm\" id="+tvacancia+" name=\"tvacancia2\" required>\n" +
            "                                <option value=\"\" selected>Seleccionar una opción</option>\n" +
            "                                <option value="+estatus1+">"+estatusDesc1+"</option>\n" +
            "                                <option value="+estatus2+">"+estatusDesc2+"</option>\n" +
            "                                <option value="+estatus3+">"+estatusDesc3+"</option>\n" +
            "                            </select>\n" +
            "                        </div></td><td><button type='button' class='btn btn-sm' title='Borrar' onclick='confirmarCategoria("+dato[0]+")'><span class='glyphicon glyphicon-floppy-disk incompleto2'></span></button></td>"+"</tr>";
                            }else{
                                if(dato[19].equals("1")){
                                    respuesta+="<td><div class=\"form-group col-md-24\">  \n" +
            "                            <select class=\"form-control input-sm\" id="+tvacancia+" name=\"tvacancia2\" required>\n" +
            "                                <option value=\"\" selected>Seleccionar una opción</option>\n" +
            "                                <option value="+estatus1+" selected>"+estatusDesc1+"</option>\n" +
            "                                <option value="+estatus2+">"+estatusDesc2+"</option>\n" +
            "                                <option value="+estatus3+">"+estatusDesc3+"</option>\n" +
            "                            </select>\n" +
            "                        </div></td><td><button type='button' class='btn btn-sm' title='Borrar' onclick='confirmarCategoria("+dato[0]+")'><span class='glyphicon glyphicon-floppy-disk incompleto2'></span></button></td>"+"</tr>";
                                    }else if(dato[19].equals("2")){
                                        respuesta+="<td><div class=\"form-group col-md-24\">  \n" +
            "                            <select class=\"form-control input-sm\" id="+tvacancia+" name=\"tvacancia2\" required>\n" +
            "                                <option value=\"\" selected>Seleccionar una opción</option>\n" +
            "                                <option value="+estatus1+">"+estatusDesc1+"</option>\n" +
            "                                <option value="+estatus2+" selected>"+estatusDesc2+"</option>\n" +
            "                                <option value="+estatus3+">"+estatusDesc3+"</option>\n" +
            "                            </select>\n" +
            "                        </div></td><td><button type='button' class='btn btn-sm' title='Borrar' onclick='confirmarCategoria("+dato[0]+")'><span class='glyphicon glyphicon-floppy-disk incompleto2'></span></button></td>"+"</tr>";
                                    }else if(dato[19].equals("3")){
                                        respuesta+="<td><div class=\"form-group col-md-24\">  \n" +
            "                            <select class=\"form-control input-sm\" id="+tvacancia+" name=\"tvacancia2\" required>\n" +
            "                                <option value=\"\">Seleccionar una opción</option>\n" +
            "                                <option value="+estatus1+">"+estatusDesc1+"</option>\n" +
            "                                <option value="+estatus2+">"+estatusDesc2+"</option>\n" +
            "                                <option value="+estatus3+" selected>"+estatusDesc3+"</option>\n" +
            "                            </select>\n" +
            "                        </div></td><td><button type='button' class='btn btn-sm' title='Borrar' onclick='confirmarCategoria("+dato[0]+")'><span class='glyphicon glyphicon-floppy-disk incompleto2'></span></button></td>"+"</tr>";
                                    }
                            }
                            
                        }
                        return respuesta;
                    }else{
                        respuesta="<tr><td colspan='9' class='text-center'>Sin información</td></tr>";
                    }
        }catch(Exception e){
            respuesta=e.toString();
        }finally{
            return respuesta;        
        }
    }
    public String asignacionVacanciaPosicion1(String programa,String idSubsistema,String periodo){        
        String respuesta="";        
        try{
            
            List<String[]> datosSetValores=metodos.ejecutaSP("sp_updatePlazasPreliminares");
            List<String[]> datosEntidades=metodos.ejecutaSP("sp_selectCatEntidades");
            for(String[] dato:datosEntidades){
                String[] parametros={idSubsistema,dato[0]};
                List<String[]> datos=metodos.ejecutaSP("sp_selectCatPlanteles",parametros);
                for(String[] datoPlanteles:datos){
                    String idEntidad=dato[0];
                    String idPlantel=datoPlanteles[0];
                    String[] parametrosGanador={programa,idSubsistema,idEntidad,idPlantel,periodo};
                    List<String[]> datosGanador=metodos.ejecutaSP("sp_consultaAspirantePosicion1",parametrosGanador);
                    if(!datosGanador.isEmpty()){
                        for(String[] datoGanador:datosGanador){
                            String[] parametrosGanador1={datoGanador[0],datoGanador[2]};
                            metodos.ejecutaSP("sp_updatePlazaPreliminar",parametrosGanador1);
                        }
                    }
                }
            }
            respuesta=asignacionVacanciaPreliminar(programa, idSubsistema, periodo);
            return respuesta;
        }catch(Exception e){
            respuesta=e.toString();
        }finally{
            return respuesta;  
        }
    }
    public String asignacionVacanciaPreliminar(String programa,String idSubsistema,String periodo){        
        String respuesta="ok";        
        try{
            List<String[]> datosEntidades=metodos.ejecutaSP("sp_selectCatEntidades");
            for(String[] dato:datosEntidades){
                String[] parametros={idSubsistema,dato[0]};
                List<String[]> datos=metodos.ejecutaSP("sp_selectCatPlanteles",parametros);
                for(String[] datoPlanteles:datos){
                    String idEntidad=dato[0];
                    String idPlantel=datoPlanteles[0];
                    String[] parametros1={programa, idSubsistema, idEntidad, idPlantel,periodo};
                    List<String[]> datosAspirantes=metodos.ejecutaSP("sp_consultaAspirantePosicion2",parametros1);
                    if(datosAspirantes.size()>0){
                        for(String[] datosAspirante:datosAspirantes){
                            
                            String idCategoriaAspira=datosAspirante[4];
                            String idJornadaAspira=datosAspirante[5];
                            
                            String[] parametrosVacancia={programa, idSubsistema, idEntidad, idPlantel,"0",periodo,idCategoriaAspira,idJornadaAspira};
                            List<String[]> datosVacancia=metodos.ejecutaSP("sp_consultaVacanciasPorCategoria",parametrosVacancia);
                            if(!datosVacancia.isEmpty()){
                                // idUsuario - idVacancia
                                // Si hay resultados para ese aspitrante se marca la vacancia como asignada preliminar.
                                String[] parametrosGanador1={datosAspirante[0],datosVacancia.get(0)[0]};
                                metodos.ejecutaSP("sp_updatePlazaPreliminar",parametrosGanador1);
                            }else{
                                // Si no hay datos se consultan las opciones del aspirante.
                                String[] parametrosPlaza={idCategoriaAspira,idJornadaAspira};
                                List<String[]> datosPlazas=metodos.ejecutaSP("sp_consultaOpcionesPlazasAspira",parametrosPlaza);
                                if(!datosPlazas.isEmpty()){
                                    String idCategoriaAspiraOpc2=datosPlazas.get(0)[4];
                                    String idJornadaAspiraOpc2=datosPlazas.get(0)[5];
                                    String idCategoriaAspiraOpc3=datosPlazas.get(0)[7];
                                    String idJornadaAspiraOpc3=datosPlazas.get(0)[8];
                                    String idCategoriaAspiraOpc4=datosPlazas.get(0)[10];
                                    String idJornadaAspiraOpc4=datosPlazas.get(0)[11];
                                    
                                    // Se consulta la tabla de vacancia con la siguiente opcion.
                                    String[] parametrosOpcion2={programa,idSubsistema,idEntidad,idPlantel,"0",periodo,idCategoriaAspiraOpc2,idJornadaAspiraOpc2};
                                    List<String[]> datosVacancia2=metodos.ejecutaSP("sp_consultaVacanciasPorCategoria",parametrosOpcion2);

                                    if(!datosVacancia2.isEmpty()){
                                        // idUsuario - idVacancia
                                        // Si hay resultados para ese aspitrante se marca la vacancia como asignada preliminar.
                                        String[] parametrosGanador1={datosAspirante[0],datosVacancia2.get(0)[0]};
                                        metodos.ejecutaSP("sp_updatePlazaPreliminar",parametrosGanador1);
                                    }else{
                                         if(idCategoriaAspiraOpc3!=null && idJornadaAspiraOpc3!=null){
                                            String[] parametrosOpcion3={programa,idSubsistema,idEntidad,idPlantel,"0",periodo,idCategoriaAspiraOpc3,idJornadaAspiraOpc3};
                                            List<String[]> datosVacancia3=metodos.ejecutaSP("sp_consultaVacanciasPorCategoria",parametrosOpcion3);

                                            if(!datosVacancia2.isEmpty()){
                                                // idUsuario - idVacancia
                                                // Si hay resultados para ese aspitrante se marca la vacancia como asignada preliminar.
                                                String[] parametrosGanador3={datosAspirante[0],datosVacancia3.get(0)[0]};
                                                metodos.ejecutaSP("sp_updatePlazaPreliminar",parametrosGanador3);
                                            }else{
                                                if(idCategoriaAspiraOpc4!=null && idJornadaAspiraOpc4!=null){
                                                    String[] parametrosOpcion4={programa,idSubsistema,idEntidad,"0",idPlantel,periodo,idCategoriaAspiraOpc3,idJornadaAspiraOpc3};
                                                    List<String[]> datosVacancia4=metodos.ejecutaSP("sp_consultaVacanciasPorCategoria",parametrosOpcion4);

                                                    if(!datosVacancia2.isEmpty()){
                                                        // idUsuario - idVacancia
                                                        // Si hay resultados para ese aspitrante se marca la vacancia como asignada preliminar.
                                                        String[] parametrosGanador3={datosAspirante[0],datosVacancia3.get(0)[0]};
                                                        metodos.ejecutaSP("sp_updatePlazaPreliminar",parametrosGanador3);
                                                    }
                                                }
                                            }
                                         }
                                    }
                                }
                            }
                        }
                    }
                }
            }
            return respuesta;
        }catch(Exception e){
            respuesta=e.toString();
        }finally{
            return respuesta;  
        }
    }
    public String generarReporteVacancia(String idPrograma, String idSubsistema) {
        ModelReporte reporte = new ModelReporte();
        UtileriasHelper utilerias = new UtileriasHelper();
        String jsonReporte = "";
        try {
            String[] parametros = {idPrograma, idSubsistema};
            reporte.setReporte(metodos.ejecutaSP("sp_reporteVacancia", parametros));
            jsonReporte = utilerias.convertObjectToJson(reporte);
            return jsonReporte;
        } catch (Exception e) {
            e.toString();
        } finally {
            return jsonReporte;
        }
    }
    public String eliminarVacancia(String idPrograma, String idSubsistema, String idEntidad, String idPlantel, String tipoCategoria) {
        String respuesta = "";
            String[] parametros = {idPrograma, idSubsistema, idEntidad, idPlantel, tipoCategoria};
            List<String[]> datos = metodos.ejecutaSP("sp_deleteVacancias", parametros);
        try {    
            if(datos.get(0)[0].contains("ok")){
                return respuesta="ok";
            }else if(datos.get(0)[0].contains("No")){
                return respuesta=datos.get(0)[0].toString();
            }
            return respuesta;
        } catch (Exception e) {
            respuesta = e.toString();
        } finally {
            return respuesta;
        }
    }
}
