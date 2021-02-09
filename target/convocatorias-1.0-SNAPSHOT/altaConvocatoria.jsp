<%-- 
    Document   : altaConvocatoria
    Created on : 5 nov 2020, 16:55:00
    Author     : David Reyna
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
    session = (HttpSession) request.getSession(true);       
%>
<!DOCTYPE html>
<html>
    <head>
        <jsp:include page="seccionesPlantilla/head.jsp"/>
        <jsp:useBean id="catalogo" class="herramientas.Catalogos" />
        <jsp:useBean id="fecha" class="herramientas.Fecha" />
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
                    <h4>Alta convocatoria</h4>                       
                </div>
                <div class="row col-xs-12">
                    <p>Los campos marcados con <span class="text-danger" title="Campo obligatorio">*</span> son obligatorios.</p>
                </div>
                <form id="formRegistro" role="form" method="POST" action="RegistrarConvocatoria">
                <div class="row">
                    <div class="form-group col-xs-12">                               
                        <label class="control-label" for="programa">Programa:<span class="text-danger" title="Campo obligatorio">*</span></label>
                        <select class="form-control input-sm ${disabled1}" id="programa" name="programa" required>                                  
                            ${catalogo.desplegarOpcionesProgramas(informacion[10])}
                        </select>
                    </div>
                </div>
                <div class="row">
                    <div class="form-group col-md-3">                               
                        <label class="control-label" for="subsistema">Subsistema:<span class="text-danger" title="Campo obligatorio">*</span></label>
                        <select class="form-control input-sm ${disabled2}" id="subsistema" name="subsistema" onchange="actualizarPlanteles()" required>                                  
                            ${catalogo.desplegarOpcionesSubsistema(sessionScope["subsistema"])}
                        </select>
                    </div>
                    <div class="form-group col-md-3">                                               
                      <label class="control-label" for="entidad">Entidad:<span class="text-danger" title="Campo obligatorio">*</span></label>
                      <select class="form-control input-sm ${disabled3}" id="entidad" name="entidad" onchange="actualizarPlanteles()" required>                                  
                          ${catalogo.desplegarOpcionesEstado(informacion[13])}
                      </select>
                    </div>
                      
                    <div class="form-group col-md-3">                               
                        <label class="control-label" for="plantel">Plantel:<span class="text-danger" title="Campo obligatorio" required>*</span></label>
                        <select class="form-control input-sm ${disabled4}" id="plantel" name="plantel">                                  
                             ${catalogo.desplegarOpcionesPlanteles2(sessionScope["subsistema"],informacion[13],informacion[9])}
                        </select>
                    </div> 
                    <div class="form-group col-md-3 datepicker-group">
                        <label class="control-label">Publicación de convocatoria:<span class="text-danger" title="Campo obligatorio">*</span></label>
                        <input type="text" class="form-control input-sm disabled" id="publicacion" name="publicacion" onChange="validaFecha('publicacion','alertaPublicacion')" value="${fecha.formatoImprimir(informacion[1])}">
                        <label class="error hidden" id="alertaPublicacion">Ingrese una fecha válida</label>
                    </div>  
                </div>
                <div class="row">
                    <div class="form-group col-md-3 datepicker-group">                        
                        <label class="control-label">Inicio registro:<span class="text-danger" title="Campo obligatorio">*</span></label>
                        <input type="text" class="form-control input-sm disabled" id="inicioRegistro" name="inicioRegistro" onChange="validaFecha('inicioRegistro','alertaInicioR')" value="${fecha.formatoImprimir(informacion[2])}">
                        <label class="error hidden" id="alertaInicioR">Ingrese una fecha válida</label>
                    </div>
                    <div class="form-group col-md-3 datepicker-group">
                        <label class="control-label">Término registro:<span class="text-danger" title="Campo obligatorio">*</span></label>
                        <input type="text" class="form-control input-sm disabled" id="finRegistro" name="finRegistro" onChange="validaFecha('finRegistro','alertaFinR')" value="${fecha.formatoImprimir(informacion[3])}">
                        <label class="error hidden" id="alertaFinR">Ingrese una fecha válida</label>
                    </div>
                    <div class="form-group col-md-3 datepicker-group">                        
                        <label class="control-label">Inicio valoración:<span class="text-danger" title="Campo obligatorio">*</span></label>
                        <input type="text" class="form-control input-sm disabled" id="inicioValoracion" name="inicioValoracion" onChange="validaFecha('inicioValoracion','alertaInicioV')" value="${fecha.formatoImprimir(informacion[4])}">
                        <label class="error hidden" id="alertaInicioV">Ingrese una fecha válida</label>
                    </div>
                    <div class="form-group col-md-3 datepicker-group">
                        <label class="control-label">Término valoración:<span class="text-danger" title="Campo obligatorio">*</span></label>
                        <input type="text" class="form-control input-sm disabled" id="finValoracion" name="finValoracion" onChange="validaFecha('finValoracion','alertaFinV')" value="${fecha.formatoImprimir(informacion[5])}">
                        <label class="error hidden" id="alertaFinV">Ingrese una fecha válida</label>
                    </div>
                </div>                
                <div class="row">
                    <div class="form-group col-md-3 datepicker-group">                        
                        <label class="control-label">Inicio dictaminación:<span class="text-danger" title="Campo obligatorio">*</span></label>
                        <input type="text" class="form-control input-sm disabled" id="inicioDictaminacion" name="inicioDictaminacion" onChange="validaFecha('inicioDictaminacion','alertaInicioD')" value="${fecha.formatoImprimir(informacion[6])}">
                        <label class="error hidden" id="alertaInicioD">Ingrese una fecha válida</label>
                    </div>
                    <div class="form-group col-md-3 datepicker-group">
                        <label class="control-label">Término dictaminación:<span class="text-danger" title="Campo obligatorio">*</span></label>
                        <input type="text" class="form-control input-sm disabled" id="finDictaminacion" name="finDictaminacion" onChange="validaFecha('finDictaminacion','alertaFinD')" value="${fecha.formatoImprimir(informacion[7])}">
                        <label class="error hidden" id="alertaFinD">Ingrese una fecha válida</label>
                    </div>     
                    <div class="form-group col-md-3 datepicker-group">
                        <label class="control-label">Publicación de resultados:<span class="text-danger" title="Campo obligatorio">*</span></label>
                        <input type="text" class="form-control input-sm disabled" id="resultados" name="resultados" onChange="validaFecha('resultados','alertaResultados')" value="${fecha.formatoImprimir(informacion[8])}">
                        <label class="error hidden" id="alertaResultados">Ingrese una fecha válida</label>
                    </div>
                    <div class="form-group col-md-3 datepicker-group">
                        <label class="control-label" for="estatus">Estatus:<span class="text-danger" title="Campo obligatorio">*</span></label>
                        <select class="form-control input-sm" id="estatus" name="estatus" >
                            <option value="TEMPORAL">Temporal</option>                            
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
                  <a id="btnContinuar" href="busquedaConvocatoria.jsp" class="btn btn-sm btn-default">Continuar</a>
                  <button id="btnCerrar" type="button" class="btn btn-sm btn-default" data-dismiss="modal">Cerrar</button>
                </div>
              </div>

            </div>
        </div>
        <jsp:include page="seccionesPlantilla/scripts.jsp"/>
        <!--Agregar scripts aquí-->
        <script src="js/funcionesAltaConvocatoria.js"></script> 
    </body>
</html>
