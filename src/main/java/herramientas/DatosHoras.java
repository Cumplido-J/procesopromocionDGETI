
/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package herramientas;

import com.aplicacion.beans.ModelReporte;
import constants.ConstantsWS;
import java.util.List;
import metodos_sql.Metodos_sql;

/**
 *
 * @author jenri
 */
public class DatosHoras {

    Metodos_sql metodos;
    ConstantsWS constants;

    public DatosHoras() {
        metodos = new Metodos_sql();
    }

    public String generarResultadosCentrales(String programa) {
        String respuesta = "<tr><td colspan='9' class='text-center'>Sin información</td></tr>";
        try {
            int registrosModificados = 0;
            String[] parametros1 = {programa};
            List<String[]> datosPlantel = metodos.ejecutaSP("sp_GanadorHorasPlanteles", parametros1);
            if (!datosPlantel.isEmpty()) {
                for (String[] datoPlantel : datosPlantel) {
                    //System.out.println("Hola " + datoPlantel[0]);
                    String[] parametrosPlantel = {programa, datoPlantel[0]};
                    List<String[]> datosAspirantes = metodos.ejecutaSP("sp_GanadoresHoraPorIdPlantel", parametrosPlantel);
                    if (!datosAspirantes.isEmpty()) {
                        int contador = 0;
                        for (String[] datoAspirante : datosAspirantes) {
                            String[] parametrosconsultahoras = {datoAspirante[0]};
                            List<String[]> datoshoras_ = metodos.ejecutaSP("spConsultaHorasOstenta", parametrosconsultahoras);

                            if (datoshoras_.get(0)[0] != null) {
                                Integer horasOstenta = Integer.parseInt(datoshoras_.get(0)[0]);
                                //System.out.println("Las horas " + horas);
                                //int horasOstenta = 10;
                                if (horasOstenta < 19) {
                                    contador++;
                                    System.out.println("IdUsuario: " + datoAspirante[0]);
                                    String[] parametrosGanador1 = {datoAspirante[0], Integer.toString(contador)};
                                    metodos.ejecutaSP("sp_insertPosicion", parametrosGanador1);
                                    String[] paramplazaaspira = {datoAspirante[0], datoshoras_.get(0)[0]};
                                    metodos.ejecutaSP("spInsertHorasOstenta", paramplazaaspira);
                                    registrosModificados++;
                                }
                            }

                        }
                    }
                }

            }
            respuesta = "<tr><td colspan='9' class='text-center'>Se modificaron " + registrosModificados + " registros</td></tr>";
            return respuesta;
        } catch (Exception e) {
            respuesta = e.toString();
        } finally {
            return respuesta;
        }
    }

