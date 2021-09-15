<%-- 
    Document   : busquedaComite
    Created on : 28 sep 2020, 11:11:40
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
        <jsp:useBean id="comite" class="herramientas.Comite" />
    </head>
    <body>
        <c:set var="disabled1" value=""></c:set>
        <c:set var="disabled2" value=""></c:set>
        <c:set var="disabled3" value=""></c:set>
        <c:set var="disabled4" value=""></c:set> 
        <c:set var="disabled5p" value=""></c:set>
        
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
        <c:if test='${sessionScope["rol"]=="S"}'>
            <c:if test='${ sessionScope["entidad"]!= "" && sessionScope["plantel"]!= "" }'>
                <c:set var="disabled2" value="disabled"></c:set>
            </c:if>
            <c:if test='${sessionScope["entidad"]!=null}'>
                <c:set var="disabled3" value="disabled"></c:set>
            </c:if>
            <c:if test='${sessionScope["plantel"]!=null}'>
                <c:set var="disabled5p" value="disabled"></c:set>
            </c:if>
        </c:if>
        <main class="page">
            <jsp:include page="seccionesPlantilla/barraSuperior.jsp"/>
            <div class="container">
                <div class="text-center">
                    <h4>Búsqueda de comité</h4>                    
                </div>
                <form id="formBusqueda" role="form" method="POST" action="BuscarComite">
                <div class="row">
                    <div class="form-group col-xs-12">                               
                        <label class="control-label" for="programa">Programa:</label>
                        <select class="form-control input-sm ${disabled1}" id="programa" name="programa" required>                                  
                            ${catalogo.desplegarOpcionesProgramas(sessionScope["programa"])}
                        </select>
                    </div>
                </div>
                <div class="row">
                    <div class="form-group col-md-3">                               
                        <label class="control-label" for="tipo">Tipo:</label>
                        <select class="form-control input-sm ${disabled4}" id="tipo" name="tipo" onChange="cambioComite()" required>                                                              
                            
                            <c:if test='${sessionScope["plantel"]!=""}'>                                
                                <option value='R'>Comité revisor</option>
                            </c:if>
                            <c:if test='${sessionScope["plantel"]==""}'>
                                <option value=''>-Seleccione-</option>
                                <option value='R'>Comité revisor</option>
                                <option value='D'>Consejo dictaminador</option>
                            </c:if>
                            
                                                      
                        </select>
                    </div>
                    <div class="form-group col-md-3">                               
                        <label class="control-label" for="subsistema">Subsistema:</label>
                        <select class="form-control input-sm ${disabled2}" id="subsistema" name="subsistema" onchange="actualizarPlanteles();cambioComite();" required>                                  
                            ${catalogo.desplegarOpcionesSubsistema(sessionScope["subsistema"])}
                        </select>
                    </div>
                    <div class="form-group col-md-3">                                               
                      <label class="control-label" for="entidad">Entidad</label>
                      <select class="form-control input-sm ${disabled3}" id="entidad" name="entidad" onchange="actualizarPlanteles()" required>                                  
                          ${catalogo.desplegarOpcionesEstado(sessionScope["entidad"])}
                      </select>
                    </div>
                      
                    <div class="form-group col-md-3">                               
                        <label class="control-label" for="plantel">Plantel:</label>
                        <select class="form-control input-sm ${disabled4} ${disabled5p}" id="plantel" name="plantel" required>                                  
                            ${catalogo.desplegarOpcionesPlanteles2(sessionScope["subsistema"],sessionScope["entidad"],sessionScope["plantel"])}
                        </select>
                    </div>
                </div>
                <div class="row">
                    <div class="form-group col-xs-12 text-center">                         
                        <input class="btn btn-sm btn-primary" id="btnBuscar" type="submit" value='Buscar'/>                          
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
                                <th>Tipo</th>
                                <th>Presidente</th>
                                <th>Estatus</th>
                                <th>Opciones</th>
                            </tr>
                        </thead>
                        <tbody id="seccionEditable">${comite.desplegarComite(sessionScope["programa"],"",sessionScope["subsistema"],sessionScope["entidad"],sessionScope["plantel"])}</tbody>
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
            <div class="modal fade" id="modalConfirmacion" role="dialog">
                <div class="modal-dialog">

                  <!-- Modal content-->
                  <div class="modal-content panel">
                    <form id="formComite" role="form" method="POST" action="RegistroComite">
                        <div class="modal-header">
                          <button type="button" class="close" data-dismiss="modal">&times;</button>
                          <h4 class="modal-title">Confirmación</h4>
                        </div>
                        <div class="modal-body">
                            <label>No se encontró el comité ¿desea registrarlo?</label>
                            <input type="hidden" name="idPrograma" id="idPrograma">
                            <input type="hidden" name="idSubsistema" id="idSubsistema">
                            <input type="hidden" name="idEntidad" id="idEntidad">
                            <input type="hidden" name="idPlantel" id="idPlantel">
                            <input type="hidden" name="idTipo" id="idTipo">
                        </div>
                        <div class="modal-footer">
                            <input class="btn btn-sm btn-primary" id="btnRegistrar" type="submit" value='Sí'/>
                            <input type="button" class="btn btn-primary btn-sm" value="No" data-dismiss="modal"/>
                        </div>
                    </form>
                  </div>

                </div>
            </div>
            <div class="modal fade" id="modalConfirmacion2" role="dialog">
                <div class="modal-dialog">

                  <!-- Modal content-->
                  <div class="modal-content panel">
                    <form id="formBorrarComite" role="form" method="POST" action="BorrarComite">
                        <div class="modal-header">
                          <button type="button" class="close" data-dismiss="modal">&times;</button>
                          <h4 class="modal-title">Confirmación</h4>
                        </div>
                        <div class="modal-body">
                            <label>Esta acción eliminará la información del comité, así como la de los integrantes del mismo ¿desea continuar?</label>
                            <input type="hidden" name="idComite" id="idComiteBorrar">
                        </div>
                        <div class="modal-footer">
                            <input class="btn btn-sm btn-primary" type="submit" value='Sí'/>
                            <input type="button" class="btn btn-primary btn-sm" value="No" data-dismiss="modal"/>
                        </div>
                    </form>
                  </div>

                </div>
            </div>
            
        </main>
        <script src="https://framework-gb.cdn.gob.mx/gobmx.js"></script>
        <script src="https://code.jquery.com/jquery-1.12.4.js"></script>
        <script src="https://ajax.aspnetcdn.com/ajax/jquery.validate/1.13.1/jquery.validate.min.js"></script>
        <script src="js/funcionesBusquedaComite.js"></script>
    </body>
</html>

