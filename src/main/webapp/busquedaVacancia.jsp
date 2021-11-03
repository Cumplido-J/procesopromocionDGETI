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
        <jsp:include page="seccionesPlantilla/scripts.jsp"/>
        <!--Agregar scripts aquí-->
        <script src="js/funcionesBusqueda.js"></script>
    </body>
</html>
