<%-- 
    Document   : cambioUsuario
    Created on : 5 nov 2020, 11:35:50
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
        <main class="page">
            <jsp:include page="seccionesPlantilla/barraSuperior.jsp"/>
            <div class="container">
                <!--Agregar contenido de página aquí-->
                <div class="text-center">
                    <h4>Actualización de información de administrador</h4>                       
                </div>
                <div class="row col-xs-12">
                    <p>Los campos marcados con <span class="text-danger" title="Campo obligatorio">*</span> son requeridos.</p>
                </div>
                <form id="formRegistro" role="form" method="POST" action="RegistrarUsuario">
                <div class="row">
                    <div class="form-group col-md-8"> 
                        <input type="hidden" id="idUsuario" name="idUsuario" value="${informacion[0]}"/>
                        <label class="control-label" for="programa">Programa:<span class="text-danger" title="Campo obligatorio">*</span></label>
                        <select class="form-control input-sm ${disabled1}" id="programa" name="programa" required>                                  
                            ${catalogo.desplegarOpcionesProgramas(informacion[14])}
                        </select>
                    </div>
                    <div class="form-group col-md-4">                               
                        <label class="control-label" for="subsistema">Subsistema:<span class="text-danger" title="Campo obligatorio">*</span></label>
                        <select class="form-control input-sm ${disabled2}" id="subsistema" name="subsistema" onchange="actualizarPlanteles()" required>                                  
                            ${catalogo.desplegarOpcionesSubsistema(informacion[13])}
                        </select>
                    </div>
                </div>
                <div class="row">
                    <div class="form-group col-md-4">                                               
                      <label class="control-label" for="nivel">Nivel:<span class="text-danger" title="Campo obligatorio">*</span></label>
                      <select class="form-control input-sm " id="nivel" name="nivel" required>                                  
                          ${catalogo.desplegarOpcionesNivel(informacion[12])}                          
                      </select>
                    </div>
                    
                    <div class="form-group col-md-4">                                               
                      <label class="control-label" for="entidad">Entidad:<span id="alertaEntidad" class="text-danger" title="Campo obligatorio"></span></label>
                      <select class="form-control input-sm ${disabled3}" id="entidad" name="entidad" onchange="actualizarPlanteles()">                                  
                          ${catalogo.desplegarOpcionesEstado(informacion[1])}
                      </select>
                    </div>                    
                    <div class="form-group col-md-4">                               
                        <label class="control-label" for="plantel">Plantel:<span id="alertaPlantel" class="text-danger" title="Campo obligatorio"></span></label>
                        <select class="form-control input-sm ${disabled4}" id="plantel" name="plantel">                                  
                            ${catalogo.desplegarOpcionesPlanteles2(informacion[13],informacion[1],informacion[2])}
                        </select>
                    </div>
                </div>
                <div class="row">
                    <div class="form-group col-md-4">                               
                        <label class="control-label" for="usuario">Usuario:<span class="text-danger" title="Campo obligatorio">*</span></label>
                        <input type="text" class="form-control input-sm" name="usuario" id="usuario" maxlength="13" value="${informacion[7]}" required/>
                        <label class="error" id="alertaUsuario" hidden >Ingrese un RFC válido</label>
                    </div>
                    <div class="form-group col-md-4">                               
                        <label class="control-label" for="nombre">Nombre:<span class="text-danger" title="Campo obligatorio">*</span></label>
                        <input type="text" class="form-control input-sm" name="nombre" value="${informacion[3]}" required/>
                    </div>
                    <div class="form-group col-md-4">                               
                        <label class="control-label" for="apellido1">Primer apellido:<span class="text-danger" title="Campo obligatorio">*</span></label>
                        <input type="text" class="form-control input-sm" name="apellido1" value="${informacion[4]}" required/>
                    </div>
                </div>
                <div class="row">
                    <div class="form-group col-md-4">                               
                        <label class="control-label" for="apellido2">Segundo apellido:</label>
                        <input type="text" class="form-control input-sm" name="apellido2" value="${informacion[5]}" />
                    </div>
                    <div class="form-group col-md-4">                               
                        <label class="control-label">Teléfono fijo:<span class="text-danger" title="Campo obligatorio">*</span></label>
                        <input type="text" class="form-control input-sm" name="fijo" maxlength="10" value="${informacion[8]}" required/>
                    </div>
                    <div class="form-group col-md-4">                               
                        <label class="control-label">Teléfono celular:<span class="text-danger" title="Campo obligatorio">*</span></label>
                        <input type="text" class="form-control input-sm" name="movil" maxlength="10" value="${informacion[9]}" required/>
                    </div>
                </div>
                <div class="row">
                    <div class="form-group col-md-4">                               
                        <label class="control-label">Correo electrónico:<span class="text-danger" title="Campo obligatorio">*</span></label>
                        <input type="text" class="form-control input-sm" name="correo" id="correo" value="${informacion[6]}" required/>
                        <label class="error" id="alertaCorreo" hidden >Ingrese una dirección de correo válida</label>
                    </div>                    
                </div>
                <div class="row col-xs-12">
                    <label class="control-label">Permisos asignados:<span class="text-danger" title="Campo obligatorio">*</span></label><br/>  
                    ${catalogo.desplegarOpcionesPermisos(informacion[0])}    
                    <input type="hidden" id="permisos" name="permisos"/>
                </div>
                <div class="row" >
                    <div class="form-group col-xs-12 text-center" style="padding-top: 20px;">                         
                        <input class="btn btn-primary" id="btnEnviar" type="submit" value='Guardar'/>                                                
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
