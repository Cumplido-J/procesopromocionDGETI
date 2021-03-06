<%-- 
    Document   : busquedaGanador
    Created on : 11-may-2021, 15:22:07
    Author     : Jonathan Trinidad de Lazaro
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
    session = (HttpSession) request.getSession(true);    
    if (session.getAttribute("idUsuario") == null) {
        response.sendRedirect("login.jsp");
    }        
%>
<html>
    <head>
        <jsp:include page="seccionesPlantilla/head.jsp"/>
        <jsp:useBean id="catalogo" class="herramientas.Catalogos" />
        <jsp:useBean id="dato" class="herramientas.Datos" />
    </head>
    <main class="page">
           <jsp:include page="seccionesPlantilla/barraSuperior.jsp"/>
            <div class="container">
                <div class="text-center">
                    <h4>Generación de asignación por cambio de categoria</h4>                    
                </div>
                <form id="formBusqueda" role="form" method="POST" action="aspiranteGanador">
                    <div class="row">
                        <div class="form-group col-xs-12">                               
                            <label class="control-label" for="programa">Programa:</label>
                            <select class="form-control input-sm ${disabled1}" id="programa" name="programa">                                  
                                ${catalogo.desplegarOpcionesProgramas("1")}
                            </select>
                        </div>
                    </div>
                    <div class="row">
                        <div class="form-group col-md-12">                                               
                          <label class="control-label" for="proceso">Seleccionar Proceso</label>
                            <select class="form-control input-sm" id="proceso" name="proceso" onchange="tipoProceso()">                    
                                <option value='0'>-Seleccione-</option>
                                <c:if test='${sessionScope["permisoActualEdicion"]=="V"}'>
                                    <option value='1'>Buscar aspirantes</option>
                                    <option value='2'>Calcular resultado</option>
                                    <option value='3'>Asignación preliminar</option>
                                </c:if>
                                <c:if test='${sessionScope["permisoActualEdicion"]=="F"}'>
                                    <option value='1'>Buscar aspirantes</option>
                                </c:if>
                            </select>
                        </div>
                    </div>
                    <div class="row" id="container1">
                        <div class="form-group col-md-4">  
                            <label class="control-label" for="tvacancia">Tipo Vacancia</label>
                            <select class="form-control input-sm" id="tvacancia" name="tvacancia" required>
                                <option value="">---Seleccionar una opción---</option>
                                <option value="1">Real</option>
                                <option value="2">Corrimiento Natural</option>
                            </select>
                        </div>
                        <div class="form-group col-md-4">                               
                            <label class="control-label" for="subsistema">Subsistema:</label>
                            <select class="form-control input-sm ${disabled2}" id="subsistema" name="subsistema" onchange="actualizarPlanteles()" >                                  
                                ${catalogo.desplegarOpcionesSubsistema(sessionScope["subsistema"])}
                            </select>
                        </div>
                        <div class="form-group col-md-4">                               
                            <label class="control-label" for="periodo">Periodo:</label>
                            <select class="form-control input-sm" id="periodo" name="periodo" required>
                                 ${catalogo.getPeriodoActivo()}
                            </select>
                        </div>
                    </div>
                    <div class="row" id="container2">
                        <div class="form-group col-md-4">                                               
                          <label class="control-label" for="entidad">Entidad</label>
                          <select class="form-control input-sm ${disabled3}" id="entidad" name="entidad" onchange="actualizarPlanteles()" >                                  
                              ${catalogo.desplegarOpcionesEstado(sessionScope["entidad"])}
                          </select>
                        </div>
                        <div class="form-group col-md-4">                               
                            <label class="control-label" for="plantel">Plantel:</label>
                            <select class="form-control input-sm ${disabled4}" id="plantel" name="plantel" onchange="actualizarVacancias()">                            
                                ${catalogo.desplegarAspirantesVacancia(sessionScope["programa"],sessionScope["subsistema"],sessionScope["entidad"],sessionScope["plantel"])}
                            </select>
                        </div>
                        <div class="form-group col-md-4">                               
                            <label class="control-label" for="categoria">Categoria:</label>
                            <select class="form-control input-sm" id="categoria" name="categoria" onchange="actualizarJornada()">                                  
                                <option value=''>-Seleccione-</option>
                            </select>
                        </div>
                    </div>
                     <div class="row" id="container3">
                        <div class="form-group col-md-4">                               
                            <label class="control-label" for="jornada">Jornada</label>
                            <select class="form-control input-sm" id="jornada" name="jornada" onchange="numeroPlazas()">                                  
                                <option value=''>-Seleccione-</option>
                            </select>
                        </div>
                        <div class="form-group col-md-4">                               
                            <label class="control-label" for="plazas">Plazas Disponibles</label>
                            <p id="plazas"></p>
                        </div>
                        <div class="form-group col-md-4">
                            <label class="control-label" for="plazasAsignadas">Plazas Asignadas</label>
                            <p id="plazasAsignadas"></p>
                        </div>
                    </div>
                    <div class="row" id="container4">
                        <c:if test='${sessionScope["permisoActualEdicion"]=="V"}'>
                            <div class="form-group col-xs-8 text-right" style="margin-left: -70px;">                    
                                <input class="btn btn-sm btn-primary" id="btnBuscar1" value='Buscar resultados' onclick="busquedaResultados()"/>
                                <input class="btn btn-sm btn-primary" id="btnBuscar" value='Calcular resultado' onclick="confirmacionResultados()"/>
                                <input class="btn btn-sm btn-primary" id="btnBuscar2" value='Asignacion preliminar' onclick="confirmacionAsignacionPreliminar()"/>
                            </div>
                        </c:if>
                        <c:if test='${sessionScope["permisoActualEdicion"]=="F"}'>
                            <div class="form-group col-xs-8 text-right" "="" style="margin-left: -75px;">                          
                                <input class="btn btn-sm btn-primary" id="btnBuscar1" value='Buscar resultados' onclick="busquedaResultados()"/>
                            </div>
                        </c:if>
                        <div class="form-group col-xs-4 text-right" style="margin-left: -95px;" id="btnReporte">                         
                            <img src="imagenes/excel.svg" style="width: 30px; border-radius: 50%; border: 2px solid #46b12e; margin-left: -190px;" onclick="confirmacionReporte()">
                            <span class="tooltiptext" style="margin-left: -190px;">Generar Reporte</span>
                        </div>
                    </div>
                </form>