    public String desplegarAspirantesAsignacion(String id, String idPrograma, String idSubsistema, String idEntidad, String idPlantel, String periodo) {
        String respuesta = "<tr><td colspan='9' class='text-center'>Sin información</td></tr>";
        try {
            String[] parametros = {idPrograma, idSubsistema, idEntidad, idPlantel, periodo};
            if (idEntidad.isEmpty() && idPlantel.isEmpty()) {
                return respuesta;
            } else {
                if (id.contains("b")) {
                    List<String[]> datos = metodos.ejecutaSP("sp_consultaGanadorAspiranteHoras", parametros);
                    List<String[]> datosCatAsignacion = metodos.ejecutaSP(constants.SP_SELECT_CAT_ASIGNACION);
                    String estatus1 = datosCatAsignacion.get(0)[0];
                    String estatus2 = datosCatAsignacion.get(1)[0];
                    String estatus3 = datosCatAsignacion.get(2)[0];

                    String estatusDesc1 = datosCatAsignacion.get(0)[1];
                    String estatusDesc2 = datosCatAsignacion.get(1)[1];
                    String estatusDesc3 = datosCatAsignacion.get(2)[1];

                    if (!datos.isEmpty()) {
                        respuesta = "";
                        for (String[] dato : datos) {
                            //                        respuesta+="<tr><td>"+dato[4]+"</td><td>"+dato[6]+"</td><td>"+dato[8]+"</td><td>"+dato[12]+"</td><td>"+dato[16]+"</td><td>"+dato[11]+"</td><td>"+dato[13]+"</td><td>"+(dato[10]==null?"0":dato[10])+"</td>";
                            respuesta += "<tr><td>" + dato[4] + "</td><td>" + dato[6] + "</td><td>" + dato[8] + "</td><td>" + dato[21] + "</td><td>" + dato[22] + "</td><td>" + dato[11] + "</td><td>" + dato[13] + "</td><td>" + (dato[10] == null ? "0" : dato[10]) + "</td>";
                            if (dato[10] == null || dato[15] == null) {
                                respuesta += "<td>" + "***" + "</td>" + "</tr>";
                            } else {
                                //respuesta+="<td>"+(datos.indexOf(dato)+1)+"</td>"+"</tr>";
                                respuesta += "<td>" + dato[15] + "</td>";
                            }

                            String tvacancia = "tvacancia" + dato[0].toString();
                            if (dato[19] == null) {
                                respuesta += "<td><div class=\"form-group col-md-24\">  \n"
                                        + "                            <select class=\"form-control input-sm\" id=" + tvacancia + " name=\"tvacancia2\" disabled>\n"
                                        + "                                <option value=\"\" selected>Seleccionar una opción</option>\n"
                                        + "                                <option value=" + estatus1 + ">" + estatusDesc1 + "</option>\n"
                                        + "                                <option value=" + estatus2 + ">" + estatusDesc2 + "</option>\n"
                                        //+ "                                <option value=" + estatus3 + ">" + estatusDesc3 + "</option>\n"
                                        + "                            </select>\n"
                                        + "                        </div></td><td><button type='button' class='btn btn-sm' title='Borrar' disabled><span class='glyphicon glyphicon-floppy-disk incompleto2' ></span></button></td>" + "</tr>";
                            } else {
                                if (dato[19].equals("1") && dato[20] == null) {
                                    respuesta += "<td><div class=\"form-group col-md-24\">  \n"
                                            + "                            <select class=\"form-control input-sm\" id=" + tvacancia + " name=\"tvacancia2\" disabled>\n"
                                            + "                                <option value=\"\" selected>Seleccionar una opción</option>\n"
                                            + "                                <option value=" + estatus1 + " selected>" + estatusDesc1 + "</option>\n"
                                            + "                                <option value=" + estatus2 + ">" + estatusDesc2 + "</option>\n"
                                            //+ "                                <option value=" + estatus3 + ">" + estatusDesc3 + "</option>\n"
                                            + "                            </select>\n"
                                            + "                        </div></td><td><button type='button' class='btn btn-sm' title='Borrar' onclick='confirmarCategoria(" + dato[0] + ")' disabled><span class='glyphicon glyphicon-floppy-disk incompleto2' disabled></span></button></td>" + "</tr>";
                                } else if (dato[19].equals("2") && dato[20] == null) {
                                    respuesta += "<td><div class=\"form-group col-md-24\">  \n"
                                            + "                            <select class=\"form-control input-sm\" id=" + tvacancia + " name=\"tvacancia2\" disabled>\n"
                                            + "                                <option value=\"\" selected>Seleccionar una opción</option>\n"
                                            + "                                <option value=" + estatus1 + ">" + estatusDesc1 + "</option>\n"
                                            + "                                <option value=" + estatus2 + " selected>" + estatusDesc2 + "</option>\n"
                                            //+ "                                <option value=" + estatus3 + ">" + estatusDesc3 + "</option>\n"
                                            + "                            </select>\n"
                                            + "                        </div></td><td><button type='button' class='btn btn-sm' title='Borrar' onclick='confirmarCategoria(" + dato[0] + ")' disabled><span class='glyphicon glyphicon-floppy-disk incompleto2' disabled></span></button></td>" + "</tr>";
                                } else if (dato[19].equals("3") && dato[20] == null) {
                                    respuesta += "<td><div class=\"form-group col-md-24\">  \n"
                                            + "                            <select class=\"form-control input-sm\" id=" + tvacancia + " name=\"tvacancia2\" disabled>\n"
                                            + "                                <option value=\"\">Seleccionar una opción</option>\n"
                                            + "                                <option value=" + estatus1 + ">" + estatusDesc1 + "</option>\n"
                                            + "                                <option value=" + estatus2 + ">" + estatusDesc2 + "</option>\n"
                                            //+ "                                <option value=" + estatus3 + " selected>" + estatusDesc3 + "</option>\n"
                                            + "                            </select>\n"
                                            + "                        </div></td><td><button type='button' class='btn btn-sm' title='Borrar' onclick='confirmarCategoria(" + dato[0] + ")' disabled><span class='glyphicon glyphicon-floppy-disk incompleto2' disabled></span></button></td>" + "</tr>";
                                } else if (dato[20] != null) {
                                    respuesta += "<td><div class=\"form-group col-md-24\">  \n"
                                            + "                            <select class=\"form-control input-sm\" id=" + tvacancia + " name=\"tvacancia2\" disabled>\n"
                                            + "                                <option value=\"\">Seleccionar una opción</option>\n"
                                            + "                                <option value=" + estatus1 + ">" + estatusDesc1 + "</option>\n"
                                            + "                                <option value=" + estatus2 + ">" + estatusDesc2 + "</option>\n"
                                            //+ "                                <option value=" + estatus3 + " selected>" + estatusDesc3 + "</option>\n"
                                            + "                            </select>\n"
                                            + "                        </div></td><td><button type='button' class='btn btn-sm' title='Borrar' onclick='confirmarCategoria(" + dato[0] + ")' disabled><span class='glyphicon glyphicon-floppy-disk incompleto2' disabled></span></button></td>" + "</tr>";
                                }
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

    public String generarReporte(String idPrograma, String idSubsistema, String entidad, String periodo) {
        String respuesta = "<table><tr><th >id</th><th >nombre</th><th >primerApellido</th><th >segundoApellido</th><th >correo</th><th >curp</th><th >idPlantel</th><th >idEntidad</th><th >entidad</th><th >cct</th><th >plantel</th><th >telfijo</th><th >telcel</th><th >consideraciones</th><th >idEscuelaEstudio</th><th >escuela</th><th >idCarrera</th><th >carrera</th><th >anioEgreso</th><th >idGradoAcademico</th><th >grado</th><th >idModalidadTitulacion</th><th >modalidad</th><th >anioTitulacion</th><th >cedula</th><th >activo</th><th >ingresoSubsistema</th><th >ingresoPlantel</th><th >idCategoriaJornada</th><th >clave</th><th >idCategoria</th><th >categoria</th><th >idJornada</th><th >jornada</th><th >fechaPlaza</th><th >idTipoNombramiento</th><th >clave</th><th >codigo</th><th >descripcion</th><th >tipo</th><th >fechaUltimaPromocion</th><th >idCategoriaJornadaAspira</th><th >clave as claveAspira</th><th >idCategoriaAspira</th><th >categoriaAspira</th>        <th >idJornadaAspira</th><th >jornadaAspira</th><th >idPerfilRequerido</th><th >requisito</th><th >notaSancion</th><th >compatibilidad</th><th >horasOtroSubsistema</th><th >nivelCENNI</th><th >folioCENNI</th><th >idCCT</th><th >cct</th><th >idEntidadEstudio</th><th >idInstitucion</th><th >idTipoInstitucion</th><th >gradoMarginacion</th><th >frenteGrupo</th><th >funcionesOtro</th><th >finRegistro</th><th >consideraciones</th><th >publico</th><th >idPrograma</th><th >idConvocatoria</th><th >idEstatus</th><th >observacionInfo</th><th >observacionEncuestados</th><th >observacionCriterios</th><th >institucion</th><th >cct</th><th >escuela</th><th >carreraOtra</th><th >observacionCriterios2</th><th >idSubsistema</th><th >folio</th><th >tipoVacanciaAspira</th><th >idEstatus</th><th >estatus</th><th >puntaje1</th><th >puntaje2</th><th >observacionInfo</th><th >observacionEncuestados</th><th >observacionCriterios</th><th >posicion</th>"
                + "<th >observacion1</th><th >observacion2</th><th >observacion3</th><th >observacion4</th><th >observacion5</th><th >observacion6</th><th >observacion7</th><th >observacion8</th></tr>";
        ModelReporte reporte = new ModelReporte();
        UtileriasHelper utilerias = new UtileriasHelper();
        String jsonReporte = "";
        try {
            String[] parametros = {idPrograma, idSubsistema, entidad, periodo};
//                List<String[]> datos=metodos.ejecutaSP("sp_reporteAsignacion",parametros);
            reporte.setReporte(metodos.ejecutaSP("sp_reporteAsignacionHoras", parametros));
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

}
