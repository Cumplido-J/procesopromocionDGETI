/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package herramientas;

import constants.ConstantsWS;
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
    public  String desplegarUsuarios(String idPrograma,String idSubsistema,String idEntidad,String idPlantel,String usuario,String tusuario){        
        String respuesta="<tr><td colspan='7' class='text-center'>Sin información</td></tr>";        
        try{
            String[] parametros={idPrograma,idSubsistema,idEntidad,idPlantel,usuario,tusuario};
            if(idEntidad.isEmpty() && idPlantel.isEmpty() && tusuario.isEmpty()){
                return respuesta;
            }else if(!idEntidad.isEmpty() && !idPlantel.isEmpty() && tusuario.isEmpty()){
                return respuesta;
            }else{
                List<String[]> datos=metodos.ejecutaSP("sp_consultaUsuarios",parametros);
                if(!datos.isEmpty()){
                    respuesta="";
                    for(String[] dato:datos)
                    {   
                        String nombreUsuario=dato[10]==null?"":dato[10];
                        
                        respuesta+="<tr><td>"+dato[2]+"</td><td>"+dato[4]+"</td><td>"+dato[6]+"</td><td>"+dato[8]+"</td><td>"+dato[9]+"</td><td>"+nombreUsuario+"</td><td>"; 
                        respuesta+="<form method='POST' action='AltaUsuario'><input type='hidden' name='idUsuario' value='"+dato[0]+"'><input class='btn btn-sm btn-link' type='submit' value='Editar'/></form>";
                        respuesta+="<td><button type='button' class='btn btn-sm' title='Borrar' onclick='confirmarUsuario("+dato[0]+")'><span class='glyphicon glyphicon-trash'></span></button></td>";                                                                                  
                        respuesta+="</td></tr>";
                    }
                }
            }
        }catch(Exception e){
            respuesta=e.toString();
        }finally{
            return respuesta;        
        }
    }
    
    public  String desplegarConvocatorias(String idPrograma,String idSubsistema,String idEntidad,String idPlantel,String estatus){        
        String respuesta="<tr><td colspan='6' class='text-center'>Sin información</td></tr>";        
        try{
            if(idEntidad==null && idPlantel==null){
                idEntidad="";
                idPlantel="";
            }else if(idEntidad==null){
                idEntidad="";
            }else if(idPlantel==null){
                idPlantel="";
            }
            String[] parametros={idPrograma,idSubsistema,idEntidad,idPlantel,estatus};
            List<String[]> datos=metodos.ejecutaSP("sp_consultaConvocatorias",parametros);
            if(!datos.isEmpty()){
                respuesta="";
                for(String[] dato:datos)
                {
                    respuesta+="<tr><td>"+dato[2]+"</td><td>"+dato[4]+"</td><td>"+dato[6]+"</td><td>"+dato[8]+"</td><td>"+dato[9]+"</td><td>"; 
                    respuesta+="<form method='POST' action='AltaConvocatoria'><input type='hidden' name='idConvocatoria' value='"+dato[0]+"'><input class='btn btn-sm btn-link' type='submit' value='Editar'/></form>";                                                                                  
                    respuesta+="</td></tr>";
                }
            }
        }catch(Exception e){
            respuesta=e.toString();
        }finally{
            return respuesta;        
        }
    }
    public  String desplegarConvocatoriasBase(String idPrograma,String idSubsistema,String idEntidad,String idPlantel,String estatus,String tipoConvocatoria){        
        String respuesta="<tr><td colspan='6' class='text-center'>Sin información</td></tr>";        
        try{
            
            if(estatus.isEmpty()){
                estatus = "0";
            }
            
            if(tipoConvocatoria.equals("NACIONAL")){
                idEntidad="0";
                idPlantel="0";
            }else if(tipoConvocatoria.equals("ESTATAL")){
                idPlantel="0";
            }
            
            String[] parametros={idPrograma,idSubsistema,idEntidad,idPlantel,estatus,tipoConvocatoria};
            
                List<String[]> datos=metodos.ejecutaSP("sp_consultaConvocatoriasBase",parametros);
                if(!datos.isEmpty()){
                respuesta="";
                for(String[] dato:datos)
                {
                    respuesta+="<tr><td>"+dato[2]+"</td><td>"+dato[9]+"</td><td>"+dato[4]+"</td><td>"+dato[6]+"</td><td>"+dato[8]+"</td><td>"; 
                    respuesta+="<form method='POST' action='AltaConvocatoriaBase'><input type='hidden' name='idConvocatoria' value='"+dato[0]+"'><input class='btn btn-sm btn-link' type='submit' value='Editar'/></form>";                                                                                  
                    respuesta+="</td></tr>";
                }
                }
            
        }catch(Exception e){
            respuesta=e.toString();
        }finally{
            return respuesta;        
        }
    }
    public  String desplegarVacancias(String idPrograma,String idSubsistema,String idEntidad,String idPlantel,String tipoCategoria){        
        String respuesta="<tr><td colspan='6' class='text-center'>Sin información</td></tr>"; 
        String aux="";
        try{
            String[] parametros={idPrograma,idSubsistema,idEntidad,idPlantel,tipoCategoria};
            List<String[]> datos=metodos.ejecutaSP("sp_consultaVacancias",parametros);
           
            if(idEntidad.isEmpty() && idPlantel.isEmpty() &&tipoCategoria.isEmpty()){
                return respuesta;
            }
            else{
                if(!datos.isEmpty()){
                respuesta="";
                for(String[] dato:datos)
                {
                    if(dato[11].equals("1")){
                        aux=" ("+dato[16]+")";
                    }else{
                        aux="";
                    }
                    respuesta+="<tr><td>"+dato[2]+"</td><td>"+dato[4]+"</td><td>"+dato[6]+"</td><td>"+dato[8]+"</td><td>"+dato[10]+"</td><td>"+dato[12]+aux+"</td><td>"+dato[13]+"</td><td>"+dato[14]+"</td>"; 
                    //respuesta+="<form method='POST' action='AltaVacancia'><input type='hidden' name='idConvocatoria' value='"+dato[0]+"'><input class='btn btn-sm btn-link' type='submit' value='Editar'/></form>";                                                                                  
                    respuesta+="</tr>";
                }
            }
            
            }
        }catch(Exception e){
            respuesta=e.toString();
        }finally{
            return respuesta;        
        }
    }
    public  String desplegarDocentes(String idPrograma,String idSubsistema,String idEntidad,String idPlantel,String nombreRFC,String estatus,String idPermiso,String idUsuario,String idPeriodo){        
        String respuesta="<tr><td colspan='9' class='text-center'>Sin información</td></tr>";        
        try{
            String[] parametros={idPrograma,idSubsistema,idEntidad,idPlantel,nombreRFC,estatus,idUsuario,idPeriodo};
            if(idEntidad.isEmpty() && idPlantel.isEmpty() && nombreRFC.isEmpty() && estatus.isEmpty()){
                return respuesta;
            }else{
                List<String[]> datos=metodos.ejecutaSP("sp_consultaDocentes",parametros);
                
                if(!datos.isEmpty()){
                    respuesta="";
                    for(String[] dato:datos)
                    {
                        respuesta+="<tr><td>"+dato[12]+"</td><td>"+dato[10]+"</td><td>"+dato[2]+"</td><td>"+dato[4]+"</td><td>"+dato[6]+"</td><td>"+dato[5]+"</td><td>"+dato[8]+"</td><td>"+dato[13]+"</td><td>"; 
                        if (idPermiso.equals("6"))
                        {
                            respuesta+=dato[14]+"</td><td>";
                            if(!dato[14].equals("")){
                                respuesta+="<span class='glyphicon glyphicon-ok-sign completo' title='Aspirante evaluado'></span>";
                            }
                        }
                        else
                        {
                            if(!dato[13].equals("")){
                                respuesta+="<span class='glyphicon glyphicon-ok-sign completo' title='Aspirante evaluado'></span>";
                            }
                        } 
                        respuesta+="<form method='POST' action='VistaDocente'><input type='hidden' name='idUsuario' value='"+dato[0]+"'><input type='hidden' name='rfc' value='"+dato[6]+"'><input class='btn btn-sm btn-link' type='submit' value='Ver información'/></form>";                                                               


                        respuesta+="</td></tr>";
                    }
                }
            }
        }catch(Exception e){
            respuesta=e.toString();
        }finally{
            return respuesta;        
        }
    }
    
    
    public  String desplegarPlazas(String idUsuario){        
        String respuesta="<tr><td colspan='7' class='text-center'>Sin información</td></tr>";        
        try{
            String[] parametros={idUsuario};
            List<String[]> datos=metodos.ejecutaSP("sp_consultaUsuarioPlaza",parametros);
            if(!datos.isEmpty()){
                respuesta="";
                String seleccionado="";
                String cargo="";
                for(String[] dato:datos)
                {
                    if(dato[12].equals("V") && dato[15].equals("1")){
                        seleccionado="checked";
                    }else if(dato[4].equals("1") && dato[15].equals("2")){
                        seleccionado="checked";
                    }else{
                        seleccionado="";
                    }
                    
                    if(dato[15].equals("1")){
                        respuesta+="<tr><td><center><input type='checkbox' onChange='seleccionarPlaza(this)' value='"+dato[0]+"' "+seleccionado+"/></center><td>"+dato[11]+"</td><td>"+dato[7]+"</td><td id="+"tipoNom"+">"+dato[9]+":"+dato[10]+"</td><td class='hidden'>"+dato[2]+"</td><td>"+dato[3]+"</td><td class='hidden'>"+dato[4]+"</td><td>"+dato[5];
                    }else{                    
                       respuesta+="<tr><td><center><input type='checkbox' onChange='seleccionarPlaza(this)' value='"+dato[0]+"' "+seleccionado+" disabled/></center><td>"+dato[11]+"</td><td>"+dato[7]+"</td><td id="+"tipoNom"+">"+dato[9]+":"+dato[10]+"</td><td class='hidden'>"+dato[2]+"</td><td>"+dato[3]+"</td><td class='hidden'>"+dato[4]+"</td><td>"+dato[5]; 
                    }
                    
                    
                    if(dato[4].equals("1")){
                        respuesta+="("+dato[6]+")";
                    }                    
                    respuesta+="</td>";
                    switch(dato[13]){
                        case "D":
                            respuesta+="<td>Director<br/>Fecha renuncia:"+dato[14]+"</td>";
                            break;
                        case "S":
                            respuesta+="<td>Subdirector<br/>Fecha renuncia:"+dato[14]+"</td>";
                            break;
                        case "J":
                            respuesta+="<td>Jefe de Departamento<br/>Fecha renuncia:"+dato[14]+"</td>";
                            break;
                        default:
                            respuesta+="<td>No aplica</td>";                        
                    }
                     
                    respuesta+="<td><button type='button' class='btn btn-sm' title='Borrar' onclick='confirmarPlaza("+dato[0]+")'><span class='glyphicon glyphicon-trash'></span></button>";  
                    respuesta+="</td></tr>";
                }
            }
        }catch(Exception e){
            respuesta=e.toString();
        }finally{
            return respuesta;        
        }
    }
    public  String validarSeleccionadas(String idUsuario){        
        String respuesta="";   
        int horas=0,numPlazas=0;
        String idCategoria="-1",idJornada="-1",idCategoriaAux="",idJornadaAux="";
        String idNombramiento="",idNombramientoAux="";
        try{
            String[] parametros={idUsuario};
            List<String[]> datos=metodos.ejecutaSP("sp_consultaUsuarioPlaza",parametros);
            if(!datos.isEmpty()){
                respuesta="";                
                for(String[] dato:datos)
                {
                    if(dato[12].equals("V")){
                        idCategoria=dato[2];
                        idJornada=dato[4];
                        idNombramiento=dato[8];
                        if(dato[4].equals("1")){
                            horas+=Integer.parseInt(dato[6]);
                        }        
                        System.out.println(idCategoria+"-"+idCategoriaAux+"-"+idJornada+"-"+idJornadaAux);
                        
                        if(dato[15].equals("1")){//Para el programa 1:Cambio categoria solo puede sumar plazas con la misma categoria y jornada
                            if(!idCategoriaAux.isEmpty()){
                                if(!idCategoriaAux.equals(idCategoria)||!idJornadaAux.equals(idJornada)){
                                    respuesta="Solo puede seleccionar plazas de la misma categoria y jornada";
                                }
                            }
                        }else if(dato[15].equals("2")){//Para el programa 2:Horas adicionales solo puede sumar plazas con jornada de horas
                            if(!idJornada.equals("1")){
                                respuesta="Solo puede seleccionar plazas de horas";
                            }
                            if(horas>19){
                                respuesta="Solo puede acumular 19 horas como máximo";
                            }
                        }
                        
                        idCategoriaAux=idCategoria;
                        idJornadaAux=idJornada;
                        idNombramientoAux=idNombramiento;
                        numPlazas++;
                    }
                    
                }
                if(!idJornada.equals("1")&&numPlazas>1){
                    respuesta="Solo puede seleccionar una plaza con la que participará";
                }else{
                    if(respuesta.isEmpty()){
                        respuesta=idCategoria+","+idJornada+","+horas+","+idNombramiento;
                    }
                }
            }
        }catch(Exception e){
            respuesta=e.toString();
        }finally{
            return respuesta;        
        }
    }
    public String desplegarAspirantesVacancia(String id,String idPrograma,String idSubsistema,String idEntidad,String idPlantel,String categoria,String jornada,String vacancia, String periodo){        
        String respuesta="<tr><td colspan='9' class='text-center'>Sin información</td></tr>";        
        try{
            String[] parametros={idPrograma,idSubsistema,idEntidad,idPlantel,categoria,jornada,vacancia,periodo};
            if(idEntidad.isEmpty() && idPlantel.isEmpty()){
                return respuesta;
            }else{
                if(id.contains("b")){
                    List<String[]> datos=metodos.ejecutaSP(constants.SP_CONSULTA_GANADOR_ASPIRANTE,parametros);
                
                if(!datos.isEmpty()){
                    respuesta="";
                    for(String[] dato:datos)
                    {
                        respuesta+="<tr><td>"+dato[2]+"</td><td>"+dato[4]+"</td><td>"+dato[6]+"</td><td>"+dato[8]+"</td><td>"+dato[12]+"</td><td>"+dato[16]+"</td><td>"+dato[11]+"</td><td>"+dato[13]+"</td><td>"+(dato[10]==null?"0":dato[10])+"</td>";
                        if(dato[10]==null || dato[15]==null){
                            respuesta+="<td>"+"***"+"</td>"+"</tr>";
                        }else{
                            //respuesta+="<td>"+(datos.indexOf(dato)+1)+"</td>"+"</tr>";
                            respuesta+="<td>"+dato[15]+"</td>"+"</tr>";
                        }
                    }
                    return respuesta; 
                }
                }else{
                    if(id.contains("r")){
                            String[] parametrosPlazas={idPrograma, idSubsistema, idEntidad, idPlantel, "D", categoria, jornada, periodo};
                            List<String[]> datosPlazas=metodos.ejecutaSP(constants.SP_CONSULTA_NUMERO_PLAZAS,parametrosPlazas);
                            int numeroPlazas=Integer.parseInt(datosPlazas.get(0)[8]);
                            String[] parametrosGanador={idPrograma, idSubsistema, idEntidad, idPlantel, categoria, jornada, vacancia, periodo};
                            List<String[]> datosGanador=metodos.ejecutaSP(constants.SP_CONSULTA_GANADOR_ASPIRANTE,parametrosGanador);
                            if(!datosGanador.isEmpty()){
                                int contador = 0;
                                for(String[] datoGanador:datosGanador){
                                    int posicionGanador=1;
//                                    if(numeroPlazas>(datosGanador.indexOf(datoGanador))){
//                                        String[] parametrosGanador1={datoGanador[0],Integer.toString(posicionGanador)};
//                                        metodos.ejecutaSP(constants.SP_INSERT_POSICION,parametrosGanador1);
//                                    }else{
//                                        contador++;
//                                        String[] parametrosGanador1={datoGanador[0],Integer.toString(contador)};
//                                        metodos.ejecutaSP(constants.SP_INSERT_POSICION,parametrosGanador1);
//                                    }
                                    contador++;
                                    String[] parametrosGanador1={datoGanador[0],Integer.toString(contador)};
                                    metodos.ejecutaSP("sp_insertPosicion",parametrosGanador1);
                                }
                            }
                        }
                    
                    List<String[]> datos=metodos.ejecutaSP(constants.SP_CONSULTA_GANADOR_ASPIRANTE,parametros);
                    if(!datos.isEmpty()){
                        respuesta="";
                        for(String[] dato:datos)
                        {
                            respuesta+="<tr><td>"+dato[2]+"</td><td>"+dato[4]+"</td><td>"+dato[6]+"</td><td>"+dato[8]+"</td><td>"+dato[12]+"</td><td>"+dato[16]+"</td><td>"+dato[11]+"</td><td>"+dato[13]+"</td><td>"+(dato[10]==null?"0":dato[10])+"</td>";
                            if(dato[10]==null){
                                respuesta+="<td>"+"***"+"</td>"+"</tr>";
                            }else{
                                respuesta+="<td>"+dato[15]+"</td>"+"</tr>";
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
                                List<String[]> datosGanador=metodos.ejecutaSP("sp_consultaGanadorAspirante",parametrosGanador);
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
    public String desplegarAspirantesAsignacion(String id,String idPrograma,String idSubsistema,String idEntidad,String idPlantel,String categoria,String jornada,String vacancia){        
        String respuesta="<tr><td colspan='9' class='text-center'>Sin información</td></tr>";        
        try{
            String[] parametros={idPrograma,idSubsistema,idEntidad,idPlantel,categoria,jornada,vacancia};
            if(idEntidad.isEmpty() && idPlantel.isEmpty()){
                return respuesta;
            }else{
                if(id.contains("b")){
                    List<String[]> datos=metodos.ejecutaSP(constants.SP_CONSULTA_GANADOR_ASPIRANTE,parametros);
                
                if(!datos.isEmpty()){
                    respuesta="";
                    for(String[] dato:datos)
                    {
                        respuesta+="<tr><td>"+dato[6]+"</td><td>"+dato[8]+"</td><td>"+dato[12]+"</td><td>"+dato[16]+"</td><td>"+dato[11]+"</td><td>"+dato[13]+"</td><td>"+(dato[10]==null?"0":dato[10])+"</td>";
                        if(dato[10]==null || dato[15]==null){
                            respuesta+="<td>"+"***"+"</td>"+"</tr>";
                        }else{
                            //respuesta+="<td>"+(datos.indexOf(dato)+1)+"</td>"+"</tr>";
                            respuesta+="<td>"+dato[15]+"</td>";
                        }
                        respuesta+="<td><div class=\"form-group col-md-24\">  \n" +
"                            <select class=\"form-control input-sm\" id=\"tvacancia\" name=\"tvacancia\" required>\n" +
"                                <option value=\"\">Seleccionar una opción</option>\n" +
"                                <option value=\"1\">Acepto</option>\n" +
"                                <option value=\"2\">Rechazo</option>\n" +
"                            </select>\n" +
"                        </div></td>"+"</tr>";
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
    public  String generarReporte(String idPrograma,String idSubsistema, String entidad, String periodo){        
        String respuesta="<table><tr><th >id</th><th >nombre</th><th >primerApellido</th><th >segundoApellido</th><th >correo</th><th >curp</th><th >idPlantel</th><th >idEntidad</th><th >entidad</th><th >cct</th><th >plantel</th><th >telfijo</th><th >telcel</th><th >consideraciones</th><th >idEscuelaEstudio</th><th >escuela</th><th >idCarrera</th><th >carrera</th><th >anioEgreso</th><th >idGradoAcademico</th><th >grado</th><th >idModalidadTitulacion</th><th >modalidad</th><th >anioTitulacion</th><th >cedula</th><th >activo</th><th >ingresoSubsistema</th><th >ingresoPlantel</th><th >idCategoriaJornada</th><th >clave</th><th >idCategoria</th><th >categoria</th><th >idJornada</th><th >jornada</th><th >fechaPlaza</th><th >idTipoNombramiento</th><th >clave</th><th >codigo</th><th >descripcion</th><th >tipo</th><th >fechaUltimaPromocion</th><th >idCategoriaJornadaAspira</th><th >clave as claveAspira</th><th >idCategoriaAspira</th><th >categoriaAspira</th>        <th >idJornadaAspira</th><th >jornadaAspira</th><th >idPerfilRequerido</th><th >requisito</th><th >notaSancion</th><th >compatibilidad</th><th >horasOtroSubsistema</th><th >nivelCENNI</th><th >folioCENNI</th><th >idCCT</th><th >cct</th><th >idEntidadEstudio</th><th >idInstitucion</th><th >idTipoInstitucion</th><th >gradoMarginacion</th><th >frenteGrupo</th><th >funcionesOtro</th><th >finRegistro</th><th >consideraciones</th><th >publico</th><th >idPrograma</th><th >idConvocatoria</th><th >idEstatus</th><th >observacionInfo</th><th >observacionEncuestados</th><th >observacionCriterios</th><th >institucion</th><th >cct</th><th >escuela</th><th >carreraOtra</th><th >observacionCriterios2</th><th >idSubsistema</th><th >folio</th><th >tipoVacanciaAspira</th><th >idEstatus</th><th >estatus</th><th >puntaje1</th><th >puntaje2</th><th >observacionInfo</th><th >observacionEncuestados</th><th >observacionCriterios</th><th >posicion</th>"
                + "<th >observacion1</th><th >observacion2</th><th >observacion3</th><th >observacion4</th><th >observacion5</th><th >observacion6</th><th >observacion7</th><th >observacion8</th></tr>";        
        try{
            String[] parametros={idPrograma,idSubsistema,entidad,periodo};
                List<String[]> datos=metodos.ejecutaSP("sp_reporteAsignacion",parametros);
                if(!datos.isEmpty()){
                    for(String[] dato:datos)
                    {   
                        respuesta+="<tr><th >"+(dato[0]==null?"":dato[0])+"</th><th >"+(dato[1]==null?"":dato[1])+"</th><th >"+(dato[2]==null?"":dato[2])+"</th><th >"+(dato[3]==null?"":dato[3])+"</th><th >"+(dato[4]==null?"":dato[4])+"</th><th >"+(dato[5]==null?"":dato[5])+"</th><th >"+(dato[6]==null?"":dato[6])+"</th><th >"+(dato[7]==null?"":dato[7])+"</th><th >"+(dato[8]==null?"":dato[8])+"</th><th >"+(dato[9]==null?"":dato[9])+"</th><th >"+(dato[10]==null?"":dato[10])+"</th><th >"+dato[11]+"</th><th >"+dato[12]+"</th><th >"+dato[13]+"</th><th >"+dato[14]+"</th><th >"+dato[15]+"</th><th >"+dato[16]+"</th><th >"+dato[17]+"</th><th >"+dato[18]+"</th><th >"+dato[19]+"</th><th >"+dato[20]+"</th><th >"+dato[21]+"</th><th >"+dato[22]+"</th><th >"+dato[23]+"</th><th >"+dato[24]+"</th><th >"+dato[25]+"</th><th >"+dato[26]+"</th><th >"+dato[27]+"</th><th >"+dato[28]+"</th><th >"+dato[29]+"</th><th >"+dato[30]+"</th><th >"+dato[31]+"</th><th >"+dato[32]+"</th><th >"+dato[33]+"</th><th >"+dato[34]+"</th><th >"+dato[35]+"</th><th >"+dato[36]+"</th><th >"+dato[37]+"</th><th >"+dato[38]+"</th><th >"+dato[39]+"</th><th >"+dato[40]+"</th><th >"+dato[41]+"</th><th >"+dato[42]+"</th><th >"+dato[43]+"</th><th >"+dato[44]+"</th><th >"+dato[45]+"</th><th >"+dato[46]+"</th><th >"+dato[47]+"</th><th >"+dato[48]+"</th><th >"+dato[49]+"</th><th >"+dato[50]+"</th><th >"+dato[51]+"</th><th >"+dato[52]+"</th><th >"+dato[53]+"</th><th >"+dato[54]+"</th><th >"+dato[55]+"</th><th >"+dato[56]+"</th><th >"+dato[57]+"</th><th >"+dato[58]+"</th><th >"+dato[59]+"</th><th >"+dato[60]+"</th><th >"+dato[61]+"</th><th >"+dato[62]+"</th><th >"+dato[63]+"</th><th >"+dato[64]+"</th><th >"+dato[65]+"</th><th >"+dato[66]+"</th><th >"+dato[67]+"</th><th >"+dato[68]+"</th><th >"+dato[69]+"</th><th >"+dato[70]+"</th><th >"+dato[71]+"</th><th >"+dato[72]+"</th><th >"+dato[73]+"</th><th >"+dato[74]+"</th><th >"+dato[75]+"</th><th >"+dato[76]+"</th><th >"+dato[77]+"</th><th >"+dato[78]+"</th><th >"+dato[79]+"</th><th >"+dato[80]+"</th><th >"+dato[81]+"</th><th >"+dato[82]+"</th><th >"+dato[83]+"</th><th >"+dato[84]+"</th><th >"+dato[85]+"</th><th >"+dato[86]+"</th>"
                                + "<th >"+(dato[87]==null?"":dato[87])+"</th><th >"+(dato[88]==null?"":dato[88])+"</th><th >"+(dato[89]==null?"":dato[89])+"</th><th >"+(dato[90]==null?"":dato[90])+"</th><th >"+(dato[91]==null?"":dato[91])+"</th><th >"+(dato[92]==null?"":dato[92])+"</th><th >"+(dato[93]==null?"":dato[93])+"</th><th >"+(dato[94]==null?"":dato[94])+"</th></tr>";
                    }
                }
                respuesta+="</table>";
                return respuesta;
        }catch(Exception e){
            respuesta=e.toString();
        }finally{
            return respuesta;        
        }
    }
    public  String validarSeleccionadasAdd(String idUsuario){        
        String respuesta="";   
        int horas=0,totalHoras=0,numPlazas=0;
        String idCategoria="-1",idJornada="-1",idCategoriaAux="",idJornadaAux="";
        String idNombramiento="",idNombramientoAux="";
        try{
            String[] parametros={idUsuario};
            List<String[]> datos=metodos.ejecutaSP("sp_consultaUsuarioPlaza",parametros);
            if(!datos.isEmpty()){
                respuesta="";                
                for(String[] dato:datos)
                {
                    if(dato[4].equals("1")){
                        idCategoria=dato[2];
                        idJornada=dato[4];
                        idNombramiento=dato[8];
                        if(dato[4].equals("1")){
                            horas+=Integer.parseInt(dato[6]);
                        }        
                        System.out.println(idCategoria+"-"+idCategoriaAux+"-"+idJornada+"-"+idJornadaAux);
                        
                        if(dato[15].equals("1")){//Para el programa 1:Cambio categoria solo puede sumar plazas con la misma categoria y jornada
                            if(!idCategoriaAux.isEmpty()){
                                if(!idCategoriaAux.equals(idCategoria)||!idJornadaAux.equals(idJornada)){
                                    respuesta="Solo puede seleccionar plazas de la misma categoria y jornada";
                                }
                            }
                        }else if(dato[15].equals("2")){//Para el programa 2:Horas adicionales solo puede sumar plazas con jornada de horas
                            if(!idJornada.equals("1")){
                                respuesta="Solo puede seleccionar plazas con jornada de horas";
                            }
//                            if(horas>19){
//                                respuesta="Solo puede acumular 19 horas como máximo";
//                            }
                        }
                        
                        idCategoriaAux=idCategoria;
                        idJornadaAux=idJornada;
                        idNombramientoAux=idNombramiento;
                        numPlazas++;
                        totalHoras=horas;
                    }
                    
                }
                if(!idJornada.equals("1")&&numPlazas>1){
                    respuesta="Solo puede seleccionar una plaza con la que participará";
                }else{
                    if(respuesta.isEmpty()){
                        respuesta=idCategoria+","+idJornada+","+horas+","+idNombramiento+","+totalHoras;
                    }
                }
            }
        }catch(Exception e){
            respuesta=e.toString();
        }finally{
            return respuesta;        
        }
    }
    public  String validarSeleccionadasAdd1(String idUsuario){        
        String respuesta="";   
        int horas=0,totalHoras=0,numPlazas=0;
        String idCategoria="-1",idJornada="-1",idCategoriaAux="",idJornadaAux="";
        String idNombramiento="",idNombramientoAux="";
        try{
            String[] parametros={idUsuario};
            List<String[]> datos=metodos.ejecutaSP("sp_consultaUsuarioPlaza",parametros);
            if(!datos.isEmpty()){
                respuesta="0";                
                for(String[] dato:datos)
                {
                    if(!dato[4].equals("1")){
                        idCategoria=dato[2];
                        idJornada=dato[4];
                        if(dato[15].equals("2")){//Para el programa 2:Horas adicionales solo puede sumar plazas con jornada de horas
                            if(!idJornada.equals("1")){
                                respuesta="1";
                        }   }
                    }
                }        
            }

        }catch(Exception e){
            respuesta=e.toString();
        }finally{
            return respuesta;        
        }
    }
    public  String desplegarCategoriasAspira(String idUsuario){        
        String respuesta="<tr><td colspan='7' class='text-center'>Sin información</td></tr>";        
        try{
            String[] parametros={idUsuario};
            List<String[]> datos=metodos.ejecutaSP("sp_consultaUsuarioCategoriaAspira",parametros);
            if(!datos.isEmpty()){
                respuesta="";
                for(String[] dato:datos)
                {
                    respuesta+="<tr><td>"+dato[3]+"</td><td>"+dato[5]+"</td><td>"+dato[6]+"</td>";
                    respuesta+="<td><button type='button' class='btn btn-sm' title='Borrar' onclick='confirmarCategoriaAspira("+dato[0]+")'><span class='glyphicon glyphicon-trash'></span></button>";  
                    respuesta+="</td></tr>";
                }
            }
        }catch(Exception e){
            respuesta=e.toString();
        }finally{
            return respuesta;        
        }
    }
    
        public  String validarHorasAspira(String idUsuario){        
        String respuesta="0";   

        try{
            String[] parametros={idUsuario};
            List<String[]> datos=metodos.ejecutaSP("sp_consultaUsuarioCategoriaAspira",parametros);
            if(!datos.isEmpty()){
                int suma=0;               
                for(String[] dato:datos)
                {
                  suma+=Integer.parseInt(dato[6]);
                }  
                respuesta=""+suma;
            }
            
        }catch(Exception e){
            respuesta=e.toString();
        }finally{
            return respuesta;        
        }
    }
}
