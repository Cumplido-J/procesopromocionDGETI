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
                    <h4>Generación de asignación de categoria</h4>                    
                </div>
                <form id="formBusqueda" role="form" method="POST" action="aspiranteGanador">
                    <div class="row">
                        <div class="form-group col-xs-12">                               
                            <label class="control-label" for="programa">Programa:</label>
                            <select class="form-control input-sm ${disabled1}" id="programa" name="programa" >                                  
                                ${catalogo.desplegarOpcionesProgramas(sessionScope["programa"])}
                            </select>
                        </div>
                    </div>
                    <div class="row">
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
                          <label class="control-label" for="entidad">Entidad</label>
                          <select class="form-control input-sm ${disabled3}" id="entidad" name="entidad" onchange="actualizarPlanteles()" >                                  
                              ${catalogo.desplegarOpcionesEstado(sessionScope["entidad"])}
                          </select>
                        </div>
                    </div>
                    <div class="row">
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
                        <div class="form-group col-md-4">                               
                            <label class="control-label" for="jornada">Jornada</label>
                            <select class="form-control input-sm" id="jornada" name="jornada" onchange="numeroPlazas()">                                  
                                <option value=''>-Seleccione-</option>
                            </select>
                        </div>
                    </div>
                     <div class="row">
                        <div class="form-group col-md-4">                               
                            <label class="control-label" for="plazas">Plazas Disponibles</label>
                            <p id="plazas"></p>
                        </div>
                        <div class="form-group col-md-4"> 
                        </div>
                        <div class="form-group col-md-4">
                        </div>
                    </div>
                    <div class="row">
                        <div class="form-group col-xs-8 text-right" style="margin-left: 28px;">                         
                            <input class="btn btn-sm btn-primary" id="btnBuscar" value='Buscar resultados' onclick="busquedaResultados()"/>
                            <c:if test='${sessionScope["permisoActualEdicion"]=="V"}'>
                                <input class="btn btn-sm btn-primary" id="btnBuscar" value='Calcular resultado' onclick="confirmacionResultados()"/>
                            </c:if>
                        </div>
                        <div class="form-group col-xs-4 text-right" style="margin-left: -95px;">                         
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
                                <th>Programa</th>
                                <th>Subsistema</th>
                                <th>Entidad</th>
                                <th>Plantel</th>
                                <th>Categoria</th>
                                <th>Jornada</th>
                                <th>Nombre</th>
                                <th>RFC</th>
                                <th>Puntaje Dictaminador</th>
                                <th>Posición</th>
                            </tr>
                        </thead>
                        <tbody id="seccionEditable">${dato.desplegarAspirantesVacancia("",sessionScope["programa"],sessionScope["subsistema"],sessionScope["entidad"],sessionScope["plantel"],"","","")}</tbody>
                    </table>
                </div>
            </div>
            <div class="modal fade" id="modalMensaje" role="dialog">
                <div class="modal-dialog">

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
                <div class="modal-dialog">
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
            <div class="modal fade" id="modalMensajeReporte" role="dialog">
                <div class="modal-dialog">

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
                $("#modalConfirmacion2").modal("hide");
                $("#btnBuscar").val("Generando resultados...");
                $("#btnBuscar").attr("disabled","disabled");
                $.post("aspiranteGanador", {id:"r",programa:programa,subsistema:subsistema,entidad:entidad,plantel:plantel,categoria:categoria,jornada:jornada,vacancia:vacancia}, function(data){
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
                $.post("aspiranteGanador", {id:"b",programa:programa,subsistema:subsistema,entidad:entidad,plantel:plantel,categoria:categoria,jornada:jornada,vacancia:vacancia}, function(data){
                    $("#seccionEditable").html(data);}
                );
            }
            function confirmacionReporte(){
                $("#btnConfirmarReporte").attr("onClick","crearExcel()");
                $("#modalMensajeReporte").modal("show");
            }
            function crearExcel(){
                var programa=$("#programa").val();
                var subsistema=$("#subsistema").val();
                var entidad=$("#entidad").val();
//                $("#modalMensajeReporte").modal("show");
                $("#btnConfirmarReporte").val("Generando reporte...");
                $("#btnConfirmarReporte").attr("disabled","disabled");
                $("#btnConfirmarReporteNo").attr("disabled","disabled");
                $.post("reporteAsignacion", {programa:programa,subsistema:subsistema,entidad:entidad}, function(data){
                    GenerarDocumento("excel",data);
                    $("#btnConfirmarReporte").val("Si");
                    $("#btnConfirmarReporte").removeAttr("disabled");
                    $("#btnConfirmarReporteNo").removeAttr("disabled");
                    $("#modalMensajeReporte").modal("hide");
                });
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
        </script>
</html>
