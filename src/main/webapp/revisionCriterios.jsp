<%-- 
    Document   : revisionCriterios
    Created on : 23 oct 2020, 11:21:54
    Author     : David Reyna
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/functions" prefix = "fn" %>

<!DOCTYPE html>
<html>
    <head>
        <title>DGETI | sep.gob.mx</title>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">        
        <link href="https://framework-gb.cdn.gob.mx/assets/styles/main.css" rel="stylesheet">
        <link href="css/estilosRegistro.css" rel="stylesheet"/> 
        <jsp:useBean id="catalogo" class="herramientas.Catalogos" />
        <jsp:useBean id="criteriosValoracion" class="herramientas.CriteriosValoracion" />
    </head>
    <body>
        <main class="page">
            <!--Barra navegación UEMSTIS-->
            <nav class="navbar navbar-inverse sub-navbar navbar-fixed-top">
                <div class="container">
                  <div class="navbar-header">
                    <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#subenlaces">
                      <span class="sr-only">Interruptor de Navegación</span>
                      <span class="icon-bar"></span>
                      <span class="icon-bar"></span>
                      <span class="icon-bar"></span>
                    </button>
                    <a class="navbar-brand" href="/">DGETI</a>
                  </div>
                  <div class="collapse navbar-collapse" id="subenlaces">
                    <ul class="nav navbar-nav navbar-right">      
                        <c:set var="hiddenDictaminador" value="hidden"></c:set>
                        <c:set var="disabled1" value=""></c:set>
                        <c:if test="${!vistaAdmin}">
                            <li><a href="SesionDocente">Regresar </a></li>
                            <c:set var="hidden" value="hidden"></c:set>
                        </c:if>
                        <c:if test="${vistaAdmin}">
                            <li><a href="VistaDocente">Regresar</a></li>
                            <c:set var="hidden" value=""></c:set>
                            <c:if test='${sessionScope["permisoActual"]=="6"}'>
                                <c:set var="hiddenDictaminador" value=""></c:set>
                                <c:set var="disabled1" value="disabled"></c:set>
                            </c:if>                            
                        </c:if>
                        <li><a href="Servlet_cerrarsesion">Cerrar sesión</a></li> 
                    </ul>
                  </div>
                </div>
            </nav>
            <!--FIN Barra navegación UEMSTIS-->                
            <!--Barra encabezado-->
            <div class="encabezado row text-center">
                <p>Dirección General de Educación Tecnológica Industrial y de Servicios</p>
            </div>
            <!--FIN Barra encabezado-->
            <div class="container">
              <div class="text-center">
                  <h4>Programa de Promoción en el Servicio Docente en Educación Media Superior</h4>
              </div>
              <!--Breadcrumbs-->
              <ol class="breadcrumb">
                <li><a href="Servlet_cerrarsesion">Inicio</a></li>
                <li><a href="SesionDocente">Sesión Docente</a></li>
                <li class="active">Revisión de evidencias de criterios de valoración</li>
              </ol>
              <!--FIN Breadcrumbs-->
                  <div class="panel-group ficha-collapse" id="accordion">
                    <div class="panel panel-default">
                      <div class="panel-heading">
                        <h4 class="panel-title">
                          <a data-parent="#accordion" data-toggle="collapse" href="#panel1" aria-expanded="true" aria-controls="panel1">
                              ${criterios[0][0]} - ${criterios[0][1]}                                
                                <c:if test = "${puntajes[0][7]=='R'}">
                                    <span class="glyphicon glyphicon-ok-sign completo" title="Criterio revisado" id="estatus1" completo="true"></span>                                      
                                </c:if>
                                <c:if test = "${puntajes[0][7]!='R'}">
                                    <span class="glyphicon glyphicon-exclamation-sign incompleto" title="Criterio pendiente de revisar" id="estatus1" completo="false"></span>                                    
                                </c:if>
                                <c:if test = "${puntajesDictaminador[0][7]=='R'}">
                                    <span class="glyphicon glyphicon-ok-sign ${hiddenDictaminador} completo" title="Criterio revisado" id="estatus1D" completo="true"></span>                                      
                                </c:if>
                                <c:if test = "${puntajesDictaminador[0][7]!='R'}">
                                    <span class="glyphicon glyphicon-exclamation-sign ${hiddenDictaminador} incompleto" title="Criterio pendiente de revisar" id="estatus1D" completo="false"></span>                                    
                                </c:if>                                
                          </a>
                          <p class="text-danger ${hidden}">Puntaje Consejo: <span id="p1">${puntajes[0][4]}</span></p>
                          <p class="text-danger ${hiddenDictaminador}">Puntaje Dictaminador: <span id="p1D">${puntajesDictaminador[0][4]}</span></p>
                          <c:set var="total" value="${puntajes[0][4]}"></c:set>
                          <c:set var="totalDictaminador" value="${puntajesDictaminador[0][4]}"></c:set>
                        </h4>
                        <button type="button" class="collpase-button collapsed" data-parent="#accordion" data-toggle="collapse" href="#panel1"></button>
                      </div>
                      <div class="panel-collapse collapse in" id="panel1">
                        <div class="panel-body">
                            <form id="form1" role="form" action="RegistrarCriterio" method="POST">
                                <input type='hidden' name='idCriterio' value='${criterios[0][0]}'>
                                <input type='hidden' name='idPermisoD1' id='idPermisoD1' value='${sessionScope["permisoActual"]}'>
                                <div class="form-group col-md-6">                                                             
                                  <label class="control-label">Antigüedad:</label>
                                  <select class="form-control input-sm" id="puntaje1" name="puntaje" required>
                                      <c:choose>
                                          <c:when test='${sessionScope["permisoActual"]=="6"}'>
                                              ${catalogo.desplegarOpcionesPuntajeAdmin(criterios[0][0],puntajesDictaminador[0][3])}
                                          </c:when>
                                          <c:otherwise>
                                              ${catalogo.desplegarOpcionesPuntajeAdmin(criterios[0][0],puntajes[0][3])}                                              
                                          </c:otherwise>
                                      </c:choose>
                                   </select>
                                </div>
                                <div class="form-group col-md-6">
                                    <label class="control-label">Carga de evidencia documental:</label>
                                    <br/>
                                    <c:if test = "${docente.documentoCargado2('2')==true}">
                                        <input id="btnEvidencia2" type="button" class="btn btn-sm btn-link" value="Ver archivo" onclick="abrirModalArchivo(2)"/>                                    
                                    </c:if>
                                    <c:if test = "${docente.documentoCargado2('2')==false}">
                                        <input id="btnEvidencia2" type="button" class="btn btn-sm btn-link incompleto" value="Subir archivo" onclick="abrirModalArchivo(2)"/>
                                        <span class="glyphicon glyphicon-exclamation-sign incompleto" id="alertaBtnEvidencia2" title="Sección incompleta"></span>  
                                    </c:if> 
                                </div>
                                <div class="col-xs-12 text-right">
                                    
                                    <input class="btn btn-sm btn-primary" id="btnEnviar1" type="submit" value='Guardar y continuar'/>                                    
                                </div>
                            </form>
                        </div>
                      </div>
                    </div>
                    <c:if test="${docente.infoRegistro[58]==null}">
                        <c:set var="disabled" value="disabled"></c:set>
                    </c:if>
                    <div class="panel panel-default ${disabled}">
                      <div class="panel-heading">
                        <h4 class="panel-title">
                          <a data-parent="#accordion" data-toggle="collapse" href="#panel2" aria-expanded="false" aria-controls="panel2">
                            ${criterios[1][0]} - ${criterios[1][1]}
                            <c:if test="${docente.infoRegistro[58]!=null}">
                                <c:if test = "${puntajes[1][7]=='R'}">
                                    <span class="glyphicon glyphicon-ok-sign completo" title="Criterio revisado" id="estatus2" completo="true"></span>                                      
                                </c:if>
                                <c:if test = "${puntajes[1][7]!='R'}">
                                    <span class="glyphicon glyphicon-exclamation-sign incompleto" title="Criterio pendiente de revisar" id="estatus2" completo="false"></span>                                    
                                </c:if>
                                <c:if test = "${puntajesDictaminador[1][7]=='R'}">
                                    <span class="glyphicon glyphicon-ok-sign ${hiddenDictaminador} completo" title="Criterio revisado" id="estatus2D" completo="true"></span>                                      
                                </c:if>
                                <c:if test = "${puntajesDictaminador[1][7]!='R'}">
                                    <span class="glyphicon glyphicon-exclamation-sign ${hiddenDictaminador} incompleto" title="Criterio pendiente de revisar" id="estatus2D" completo="false"></span>                                    
                                </c:if>    
                            </c:if>
                            <c:if test="${docente.infoRegistro[58]==null}">
                            
                                <span class="glyphicon glyphicon-ok-sign completo" title="Criterio revisado" id="estatus2" completo="true"></span>
                                <span class="glyphicon glyphicon-ok-sign ${hiddenDictaminador} completo" title="Criterio revisado" id="estatus2D" completo="true"></span>
                            
                            </c:if>                                
                          </a>
                          <p class="text-danger ${hidden}">Puntaje Consejo: <span id="p2">${puntajes[1][4]}</span></p>
                          <p class="text-danger ${hiddenDictaminador}">Puntaje Dictaminador: <span id="p2D">${puntajesDictaminador[1][4]}</span></p>
                          <c:set var="total" value="${total+puntajes[1][4]}"></c:set>
                          <c:set var="totalDictaminador" value="${totalDictaminador+puntajesDictaminador[1][4]}"></c:set>
                        </h4>
                        <button type="button" class="collpase-button collapsed" data-parent="#accordion" data-toggle="collapse" href="#panel2"></button>
                      </div>
                      <div class="panel-collapse collapse" id="panel2">
                        <div class="panel-body">
                          <form id="form2" role="form" action="RegistrarCriterio" method="POST">
                                <input type='hidden' name='idCriterio' value='${criterios[1][0]}'>
                                <input type='hidden' name='idPermisoD2' id='idPermisoD2' value='${sessionScope["permisoActual"]}'>
                                <div class="form-group col-md-6">                                                             
                                  <label class="control-label">Experiencia:</label>
                                  <select class="form-control input-sm" id="puntaje2" name="puntaje" required>
                                      <c:choose>
                                          <c:when test='${sessionScope["permisoActual"]=="6"}'>                                              
                                              ${catalogo.desplegarOpcionesPuntajeAdmin(criterios[1][0],puntajesDictaminador[1][3])}
                                          </c:when>
                                          <c:otherwise>
                                              ${catalogo.desplegarOpcionesPuntajeAdmin(criterios[1][0],puntajes[1][3])}                                              
                                          </c:otherwise>
                                       </c:choose>                                      
                                  </select>
                                </div>
                                <div class="form-group col-md-6">
                                    <label class="control-label">Carga de evidencia documental:</label><br/>
                                    <c:if test = "${docente.documentoCargado2('10')==true}">
                                        <input id="btnEvidencia10" type="button" class="btn btn-sm btn-link" value="Ver archivo" onclick="abrirModalArchivo(10)"/>                                                                            
                                    </c:if>
                                    <c:if test = "${docente.documentoCargado2('10')==false}">
                                        <input id="btnEvidencia10" type="button" class="btn btn-sm btn-link incompleto" value="Subir archivo" onclick="abrirModalArchivo(10)"/>
                                        <span class="glyphicon glyphicon-exclamation-sign incompleto" id="alertaBtnEvidencia10" title="Sección incompleta"></span>  
                                    </c:if>
                                    
                                </div>
                                <div class="col-xs-12 text-right">
                                    
                                    <input class="btn btn-sm btn-primary" id="btnEnviar2" type="submit" value='Guardar y continuar'/>                                    
                                </div>
                            </form>
                        </div>
                      </div>
                    </div>
                    <div class="panel panel-default">
                      <div class="panel-heading">
                        <h4 class="panel-title">
                          <a data-parent="#accordion" data-toggle="collapse" href="#panel3" aria-expanded="false" aria-controls="panel3">
                          ${criterios[2][0]} - ${criterios[2][1]}
                            <span class="glyphicon glyphicon-ok-sign completo" title="Criterio revisado" id="estatus3" completo="true"></span>
                            <span class="glyphicon glyphicon-ok-sign ${hiddenDictaminador} completo" title="Criterio revisado" id="estatus3D" completo="true"></span>
                          </a>
                          <p class="text-danger ${hidden}">Puntaje Consejo: <span id="p3">${puntajeEncuestas[5]}</span></p>
                          <c:set var="total" value="${total+puntajeEncuestas[5]}"></c:set>
                          <p class="text-danger ${hiddenDictaminador}">Puntaje Dictaminador: <span id="p3D">${puntajeEncuestas[5]}</span></p>
                          <c:set var="totalDictaminador" value="${totalDictaminador+puntajeEncuestas[5]}"></c:set>
                        </h4>
                        <button type="button" class="collpase-button collapsed" data-parent="#accordion" data-toggle="collapse" href="#panel3"></button>
                      </div>
                      <div class="panel-collapse collapse" id="panel3">
                        <div class="panel-body">
                            <div class='table-responsive'>
                                <table class='table table-condensed table-bordered'>
                                    <tr><th>Encuesta</th><th><c:if test="${vistaAdmin}">Puntaje</c:if><c:if test="${!vistaAdmin}">Estatus</c:if></th></tr>
                                    <tr><td>A madres y padres de familia o tutores</td><td><c:if test="${vistaAdmin}">${puntajeEncuestas[4]}</c:if><c:if test="${!vistaAdmin}">Evaluado</c:if></td></tr>
                                    <tr><td>A alumnos</td><td><c:if test="${vistaAdmin}">${puntajeEncuestas[2]}</c:if><c:if test="${!vistaAdmin}">Evaluado</c:if></td></tr>
                                    <tr><td>A compañeros de trabajo</td><td><c:if test="${vistaAdmin}">${puntajeEncuestas[3]}</c:if><c:if test="${!vistaAdmin}">Evaluado</c:if></td></tr>
                                </table>
                            </div>
                        </div>
                      </div>
                    </div>
                    <div class="panel panel-default">
                      <div class="panel-heading">
                        <h4 class="panel-title">
                          <a data-parent="#accordion" data-toggle="collapse" href="#panel4" aria-expanded="false" aria-controls="panel4">
                            ${criterios[3][0]} - ${criterios[3][1]}                               
                                <c:if test = "${puntajes[3][7]=='R'}">
                                    <span class="glyphicon glyphicon-ok-sign completo" title="Criterio revisado" id="estatus4" completo="true"></span>                                      
                                </c:if>
                                <c:if test = "${puntajes[3][7]!='R'}">
                                    <span class="glyphicon glyphicon-exclamation-sign incompleto" title="Criterio pendiente de revisar" id="estatus4" completo="false"></span>                                    
                                </c:if>
                                <c:if test = "${puntajesDictaminador[3][7]=='R'}">
                                    <span class="glyphicon glyphicon-ok-sign ${hiddenDictaminador} completo" title="Criterio revisado" id="estatus4D" completo="true"></span>                                      
                                </c:if>
                                <c:if test = "${puntajesDictaminador[3][7]!='R'}">
                                    <span class="glyphicon glyphicon-exclamation-sign ${hiddenDictaminador} incompleto" title="Criterio pendiente de revisar" id="estatus4D" completo="false"></span>                                    
                                </c:if>           
                          </a>
                          <p class="text-danger ${hidden}">Puntaje Consejo: <span id="p4">${puntajes[3][4]}</span></p>
                          <p class="text-danger ${hiddenDictaminador}">Puntaje Dictaminador: <span id="p4D">${puntajesDictaminador[3][4]}</span></p>
                          <c:set var="total" value="${total+puntajes[3][4]}"></c:set>
                          <c:set var="totalDictaminador" value="${totalDictaminador+puntajesDictaminador[3][4]}"></c:set>
                        </h4>
                        <button type="button" class="collpase-button collapsed" data-parent="#accordion" data-toggle="collapse" href="#panel4"></button>
                      </div>
                      <div class="panel-collapse collapse" id="panel4">
                        <div class="panel-body">
                          <form id="form4" role="form" action="RegistrarCriterio" method="POST">
                                <input type='hidden' name='idCriterio' value='${criterios[3][0]}'>
                                <input type='hidden' name='idPermisoD4' id='idPermisoD4' value='${sessionScope["permisoActual"]}'>
                                <div class="form-group col-md-6">                                                             
                                  <label class="control-label">Máximo grado académico:</label>
                                  <select class="form-control input-sm disabled" id="puntaje4" name="puntaje" required>                                  
                                      ${catalogo.desplegarOpcionesPuntajeAdmin(criterios[3][0],docente.infoRegistro[19])}                                                                            
                                  </select>
                                  
                                </div>
                                <div class="form-group col-md-6">
                                    <label class="control-label">Carga de evidencia documental:</label>
                                    <br/>
                                    <c:if test = "${docente.documentoCargado2('1')==true}">
                                        <input id="btnEvidencia1" type="button" class="btn btn-sm btn-link" value="Ver archivo" onclick="abrirModalArchivo(1)"/>                                                                            
                                    </c:if>
                                    <c:if test = "${docente.documentoCargado2('1')==false}">
                                        <input id="btnEvidencia1" type="button" class="btn btn-sm btn-link incompleto" value="Subir archivo" onclick="abrirModalArchivo(1)"/>  
                                        <span class="glyphicon glyphicon-exclamation-sign incompleto" id="alertaBtnEvidencia1" title="Sección incompleta"></span>  
                                    </c:if>
                                    
                                </div>
                                <div class="col-xs-12 text-right">
                                    
                                    <input class="btn btn-sm btn-primary" id="btnEnviar4" type="submit" value='Guardar y continuar'/>                                    
                                </div>
                            </form>
                        </div>
                      </div>
                    </div>
                    <div class="panel panel-default">
                      <div class="panel-heading">
                        <h4 class="panel-title">
                          <a data-parent="#accordion" data-toggle="collapse" href="#panel5" aria-expanded="false" aria-controls="panel5">
                          ${criterios[4][0]} - ${criterios[4][1]}                            
                            <c:if test="${puntajes[4][7]=='R'}">
                                <span class="glyphicon glyphicon-ok-sign completo" title="Criterio revisado" id="estatus5" completo="true"></span>
                            </c:if>
                            <c:if test="${puntajes[4][7]!='R'}">
                                <span class="glyphicon glyphicon-exclamation-sign incompleto" title="Criterio pendiente de revisar" id="estatus5" completo="false"></span>                                    
                            </c:if>
                            <c:if test="${puntajesDictaminador[4][7]=='R'}">
                                <span class="glyphicon glyphicon-ok-sign ${hiddenDictaminador} completo" title="Criterio revisado" id="estatus5D" completo="true"></span>
                            </c:if>
                            <c:if test="${puntajesDictaminador[4][7]!='R'}">
                                <span class="glyphicon glyphicon-exclamation-sign ${hiddenDictaminador} incompleto" title="Criterio pendiente de revisar" id="estatus5D" completo="false"></span>                                    
                            </c:if>    
                          </a>
                          <p class="text-danger ${hidden}">Puntaje Consejo: 
                              <span id="p5">
                                  <c:if test="${puntajes[4][3]=='0'}">
                                      ${puntajes[4][4]}
                                      <c:set var="checked" value="checked"></c:set>
                                      <c:set var="in" value=""></c:set>
                                      <c:set var="total" value="${total+puntajes[4][4]}"></c:set>
                                  </c:if>
                                  <c:if test="${puntajes[4][3]!='0'}">
                                      ${cursos[1]}
                                      <c:set var="checked" value=""></c:set>
                                      <c:set var="in" value="in"></c:set>
                                      <c:set var="total" value="${total+cursos[1]}"></c:set>
                                  </c:if>
                              </span></p>
                              <p class="text-danger ${hiddenDictaminador}">Puntaje Dictaminador: 
                              <span id="p5D">
                                  <c:if test="${puntajesDictaminador[4][3]=='0'}">
                                      ${puntajesDictaminador[4][4]}
                                      <c:set var="checked" value="checked"></c:set>
                                      <c:set var="in" value=""></c:set>
                                      <c:set var="totalDictaminador" value="${totalDictaminador+puntajesDictaminador[4][4]}"></c:set>
                                  </c:if>
                                  <c:if test="${puntajesDictaminador[4][3]!='0'}">
                                      ${cursos[2]}
                                      <c:set var="checked" value=""></c:set>
                                      <c:set var="in" value="in"></c:set>
                                      <c:set var="totalDictaminador" value="${totalDictaminador+cursos[2]}"></c:set>
                                  </c:if>
                              </span></p>
                        </h4>
                        <button type="button" class="collpase-button collapsed" data-parent="#accordion" data-toggle="collapse" href="#panel5"></button>
                      </div>
                      <div class="panel-collapse collapse" id="panel5">
                        <div class="panel-body">
                            <form id="form5" role="form" action="RegistrarCriterio" method="POST">
                            <input type='hidden' name='idPermisoD5' id='idPermisoD5' value='${sessionScope["permisoActual"]}'>
                            <div class="row">
                                <div class="checkbox col-xs-12">                                  
                                  <label><input type="checkbox" name="cbConstancia" id="cb5" data-toggle="collapse" data-target="#seccionCursos" ${checked}>Marque la casilla si no cuenta con evidencias de este criterio</label>
                                </div>
                            </div>
                            <div id="seccionCursos" class="collapse ${in}">
                            <div class="text-left">
                                <label class="control-label">Cursos de actualización relacionados con la asignatura y/o módulo que imparte, o mejora pedagógica en los 2 años anteriores</label>
                            </div>
                            
                            <div class='table-responsive'>
                                <label class="text-warning" id="alertaCarga"><span class="glyphicon glyphicon-warning-sign"></span>&nbsp;Utilice la barra de desplazamiento para recorrer la tabla y visualizar todos los elementos</label>
                                <table class='table table-bordered table-condensed'>
                                    <tr><th>Tipo</th><th>Nombre del curso</th><th>Periodo o Fecha de realización</th><th>Institución educativa con reconocimiento oficial que emite constancia</th><th>Total de horas que acredita el curso</th><th>Constancia o documento probatorio</th><th>Opciones</th></tr>
                                    <tbody id="tablaCursos">
                                        ${cursos[0]}
                                    </tbody>
                                </table>
                            </div>
                            
                            <input type='hidden' name='idCriterio' value='${criterios[4][0]}'>                                
                            <div class="form-group col-xs-12">
                                <label class="control-label">Carga de evidencia documental:</label><br/>
                                    <c:if test = "${docente.documentoCargado2('13')==true}">
                                        <input id="btnEvidencia13" type="button" class="btn btn-sm btn-link" value="Ver archivo" onclick="abrirModalArchivo(13)"/>                                                                            
                                    </c:if>
                                    <c:if test = "${docente.documentoCargado2('13')==false}">
                                        <input id="btnEvidencia13" type="button" class="btn btn-sm btn-link incompleto" value="Subir archivo" onclick="abrirModalArchivo(13)"/>  
                                        <span class="glyphicon glyphicon-exclamation-sign incompleto" id="alertaBtnEvidencia13" title="Sección incompleta"></span>  
                                    </c:if>
                            </div>                              
                            </div>
                            <div class="col-xs-12 text-right">
                                
                                <input class="btn btn-sm btn-primary" id="btnEnviar5" type="submit" value='Guardar y continuar'/>                                    
                            </div>
                            </form>
                        </div>
                      </div>
                    </div>
                    <div class="panel panel-default">
                      <div class="panel-heading">
                        <h4 class="panel-title">
                          <a data-parent="#accordion" data-toggle="collapse" href="#panel6" aria-expanded="false" aria-controls="panel6">
                          ${criterios[5][0]} - ${criterios[5][1]}                               
                            <c:if test = "${puntajes[5][7]=='R'}">
                                <span class="glyphicon glyphicon-ok-sign completo" title="Criterio revisado" id="estatus6" completo="true"></span>                                      
                            </c:if>
                            <c:if test = "${puntajes[5][7]!='R'}">
                                <span class="glyphicon glyphicon-exclamation-sign incompleto" title="Criterio pendiente de revisar" id="estatus6" completo="false"></span>                                    
                            </c:if>
                            <c:if test = "${puntajesDictaminador[5][7]=='R'}">
                                <span class="glyphicon glyphicon-ok-sign ${hiddenDictaminador} completo" title="Criterio revisado" id="estatus6D" completo="true"></span>                                      
                            </c:if>
                            <c:if test = "${puntajesDictaminador[5][7]!='R'}">
                                <span class="glyphicon glyphicon-exclamation-sign ${hiddenDictaminador} incompleto" title="Criterio pendiente de revisar" id="estatus6D" completo="false"></span>                                    
                            </c:if>    
                          </a>
                          <p class="text-danger ${hidden}">Puntaje Consejo: 
                              <span id="p6">
                                  <c:if test="${puntajes[5][3]=='0'}">
                                      ${puntajes[5][4]}
                                      <c:set var="checked" value="checked"></c:set>
                                      <c:set var="in" value=""></c:set>
                                      <c:set var="total" value="${total+puntajes[5][4]}"></c:set>
                                  </c:if>
                                  <c:if test="${puntajes[5][3]!='0'}">
                                      ${aportaciones[1]}
                                      <c:set var="checked" value=""></c:set>
                                      <c:set var="in" value="in"></c:set>
                                      <c:set var="total" value="${total+aportaciones[1]}"></c:set>
                                  </c:if>                                  
                              </span></p>
                              <p class="text-danger ${hiddenDictaminador}">Puntaje Dictaminador: 
                              <span id="p6D">
                                  <c:if test="${puntajesDictaminador[5][3]=='0'}">
                                      ${puntajesDictaminador[5][4]}
                                      <c:set var="checked" value="checked"></c:set>
                                      <c:set var="in" value=""></c:set>
                                      <c:set var="totalDictaminador" value="${totalDictaminador+puntajesDictaminador[5][4]}"></c:set>
                                  </c:if>
                                  <c:if test="${puntajesDictaminador[5][3]!='0'}">
                                      ${aportaciones[2]}
                                      <c:set var="checked" value=""></c:set>
                                      <c:set var="in" value="in"></c:set>
                                      <c:set var="totalDictaminador" value="${totalDictaminador+aportaciones[2]}"></c:set>
                                  </c:if>                                  
                              </span></p>
                        </h4>
                        <button type="button" class="collpase-button collapsed" data-parent="#accordion" data-toggle="collapse" href="#panel6"></button>
                      </div>
                      <div class="panel-collapse collapse" id="panel6">
                        <div class="panel-body">
                            <form id="form6" role="form" action="RegistrarCriterio" method="POST">
                            <input type='hidden' name='idPermisoD6' id='idPermisoD6' value='${sessionScope["permisoActual"]}'>
                            <div class="row">
                                <div class="checkbox col-xs-12">                                  
                                  <label><input type="checkbox" ${checked} id="cb6" name="cbConstancia" data-toggle="collapse" data-target="#seccionAportaciones">Marque la casilla si no cuenta con evidencias de este criterio</label>
                                </div>
                            </div>
                            <div id="seccionAportaciones" class="collapse ${in}">
                            
                            <div class='table-responsive'>
                                <label class="text-warning" id="alertaCarga"><span class="glyphicon glyphicon-warning-sign"></span>&nbsp;Utilice la barra de desplazamiento para recorrer la tabla y visualizar todos los elementos</label>
                                <table class='table table-bordered table-condensed'>
                                    <tr><th>Nombre de la aportación en materia de mejora continua</th><th>Periodo o Fecha de realización</th><th>Institución educativa con reconocimiento oficial que emite constancia</th><th>Constancia o documento probatorio</th><th>Opciones</th></tr>
                                    <tbody id="tablaAportaciones">
                                        ${aportaciones[0]}
                                    </tbody>
                                </table>
                            </div>
                            
                            <input type='hidden' name='idCriterio' value='${criterios[5][0]}'>                                
                            <div class="form-group col-xs-12">
                                <label class="control-label">Carga de evidencia documental:</label>
                                <br/>
                                    <c:if test = "${docente.documentoCargado2('14')==true}">
                                        <input id="btnEvidencia14" type="button" class="btn btn-sm btn-link" value="Ver archivo" onclick="abrirModalArchivo(14)"/>                                                                            
                                    </c:if>
                                    <c:if test = "${docente.documentoCargado2('14')==false}">
                                        <input id="btnEvidencia14" type="button" class="btn btn-sm btn-link incompleto" value="Subir archivo" onclick="abrirModalArchivo(14)"/>  
                                        <span class="glyphicon glyphicon-exclamation-sign incompleto" id="alertaBtnEvidencia14" title="Sección incompleta"></span>  
                                    </c:if>
                            </div>
                                
                            
                        </div>
                            <div class="col-xs-12 text-right">
                                
                                <input class="btn btn-sm btn-primary" id="btnEnviar6" type="submit" value='Guardar y continuar'/>                                    
                            </div>
                            </form>
                        </div>        
                      </div>
                    </div>
                    <div class="panel panel-default">
                      <div class="panel-heading">
                        <h4 class="panel-title">
                          <a data-parent="#accordion" data-toggle="collapse" href="#panel7" aria-expanded="false" aria-controls="panel7">
                          ${criterios[6][0]} - ${criterios[6][1]}                               
                            <c:if test = "${puntajes[6][7]=='R'}">
                                <span class="glyphicon glyphicon-ok-sign completo" title="Criterio revisado" id="estatus7" completo="true"></span>                                      
                            </c:if>
                            <c:if test = "${puntajes[6][7]!='R'}">
                                <span class="glyphicon glyphicon-exclamation-sign incompleto" title="Criterio pendiente de revisar" id="estatus7" completo="false"></span>                                    
                            </c:if>
                            <c:if test = "${puntajesDictaminador[6][7]=='R'}">
                                <span class="glyphicon glyphicon-ok-sign ${hiddenDictaminador} completo" title="Criterio revisado" id="estatus7D" completo="true"></span>                                      
                            </c:if>
                            <c:if test = "${puntajesDictaminador[6][7]!='R'}">
                                <span class="glyphicon glyphicon-exclamation-sign ${hiddenDictaminador} incompleto" title="Criterio pendiente de revisar" id="estatus7D" completo="false"></span>                                    
                            </c:if>    
                          </a>
                          <p class="text-danger ${hidden}">Puntaje Consejo: 
                              <span id="p7">
                                  <c:if test="${puntajes[6][3]=='0'}">
                                      ${puntajes[6][4]}
                                      <c:set var="checked" value="checked"></c:set>
                                      <c:set var="in" value=""></c:set>
                                      <c:set var="total" value="${total+puntajes[6][4]}"></c:set>
                                  </c:if>
                                  <c:if test="${puntajes[6][3]!='0'}">
                                      ${participaciones[1]}
                                      <c:set var="checked" value=""></c:set>
                                      <c:set var="in" value="in"></c:set>
                                      <c:set var="total" value="${total+participaciones[1]}"></c:set>
                                  </c:if>                                  
                              </span></p>
                          <p class="text-danger ${hiddenDictaminador}">Puntaje Dictaminador: 
                              <span id="p7D">
                                  <c:if test="${puntajesDictaminador[6][3]=='0'}">
                                      ${puntajesDictaminador[6][4]}
                                      <c:set var="checked" value="checked"></c:set>
                                      <c:set var="in" value=""></c:set>
                                      <c:set var="totalDictaminador" value="${totalDictaminador+puntajesDictaminador[6][4]}"></c:set>
                                  </c:if>
                                  <c:if test="${puntajesDictaminador[6][3]!='0'}">
                                      ${participaciones[2]}
                                      <c:set var="checked" value=""></c:set>
                                      <c:set var="in" value="in"></c:set>
                                      <c:set var="totalDictaminador" value="${totalDictaminador+participaciones[2]}"></c:set>
                                  </c:if>                                  
                              </span></p>
                        </h4>
                        <button type="button" class="collpase-button collapsed" data-parent="#accordion" data-toggle="collapse" href="#panel7"></button>
                      </div>
                      <div class="panel-collapse collapse" id="panel7">
                        <div class="panel-body">
                            <form id="form7" role="form" action="RegistrarCriterio" method="POST">
                            <input type='hidden' name='idPermisoD7' id="idPermisoD7" value='${sessionScope["permisoActual"]}'>    
                            <div class="row">
                                <div class="checkbox col-xs-12">                                  
                                  <label><input type="checkbox" ${checked} id="cb7" name="cbConstancia" data-toggle="collapse" data-target="#seccionParticipaciones">Marque la casilla si no cuenta con evidencias de este criterio</label>
                                </div>
                            </div>
                            <div id="seccionParticipaciones" class="collapse ${in}">
                            
                            <div class='table-responsive'>
                                <label class="text-warning" id="alertaCarga"><span class="glyphicon glyphicon-warning-sign"></span>&nbsp;Utilice la barra de desplazamiento para recorrer la tabla y visualizar todos los elementos</label>
                                <table class='table table-bordered table-condensed'>
                                    <tr><th>Nombre de la participación en eventos y actividades de fortalecimiento académico y formación integral del educando</th><th>Periodo o Fecha de realización</th><th>Institución educativa con reconocimiento oficial que emite constancia</th><th>Constancia o documento probatorio</th><th>Opciones</th></tr>
                                    <tbody id="tablaParticipaciones">
                                        ${participaciones[0]}
                                    </tbody>
                                </table>
                            </div>
                            
                                <input type='hidden' name='idCriterio' value='${criterios[6][0]}'>                                
                                <div class="form-group col-xs-12">
                                    <label class="control-label">Carga de evidencia documental:</label>
                                    <br/>
                                    <c:if test = "${docente.documentoCargado2('15')==true}">
                                        <input id="btnEvidencia15" type="button" class="btn btn-sm btn-link" value="Ver archivo" onclick="abrirModalArchivo(15)"/>                                                                            
                                    </c:if>
                                    <c:if test = "${docente.documentoCargado2('15')==false}">
                                        <input id="btnEvidencia15" type="button" class="btn btn-sm btn-link incompleto" value="Subir archivo" onclick="abrirModalArchivo(15)"/>  
                                        <span class="glyphicon glyphicon-exclamation-sign incompleto" id="alertaBtnEvidencia15" title="Sección incompleta"></span>  
                                    </c:if>                                        
                                </div>
                                
                            </div>
                            <div class="col-xs-12 text-right">
                                    
                                    <input class="btn btn-sm btn-primary" id="btnEnviar7" type="submit" value='Guardar y continuar'/>                                    
                                </div>
                            </form>
                        </div>
                      </div>
                    </div>
                    <div class="panel panel-default">
                      <div class="panel-heading">
                        <h4 class="panel-title">
                          <a data-parent="#accordion" data-toggle="collapse" href="#panel8" aria-expanded="false" aria-controls="panel8">
                          ${criterios[7][0]} - ${criterios[7][1]}                                
                            <c:if test = "${puntajes[7][7]=='R'}">
                                <span class="glyphicon glyphicon-ok-sign completo" title="Criterio revisado" id="estatus8" completo="true"></span>                                      
                            </c:if>
                            <c:if test = "${puntajes[7][7]!='R'}">
                                <span class="glyphicon glyphicon-exclamation-sign incompleto" title="Criterio pendiente de revisar" id="estatus8" completo="false"></span>                                    
                            </c:if>
                            <c:if test = "${puntajesDictaminador[7][7]=='R'}">
                                <span class="glyphicon glyphicon-ok-sign ${hiddenDictaminador} completo" title="Criterio revisado" id="estatus8D" completo="true"></span>                                      
                            </c:if>
                            <c:if test = "${puntajesDictaminador[7][7]!='R'}">
                                <span class="glyphicon glyphicon-exclamation-sign ${hiddenDictaminador} incompleto" title="Criterio pendiente de revisar" id="estatus8D" completo="false"></span>                                    
                            </c:if>    
                          </a>
                          <p class="text-danger ${hidden}">Puntaje Consejo: 
                              <span id="p8">
                                  <c:if test="${puntajes[7][3]=='0'}">
                                      ${puntajes[7][4]}
                                      <c:set var="checked" value="checked"></c:set>
                                      <c:set var="in" value=""></c:set>
                                      <c:set var="total" value="${total+puntajes[7][4]}"></c:set>
                                  </c:if>
                                  <c:if test="${puntajes[7][3]!='0'}">
                                      ${tutorias[1]}
                                      <c:set var="checked" value=""></c:set>
                                      <c:set var="in" value="in"></c:set>
                                      <c:set var="total" value="${total+tutorias[1]}"></c:set>
                                  </c:if> 
                              </span></p>
                          <p class="text-danger ${hiddenDictaminador}">Puntaje Dictaminador: 
                              <span id="p8D">
                                  <c:if test="${puntajesDictaminador[7][3]=='0'}">
                                      ${puntajesDictaminador[7][4]}
                                      <c:set var="checked" value="checked"></c:set>
                                      <c:set var="in" value=""></c:set>
                                      <c:set var="totalDictaminador" value="${totalDictaminador+puntajesDictaminador[7][4]}"></c:set>
                                  </c:if>
                                  <c:if test="${puntajesDictaminador[7][3]!='0'}">
                                      ${tutorias[2]}
                                      <c:set var="checked" value=""></c:set>
                                      <c:set var="in" value="in"></c:set>
                                      <c:set var="totalDictaminador" value="${totalDictaminador+tutorias[2]}"></c:set>
                                  </c:if> 
                              </span></p>
                        </h4>
                        <button type="button" class="collpase-button collapsed" data-parent="#accordion" data-toggle="collapse" href="#panel8"></button>
                      </div>
                      <div class="panel-collapse collapse" id="panel8">
                        <div class="panel-body">
                            <form id="form8" role="form" action="RegistrarCriterio" method="POST">
                            <input type='hidden' name='idPermisoD8' id="idPermisoD8" value='${sessionScope["permisoActual"]}'>    
                            <div class="row">
                                    <div class="checkbox col-xs-12">                                  
                                      <label><input type="checkbox" id="cb8" ${checked} name="cbConstancia" data-toggle="collapse" data-target="#seccionTutorias">Marque la casilla si no cuenta con evidencias de este criterio</label>
                                    </div>
                            </div>
                            <div id="seccionTutorias" class="collapse ${in}">
                            
                            <div class='table-responsive'>
                                <label class="text-warning" id="alertaCarga"><span class="glyphicon glyphicon-warning-sign"></span>&nbsp;Utilice la barra de desplazamiento para recorrer la tabla y visualizar todos los elementos</label>
                                <table class='table table-bordered table-condensed'>
                                    <tr><th>Periodo o Fecha de realización</th><th>Constancia o documento probatorio</th><th>Opciones</th></tr>
                                    <tbody id="tablaTutorias">
                                        ${tutorias[0]}
                                    </tbody>
                                </table>
                            </div>
                            
                                <input type='hidden' name='idCriterio' value='${criterios[7][0]}'>                                
                                <div class="form-group col-xs-12">
                                    <label class="control-label">Carga de evidencia documental:</label>
                                    <br/>
                                    <c:if test = "${docente.documentoCargado2('16')==true}">
                                        <input id="btnEvidencia16" type="button" class="btn btn-sm btn-link" value="Ver archivo" onclick="abrirModalArchivo(16)"/>                                                                            
                                    </c:if>
                                    <c:if test = "${docente.documentoCargado2('16')==false}">
                                        <input id="btnEvidencia16" type="button" class="btn btn-sm btn-link incompleto" value="Subir archivo" onclick="abrirModalArchivo(16)"/>  
                                        <span class="glyphicon glyphicon-exclamation-sign incompleto" id="alertaBtnEvidencia16" title="Sección incompleta"></span>  
                                    </c:if>
                                </div>
                                
                            
                        </div>
                                <div class="col-xs-12 text-right">
                                    
                                    <input class="btn btn-sm btn-primary" id="btnEnviar8" type="submit" value='Guardar y continuar'/>                                    
                                </div>
                            </form>
                        </div>
                      </div>
                    </div>
                    <div class="panel panel-default">
                      <div class="panel-heading">
                        <h4 class="panel-title">
                          <a data-parent="#accordion" data-toggle="collapse" href="#panel9" aria-expanded="false" aria-controls="panel9">
                          ${criterios[8][0]} - ${criterios[8][1]} 
                            <c:if test = "${puntajes[8][7]=='R'}">
                                <span class="glyphicon glyphicon-ok-sign completo" title="Criterio revisado" id="estatus9" completo="true"></span>                                      
                            </c:if>
                            <c:if test = "${puntajes[8][7]!='R'}">
                                <span class="glyphicon glyphicon-exclamation-sign incompleto" title="Criterio pendiente de revisar" id="estatus9" completo="false"></span>                                    
                            </c:if>
                            <c:if test = "${puntajesDictaminador[8][7]=='R'}"> 
                                <span class="glyphicon glyphicon-ok-sign ${hiddenDictaminador} completo" title="Criterio revisado" id="estatus9D" completo="true"></span>                                      
                            </c:if>
                            <c:if test = "${puntajesDictaminador[8][7]!='R'}">
                                <span class="glyphicon glyphicon-exclamation-sign ${hiddenDictaminador} incompleto" title="Criterio pendiente de revisar" id="estatus9D" completo="false"></span>                                    
                            </c:if>

                          </a>
                          <p class="text-danger ${hidden}">Puntaje Consejo: 
                              <span id="p9">
                                  <c:if test="${puntajes[8][3]=='0'}">
                                      ${puntajes[8][4]}
                                      <c:set var="checked" value="checked"></c:set>
                                      <c:set var="in" value=""></c:set>
                                      <c:set var="total" value="${total+puntajes[8][4]}"></c:set>
                                  </c:if>
                                  <c:if test="${puntajes[8][3]!='0'}">
                                      ${publicaciones[1]}
                                      <c:set var="checked" value=""></c:set>
                                      <c:set var="in" value="in"></c:set>
                                      <c:set var="total" value="${total+publicaciones[1]}"></c:set>
                                  </c:if> 
                              </span></p>
                          <p class="text-danger ${hiddenDictaminador}">Puntaje Dictaminador: 
                              <span id="p9D">
                                  <c:if test="${puntajesDictaminador[8][3]=='0'}">
                                      ${puntajesDictaminador[8][4]}
                                      <c:set var="checked" value="checked"></c:set>
                                      <c:set var="in" value=""></c:set>
                                      <c:set var="totalDictaminador" value="${totalDictaminador+puntajesDictaminador[8][4]}"></c:set>
                                  </c:if>
                                  <c:if test="${puntajesDictaminador[8][3]!='0'}">
                                      ${publicaciones[2]}
                                      <c:set var="checked" value=""></c:set>
                                      <c:set var="in" value="in"></c:set>
                                      <c:set var="totalDictaminador" value="${totalDictaminador+publicaciones[2]}"></c:set>
                                  </c:if> 
                              </span></p>
                        </h4>
                        <button type="button" class="collpase-button collapsed" data-parent="#accordion" data-toggle="collapse" href="#panel9"></button>
                      </div>
                      <div class="panel-collapse collapse" id="panel9">
                        <div class="panel-body">
                            <form id="form9" role="form" action="RegistrarCriterio" method="POST">
                            <input type='hidden' name='idPermisoD9' id="idPermisoD9" value='${sessionScope["permisoActual"]}'>    
                            <div class="row">
                                    <div class="checkbox col-xs-12">                                  
                                      <label><input type="checkbox" id="cb9" ${checked} name="cbConstancia" data-toggle="collapse" data-target="#seccionPublicaciones">Marque la casilla si no cuenta con evidencias de este criterio</label>
                                    </div>
                            </div>
                            <div id="seccionPublicaciones" class="collapse ${in}">
                            
                            <div class='table-responsive'>
                                <label class="text-warning" id="alertaCarga"><span class="glyphicon glyphicon-warning-sign"></span>&nbsp;Utilice la barra de desplazamiento para recorrer la tabla y visualizar todos los elementos</label>
                                <table class='table table-bordered table-condensed'>
                                    <tr><th>Nombre de  la publicación</th><th>Medio en el que se publicó</th><th>Fecha de publicación</th><th>ISSN/ISBN</th><th>Opciones</th></tr>
                                    <tbody id="tablaPublicaciones">
                                        ${publicaciones[0]}
                                    </tbody>
                                </table>
                            </div>
                            
                                <input type='hidden' name='idCriterio' value='${criterios[8][0]}'>                                
                                <div class="form-group col-xs-12">
                                    <label class="control-label">Carga de evidencia documental:</label>
                                    <br/>
                                    <c:if test = "${docente.documentoCargado2('17')==true}">
                                        <input id="btnEvidencia17" type="button" class="btn btn-sm btn-link" value="Ver archivo" onclick="abrirModalArchivo(17)"/>                                                                            
                                    </c:if>
                                    <c:if test = "${docente.documentoCargado2('17')==false}">
                                        <input id="btnEvidencia17" type="button" class="btn btn-sm btn-link incompleto" value="Subir archivo" onclick="abrirModalArchivo(17)"/>  
                                        <span class="glyphicon glyphicon-exclamation-sign incompleto" id="alertaBtnEvidencia17" title="Sección incompleta"></span>  
                                    </c:if>
                                </div>
                                
                            
                        </div>
                        <div class="col-xs-12 text-right">
                                    
                                    <input class="btn btn-sm btn-primary" id="btnEnviar9" type="submit" value='Guardar y continuar'/>                                    
                                </div>
                            </form>
                        </div>
                      </div>
                    </div>
                    <div class="panel panel-default">
                      <div class="panel-heading">
                        <h4 class="panel-title">
                          <a data-parent="#accordion" data-toggle="collapse" href="#panel10" aria-expanded="false" aria-controls="panel10">
                          ${criterios[9][0]} - ${criterios[9][1]}  
                            <c:if test = "${puntajes[9][7]=='R'}">
                                <span class="glyphicon glyphicon-ok-sign completo" title="Criterio revisado" id="estatus10" completo="true"></span>                                      
                            </c:if>
                            <c:if test = "${puntajes[9][7]!='R'}">
                                <span class="glyphicon glyphicon-exclamation-sign incompleto" title="Criterio pendiente de revisar" id="estatus10" completo="false"></span>                                    
                            </c:if>
                            <c:if test = "${puntajesDictaminador[9][7]=='R'}">
                                <span class="glyphicon glyphicon-ok-sign ${hiddenDictaminador} completo" title="Criterio revisado" id="estatus10D" completo="true"></span>                                      
                            </c:if>
                            <c:if test = "${puntajesDictaminador[9][7]!='R'}">
                                <span class="glyphicon glyphicon-exclamation-sign ${hiddenDictaminador} incompleto" title="Criterio pendiente de revisar" id="estatus10D" completo="false"></span>                                    
                            </c:if>    
                          </a>
                          <p class="text-danger ${hidden}">Puntaje Consejo: <span id="p10">${puntajes[9][4]+puntajes[10][4]+puntajes[11][4]+puntajes[12][4]+puntajes[13][4]+resultados[1]}</span></p>
                          <c:set var="total" value="${total+puntajes[9][4]+puntajes[10][4]+puntajes[11][4]+puntajes[12][4]+puntajes[13][4]+resultados[1]}"></c:set>
                          <p class="text-danger ${hiddenDictaminador}">Puntaje Dictaminador: <span id="p10D">${puntajesDictaminador[9][4]+puntajesDictaminador[10][4]+puntajesDictaminador[11][4]+puntajesDictaminador[12][4]+puntajesDictaminador[13][4]+resultados[2]}</span></p>
                          <c:set var="totalDictaminador" value="${totalDictaminador+puntajesDictaminador[9][4]+puntajesDictaminador[10][4]+puntajesDictaminador[11][4]+puntajesDictaminador[12][4]+puntajesDictaminador[13][4]+resultados[2]}"></c:set>
                        </h4>
                        <button type="button" class="collpase-button collapsed" data-parent="#accordion" data-toggle="collapse" href="#panel10"></button>
                      </div>
                      <div class="panel-collapse collapse" id="panel10">
                        <div class="panel-body">
                            <form id="form10" role="form" action="RegistrarCriterio" method="POST">
                                <input type='hidden' name='idCriterio' value='${criterios[9][0]}'>
                                <input type='hidden' name='idPermisoD10' id="idPermisoD10" value='${sessionScope["permisoActual"]}'>    
                                <div class="row">
                                    <div class="form-group col-md-6">
                                        <label class="control-label">10.A Planeación didáctica: Docente</label>
                                        <select class="form-control input-sm" id="puntaje10" name="puntaje10" required>                                  
                                            <c:choose>
                                              <c:when test='${sessionScope["permisoActual"]=="6"}'>                                              
                                                  ${catalogo.desplegarOpcionesPuntajeAdmin("10",puntajesDictaminador[9][3])}
                                              </c:when>
                                              <c:otherwise>
                                                  ${catalogo.desplegarOpcionesPuntajeAdmin("10",puntajes[9][3])}                                                  
                                              </c:otherwise>
                                            </c:choose>
                                      </select>
                                    </div>
                                    <div class="form-group col-md-6">
                                        <label class="control-label">10.B Portafolio de evidencias de Evaluación del aprendizaje</label>
                                        <select class="form-control input-sm" id="puntaje11" name="puntaje11" required>                                  
                                            <c:choose>
                                              <c:when test='${sessionScope["permisoActual"]=="6"}'>                                              
                                                  ${catalogo.desplegarOpcionesPuntajeAdmin("11",puntajesDictaminador[10][3])}
                                              </c:when>
                                              <c:otherwise>
                                                  ${catalogo.desplegarOpcionesPuntajeAdmin("11",puntajes[10][3])}                                                  
                                              </c:otherwise>
                                            </c:choose>
                                        </select>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="form-group col-md-6">                                                             
                                      <label class="control-label">10.C. Observación en el aula (práctica docente)
                                          <br/>Nivel de desempeño en la observación de clase en aula (práctica docente)
                                      </label>
                                      <select class="form-control input-sm" id="puntaje12" name="puntaje12" required>                                  
                                           <c:choose>
                                              <c:when test='${sessionScope["permisoActual"]=="6"}'>
                                                  ${catalogo.desplegarOpcionesPuntajeAdmin("12",puntajesDictaminador[11][3])}
                                              </c:when>
                                              <c:otherwise>
                                                  ${catalogo.desplegarOpcionesPuntajeAdmin("12",puntajes[11][3])}                                                                                               
                                              </c:otherwise>
                                           </c:choose>
                                      </select>
                                    </div>
                                    <div class="form-group col-md-6">                                                             
                                      <label class="control-label">10.C Porcentaje de aprobación escolar (Resultados educativos) por las asignatura, actividades paraescolar o módulos profesionales impartidos:<br/><br/></label>
                                      <select class="form-control input-sm" id="puntaje13" name="puntaje13" required>                                  
                                          <c:choose>
                                              <c:when test='${sessionScope["permisoActual"]=="6"}'>
                                                  ${catalogo.desplegarOpcionesPuntajeAdmin("13",puntajesDictaminador[12][3])}
                                              </c:when>
                                              <c:otherwise>
                                                  ${catalogo.desplegarOpcionesPuntajeAdmin("13",puntajes[12][3])}                                                                                               
                                              </c:otherwise>
                                           </c:choose>                                          
                                      </select>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="form-group col-md-6">                                                             
                                      <label class="control-label">10.D. Dictamen del área académica
                                      <br/>Nivel de Desempeño(resultados educativos): 
                                      </label>
                                      <select class="form-control input-sm" id="puntaje13" name="puntaje14" required>                                  
                                          <c:choose>
                                              <c:when test='${sessionScope["permisoActual"]=="6"}'>
                                                  ${catalogo.desplegarOpcionesPuntajeAdmin("14",puntajesDictaminador[13][3])}
                                              </c:when>
                                              <c:otherwise>
                                                  ${catalogo.desplegarOpcionesPuntajeAdmin("14",puntajes[13][3])}                                                                                               
                                              </c:otherwise>
                                           </c:choose>  
                                      </select>
                                    </div>
                                </div>
                                <div class="col-xs-12">
                                    <label class="control-label">10.F. Evidencia de participación en actividades para mejorar los resultados educativos</label>
                                    <div class='text-center'>
                                        <input type="hidden" id="pEvidencias" value="${puntajes[9][4]+puntajes[10][4]+puntajes[11][4]+puntajes[12][4]+puntajes[13][4]}"/>
                                        <input type='hidden' id='pEvidenciasD' value="${puntajesDictaminador[9][4]+puntajesDictaminador[10][4]+puntajesDictaminador[11][4]+puntajesDictaminador[12][4]+puntajesDictaminador[13][4]}"/>                                        
                                        <input type="hidden" id="pResultado" value="${resultados[1]}"/>
                                        <input type="hidden" id="pResultadoD" value="${resultados[2]}"/>                                        
                                    </div>
                                    <div class='table-responsive'>
                                        <label class="text-warning" id="alertaCarga"><span class="glyphicon glyphicon-warning-sign"></span>&nbsp;Utilice la barra de desplazamiento para recorrer la tabla y visualizar todos los elementos</label>
                                        <table class='table table-bordered table-condensed'>
                                            <tr><th>Tipo de evidencia</th><th>Periodo o Fecha de realización</th><th>Constancia o documento probatorio</th><th>Opciones</th></tr>
                                            <tbody id="tablaResultados">
                                                ${resultados[0]}
                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                                <div class="form-group col-md-12">
                                    <label class="control-label">Carga de evidencia documental:</label>
                                    <br/>
                                    <c:if test = "${docente.documentoCargado2('18')==true}">
                                        <input id="btnEvidencia18" type="button" class="btn btn-sm btn-link" value="Ver archivo" onclick="abrirModalArchivo(18)"/>                                                                            
                                    </c:if>
                                    <c:if test = "${docente.documentoCargado2('18')==false}">
                                        <input id="btnEvidencia18" type="button" class="btn btn-sm btn-link incompleto" value="Subir archivo" onclick="abrirModalArchivo(18)"/>  
                                        <span class="glyphicon glyphicon-exclamation-sign incompleto" id="alertaBtnEvidencia18" title="Sección incompleta"></span>  
                                    </c:if>
                                </div>
                                <div class="col-xs-12 text-right">
                                    
                                    <input class="btn btn-sm btn-primary" id="btnEnviar10" type="submit" value='Guardar y continuar'/>                                    
                                </div>
                            </form>
                        </div>
                      </div>
                    </div>
                      
                  </div>
              <div class="container text-center" style="margin-bottom:15px;"> 
                    <div class="form-group col-md-12 text-left">              
                        <p><label class="control-label text-danger" id="puntajeCR1" >Puntaje total Consejo:&nbsp<span id="totalCR">${total}</span></label></p>
                        <p><label class="control-label text-danger ${hiddenDictaminador}">Puntaje total Dictaminador:&nbsp<span id="totalD">${totalDictaminador}</span></label></p>
                        <br/>
                        <label class="control-label">Observaciones Consejo:</label>
                        <textarea class="form-control text-uppercase ${disabled1}" id="aux" name="observaciones" maxlength="200">${docente.infoRegistro[69]}</textarea>
                        <br/>
                        <label class="control-label ${hiddenDictaminador}">Observaciones Dictaminador:</label>
                         <textarea class="form-control text-uppercase ${hiddenDictaminador}" id="aux2" name="observacionesD" maxlength="200">${docente.infoRegistro[74]}</textarea>
                    </div>
                    <br/>                      
                    <!--<button type="button" class="btn btn-primary" data-toggle="modal" data-target="#modalConfirmacion2">Finalizar registro</button>-->
                    <button type="button" class="btn btn-primary" onClick="finalizarRevision()">Evaluación finalizada</button>
                  
              </div>
              
        </main>
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
                      
        <div class="modal fade" id="modalCursos" role="dialog">
            <div class="modal-dialog">

              <!-- Modal content-->
              <div class="modal-content panel">
                <form id="formCursos" role="form" action="RegistrarCurso" method="POST">
                <div class="modal-header">
                  <button type="button" class="close" data-dismiss="modal">&times;</button>
                  <h4 class="modal-title">Registro de información</h4>
                </div>
                <div class="modal-body">
                    
                        <div class="row">
                            <div class="form-group col-md-6">                                                             
                                <label class="control-label">Tipo:</label>
                                <select class="form-control input-sm" name="tipo" required>   
                                    <option value="">-Seleccione-</option>
                                    <option value="CE">Certificación vigente laboral o de idiomas</option>
                                    <option value="CU">Curso de actualización</option>
                                </select>  
                            </div> 
                            <div class="form-group col-md-6">                                                             
                                <label class="control-label">Nombre del curso:</label>
                                <input type="text" class="form-control input-sm" name="nombreCurso" required/>
                            </div>                            
                        </div>
                        <div class="row">
                            <div class="form-group col-md-6">                                                             
                                <label class="control-label">Fecha de inicio:</label>
                                <input type="text" class="form-control input-sm" id="inicioCurso" name="inicioCurso" required/>
                            </div>
                            <div class="form-group col-md-6">                                                             
                                <label class="control-label">Fecha de término:</label>
                                <input type="text" class="form-control input-sm" id="finCurso" name="finCurso" required/>
                            </div>                            
                        </div>
                        <div class="row">
                            <div class="form-group col-md-6">                                                             
                                <label class="control-label">Institución:</label>
                                <input type="text" class="form-control input-sm" name="institucionCurso" maxlength="200" required/>
                            </div>
                            <div class="form-group col-md-6">                                                             
                                <label class="control-label">Total de horas:</label>
                                <input type="text" class="form-control input-sm" name="horasCurso" required/>
                            </div>
                        </div>  
                        <div class="row">
                            <div class="form-group col-md-6">                                                             
                                <label class="control-label">Constancia o documento probatorio:</label>                               
                                <input type="text" class="form-control input-sm" name="documento" placeholder="Constancia/Diploma/Reconocimiento" maxlength="100" required/>
                            </div>
                        </div>
                </div> 
                <div class="modal-footer">
                    <input class="btn btn-sm btn-primary" id="btnEnviarCurso" type="submit" value='Guardar'/>                                    
                    <button type="button" class="btn btn-sm btn-default" data-dismiss="modal">Cancelar</button>
                        
                </div>
                </form>
              </div>
              
            </div>
          </div>
        <div class="modal fade" id="modalAportaciones" role="dialog">
            <div class="modal-dialog">

              <!-- Modal content-->
              <div class="modal-content panel">
                <form id="formAportacion" role="form" action="RegistrarAportacion" method="POST">
                <div class="modal-header">
                  <button type="button" class="close" data-dismiss="modal">&times;</button>
                  <h4 class="modal-title">Registro de información</h4>
                </div>
                <div class="modal-body">
                    
                        <div class="row">                            
                            <div class="form-group col-md-6">                                                             
                                <label class="control-label">Nombre de la aportacion:</label>
                                <select class="form-control input-sm" id="idAportacion" name="idAportacion" onChange="cambioAportacion()" required>                                  
                                    ${catalogo.desplegarOpcionesAportacion()}
                                </select>
                                <input type="text" class="form-control input-sm hidden" id="aportacion" name="aportacion" placeHolder="Especifíque" maxlength="500"/>
                            </div>   
                            <div class="form-group col-md-6">                                                             
                                <label class="control-label">Fecha de inicio:</label>
                                <input type="text" class="form-control input-sm" id="inicioAportacion" name="inicioAportacion" required/>
                            </div>
                        </div>
                        <div class="row">                            
                            <div class="form-group col-md-6">                                                             
                                <label class="control-label">Fecha de término:</label>
                                <input type="text" class="form-control input-sm" id="finAportacion" name="finAportacion" required/>
                            </div>  
                            <div class="form-group col-md-6">                                                             
                                <label class="control-label">Institución:</label>
                                <input type="text" class="form-control input-sm" name="institucionAportacion" maxlength="200" required/>
                            </div>  
                        </div>   
                        <div class="row">
                            <div class="form-group col-md-6">                                                             
                                <label class="control-label">Constancia o documento probatorio:</label>                               
                                <input type="text" class="form-control input-sm" name="documento" placeholder="Constancia/Diploma/Reconocimiento" maxlength="100" required/>
                            </div>
                        </div>        
                </div> 
                <div class="modal-footer">
                    <input class="btn btn-sm btn-primary" id="btnEnviarAportacion" type="submit" value='Guardar'/>                                    
                    <button type="button" class="btn btn-sm btn-default" data-dismiss="modal">Cancelar</button>
                        
                </div>
                </form>
              </div>
              
            </div>
          </div>
                      
        <div class="modal fade" id="modalParticipacion" role="dialog">
            <div class="modal-dialog">

              <!-- Modal content-->
              <div class="modal-content panel">
                <form id="formParticipacion" role="form" action="RegistrarParticipacion" method="POST">
                <div class="modal-header">
                  <button type="button" class="close" data-dismiss="modal">&times;</button>
                  <h4 class="modal-title">Registro de información</h4>
                </div>
                <div class="modal-body">
                    
                        <div class="row">                            
                            <div class="form-group col-md-6">                                                             
                                <label class="control-label">Nombre de la participación:</label>
                                <select class="form-control input-sm" id="idParticipacion" name="idParticipacion" onChange="cambioParticipacion()" required>
                                    ${catalogo.desplegarOpcionesParticipacion()}
                                </select>
                                <input type="text" class="form-control input-sm" id="participacion" name="participacion" maxlength="300" placeholder="Especifíque" required/>
                            </div>   
                            <div class="form-group col-md-6">                                                             
                                <label class="control-label">Fecha de inicio:</label>
                                <input type="text" class="form-control input-sm" id="inicioParticipacion" name="inicioParticipacion" required/>
                            </div>
                        </div>
                        <div class="row">                            
                            <div class="form-group col-md-6">                                                             
                                <label class="control-label">Fecha de término:</label>
                                <input type="text" class="form-control input-sm" id="finParticipacion" name="finParticipacion" required/>
                            </div>  
                            <div class="form-group col-md-6">                                                             
                                <label class="control-label">Institución:</label>
                                <input type="text" class="form-control input-sm" name="institucionParticipacion" maxlength="200" required/>
                            </div>  
                        </div>   
                        <div class="row">
                            <div class="form-group col-md-6">                                                             
                                <label class="control-label">Constancia o documento probatorio:</label>                               
                                <input type="text" class="form-control input-sm" name="documento" placeholder="Constancia/Diploma/Reconocimiento" maxlength="100" required/>
                            </div>
                        </div>
                </div> 
                <div class="modal-footer">
                    <input class="btn btn-sm btn-primary" id="btnEnviarParticipacion" type="submit" value='Guardar'/>                                    
                    <button type="button" class="btn btn-sm btn-default" data-dismiss="modal">Cancelar</button>
                </div>
                </form>
              </div>
              
            </div>
          </div>
        <div class="modal fade" id="modalTutoria" role="dialog">
            <div class="modal-dialog">

              <!-- Modal content-->
              <div class="modal-content panel">
                <form id="formTutoria" role="form" action="RegistrarTutoria" method="POST">
                <div class="modal-header">
                  <button type="button" class="close" data-dismiss="modal">&times;</button>
                  <h4 class="modal-title">Registro de información</h4>
                </div>
                <div class="modal-body">
                    
                        <div class="row">                            
                               
                            <div class="form-group col-md-6">                                                             
                                <label class="control-label">Fecha de inicio:</label>
                                <input type="text" class="form-control input-sm" id="inicioTutoria" name="inicioTutoria" required/>
                            </div>
                            <div class="form-group col-md-6">                                                             
                                <label class="control-label">Fecha de término:</label>
                                <input type="text" class="form-control input-sm" id="finTutoria" name="finTutoria" required/>
                            </div>
                        </div>
                        <div class="row">
                            <div class="form-group col-md-6">                                                             
                                <label class="control-label">Constancia o documento probatorio:</label>                               
                                <input type="text" class="form-control input-sm" name="documento" placeholder="Constancia/Diploma/Reconocimiento" maxlength="100" required/>
                            </div>
                        </div>
                                  
                </div> 
                <div class="modal-footer">
                    <input class="btn btn-sm btn-primary" id="btnEnviarTutoria" type="submit" value='Guardar'/>                                    
                    <button type="button" class="btn btn-sm btn-default" data-dismiss="modal">Cancelar</button>
                        
                </div>
                </form>
              </div>
              
            </div>
          </div> 
        <div class="modal fade" id="modalPublicacion" role="dialog">
            <div class="modal-dialog">

              <!-- Modal content-->
              <div class="modal-content panel">
                <form id="formPublicacion" role="form" action="RegistrarPublicacion" method="POST">
                <div class="modal-header">
                  <button type="button" class="close" data-dismiss="modal">&times;</button>
                  <h4 class="modal-title">Registro de información</h4>
                </div>
                <div class="modal-body">                    
                        <div class="row">
                            <div class="form-group col-md-6">                                                             
                                <label class="control-label">Nombre publicación:</label>
                                <input type="text" class="form-control input-sm" name="nombre" maxlength="200" required/>
                            </div>
                            <div class="form-group col-md-6">                                                             
                                <label class="control-label">Medio publicación:</label>
                                <select class="form-control input-sm" name="tipo" required>   
                                    <option value="">-Seleccione-</option>
                                    <option value="I">Impreso</option>
                                    <option value="E">Electrónico</option>
                                </select>
                            </div>                            
                        </div>
                        <div class="row">
                            <div class="form-group col-md-6">                                                             
                                <label class="control-label">Fecha de publicación:</label>
                                <input type="text" class="form-control input-sm" id="fechaPublicacion" name="fecha" required/>
                            </div>
                            <div class="form-group col-md-6">                                                             
                                <label class="control-label">ISSN/ISBN:</label>
                                <input type="text" class="form-control input-sm" name="ISSN" maxlength="50" required/>
                            </div>
                        </div>
                                  
                </div> 
                <div class="modal-footer">
                    <input class="btn btn-sm btn-primary" id="btnEnviarPublicacion" type="submit" value='Guardar'/>                                    
                    <button type="button" class="btn btn-sm btn-default" data-dismiss="modal">Cancelar</button>
                        
                </div>
                </form>
              </div>
              
            </div>
          </div> 
        <div class="modal fade" id="modalResultado" role="dialog">
            <div class="modal-dialog">
              <!-- Modal content-->
              <div class="modal-content panel">
                <form id="formResultado" role="form" action="RegistrarResultado" method="POST">
                <div class="modal-header">
                  <button type="button" class="close" data-dismiss="modal">&times;</button>
                  <h4 class="modal-title">Registro de información</h4>
                </div>
                <div class="modal-body">
                        <div class="row">
                            <div class="form-group col-md-6">                                                             
                                <label class="control-label">Tipo de evidencia de Resultados Educativos:</label>
                                <select class="form-control input-sm" id="idResultado" name="idResultado" onChange="cambioResultado()" required>                                  
                                    ${catalogo.desplegarOpcionesResultados()}
                                </select>
                                <input type="text" class="form-control input-sm hidden" id="resultado" name="resultado" placeHolder="Especifíque" maxlength="200"/>
                            </div>
                            <div class="form-group col-md-6">                                                             
                                <label class="control-label">Constancia o documento probatorio:</label>                               
                                <input type="text" class="form-control input-sm" id="documentoResultado" name="documento" placeholder="Constancia/Diploma/Reconocimiento" maxlength="100" required/>
                            </div>
                        </div>                    
                        <div class="row">
                            <div class="form-group col-md-6">                                                             
                                <label class="control-label">Fecha de inicio:</label>
                                <input type="text" class="form-control input-sm" id="inicioResultado" name="inicioResultado" required/>
                            </div>
                            <div class="form-group col-md-6">                                                             
                                <label class="control-label">Fecha de término:</label>
                                <input type="text" class="form-control input-sm" id="finResultado" name="finResultado" required/>
                            </div>
                        </div>
                                  
                </div> 
                <div class="modal-footer">
                    <input class="btn btn-sm btn-primary" id="btnEnviarResultado" type="submit" value='Guardar'/>                                    
                    <button type="button" class="btn btn-sm btn-default" data-dismiss="modal">Cancelar</button>
                        
                </div>
                </form>
              </div>
              
            </div>
          </div>              
                      
        <div id="modalArchivo" class="modal fade" role="dialog">
            <div class="modal-dialog">
              <div class="modal-content">
                <div class="modal-header">
                  <button type="button" class="close" data-dismiss="modal">&times;</button>
                  <h4 class="modal-title" id="tituloModal">Carga de evidencia documental</h4>
                </div>
                <div class="modal-body">
                    <iframe name="ifRespuesta" hidden></iframe>
                    <iframe style="width:100%;" id="ifArchivo" name="ifArchivo" src="" hidden></iframe>
                    <div id="seccionCarga">
                        <form id="formArchivo" name="formArchivo" method="POST" enctype="multipart/form-data" >
                                <label class="text-warning" id="alertaCarga"><span class="glyphicon glyphicon-warning-sign"></span>&nbsp;Cárgue todas las evidencias documentales del criterio en un solo archivo PDF</label>
                                <label class="control-label" for="archivo">Seleccione el archivo a cargar:</label>
                                <label class="text-warning" id="alertaCarga"><span class="glyphicon glyphicon-warning-sign"></span>&nbsp;Al seleccionar un nuevo archivo, este se actualizará</label>
                                <input type="hidden" id="idArchivo" name="idArchivo" value="" />
                                <input type="file" class="form-control input-sm" id="archivo" name="archivo" onchange="subirArchivo()" accept=".pdf" />

                        </form>  
                    </div>
                </div>
                <div class="modal-footer">
                  <button type="button" class="btn btn-sm btn-default" data-dismiss="modal">Cerrar</button>
                </div>
              </div>
            </div>
        </div>
        <div id="modalConfirmacion" class="modal fade" role="dialog">
            <div class="modal-dialog">
              <div class="modal-content">
                <div class="modal-header">
                  <button type="button" class="close" data-dismiss="modal">&times;</button>
                  <h4 class="modal-title" >Confirmación</h4>
                </div>
                <div class="modal-body">
                    <p id="mensajeConfirmacion">La información seleccionada será borrada<br/>¿Desea continuar?</p>                  
                </div>
                <div class="modal-footer">
                  <button type="button" id="btnConfirmar" class="btn btn-sm btn-default">Sí</button>
                  <button type="button" class="btn btn-sm btn-default" data-dismiss="modal">No</button>
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
                    <p id="mensajeConfirmacion">Una vez finalizado el proceso, la información no podra ser modificada<br/>¿Desea continuar?</p>                  
                </div>
                <div class="modal-footer">
                  <form action="FinalizaProceso" method="POST">
                    <textarea class="form-control text-uppercase hidden" id="observaciones" name="observaciones" maxlength="200"></textarea>
                    <input type="hidden" id="evaluacion" name="evaluacion" />
                    <input class="btn btn-sm btn-default" type="submit" value='Sí'/>
                    <button type="button" class="btn btn-sm btn-default" data-dismiss="modal">No</button>
                  </form>
                  
                </div>
              </div>
            </div>
        </div>                       
        <script src="https://framework-gb.cdn.gob.mx/gobmx.js"></script>        
        <script src="https://code.jquery.com/jquery-1.12.4.js"></script>      
        <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>  
        <script src="https://framework-gb.cdn.gob.mx/assets/scripts/jquery-ui-datepicker.js"></script>
        <script src="https://ajax.aspnetcdn.com/ajax/jquery.validate/1.13.1/jquery.validate.min.js"></script>
        <script type="text/javascript" src="js/jquery.ui.datepicker.validation.js"></script>
        <script src="js/funcionesEvidencias.js?v=1"></script>
        <script src="js/funcionesPermisoActual.js?v=1"></script>
    </body>
</html>
