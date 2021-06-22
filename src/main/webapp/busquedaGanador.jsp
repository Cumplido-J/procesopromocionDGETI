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
                        <div class="form-group col-xs-12 text-center">                         
                            <input class="btn btn-sm btn-primary" id="btnBuscar" value='Buscar resultados' onclick="busquedaResultados()"/>
                            <c:if test='${sessionScope["permisoActualEdicion"]=="V"}'>
                                <input class="btn btn-sm btn-primary" id="btnBuscar" value='Calcular resultado' onclick="confirmacionResultados()"/>
                            </c:if>
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
        </script>
</html>
