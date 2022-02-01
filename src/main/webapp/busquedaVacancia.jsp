<%-- 
    Document   : busquedaVacancia
    Created on : 5 nov 2020, 20:39:43
    Author     : David Reyna
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
    session = (HttpSession) request.getSession(true);
    if (session.getAttribute("idUsuario") == null) {
        response.sendRedirect("login.jsp");
    }
%>
<!DOCTYPE html>
<html>
    <head>
        <jsp:include page="seccionesPlantilla/head.jsp"/>
        <jsp:useBean id="catalogo" class="herramientas.Catalogos" />
        <jsp:useBean id="dato" class="herramientas.Datos" />
        <!--Agregar estilos aquí-->
    </head>
    <body>
        <c:set var="disabled1" value=""></c:set>
        <c:set var="disabled2" value=""></c:set>
        <c:set var="disabled3" value=""></c:set>
        <c:set var="disabled4" value=""></c:set> 

        <c:if test='${sessionScope["rol"]!="S"}'>
            <c:if test='${sessionScope["programa"]!=""}'>
                <c:set var="disabled1" value="disabled"></c:set>
            </c:if>
            <c:if test='${sessionScope["subsistema"]!=""}'>
                <c:set var="disabled2" value="disabled"></c:set>
            </c:if>
            <c:if test='${sessionScope["entidad"]!=null}'>
                <c:set var="disabled3" value="disabled"></c:set>
            </c:if>
            <c:if test='${sessionScope["plantel"]!=null}'>
                <c:set var="disabled4" value="disabled"></c:set>
            </c:if>
            <c:if test='${sessionScope["rol"]=="A" && sessionScope["entidad"]=="" && sessionScope["plantel"]==""}'>
                <c:set var="disabled3" value=""></c:set>
                <c:set var="disabled4" value=""></c:set>
            </c:if>
            <c:if test='${sessionScope["rol"]=="A" && sessionScope["entidad"]!="" && sessionScope["plantel"]==""}'>
                <c:set var="disabled3" value="disabled"></c:set>
                <c:set var="disabled4" value=""></c:set>
            </c:if>
            <c:if test='${sessionScope["rol"]=="A" && sessionScope["entidad"]!="" && sessionScope["plantel"]!=""}'>
                <c:set var="disabled3" value="disabled"></c:set>
                <c:set var="disabled4" value="disabled"></c:set>
            </c:if>
        </c:if>

        <c:if test='${sessionScope["rol"]=="S" &&  sessionScope["entidad"] != null && sessionScope["plantel"] != null }'>
            <c:set var="dataEntidad1" value='${sessionScope["entidad"]}'></c:set>
            <c:set var="dataSubsistema1" value='${sessionScope["subsistema"]}'></c:set>
            <c:set var="dataPlantel1" value='${sessionScope["plantel"]}'></c:set>
        </c:if>
        <c:if test='${sessionScope["rol"]=="S" && empty sessionScope["entidad"] && empty sessionScope["plantel"] }'>
            <c:set var="dataSubsistema" value='${sessionScope["subsistema"]}'></c:set>
        </c:if>

        <main class="page">
            <jsp:include page="seccionesPlantilla/barraSuperior.jsp"/>
            <div class="container">
                <div class="text-center">
                    <h4>Consulta de vacancia</h4>                       
                </div>
                <form id="formBusqueda" role="form" method="POST" action="BuscarVacancia">
                    <div class="row">
                        <div class="form-group col-xs-12">                               
                            <label class="control-label" for="programa">Programa:</label>
                            <select class="form-control input-sm ${disabled1}" id="programa" name="programa" data-ent="${dataEntidad1}" data-sub="${dataSubsistema1}" data-pla="${dataPlantel1}" >                                  
                                ${catalogo.desplegarOpcionesProgramas(sessionScope["programa"])}
                            </select>
                        </div>
                    </div>
                    <div class="row">
                        <div class="form-group col-md-3">                               
                            <label class="control-label" for="subsistema">Subsistema:</label>
                            <select class="form-control input-sm ${disabled2}" id="subsistema" name="subsistema" onchange="actualizarPlanteles()" data-subsistema="${dataSubsistema}" >                                  
                                ${catalogo.desplegarOpcionesSubsistema(sessionScope["subsistema"])}
                            </select>
                        </div>
                        <div class="form-group col-md-3">                                               
                            <label class="control-label" for="entidad">Entidad</label>
                            <select class="form-control input-sm ${disabled3}" id="entidad" name="entidad" onchange="actualizarPlanteles()" >                                  
                                ${catalogo.desplegarOpcionesEstado(sessionScope["entidad"])}
                            </select>
                        </div>

                        <div class="form-group col-md-3">                               
                            <label class="control-label" for="plantel">Plantel:</label>
                            <select class="form-control input-sm ${disabled4}" id="plantel" name="plantel" >                                  
                                ${catalogo.desplegarOpcionesPlanteles2(sessionScope["subsistema"],sessionScope["entidad"],sessionScope["plantel"])}
                            </select>
                        </div>                        
                        <div class="form-group col-md-3">                               
                            <label class="control-label" for="tipo">Tipo:</label>
                            <select class="form-control input-sm" id="tipo" name="tipo" >                                  
                                ${catalogo.desplegarOpcionesTipoCategoria()}
                            </select>
                        </div>

                    </div>
                    <div class="row">
                        <div class="form-group col-xs-12 text-center">                         
                            <input class="btn btn-sm btn-primary" id="btnBuscar" type="submit" value='Buscar'/> 
                            <a href="altaVacancia.jsp" class="btn btn-sm btn-primary">Agregar</a>                        
                        </div>
                        <div class="form-group col-xs-4 text-right" style="margin-left: 650px;" id="btnReporte">                         
                            <img src="imagenes/excel.svg" style="width: 30px; border-radius: 50%; border: 2px solid #46b12e; margin-left: -190px;" onclick="confirmacionReporte()">
                            <span class="tooltiptext" style="margin-left: -190px;">Generar Reporte</span>
                        </div>
                    </div>
                </form>
                <div class="table-responsive" >
                    <table class="table table-condensed table-striped">
                        <thead>
                            <tr>
                                <th>Programa</th>
                                <th>Subsistema</th>
                                <th>Entidad</th>
                                <th>Plantel</th>
                                <th>Categoria</th>
                                <th>Jornada</th>
                                <th>Tipo de vacancia</th>
                                <th>Plazas</th>
                            </tr>
                        </thead>
                        <tbody id="seccionEditable" >${dato.desplegarVacancias(sessionScope["programa"],sessionScope["subsistema"],sessionScope["entidad"],sessionScope["plantel"],'')}</tbody>
                    </table>
                </div>
            </div>
        </main>
        <!--Agregar modals aquí-->
        <div class="modal fade" id="modalMensaje" role="dialog">
            <div class="modal-dialog">

                <!-- Modal content-->
                <div class="modal-content panel">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                        <h4 class="modal-title">Aviso</h4>
                    </div>
                    <div class="modal-body">
                        <p id="mensaje"></p>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-sm btn-default" data-dismiss="modal">Cerrar</button>
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
        <jsp:include page="seccionesPlantilla/scripts.jsp"/>
        <!--Agregar scripts aquí-->
        <script src="js/funcionesBusqueda.js"></script>
        <script>
            function confirmacionReporte(){
                $("#btnConfirmarReporte").attr("onClick","crearExcel()");
                $("#modalMensajeReporte").modal("show");
            }
            function crearExcel(){
                var programa=$("#programa").val();
                var subsistema=$("#subsistema").val();
                var entidad="";
                var periodo="";
                var proceso="4";
                $("#btnConfirmarReporte").val("Generando reporte...");
                $("#btnConfirmarReporte").attr("disabled","disabled");
                $("#btnConfirmarReporteNo").attr("disabled","disabled");
                $.ajax({
                type: "POST",
                url: '/promocion/reporteAsignacion',
                data: {programa:programa,subsistema:subsistema,entidad:entidad,periodo:periodo,proceso:proceso},     
                timeout: 360000,
                success: function (data) {
                    var reporteObject=JSON.parse(data);
                    var tabla= ""
                    tabla +=  "<table><tr><th >idEntidad</th><th >entidad</th><th >idJornada</th><th >jornada</th><th >idCategoria</th><th >categoria</th><th >clave</th><th >horas</th><th >plazas</th><th >tipoVacancia</th><th >cct</th><th >plantel</th></tr>";
                    for (let i = 0; i < reporteObject.reporte.length; i++) {
                        tabla +=  "<tr> "
                        for (let z = 0; z < reporteObject.reporte[i].length; z++) {
                            if(JSON.parse(JSON.stringify(reporteObject.reporte[i]))[z]!=null){
                                tabla +=  "<td >"+JSON.parse(JSON.stringify(reporteObject.reporte[i]))[z]+"</td> "
                            }else{
                                tabla +=  "<td >---</td> "
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
                       window.navigator.msSaveOrOpenBlob(blob, 'Reporte vacancia ' + new Date().toDateString() + '.' + fileType);
                    }
                    else {
                       var a = window.document.createElement("a");
                       a.href = window.URL.createObjectURL(blob, { type: "text/plain" });
                       a.download = "Reporte vacancia " + new Date().toDateString() + "." + fileType;
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
    </body>
</html>