<!--                <div style="margin: -6px 1050px 0px;">
                    <div class="tooltip2" style="margin-right: 10px;">
                    <img src="imagenes/excel.svg" style="width: 30px; border-radius: 50%; border: 2px solid #46b12e;" onclick="confirmacionReporte()">
                    <span class="tooltiptext" style="margin-left: -190px;">Generar Reporte</span>
                    </div>
                </div>-->
                <div class="table-responsive">
                    <table class="table table-condensed table-striped">
                        <thead>                                
                            <tr>
                                <!--<th>Programa</th>-->
                                <th>Subsistema</th>
                                <th>Entidad</th>
                                <th>Plantel</th>
                                <!--<th>Categoria</th>-->
                                <!--<th>Jornada</th>-->
                                <th>Categoria Ostenta</th>
                                <th>Categoria Aspira</th>
                                <th style="width: 130px;">Nombre</th>
                                <th>RFC</th>
                                <th style="width: 0;">Puntaje Dictaminador</th>
                                <th>Posición</th>
                                <th>Estatus</th>
                                <th>Guardar</th>
                            </tr>
                        </thead>
                        <tbody id="seccionEditable">${dato.desplegarAspirantesVacancia("",sessionScope["programa"],sessionScope["subsistema"],sessionScope["entidad"],sessionScope["plantel"],"","","","")}</tbody>
                    </table>
                </div>
            </div>
            <div class="modal fade" id="modalMensaje" role="dialog">
                <div style="width: 50%;margin: auto;margin-top: 20%;">

                  <!-- Modal content-->
                  <div class="modal-content panel">
                    <div class="modal-header">
                      <button type="button" class="close" data-dismiss="modal">&times;</button>
                      <h4 class="modal-title">Aviso</h4>
                    </div>
                    <div class="modal-body">
                      <p id="mensaje">Registro exitoso.</p>
                    </div>
                    <div class="modal-footer">
                      <button type="button" class="btn btn-sm btn-default" data-dismiss="modal">Cerrar</button>
                    </div>
                  </div>
                </div>
            </div>
            <div id="modalConfirmacion2" class="modal fade" role="dialog">
                <div style="width: 50%;margin: auto;margin-top: 20%;">
                  <div class="modal-content">
                    <div class="modal-header">
                      <button type="button" class="close" data-dismiss="modal">&times;</button>
                      <h4 class="modal-title" >Confirmación</h4>
                    </div>
                    <div class="modal-body">
                        <p id="mensajeConfirmacion">En este proceso se generara<br/>
                            la posición de los participantes de forma automatica<br/>
                            con la seleccion de la pantalla.<br/>
                            ¿Desea continuar?</p>                  
                    </div>
                    <div class="modal-footer">
                      <button type="button" id="btnConfirmar" class="btn btn-sm btn-default">Sí</button>
                      <button type="button" class="btn btn-sm btn-default" data-dismiss="modal">No</button>
                    </div>
                  </div>
                </div>
            </div>
            <div id="modalConfirmacion3" class="modal fade" role="dialog">
                <div style="width: 50%;margin: auto;margin-top: 20%;">
                  <div class="modal-content">
                    <div class="modal-header">
                      <button type="button" class="close" data-dismiss="modal">&times;</button>
                      <h4 class="modal-title" >Confirmación</h4>
                    </div>
                    <div class="modal-body">
                        <p id="mensajeConfirmacion">
                            Se asignara de manera definitiva el estatus seleccionado.<br/>
                            ¿Desea continuar?</p>                  
                    </div>
                    <div class="modal-footer">
                      <button type="button" id="btnConfirmar3" class="btn btn-sm btn-default">Sí</button>
                      <button type="button" class="btn btn-sm btn-default" data-dismiss="modal">No</button>
                    </div>
                  </div>
                </div>
            </div>
            <div class="modal fade" id="modalMensajeReporte" role="dialog">
                <div style="width: 50%;margin: auto;margin-top: 20%;">

                  <!-- Modal content-->
                  <div class="modal-content panel">
                    <div class="modal-header">
                      <button type="button" class="close" data-dismiss="modal">&times;</button>
                      <h4 class="modal-title">Reporte asignación de categoria</h4>
                    </div>
                    <div class="modal-body">
                      <p id="mensaje">Desea generar el reporte de asignación de categoria?</p>
                    </div>
                    <div class="modal-footer">
                      <input class="btn btn-sm btn-primary" id="btnConfirmarReporte" value='Si'/>
                      <!--<button type="button" id="btnConfirmarReporte" class="btn btn-sm btn-default">Sí</button>-->
                      <!--<button type="button" class="btn btn-sm btn-default" data-dismiss="modal">No</button>-->
                      <input class="btn btn-sm btn-primary" id="btnConfirmarReporteNo" data-dismiss="modal" value='No'/>
                    </div>  
                  </div>
                </div>
            </div>
            <div class="modal fade" id="modalMensajeAsignacionPreliminar" role="dialog">
                <div style="width: 50%;margin: auto;margin-top: 20%;">

                  <!-- Modal content-->
                  <div class="modal-content panel">
                    <div class="modal-header">
                      <button type="button" class="close" data-dismiss="modal">&times;</button>
                      <h4 class="modal-title">Asignación preliminar</h4>
                    </div>
                    <div class="modal-body">
                      <p id="mensaje">Desea generar la asignación preliminar?</p>
                    </div>
                    <div class="modal-footer">
                      <input class="btn btn-sm btn-primary" id="btnConfirmarAsignacion" value='Si'/>
                      <!--<button type="button" id="btnConfirmarReporte" class="btn btn-sm btn-default">Sí</button>-->
                      <!--<button type="button" class="btn btn-sm btn-default" data-dismiss="modal">No</button>-->
                      <input class="btn btn-sm btn-primary" id="btnConfirmarAsignacionNo" data-dismiss="modal" value='No'/>
                    </div>  
                  </div>
                </div>
            </div>
        </main>
        <script src="https://framework-gb.cdn.gob.mx/gobmx.js"></script>
        <script src="https://code.jquery.com/jquery-1.12.4.js"></script>
        <script src="https://ajax.aspnetcdn.com/ajax/jquery.validate/1.13.1/jquery.validate.min.js"></script>
        <script src="js/funcionesBusquedaDocente.js"></script>
        <script>
            function confirmacionResultados(){
                $("#btnConfirmar").attr("onClick","calcularResultados()");
                $("#modalConfirmacion2").modal("show");
            }
            function calcularResultados(){
                var programa=$("#programa").val();
                var subsistema=$("#subsistema").val();
                var entidad=$("#entidad").val();
                var plantel=$("#plantel").val();
                var categoria=$("#categoria").val();
                var jornada=$("#jornada").val();
                var vacancia=$("#tvacancia").val();
                var periodo=$("#periodo").val();
                $("#modalConfirmacion2").modal("hide");
                $("#btnBuscar").val("Generando resultados...");
                $("#btnBuscar").attr("disabled","disabled");
                $.post("aspiranteGanador", {id:"r",programa:programa,subsistema:subsistema,entidad:entidad,plantel:plantel,categoria:categoria,jornada:jornada,vacancia:vacancia, periodo:periodo}, function(data){
                    $("#btnBuscar").val("Buscar resultados");
                    $("#btnBuscar").removeAttr("disabled");}
                );
            }
            function busquedaResultados(){
                var programa=$("#programa").val();
                var subsistema=$("#subsistema").val();
                var entidad=$("#entidad").val();
                var plantel=$("#plantel").val();
                var categoria=$("#categoria").val();
                var jornada=$("#jornada").val();
                var vacancia=$("#tvacancia").val();
                var periodo=$("#periodo").val();
                $.post("aspiranteGanador", {id:"b",programa:programa,subsistema:subsistema,entidad:entidad,plantel:plantel,categoria:categoria,jornada:jornada,vacancia:vacancia,periodo:periodo}, function(data){
                    $("#seccionEditable").html(data);}
                );
            }
            function asignacionPreliminar(){
                var programa=$("#programa").val();
                var subsistema=$("#subsistema").val();
                var periodo=$("#periodo").val();
                $("#btnConfirmarAsignacion").val("Generando resultados...");
                $("#btnConfirmarAsignacion").attr("disabled","disabled");
                $.post("aspiranteGanador", {id:"a",programa:programa,subsistema:subsistema,periodo:periodo}, function(data){
                     $("#btnConfirmarAsignacion").val("Si");
                     $("#btnConfirmarAsignacion").removeAttr("disabled");
                    $("#modalMensajeAsignacionPreliminar").modal("hide");}
                );
            }
            function confirmacionAsignacionPreliminar(){
                $("#btnConfirmarAsignacion").attr("onClick","asignacionPreliminar()");
                $("#modalMensajeAsignacionPreliminar").modal("show");
            }
            function confirmacionReporte(){
                $("#btnConfirmarReporte").attr("onClick","crearExcel()");
                $("#modalMensajeReporte").modal("show");
            }
            function crearExcel(){
                var programa=$("#programa").val();
                var subsistema=$("#subsistema").val();
                var entidad=$("#entidad").val();
                var periodo=$("#periodo").val();
                var proceso="1";
//                $("#modalMensajeReporte").modal("show");
                $("#btnConfirmarReporte").val("Generando reporte...");
                $("#btnConfirmarReporte").attr("disabled","disabled");
                $("#btnConfirmarReporteNo").attr("disabled","disabled");
//                $.post("reporteAsignacion", {programa:programa,subsistema:subsistema,entidad:entidad}, function(data){
//                    GenerarDocumento("excel",data);
//                    $("#btnConfirmarReporte").val("Si");
//                    $("#btnConfirmarReporte").removeAttr("disabled");
//                    $("#btnConfirmarReporteNo").removeAttr("disabled");
//                    $("#modalMensajeReporte").modal("hide");
//                });
                $.ajax({
                type: "POST",
                url: '/promocion/reporteAsignacion',
                data: {programa:programa,subsistema:subsistema,entidad:entidad,periodo:periodo,proceso:proceso},     
                timeout: 360000,
                success: function (data) {
                    var reporteObject=JSON.parse(data);
                    var tabla= ""
                    tabla +=  "<table><tr><th >id</th><th >nombre</th><th >primerApellido</th><th >segundoApellido</th><th >correo</th><th >curp</th><th >idPlantel</th><th >idEntidad</th><th >entidad</th><th >cct</th><th >plantel</th><th >telfijo</th><th >telcel</th><th >consideraciones</th><th >idEscuelaEstudio</th><th >escuela</th><th >idCarrera</th><th >carrera</th><th >anioEgreso</th><th >idGradoAcademico</th><th >grado</th><th >idModalidadTitulacion</th><th >modalidad</th><th >anioTitulacion</th><th >cedula</th><th >activo</th><th >ingresoSubsistema</th><th >ingresoPlantel</th><th >idCategoriaJornada</th><th >clave</th><th >idCategoria</th><th >categoria</th><th >idJornada</th><th >jornada</th><th >fechaPlaza</th><th >idTipoNombramiento</th><th >clave</th><th >codigo</th><th >descripcion</th><th >tipo</th><th >fechaUltimaPromocion</th><th >idCategoriaJornadaAspira</th><th >clave as claveAspira</th><th >idCategoriaAspira</th><th >categoriaAspira</th>        <th >idJornadaAspira</th><th >jornadaAspira</th><th >idPerfilRequerido</th><th >requisito</th><th >notaSancion</th><th >compatibilidad</th><th >horasOtroSubsistema</th><th >nivelCENNI</th><th >folioCENNI</th><th >idCCT</th><th >cct</th><th >idEntidadEstudio</th><th >idInstitucion</th><th >idTipoInstitucion</th><th >gradoMarginacion</th><th >frenteGrupo</th><th >funcionesOtro</th><th >finRegistro</th><th >consideraciones</th><th >publico</th><th >Programa</th><th >idConvocatoria</th><th >idEstatus</th><th >observacionInfo</th><th >observacionEncuestados</th><th >observacionCriterios</th><th >institucion</th><th >cct</th><th >escuela</th><th >carreraOtra</th><th >observacionCriterios2</th><th >idSubsistema</th><th >folio</th><th >tipoVacanciaAspira</th><th >idEstatus</th><th >estatus</th><th >puntaje1</th><th >puntaje2</th><th >observacionInfo</th><th >observacionEncuestados</th><th >observacionCriterios</th><th >posicion</th>"
                + "<th >observacion1</th><th >observacion2</th><th >observacion3</th><th >observacion4</th><th >observacion5</th><th >observacion6</th><th >observacion7</th><th >observacion8</th><th >Lista cotejo</th><th >idPrograma</th><th >Acepto registro anterior</th><th >Criterio1 Puntaje Revisor</th><th >Criterio1 Puntaje Dictaminador</th><th >Criterio2 Puntaje Revisor</th><th >Criterio2 Puntaje Dictaminador</th><th >Criterio3 Puntaje Revisor</th><th >Criterio3 Puntaje Dictaminador</th><th >Criterio4 Puntaje Revisor</th><th >Criterio4 Puntaje Dictaminador</th><th >Criterio5 Puntaje Revisor</th><th >Criterio5 Puntaje Dictaminador</th><th >Criterio6 Puntaje Revisor</th><th >Criterio6 Puntaje Dictaminador</th><th >Criterio7 Puntaje Revisor</th><th >Criterio7 Puntaje Dictaminador</th><th >Criterio8 Puntaje Revisor</th><th >Criterio8 Puntaje Dictaminador</th><th >Criterio9 Puntaje Revisor</th><th >Criterio9 Puntaje Dictaminador</th><th >Criterio10 Puntaje Revisor</th><th >Criterio10 Puntaje Dictaminador</th><th >idPlazaPremilinar</th><th >categoriaPreliminar</th><th >jornadaPreliminar</th><th >clavePreliminar</th></tr>";
                    for (let i = 0; i < reporteObject.reporte.length; i++) {
                        tabla +=  "<tr> "
                        for (let z = 0; z < reporteObject.reporte[i].length; z++) {
                            
                            if(z==65){
                                if(JSON.parse(JSON.stringify(reporteObject.reporte[i]))[z]==1){
                                    tabla +=  "<td >Programa de Promoción en el Servicio Docente por Cambio de Categoría en Educación Media Superior</td> "
                                }else if(JSON.parse(JSON.stringify(reporteObject.reporte[i]))[z]==2){
                                    tabla +=  "<td >Programa de Promoción en el Servicio Docente por Asignación de Horas Adicionales en Educación Media Superior</td> "
                                }else{
                                    tabla +=  "<td >Programa de Promoción en la Función por Incentivos en Educación Media Superior</td> "
                                }
                            }else if(z==95){
                                if(JSON.parse(JSON.stringify(reporteObject.reporte[i]))[z]!=null){
                                    tabla +=  "<td >Si</td> "
                                }else{
                                    tabla +=  "<td >No</td> "
                                }
                            }else if(z==97){
                                if(JSON.parse(JSON.stringify(reporteObject.reporte[i]))[z]!=null){
                                    tabla +=  "<td >Si</td> "
                                }else{
                                    tabla +=  "<td >No</td> "
                                }
                            }else{
                                if(JSON.parse(JSON.stringify(reporteObject.reporte[i]))[z]!=null){
                                    tabla +=  "<td >"+JSON.parse(JSON.stringify(reporteObject.reporte[i]))[z]+"</td> "
                                }else{
                                    tabla +=  "<td >---</td> "
                                }
                            }
                        }
                        tabla +=  "</tr>";
                    }
                    tabla+="</table>";
                    GenerarDocumento("excel",tabla);
                    $("#btnConfirmarReporte").val("Si");
                    $("#btnConfirmarReporte").removeAttr("disabled");
                    $("#btnConfirmarReporteNo").removeAttr("disabled");
                    $("#modalMensajeReporte").modal("hide");
                },
                error: function(jqXHR, textStatus, errorThrown) {
                    if(textStatus==="timeout") {
                       $("#btnConfirmarReporte").val("Si");
                       $("#btnConfirmarReporte").removeAttr("disabled");
                       $("#btnConfirmarReporteNo").removeAttr("disabled");
                       $("#modalMensajeReporte").modal("hide");
                    } 
                }});
            }
            function GenerarDocumento(option,tabla) {
                switch (option) {
                    case 'pdf':
                    tableExport({ type: 'pdf', escape: false },tabla);
                        break;
                    case 'excel':
                    tableExport({ type: 'excel', escape: false },tabla);
                        break;
                    default: console.log('No se pudo cargar archivo');
                }
            }
            function tableExport(options,tabla){
                var defaults = {
                    separator: ',',
                    ignoreColumn: [],
                    tableName:'yourTableName',
                    type:'excel',
                    pdfFontSize:14,
                    pdfLeftMargin:20,
                    escape:'true',
                    htmlContent:'false',
                    consoleLog:'false'
                };
                var options = $.extend(defaults, options);
                if(defaults.type == 'excel'  ){
                    var excelFile = "<html xmlns:o='urn:schemas-microsoft-com:office:office' xmlns:x='urn:schemas-microsoft-com:office:"+defaults.type+"' xmlns='http://www.w3.org/TR/REC-html40'><meta http-equiv='content-type' content='application/vnd.ms-excel; charset=UTF-8'>";
                    excelFile += "<head>";
                    excelFile += "<!--[if gte mso 9]>";
                    excelFile += "<xml>";
                    excelFile += "<x:ExcelWorkbook>";
                    excelFile += "<x:ExcelWorksheets>";
                    excelFile += "<x:ExcelWorksheet>";
                    excelFile += "<x:Name>";
                    excelFile += "{worksheet}";
                    excelFile += "</x:Name>";
                    excelFile += "<x:WorksheetOptions>";
                    excelFile += "<x:DisplayGridlines/>";
                    excelFile += "</x:WorksheetOptions>";
                    excelFile += "</x:ExcelWorksheet>";
                    excelFile += "</x:ExcelWorksheets>";
                    excelFile += "</x:ExcelWorkbook>";
                    excelFile += "</xml>";
                    excelFile += "<![endif]-->";
                    excelFile += "</head>";
                    excelFile += "<body>";
                    excelFile += tabla;
                    excelFile += "</body>";
                    excelFile += "</html>";

                    var fileType='';
                    if (defaults.type == 'excel') {
                       fileType = 'xls';
                    }

                    var blob = new Blob([excelFile], { type: 'text/' + fileType });
                    if (window.navigator.msSaveBlob) {
                       window.navigator.msSaveOrOpenBlob(blob, 'Reporte de asignación de categoria ' + new Date().toDateString() + '.' + fileType);
                    }
                    else {
                       var a = window.document.createElement("a");
                       a.href = window.URL.createObjectURL(blob, { type: "text/plain" });
                       a.download = "Reporte de asignación de categoria " + new Date().toDateString() + "." + fileType;
                       document.body.appendChild(a);
                       a.click();
                       document.body.removeChild(a);
                    }
                    }else if(defaults.type == 'pdf'){
                    var doc = new jsPDF('p','pt', 'a4', true);
                    doc.setFontSize(defaults.pdfFontSize);
                    defaults.ignoreColumn = '<table > '+
                    '<tr> <th >Número<br>económico</th> <th >CU</th><th >Fecha<br>pedido</th><th >Empleado<br>entrega</th>'+
                    '<th >Pedido<br>surtido</th><th >Monto</th><th >Fecha<br>redención</th> <th >Premio</th><th >Estatus</th></tr><tr>'+
                    '<td>112233</td> <td>01098462985632</td> <td>20/07/2019</td><td>T73076</td><td>69878</td>'+
                    '<td>$10,000</td><td>20/07/2019</td><td>Lonchera</td> <td>Pendiente</td> </tr></table>';
                    // Header
                    var startColPosition=defaults.pdfLeftMargin;
                    doc.text(20,20, defaults.ignoreColumn);

                    doc.output('datauriNew');
                }
            }
            function confirmarCategoria(id){
                $("#btnConfirmar3").attr("onClick","confirmarCategoriaAspira("+id+")");
                $("#modalConfirmacion3").modal("show");
            }
            function confirmarCategoriaAspira(id){
                $("#modalConfirmacion3").modal("hide");
                var programa=$("#programa").val();
                var subsistema=$("#subsistema").val();
                var entidad=$("#entidad").val();
                var plantel=$("#plantel").val();
                var categoria=$("#categoria").val();
                var jornada=$("#jornada").val();
                var vacancia=$("#tvacancia").val();
                var periodo=$("#periodo").val();
                var estatus="#tvacancia"+id.toString();
                var numero2=document.getElementById(estatus);
                var tConvocatoria = document.querySelector(estatus).value;
                var idEstatus=$("#tvacancia").val()+id;
                $.post("asignarCategoria", {id: id,z: "b",idEstatus: tConvocatoria,programa:programa,subsistema:subsistema,entidad:entidad,plantel:plantel,categoria:categoria,jornada:jornada,vacancia:vacancia, periodo:periodo}, function(data){
                    if(data.includes("<tr>")){            
                        $("#seccionEditable").html(data);
                        $("#mensaje").html("Se guardo correctamente");            
                        $("#modalMensaje").modal("show");
                        numeroPlazasAsignadas();
                    }else if(data.includes("No hay mas vacancias disponibles")){
                        busquedaResultados();
                        $("#mensaje").html("No hay mas vacancias disponibles");            
                        $("#modalMensaje").modal("show");
                    }else{
                        numeroPlazasAsignadas();
                        $("#mensaje").html(data);            
                        $("#modalMensaje").modal("show");
                    }
                });
            }
            function tipoProceso(){
                var idProceso=$("#proceso").val();
                if(idProceso==0){
                    $("#container1").hide();
                    $("#container2").hide();
                    $("#container3").hide();
                    $("#container4").hide();
                }else if(idProceso==1){
                    $("#container1").show();
                    $("#container2").show();
                    $("#container3").show();
                    $("#container4").show();
                    $("#btnBuscar1").show();
                    $("#btnBuscar").hide();
                    $("#btnReporte").show();
                    $("#btnBuscar2").hide();
                }else if(idProceso==2){
                    $("#container1").show();
                    $("#container2").hide();
                    $("#container3").hide();
                    $("#container4").show();
                    $("#btnBuscar1").hide();
                    $("#btnBuscar").show();
                    $("#btnReporte").hide();
                    $("#btnBuscar2").hide();
                }else{
                    $("#container1").show();
                    $("#container2").hide();
                    $("#container3").hide();
                    $("#container4").show();
                    $("#btnBuscar1").hide();
                    $("#btnBuscar").hide();
                    $("#btnReporte").hide();
                    $("#btnBuscar2").show();
                }
            }
            $("#container1").hide();
            $("#container2").hide();
            $("#container3").hide();
            $("#container4").hide();
        </script>
</html>
