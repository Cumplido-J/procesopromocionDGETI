<%-- 
    Document   : altaUsuario
    Created on : 4 nov 2020, 15:57:31
    Author     : David Reyna
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
    <head>
        <jsp:include page="seccionesPlantilla/head.jsp"/>
        <jsp:useBean id="catalogo" class="herramientas.Catalogos" />
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
                <!--Agregar contenido de página aquí-->
                <div class="text-center">
                    <h4>Alta de Usuario</h4>                       
                </div>
                <div class="row col-xs-12">
                    <p>Los campos marcados con <span class="text-danger" title="Campo obligatorio">*</span> son obligatorios.</p>
                </div>
                <form id="formRegistro" role="form" method="POST" action="RegistrarUsuario">
                    <div class="row">
                        <div class="form-group col-md-8"> 
                            <input type="hidden" id="idUsuario" name="idUsuario"/>
                            <label class="control-label" for="programa">Programa:<span class="text-danger" title="Campo obligatorio">*</span></label>
                            <select class="form-control input-sm ${disabled1}" id="programa" name="programa" required data-ent="${dataEntidad1}" data-sub="${dataSubsistema1}" data-pla="${dataPlantel1}" >                                  
                                ${catalogo.desplegarOpcionesProgramas(sessionScope["programa"])}
                            </select>
                        </div>
                        <div class="form-group col-md-4">                               
                            <label class="control-label" for="subsistema">Subsistema:<span class="text-danger" title="Campo obligatorio">*</span></label>
                            <select class="form-control input-sm ${disabled2}" id="subsistema" name="subsistema" onchange="actualizarPlanteles()" required data-subsistema="${dataSubsistema}">                                  
                                ${catalogo.desplegarOpcionesSubsistema(sessionScope["subsistema"])}
                            </select>
                        </div>
                    </div>
                    <div class="row">
                        <div class="form-group col-md-4">                                               
                            <label class="control-label" for="nivel">Nivel:<span class="text-danger" title="Campo obligatorio">*</span></label>
                            <select class="form-control input-sm " id="nivel" name="nivel" required> 
                                <c:if test='${sessionScope["rol"]=="S"}'>
                                    ${catalogo.desplegarOpcionesNivel()}
                                </c:if>
                                <c:if test='${sessionScope["rol"]!="S"}'>
                                    <c:if test='${sessionScope["nivel"]=="N"}'>
                                        <option value=''>-Seleccione-</option>                                
                                        <option value='E'>Estatal</option>
                                        <option value='P'>Plantel</option>
                                    </c:if>
                                    <c:if test='${sessionScope["nivel"]=="E"}'>
                                        <option value='P'>Plantel</option>
                                    </c:if>
                                    <c:if test='${sessionScope["nivel"]=="P"}'>
                                        <option value=''>-Seleccione-</option>
                                    </c:if>                                
                                </c:if>
                            </select>
                        </div>
                        <div class="form-group col-md-4">                                               
                            <label class="control-label" for="entidad">Entidad:<span id="alertaEntidad" class="text-danger" title="Campo obligatorio"></span></label>
                            <select class="form-control input-sm ${disabled3}" id="entidad" name="entidad" onchange="actualizarPlanteles()" >                                  
                                ${catalogo.desplegarOpcionesEstado(sessionScope["entidad"])}
                            </select>
                        </div>                    
                        <div class="form-group col-md-4">                               
                            <label class="control-label" for="plantel">Plantel:<span id="alertaPlantel" class="text-danger" title="Campo obligatorio"></span></label>
                            <select class="form-control input-sm ${disabled4}" id="plantel" name="plantel" >                                  
                                ${catalogo.desplegarOpcionesPlanteles2(sessionScope["subsistema"],sessionScope["entidad"],sessionScope["plantel"])}
                            </select>
                        </div>
                    </div>
                    <div class="row">
                        <div class="form-group col-md-4">                               
                            <label class="control-label" for="usuario">Usuario:<span class="text-danger" title="Campo obligatorio">*</span></label>
                            <input type="text" class="form-control input-sm" name="usuario" id="usuario" maxlength="13" required/>
                            <label class="error" id="alertaUsuario" hidden >Ingrese un RFC válido</label>
                        </div>
                        <div class="form-group col-md-4">                               
                            <label class="control-label" for="nombre">Nombre:<span class="text-danger" title="Campo obligatorio">*</span></label>
                            <input type="text" class="form-control input-sm" name="nombre" required/>
                        </div>
                        <div class="form-group col-md-4">                               
                            <label class="control-label" for="apellido1">Primer apellido:<span class="text-danger" title="Campo obligatorio">*</span></label>
                            <input type="text" class="form-control input-sm" name="apellido1" required/>
                        </div>
                    </div>
                    <div class="row">
                        <div class="form-group col-md-4">                               
                            <label class="control-label" for="apellido2">Segundo apellido:</label>
                            <input type="text" class="form-control input-sm" name="apellido2" />
                        </div>
                        <div class="form-group col-md-4">                               
                            <label class="control-label">Teléfono fijo:<span class="text-danger" title="Campo obligatorio">*</span></label>
                            <input type="text" class="form-control input-sm" name="fijo" maxlength="10" required/>
                        </div>
                        <div class="form-group col-md-4">                               
                            <label class="control-label">Teléfono celular:<span class="text-danger" title="Campo obligatorio">*</span></label>
                            <input type="text" class="form-control input-sm" name="movil" maxlength="10" required/>
                        </div>
                    </div>
                    <div class="row">
                        <div class="form-group col-md-4">                               
                            <label class="control-label">Correo electrónico:<span class="text-danger" title="Campo obligatorio">*</span></label>
                            <input type="text" class="form-control input-sm" name="correo" id="correo" maxlength="50" required/>
                            <label class="error" id="alertaCorreo" hidden >Ingrese una dirección de correo válida</label>
                        </div>  
                        <div class="form-group col-md-4">                               
                            <label class="control-label" for="tusuario">Tipo Usuario</label>
                            <select class="form-control input-sm" id="tusuario" name="tusuario" onchange="habilitaPermisos()" required>
                                <option value="">---Seleccionar una opción---</option>
                                <option value="D">DOCENTE</option>
                                <option value="A">ADMINISTRADOR</option>
                                <option value="S">SUPER</option>
                            </select>
                        </div>                    
                    </div>
                    <div class="row col-xs-12" id="PermisosAsignados1">
                        <label class="control-label">Permisos asignados:<span class="text-danger" title="Campo obligatorio">*</span></label><br/>  
                        ${catalogo.desplegarOpcionesPermisos()}    
                        <input type="hidden" id="permisos" name="permisos"/>
                        <input type="hidden" id="permisosEscritura" name="permisosEscritura"/>
                    </div>
                    <div class="row" >
                        <div class="form-group col-xs-12 text-center" style="padding-top: 20px;">                         
                            <input class="btn btn-primary" id="btnEnviar" type="submit" value='Registrar'/>                                                
                        </div>
                    </div>
                </form>
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
                        <a id="btnContinuar" href="busquedaUsuarios.jsp" class="btn btn-sm btn-default">Continuar</a>
                        <button id="btnCerrar" type="button" class="btn btn-sm btn-default" data-dismiss="modal">Cerrar</button>
                    </div>
                </div>

            </div>
        </div>
        <jsp:include page="seccionesPlantilla/scripts.jsp"/>
        <!--Agregar scripts aquí-->
        <script src="js/funcionesAltaUsuario.js"></script>
    </body>
</html>
