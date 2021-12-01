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
        <link rel="stylesheet" href="https://pro.fontawesome.com/releases/v5.10.0/css/all.css" integrity="sha384-AYmEC3Yw5cVb3ZcuHtOA93w35dYTsvhLPVnYs9eStHfGJvOvKxVfELGroGkvsg+p" crossorigin="anonymous"/>

        <jsp:useBean id="catalogo" class="herramientas.Catalogos" />
        <jsp:useBean id="dato" class="herramientas.Datos" />
        <link id="contextPathHolder" data-contextPath="${pageContext.request.contextPath}"/>
        <style>
            .ocultar{
                display:none;
            }
        </style>
    </head>
    <body>
        <c:set var="periodoIdActivo" value="${catalogo.getPeriodoActivoUnicamenteId()}"></c:set> 
            <main class="page">
            <jsp:include page="seccionesPlantilla/barraSuperior.jsp"/>
            <div class="container">
                <div class="text-center">
                    <h4>Búsqueda de ganadores</h4>                    
                </div>
                <form id="formBusqueda" role="form" method="POST" action="BuscarGanadores">
                    <div class="row">
                        <div class="form-group col-xs-12">                               
                            <label class="control-label" for="programa">Programa:</label>
                            <select class="form-control input-sm ${disabled1}" id="programa" name="programa">                                  
                                ${catalogo.desplegarOpcionesProgramas(sessionScope["programa"])}
                            </select>
                        </div>
                    </div>
                    <div class="row">
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

                        <div class="form-group col-md-4">                               
                            <label class="control-label" for="plantel">Plantel:</label>
                            <select class="form-control input-sm ${disabled4}" id="plantel" name="plantel" >                                  
                                ${catalogo.desplegarOpcionesPlanteles2(sessionScope["subsistema"],sessionScope["entidad"],sessionScope["plantel"])}
                            </select>
                        </div>
                    </div>
                    <div class="row">                        
                        <div class="form-group col-md-4">                               
                            <label class="control-label" for="rfcNombre"> RFC o nombre</label>
                            <input type="text" class="form-control input-sm" id="rfcNombre" name="rfcNombre" >
                        </div> 

                        <c:if test='${sessionScope["permisoActual"]!="5"}'>
                                                 
                                <div class="form-group col-md-4">                               
                                    <label class="control-label" for="periodo">Periodo:</label>
                                    <select class="form-control input-sm" id="periodo" name="periodo" >
                                        ${catalogo.getPeriodoActivo()}
                                    </select>
                                </div>
                            
                        </c:if>
                    </div>

                    <div class="row">
                        <div class="form-group col-xs-12 text-center">                         
                            <input class="btn btn-sm btn-primary" name="buscar" id="btnBuscar" type="submit" value='Buscar'/>                          
                        </div>
                    </div>
                </form>
                <div class="table-responsive">
                    <table class="table table-condensed table-striped">
                        <thead>                                
                            <tr>
                                <th>Programa</th>
                                <th>Subsistema</th>
                                <th>Entidad</th>
                                <th>Plantel</th>
                                <th>RFC</th>
                                <th>Nombre</th>                                
                                <th>Puntaje Consejo Dictaminador</th>

                                <th>Periodo</th>
                                <th>Ronda</th>
                                <th>Fecha de Aplicacion</th>
                                <th>Vacancia asignada</th>
                            </tr>
                        </thead>
                        <tbody id="seccionEditable"></tbody>
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
        </main>
        <script src="https://framework-gb.cdn.gob.mx/gobmx.js"></script>
        <script src="https://code.jquery.com/jquery-1.12.4.js"></script>
        <script src="https://ajax.aspnetcdn.com/ajax/jquery.validate/1.13.1/jquery.validate.min.js"></script>
        <script src="https://framework-gb.cdn.gob.mx/gm/v4/qa/js/jquery-ui-datepicker.js"></script>
        <script src="js/funcionesBusquedaGanadores.js"></script>
        <script>
                                var CONTEXT_PATH = $('#contextPathHolder').attr('data-contextPath');

                                function mostrarDatePicker(id) {

                                    let datepicker = '<form action="/fechaAplicacion" method="POST"><div class="row"><div class="col-md-12"><div class="form-group datepicker-group">' +
                                            '<input style="height:27px;padding-right:3px; font-size:12px" class="calendar form-control" class="calendar" id="' +
                                            id + '" type="text"></div><div></div>'
                                            + '<div class="row"><div class="col-md-6"><button name="leer" id="C-' + id + '" onClick="leerGanadorPorId(this.id,1)" type="button"><i class="fa fa-times-circle" style="color:#9D2449;"></i></button></div><div class="col-md-6"><button name="guardar" id="A-' + id + '" onClick="leerGanadorPorId(this.id,2)" type="button"><i class="fa fa-check-circle" style="color:#282a2b;"></button></div></div></form>';
                                    let btnEditar = document.querySelector(id);

                                    let tdFecha = document.getElementById(id).parentNode;
                                    tdFecha.innerHTML = datepicker;

                                    $('.calendar').datepicker({changeMonth: true, changeYear: true, firstDay: 0});
                                    //$("#"+id).val(fechaActual());
                                }

                                function leerGanadorPorId(id, param) {
                                    let _id = id.slice(2);
                                    let tdFecha = document.getElementById(_id).parentNode.parentNode.parentNode.parentNode;
                                    let id_ganador = tdFecha.parentNode.getAttribute("id");
                                    let form = tdFecha;
                                    let dato = "NA";
                                    //tdFecha.innerHTML = 'NA <a id="' + _id + '"onClick="mostrarDatePicker(this.id);"><i class="fa fa-edit"></i></a>';
                                    let post_url = form.getAttribute("action"); //get form action url
                                    let request_method = form.getAttribute("method"); //get form GET/POST method
                                    let form_data;
                                    if (param == 1) {
                                        form_data = {accion: "leer", idGanador: id_ganador}; //Encode form elements for submission 
                                    }
                                    if (param == 2) {
                                        form_data = {accion: "actualizar", idGanador: id_ganador, fecha: $("#" + _id).val()}; //Encode form elements for submission 
                                    }
                                    post_url = CONTEXT_PATH + post_url
                                    $.ajax({
                                        url: post_url,
                                        type: request_method,
                                        data: form_data
                                    }).done(function (response) { //

                                        tdFecha.innerHTML = response + ' <a id="' + _id + '"onClick="mostrarDatePicker(this.id);"><i class="fa fa-edit" style="color:#9d2449;"></i></a>';

                                    });
                                }

                                function fechaActual() {
                                    let d = new Date();
                                    let dia = d.getDate();
                                    let mes = d.getMonth() + 1;
                                    let anio = d.getFullYear();

                                    if (dia < 10) {
                                        dia = "0" + dia;
                                    }
                                    if (mes < 10) {
                                        mes = "0" + mes;
                                    }

                                    return dia + "/" + mes + "/" + anio;
                                }
        </script>
    </body>
</html>
