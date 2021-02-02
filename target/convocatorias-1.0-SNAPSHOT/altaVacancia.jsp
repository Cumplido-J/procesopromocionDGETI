<%-- 
    Document   : altaVacancia
    Created on : 5 nov 2020, 21:38:32
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
                <div class="text-center">
                    <h4>Registro de vacancia</h4>                       
                </div>
                <div class="row col-xs-12">
                    <p>Los campos marcados con <span class="text-danger" title="Campo obligatorio">*</span> son obligatorios.</p>
                </div>
                <form id="formRegistro" role="form" method="POST" action="RegistrarVacancia">
                <div class="row">
                    <div class="form-group col-xs-12">                               
                        <label class="control-label" for="programa">Programa:<span class="text-danger" title="Campo obligatorio">*</span></label>
                        <select class="form-control input-sm " id="programa" name="programa" required>                                  
                            ${catalogo.desplegarOpcionesProgramas(sessionScope["programa"])}
                        </select>
                    </div>
                </div>
                <div class="row">
                    <div class="form-group col-md-3">                               
                        <label class="control-label" for="subsistema">Subsistema: <span class="text-danger" title="Campo obligatorio">*</span></label>
                        <select class="form-control input-sm ${disabled2}" id="subsistema" name="subsistema" onchange="actualizarPlanteles()" required>                                  
                            ${catalogo.desplegarOpcionesSubsistema(sessionScope["subsistema"])}
                        </select>
                    </div>
                    <div class="form-group col-md-3">                                               
                      <label class="control-label" for="entidad">Entidad: <span class="text-danger" title="Campo obligatorio">*</span></label>
                      <select class="form-control input-sm ${disabled3}" id="entidad" name="entidad" onchange="actualizarPlanteles()" required>                                  
                          ${catalogo.desplegarOpcionesEstado(sessionScope["entidad"])}
                      </select>
                    </div>
                      
                    <div class="form-group col-md-3">                               
                        <label class="control-label" for="plantel">Plantel:<span class="text-danger" title="Campo obligatorio">*</span></label>
                        <select class="form-control input-sm ${disabled4}" id="plantel" name="plantel" required>                                  
                             ${catalogo.desplegarOpcionesPlanteles2(sessionScope["subsistema"],sessionScope["entidad"],sessionScope["plantel"])}
                        </select>
                    </div>                        
                    <div class="form-group col-md-3">                               
                        <label class="control-label" for="categoria">Categoria:<span class="text-danger" title="Campo obligatorio">*</span></label>
                        <select class="form-control input-sm" id="categoria" name="categoria" onChange="cambioCategoria(this,'tipoCategoria','jornada')" required>                                  
                            ${catalogo.desplegarOpcionesCategorias()}
                        </select>
                        <input type="hidden" id="tipoCategoria" name="tipoCategoria"/>
                    </div>
                </div>
                <div class="row">
                    <div class="form-group col-md-3">                               
                        <label class="control-label" for="jornada">Jornada:<span class="text-danger" title="Campo obligatorio">*</span></label>
                        <select class="form-control input-sm" id="jornada" name="jornada" onchange="cambioJornada(this)" required>                                  
                            ${catalogo.desplegarOpcionesJornada("")}
                        </select>
                    </div>
                    <div id="seccionHoras" class="form-group col-md-3 hidden">
                        <label class="control-label">Cantidad de horas:<span class="text-danger" title="Campo obligatorio">*</span></label>
                        <input type="text" class="form-control input-sm" id="horas" name="horas" maxlength="2"/>                        
                    </div>
                    <div class="form-group col-md-3">                               
                        <label class="control-label" for="vacancia">Cantidad de plazas vacantes:<span class="text-danger" title="Campo obligatorio">*</span></label>
                        <input type="text" class="form-control input-sm" id="vacancia" name="vacancia" required/>
                    </div>
                    <div class="form-group col-md-3">                               
                        <label class="control-label" for="tipoVacancia">Tipo de vacancia:<span class="text-danger" title="Campo obligatorio">*</span></label>
                        <select class="form-control input-sm" id="tipoVacancia" name="tipoVacancia" required>                                  
                            <option value="Real">Real</option>
                        </select>
                    </div>
                </div>
                <div class="row">
                    <div class="form-group col-xs-12 text-center">                         
                        <input class="btn btn-sm btn-primary" id="btnEnviar" type="submit" value='Guardar'/> 
                                                
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
                    <a id="btnContinuar" href="busquedaVacancia.jsp" class="btn btn-sm btn-default">Continuar</a>
                  <button type="button" id="btnCerrar" class="btn btn-sm btn-default" data-dismiss="modal">Cerrar</button>
                </div>
              </div>

            </div>
        </div>
        <jsp:include page="seccionesPlantilla/scripts.jsp"/>
        <!--Agregar scripts aquí-->
        <script src="js/funcionesAltaVacancia.js"></script>
    </body>
</html>
