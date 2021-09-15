<%-- 
    Document   : registro
    Created on : 8 jun 2020, 14:51:58
    Author     : David Reyna
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import='herramientas.Catalogos'%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%
    session = (HttpSession) request.getSession(true);       
%>
<!DOCTYPE html>
<html lang="es">
    <head>
        <title>DGETI | gob.mx</title>
        <meta charset="UTF-8"/>
        <meta http-equiv="X-UA-Compatible" content="IE=edge"/>
        <meta name="viewport" content="width=device-width, initial-scale=1.0"/>        
        <link href="https://framework-gb.cdn.gob.mx/assets/styles/main.css" rel="stylesheet"/>        
        <link href="css/estilosRegistro.css" rel="stylesheet"/>        
        <jsp:useBean id="mensaje" class="com.aplicacion.beans.Mensaje" />
        <jsp:useBean id="catalogo" class="herramientas.Catalogos" />
        <jsp:useBean id="fecha" class="herramientas.Fecha" />
        <jsp:useBean id="dato" class="herramientas.Datos" />
    </head>
    <body>
        <input type="hidden" id="mensajeRegistroCompleto" value="${mensaje.registroCompleto}" />
        <input type="hidden" id="mensajeNotaDesfavorable" value="${mensaje.notaDesfavorable}" />
        <input type="hidden" id="mensajeInactivoServicio" value="${mensaje.inactivoServicio}" />
        <input type="hidden" id="mensajeNoFrenteGrupo" value="${mensaje.noFrenteGrupo}" />
        <input type="hidden" id="mensajeNoCompatibilidad" value="${mensaje.noCompatibilidad}" />
        <input type="hidden" id="mensajeConfirmacionHora" value="${mensaje.confirmacionHora}" />
        <input type="hidden" id="mensajeRechazoHora" value="${mensaje.rechazoHora}" />
        <c:if test = "${Docente.infoRegistro[6]==null&& Docente.infoRegistro[64]==null}">
            <input type="hidden" id="programa" value="${sessionScope["programa"]}" />
            <input type="hidden" id="plantel" value="${sessionScope["plantel"]}" />
        </c:if>
        <c:if test = "${Docente.infoRegistro[6]!= null&& Docente.infoRegistro[64] != null}">
            <input type="hidden" id="programa" value="${Docente.infoRegistro[64]}" />
            <input type="hidden" id="plantel" value="${Docente.infoRegistro[6]}" />
        </c:if>
        <c:if test='${sessionScope["rol"]=="D"}'>
            <c:if test = "${Docente.infoRegistro[61]!=null&&Docente.infoRegistro[66]!='1'}">
            <%
                response.sendRedirect("/procesopromocion/SesionDocente");
            %>
            </c:if>       
        </c:if>
        <c:if test="${vistaAdmin}">    
        <c:set var="disabled1" value=""></c:set>
            <c:if test='${sessionScope["permisoActual"]=="6"}'>
                  <c:set var="disabled1" value="disabled"></c:set>
            </c:if>
        </c:if>    
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
                        <c:if test="${!vistaAdmin}">
                            <li><a href="SesionDocente">Regresar </a></li>
                        </c:if>
                        <c:if test="${vistaAdmin}">
                            <li><a href="VistaDocente">Regresar</a></li>
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
                <li class="active">Registro de aspirante</li>
              </ol>
              <!--FIN Breadcrumbs-->
              <div class="text-center">
                <h4>Registro de requisitos para participar en el:</h4>
                <h4>Programa de Promoción en el Servicio Docente por 
                    
                      <c:if test='${sessionScope["programa"]=="1"}'>
                      cambio de categoría  
                      </c:if>
                      <c:if test='${sessionScope["programa"]=="2"}'>
                      horas adicionales 
                      </c:if>
                       <c:if test='${sessionScope["programa"]=="3"}'>
                      incentivos
                      </c:if>
                    en Educación Media Superior</h4>
              </div>
              <!--Paneles colapsables-->
              <div class="panel-group ficha-collapse" id="accordion">
                <div class="panel panel-default">
                  <div class="panel-heading">
                    <h4 class="panel-title">
                        <a data-parent="#accordion" data-toggle="collapse" href="#infoAcademica" aria-expanded="true" aria-controls="infoAcademica">
                          Información Académica                        
                        <c:set var="bandera" value="${Docente.verificaSeccion('1')}"></c:set>
                        <c:if test="${!vistaAdmin}">
                            <c:if test = "${bandera==true}">
                                <span class="glyphicon glyphicon-ok-sign completo" title="Sección completa" id="estatusInfoAcademica" completo="true"></span>  
                                <c:set var="in" value=""></c:set>
                            </c:if>
                            <c:if test = "${bandera==false}">
                                <span class="glyphicon glyphicon-exclamation-sign incompleto" title="Sección incompleta" id="estatusInfoAcademica" completo="false"></span>
                                <c:set var="in" value="in"></c:set>
                            </c:if>
                        </c:if>
                        <c:if test="${vistaAdmin}">
                            <c:set var="in" value=""></c:set>
                            <c:if test="${Docente.infoRegistro[67]!=null}">
                                <span class="glyphicon glyphicon-ok-sign completo" title="Sección completa" id="estatusInfoAcademica" completo="true"></span>                                  
                            </c:if>
                            <c:if test="${Docente.infoRegistro[67]==null}">
                                <span class="glyphicon glyphicon-exclamation-sign incompleto" title="Sección incompleta" id="estatusInfoAcademica" completo="false"></span>                                
                            </c:if>  
                        </c:if>    
                        </a>
                    </h4>
                    
                    <button type="button" class="collpase-button collapsed" data-parent="#accordion" data-toggle="collapse" href="#infoAcademica"></button>
                  </div>
                  <div class="panel-collapse collapse ${in}" id="infoAcademica">
                    <div class="panel-body">
                      <form id="formInfoAcademica" role="form" action="RegistroInfoAcademica" method="POST">
                        <div class="row hidden">
                            <div class="col-xs-12">
                            <label class="text-warning"><span class="glyphicon glyphicon-warning-sign"></span>&nbsp;Si la información de Institucion, Escuela o Facultad y/o Carrera no está disponible para seleccionar, comuníquese con Mesa de Ayuda.</label>
                            </div>
                        </div>
                        <div class="row">
                            <div class="form-group col-md-3">
                              <!--<input type="text" value="${Docente.rfc}" />-->                                
                              <label class="control-label" for="entidad">Entidad de estudio:</label>
                              <select class="form-control input-sm" id="entidad" name="entidad" onchange="actualizarTipoInstitucion()" required>                                  
                                  ${catalogo.desplegarOpcionesEstado(Docente.infoRegistro[55])}
                              </select>
                            </div>
                            <div class="form-group col-md-3">
                              <label class="control-label" for="tipoInstitucion">Tipo de institución:</label>
                              <select class="form-control input-sm" id="tipoInstitucion" name="tipoInstitucion" onchange="actualizarInstitucion()" required>
                                ${catalogo.desplegarOpcionesTipoInstitucion(Docente.infoRegistro[55],Docente.infoRegistro[57])}                                
                              </select>
                            </div>                            
                            <div class="form-group col-md-3">
                              <label class="control-label" for="institucion">Institución:</label>
                              <select class="form-control input-sm" id="institucion" name="institucion" onchange="cambioInstitucion()" required>
                                ${catalogo.desplegarOpcionesInstituciones(Docente.infoRegistro[55],Docente.infoRegistro[57],Docente.infoRegistro[56])}
                              </select>
                              <c:if test = "${Docente.infoRegistro[56]=='-1'}">
                                    <c:set var="hidden" value=""></c:set>
                                    <c:set var="required" value="required"></c:set>
                              </c:if>
                              <c:if test = "${Docente.infoRegistro[56]!='-1'}">
                                    <c:set var="hidden" value="hidden"></c:set>
                                    <c:set var="required" value=""></c:set>
                              </c:if>
                              <input type="text" class="form-control input-sm ${hidden}" id="institucionOtro" placeholder="Indique" name="institucionOtro" value="${Docente.infoRegistro[70]}" ${required}>
                            </div>
                            <div class="form-group col-md-3">
                              <label class="control-label" for="cct">CCT:</label>
                              <select class="form-control input-sm" id="cct" name="cct" onChange="cambioCCT()" required>
                                ${catalogo.desplegarOpcionesCCT(Docente.infoRegistro[56],Docente.infoRegistro[53])}
                              </select>
                              <c:if test = "${Docente.infoRegistro[53]=='-1'}">
                                    <c:set var="hidden" value=""></c:set>
                                    <c:set var="required" value="required"></c:set>
                              </c:if>
                              <c:if test = "${Docente.infoRegistro[53]!='-1'}">
                                    <c:set var="hidden" value="hidden"></c:set>
                                    <c:set var="required" value=""></c:set>
                              </c:if>
                              <input type="text" class="form-control input-sm ${hidden}" id="cctOtro" placeholder="Indique" name="cctOtro" value="${Docente.infoRegistro[71]}" ${required}>
                            </div>
                        </div>
                        <div class="row">
                            <div class="form-group col-md-3">
                              <label class="control-label" for="escuela">Escuela o Facultad:</label>
                              <select class="form-control input-sm" id="escuela" name="escuela" onChange="cambioEscuela()" required>
                                ${catalogo.desplegarOpcionesEscuelas(Docente.infoRegistro[56],Docente.infoRegistro[14])}
                              </select>
                              <c:if test = "${Docente.infoRegistro[14]=='-1'}">
                                    <c:set var="hidden" value=""></c:set>
                                    <c:set var="required" value="required"></c:set>
                              </c:if>
                              <c:if test = "${Docente.infoRegistro[14]!='-1'}">
                                    <c:set var="hidden" value="hidden"></c:set>
                                    <c:set var="required" value=""></c:set>
                              </c:if>
                              <input type="text" class="form-control input-sm ${hidden}" id="escuelaOtro" placeholder="Indique" name="escuelaOtro" value="${Docente.infoRegistro[72]}" ${required}>
                            </div>
                            <div class="form-group col-md-3">
                              <label class="control-label" for="grado">Grado Académico:</label>
                              <select class="form-control input-sm" id="grado" name="grado" required>                                
                                ${catalogo.desplegarOpcionesGrado(Docente.infoRegistro[19])}
                              </select>
                            </div>
                            <div class="form-group col-md-3">
                              <label class="control-label" for="carrera">Carrera:</label>  
                              <c:if test = "${Docente.infoRegistro[16]=='-1'}">
                                    <c:set var="carrera" value="${Docente.infoRegistro[73]}"></c:set>
                              </c:if>
                              <c:if test = "${Docente.infoRegistro[16]!='-1'}">
                                    <c:set var="carrera" value="${Docente.infoRegistro[17]}"></c:set>
                              </c:if>
                              <input type="text" class="form-control input-sm" id="carrera" name="carrera" value="${carrera}" required >
                              <textarea id="catCarreras" hidden>${catalogo.consultarCarreras()}</textarea>
                            </div>
                            <div class="form-group col-md-3">
                              <label class="control-label" for="egreso">Año de egreso:</label>
                              <input type="text" class="form-control input-sm" id="egreso" name="egreso" pattern="[0-9]{4}" maxlength="4" value="${Docente.infoRegistro[18]}" required>
                            </div>
                        </div>
                        <div class="row">
                            <div class="form-group col-md-3">
                              <label class="control-label" for="modalidad">Modalidad de Titulación:</label>
                              <select class="form-control input-sm" id="modalidad" name="modalidad" required>
                                ${catalogo.desplegarOpcionesModalidadTitulacion(Docente.infoRegistro[21])}
                              </select>
                            </div>
                            <div class="form-group col-md-3">
                              <label class="control-label" for="titulacion">Año de titulación:</label>
                              <input type="text" class="form-control input-sm" id="titulacion" name="titulacion" pattern="[0-9]{4}" value="${Docente.infoRegistro[23]}" maxlength="4" required>
                            </div>                            
                            <div class="form-group col-md-3">
                                <label class="control-label" for="btnEvidencia1">Documento comprobatorio:</label>
                                <a title="Ver ejemplo" onclick="abrirModalEjemplo(1)">
                                  <span class="glyphicon glyphicon-picture"></span>
                                </a><br/> 
                                <c:if test = "${Docente.documentoCargado2('1')==true}">
                                    <input id="btnEvidencia1" type="button" class="btn btn-sm btn-link" value="Ver archivo" onclick="abrirModalArchivo(1)"/>                                    
                                    <span class="glyphicon glyphicon-exclamation-sign incompleto" title="Sección incompleta" id="alertaBtnEvidencia1" style="display:none;"></span>
                                </c:if>
                                <c:if test = "${Docente.documentoCargado2('1')==false}">
                                    <input id="btnEvidencia1" type="button" class="btn btn-sm btn-link incompleto" value="Subir archivo" onclick="abrirModalArchivo(1)"/>
                                    <span class="glyphicon glyphicon-exclamation-sign incompleto" title="Sección incompleta" id="alertaBtnEvidencia1"></span>
                                </c:if>
                            </div> 
                            <div class="form-group col-md-3">
                              <label class="control-label" for="documento">Archivo de evidencia:</label>
                              <select class="form-control input-sm" id="documento" name="documento" onchange="cambioDocumento(this)" required>
                                    <c:if test = "${Docente.infoRegistro[82]==null}">
                                      <option value="" selected>-Seleccionar-</option>   
                                      <option value="acta" >Acta de grado</option>
                                      <option value="cedula">Cédula profesional</option>
                                      <option value="titulo">Título</option>
                                      <option value="Otros">Otros</option> 
                                    </c:if>
                                    <c:if test = "${Docente.infoRegistro[82]=='acta'}">
                                      <option value="acta" selected>Acta de grado</option>
                                      <option value="cedula">Cédula profesional</option>
                                      <option value="titulo">Título</option>
                                      <option value="Otros">Otros</option> 
                                    </c:if>
                                    <c:if test = "${Docente.infoRegistro[82]=='cedula'}">
                                      <option value="acta" >Acta de grado</option>
                                      <option value="cedula" selected>Cédula profesional</option>
                                      <option value="titulo">Título</option>
                                      <option value="Otros">Otros</option>  
                                    </c:if>
                                    <c:if test = "${Docente.infoRegistro[82]=='titulo'}">
                                      <option value="acta" >Acta de grado</option>
                                      <option value="cedula">Cédula profesional</option>
                                      <option value="titulo" selected>Título</option>
                                      <option value="Otros">Otros</option> 
                                    </c:if> 
                                    <c:if test = "${Docente.infoRegistro[82]=='Otros'}">
                                      <option value="acta" >Acta de grado</option>
                                      <option value="cedula">Cédula profesional</option>
                                      <option value="titulo">Título</option>
                                      <option value="Otros" selected>Otros</option>   
                                    </c:if> 
                                      
                              </select>
                            </div>
                        </div>
                        <div class="row">
                            <c:if test = "${Docente.infoRegistro[24]==null}">
                                <c:set var="hidden" value="hidden"></c:set>
                            </c:if>
                            <c:set var="cedulahidden" value=""></c:set>
                            <c:if test = "${Docente.infoRegistro[82]!='cedula'}">
                                 <c:set var="cedulahidden" value="hidden"></c:set>
                            </c:if>
                            <div id="seccionCedula" ${cedulahidden}>
                                
                                <div class="form-group col-md-3">
                                  <label class="control-label" for="cedula">Número de Cédula:</label>
                                  <input type="text" class="form-control input-sm" id="cedula" name="cedula" value="${Docente.infoRegistro[24]}">
                                </div>
                                
                                <%--
                                <div class="form-group col-md-3">
                                    <label class="control-label" for="btnEvidencia8">Cédula profesional:</label>
                                    <a title="Ver ejemplo" onclick="abrirModalEjemplo(8)"><span class="glyphicon glyphicon-picture"></span></a><br/>  
                                    <c:if test = "${Docente.documentoCargado2('8')==true}">
                                        <input id="btnEvidencia8" type="button" class="btn btn-sm btn-link" value="Ver archivo" onclick="abrirModalArchivo(8)"/>                                    
                                    </c:if>
                                    <c:if test = "${Docente.documentoCargado2('8')==false}">
                                        <input id="btnEvidencia8" type="button" class="btn btn-sm btn-link incompleto" value="Subir archivo" onclick="abrirModalArchivo(8)"/>
                                        <span class="glyphicon glyphicon-exclamation-sign incompleto" title="Sección incompleta" id="alertaBtnEvidencia8"></span>
                                    </c:if>                                  
                                </div> --%>
                            </div>
                        </div>     
                        
                            <div class="col-xs-12 text-right">
                              <c:if test="${!vistaAdmin}">
                                <input  class="btn btn-sm btn-primary" type="reset" value="Limpiar"/>
                                <input class="btn btn-sm btn-primary" id="btnEnviar1" type="submit" value='Guardar y continuar'/>
                              </c:if>
                              <c:if test="${vistaAdmin}">
                                  <c:if test='${sessionScope["permisoActualEdicion"]=="F"}'>
                                      <input class="btn btn-sm btn-primary" id="btnEnviar1" type="submit" value='Validar información' disabled/>
                                  </c:if>
                                  <c:if test='${sessionScope["permisoActualEdicion"]=="V"}'>
                                      <input class="btn btn-sm btn-primary" id="btnEnviar1" type="submit" value='Validar información'/>
                                  </c:if>
                              </c:if>
                              <!--<input type="button" class="btn btn-sm btn-primary" value="Guardar y continuar" onclick="mostrarSiguiente(1)"/>-->
                            </div>
                        
                      </form>
                            
                <c:if test="${vistaAdmin}">
                    <form id="formInfoAcademicaOb1" role="form" action="RegistroInfoAcademica" method="POST">
                      <input type="hidden" id="accion" name="accion" value="observacionesPaso1">
                         <%-- <c:if test='${sessionScope["permisoActualEdicion"]=="F"}'>    --%>
                    <label class="control-label">Observaciones comité revisor:</label>    
                    <textarea ${disabled1}  class="form-control text-uppercase ${disabled1}" id="observacion1P1R" name="observacion1P1R" maxlength="2000" onKeyUp="cambioObservacionesPaso1(this)" >${observacionesR[4]}</textarea>
                         <%-- </c:if>--%>
                    <c:if test='${sessionScope["permisoActual"]=="6"}'>
                    <input type="hidden" id="observacion1P1R" name="observacion1P1R" value="">
                    <label class="control-label">Observaciones consejo dictaminador:</label>
                    <textarea  class="form-control text-uppercase" id="observacion1P1D" name="observacion1P1D" maxlength="2000" onKeyUp="cambioObservacionesPaso1(this)"  required>${observacionesR[0]}</textarea>
                    </c:if>
                    <input style="margin-top:10px;" disabled="true" type="submit"  class="btn btn-primary" value="Guardar" id="btnFinalizarOb1" onclick="cerrar(1)">
                    </form>
                </c:if>      
                    </div>
                  </div>
                </div>
                <c:if test = "${Docente.infoRegistro[14]!=null}">
                    <c:set var="hidden" value=""></c:set>
                    <c:if test = "${Docente.infoRegistro[26]==null}">
                        <c:set var="in" value="in"></c:set>
                    </c:if>
                    <c:if test = "${Docente.infoRegistro[26]!=null}">
                        <c:set var="in" value=""></c:set>
                    </c:if>
                </c:if>
                <c:if test = "${Docente.infoRegistro[14]==null}">
                    <c:set var="hidden" value="hidden"></c:set>                    
                </c:if>    
                            
                <div class="panel panel-default" id="panelInfoLaboral" ${hidden}>
                  <div class="panel-heading" id="phInfoLaboral">
                    <h4 class="panel-title">
                        <a data-parent="#accordion" data-toggle="collapse" href="#infoLaboral" aria-expanded="true" aria-controls="infoLaboral">
                        Información Laboral                        
                        <c:set var="bandera" value="${Docente.verificaSeccion('2')}"></c:set>
                        <c:if test="${!vistaAdmin}">
                            <c:if test = "${bandera==true}">
                                <span class="glyphicon glyphicon-ok-sign completo" title="Sección completa" id="estatusInfoLaboral" completo="true"></span>  
                                <c:set var="in" value=""></c:set>
                            </c:if>
                            <c:if test = "${bandera==false}">
                                <span class="glyphicon glyphicon-exclamation-sign incompleto" title="Sección incompleta" id="estatusInfoLaboral" completo="false"></span>
                                <c:set var="in" value="in"></c:set>
                            </c:if>                        
                        </c:if>
                        <c:if test="${vistaAdmin}">
                            <c:set var="in" value=""></c:set>
                            <c:if test="${Docente.infoRegistro[67]!=null}">
                                <span class="glyphicon glyphicon-ok-sign completo" title="Sección completa" id="estatusInfoLaboral" completo="true"></span>                                  
                            </c:if>
                            <c:if test="${Docente.infoRegistro[67]==null}">
                                <span class="glyphicon glyphicon-exclamation-sign incompleto" title="Sección incompleta" id="estatusInfoLaboral" completo="false"></span>                                
                            </c:if>  
                        </c:if>   
                        </a>
                    </h4>
                    <button type="button" class="collpase-button collapsed" data-parent="#accordion" data-toggle="collapse" href="#infoLaboral"></button>
                  </div>
                  <div class="panel-collapse collapse ${in}" id="infoLaboral" >
                    <div class="panel-body">
                      <form id="formInfoLaboral" role="form" action="RegistroInfoLaboral" method="POST">                      
                        <div class="row">
                            <div class="checkbox col-xs-12">
                              <c:if test = "${Docente.infoRegistro[25]=='N'}">
                                    <c:set var="checked" value="'"></c:set>
                                    <c:set var="in" value=""></c:set>
                              </c:if>
                              <c:if test = "${Docente.infoRegistro[25]!='N'}">
                                    <c:set var="checked" value="checked='true'"></c:set>
                                    <c:set var="in" value="in"></c:set>
                              </c:if>
                              <label><input type="checkbox" ${checked} id="activoServicio" name="activoServicio" data-toggle="collapse" data-target="#seccionActivoServicio">Activo en Servicio en Plantel</label>
                            </div>
                        </div>
                        <div id="seccionActivoServicio" class="collapse ${in}">
                            <div class="row">
                                <div class="form-group col-md-3 datepicker-group">
                                  <label class="control-label" for="ingresoSubsistema">Fecha de ingreso al subsistema:</label>
                                  <input type="text" class="form-control input-sm fecha" id="ingresoSubsistema" name="ingresoSubsistema" value="${fecha.formatoImprimir(Docente.infoRegistro[26])}" required>

                                </div>
                                <div class="form-group col-md-3 datepicker-group">
                                  <label class="control-label" for="ingresoPlantel">Fecha de ingreso al plantel:</label>
                                  <input class="form-control input-sm fecha" id="ingresoPlantel" name="ingresoPlantel" type="text" value="${fecha.formatoImprimir(Docente.infoRegistro[27])}" required>

                                </div>
                                <div class="form-group col-md-3">
                                  <label class="control-label" for="plantel">Plantel:</label>      
                                  <br/><span>${Docente.infoRegistro[10]}</span>
                                </div>
                                <div class="form-group col-md-3">
                                  <br/>
                                  <span class="text-danger" id="marginacion">
                                      <c:if test="${Docente.infoRegistro[58]!=null}">
                                          <c:out value="Con grado de marginación"></c:out>
                                      </c:if>
                                  </span>
                                </div>  
                            </div>
                            <div class="row">
                                <c:if test="${vistaAdmin}">
                                    <c:if test='${sessionScope["permisoActualEdicion"]=="F" && sessionScope["subsistema"]!=2}'>
                                        <div class='text-center'>
                                            <input type='button' class='btn btn-sm btn-link' value='(+) Agregar información de plazas' onclick="abrirModalPlazas();" disabled/>
                                        </div>
                                    </c:if>
                                    <c:if test='${sessionScope["permisoActualEdicion"]=="V" && sessionScope["subsistema"]!=2}'>
                                        <div class='text-center'>
                                            <input type='button' class='btn btn-sm btn-link' value='(+) Agregar información de plazas' onclick="abrirModalPlazas();" />
                                        </div>
                                    </c:if>
                                </c:if>
                                <c:if test="${!vistaAdmin}">
                                    <c:if test='${sessionScope["subsistema"]!=2}'>
                                    <div class='text-center'>
                                        <input type='button' class='btn btn-sm btn-link' value='(+) Agregar información de plazas' onclick="abrirModalPlazas();"/>
                                    </div>
                                    </c:if>
                                </c:if>
                                <c:if test="${vistaAdmin}">
                                    <c:if test='${sessionScope["permisoActualEdicion"]=="F" && sessionScope["subsistema"]==2}'>
                                        <div class='text-center'>
                                            <input type='button' class='btn btn-sm btn-link' value='(+) Agregar información de plazas' onclick="abrirModalPlazasHoras();" disabled/>
                                        </div>
                                    </c:if>
                                    <c:if test='${sessionScope["permisoActualEdicion"]=="V" && sessionScope["subsistema"]==2}'>
                                        <div class='text-center'>
                                            <input type='button' class='btn btn-sm btn-link' value='(+) Agregar información de plazas' onclick="abrirModalPlazasHoras();" />
                                        </div>
                                    </c:if>
                                </c:if>
                                <c:if test="${!vistaAdmin}">
                                    <c:if test='${sessionScope["subsistema"]==2}'>
                                    <div class='text-center'>
                                        <input type='button' class='btn btn-sm btn-link' value='(+) Agregar información de plazas' onclick="abrirModalPlazasHoras();"/>
                                    </div>
                                    </c:if>
                                </c:if>
                                <div class='table-responsive'>
                                    <table class='table table-bordered table-condensed'>
                                        <tr><th>Plaza con la que participa</th><th>Clave presupuestal</th><th>Fecha desde que ostenta la plaza</th><th>Tipo de nombramiento</th><th>Categoria</th><th>Jornada</th><th>Cargo directivo</th><th>Borrar</th></tr>
                                        <tbody id="tablaPlazas">
                                            ${dato.desplegarPlazas(Docente.infoRegistro[0])}
                                        </tbody>
                                    </table>
                                </div>                              
                            </div>
                            <div class="row">                                 
                                <div class="form-group col-md-3 datepicker-group ">
                                    <c:if test="${Docente.infoRegistro[39]==null}">
                                        <c:set var="checked" value="checked='true'"></c:set>
                                        <c:set var="in" value=""></c:set>
                                    </c:if>
                                    <c:if test="${Docente.infoRegistro[39]!=null}">
                                        <c:set var="checked" value=""></c:set>
                                        <c:set var="in" value="in"></c:set>
                                    </c:if>
                                  <label><input type="checkbox" id="cbUP" name="cbUP" data-toggle="collapse" data-target="#seccionFUP" ${checked}>No he tenido promociones previas</label>
                                  <div id="seccionFUP" class="collapse ${in}">
                                    <label class="control-label" for="fechaPromocion">Fecha de su última promoción:</label>
                                    <input class="form-control input-sm fecha" id="fechaPromocion" name="fechaPromocion" type="text" value="${fecha.formatoImprimir(Docente.infoRegistro[39])}" required>
                                  </div>
                                </div>
                                <div class="form-group col-md-3">                                    
                                    <label class="control-label" for="btnEvidencia2">Constancia de antiguedad:</label>
                                    <a title="Ver ejemplo" onclick="abrirModalEjemplo(2)"><span class="glyphicon glyphicon-picture"></span></a><br/>  
                                    <c:if test = "${Docente.documentoCargado2('2')==true}">
                                        <input id="btnEvidencia2" type="button" class="btn btn-sm btn-link" value="Ver archivo" onclick="abrirModalArchivo(2)"/>                                    
                                    </c:if>
                                    <c:if test = "${Docente.documentoCargado2('2')==false}">
                                        <input id="btnEvidencia2" type="button" class="btn btn-sm btn-link incompleto" value="Subir archivo" onclick="abrirModalArchivo(2)"/>
                                        <span class="glyphicon glyphicon-exclamation-sign incompleto" title="Sección incompleta" id="alertaBtnEvidencia2"></span>
                                    </c:if>                                    
                                </div> 
                                <div class="form-group col-md-6">
                                    <label class="control-label" for="btnEvidencia3">Constancia de nombramiento definitivo:</label>  
                                    <a title="Ver ejemplo" onclick="abrirModalEjemplo(3)"><span class="glyphicon glyphicon-picture"></span></a><br/>
                                    <c:if test = "${Docente.documentoCargado2('3')==true}">
                                        <input id="btnEvidencia3" type="button" class="btn btn-sm btn-link" value="Ver archivo" onclick="abrirModalArchivo(3)"/>                                    
                                    </c:if>
                                    <c:if test = "${Docente.documentoCargado2('3')==false}">
                                        <input id="btnEvidencia3" type="button" class="btn btn-sm btn-link incompleto" value="Subir archivo" onclick="abrirModalArchivo(3)"/>
                                        <span class="glyphicon glyphicon-exclamation-sign incompleto" title="Sección incompleta" id="alertaBtnEvidencia3"></span>
                                    </c:if>                                    
                                </div>                             
                            </div>
                            <div class="row">
                                <div class="form-group col-md-6">
                                  <label class="control-label" for="categoriaAspira">Categoría a la que aspira: <span id="avisoCategoria" class="glyphicon glyphicon-warning-sign text-warning hidden"></span></label>
                                  <select class="form-control input-sm" id="categoriaAspira" name="categoriaAspira" onchange="cambioCategoriaAspira()" required>                                     
                                      <c:if test = "${Docente.infoRegistro[6]==null&& Docente.infoRegistro[64]==null}">
                                      ${catalogo.desplegarOpcionesCategoriasVacantes(sessionScope["plantel"],sessionScope["programa"],Docente.infoRegistro[42],Docente.infoRegistro[78],Docente.infoRegistro[44],sessionScope["subsistema"])}
                                      </c:if>
                                      <c:if test = "${Docente.infoRegistro[6]!=null&& Docente.infoRegistro[64]!=null}">
                                      ${catalogo.desplegarOpcionesCategoriasVacantes(Docente.infoRegistro[6],Docente.infoRegistro[64],Docente.infoRegistro[42],Docente.infoRegistro[78],Docente.infoRegistro[44],Docente.infoRegistro[75])}
                                      </c:if>
                                  </select>
                                </div>
                                <c:if test='${sessionScope["programa"]=="1"}'>
                                <div class="form-group col-md-3">
                                  <label class="control-label" for="jornadaAspira">Tipo de jornada:</label>
                                  <select class="form-control input-sm" id="jornadaAspira" name="jornadaAspira" onchange="cambioCategoriaAspiraHoras2()" required>
                                      ${catalogo.desplegarOpcionesJornadaVacante(Docente.infoRegistro[42],Docente.infoRegistro[6],Docente.infoRegistro[64],Docente.infoRegistro[44])}
                                  </select>
                                </div>
                                </c:if>
                                <c:if test='${sessionScope["programa"]=="2"}'>
                                <div class="form-group col-md-3">
                                  <label class="control-label" for="jornadaAspira">Tipo de jornada:</label>
                                  <select class="form-control input-sm" id="jornadaAspira" name="jornadaAspira" onchange="cambioCategoriaAspiraHoras2()">
                                      ${catalogo.desplegarOpcionesJornadaVacante(Docente.infoRegistro[42],Docente.infoRegistro[6],Docente.infoRegistro[64],Docente.infoRegistro[44])}
                                  </select>
                                </div>
                                </c:if>
                                  
                                <c:if test='${sessionScope["programa"]=="2"}'>
                                <div class="row">
                                    <div class="form-group col-md-3">
                                      <label class="control-label" for="numhoras">Numero de horas:</label>
                                      <select class="form-control input-sm" id="numhoras" name="numhoras">
                                          
                                        ${catalogo.desplegarOpcionesHorasVacante(Docente.infoRegistro[42],Docente.infoRegistro[6],Docente.infoRegistro[64],Docente.infoRegistro[44])}
                                      </select>
                                    </div>
                                    <div class="form-group col-md-3">
                                    </div>
                                    <div class="form-group col-md-3">
                                    </div>
                                    <div class="form-group col-md-3">                                   
                                    </div>
                                </div>
                            </c:if>
                            
                            <div class="row">
                                    <div class="form-group col-md-3">
                                    </div>
                                    <div class="form-group col-md-3">
                                    </div>
                                    <div class="form-group col-md-3">                                   
                                    </div>
                                    <div class="form-group col-md-3">
                                        <input class="btn btn-sm btn-primary" id="btnEnviarCategorias" onclick="myAgregarCategoria()" value='Agregar categoria'/>
                                    </div>
                                </div>
                                
                                <c:if test='${sessionScope["programa"]=="1"}'>
                                <div class='table-responsive'>
                                    <table class='table table-bordered table-condensed'>
                                        <tr><th>Plazas a la que aspira</th><th>Jornada</th><th>Borrar</th></tr>
                                        <tbody id="tablaCategorias">
                                            ${dato.desplegarCategoriasAspira(Docente.infoRegistro[0])}
                                        </tbody>
                                    </table>
                                </div>
                                </c:if>
                                <c:if test='${sessionScope["programa"]=="2"}'>
                                <div class='table-responsive'>
                                    <table class='table table-bordered table-condensed'>
                                        <tr><th>Plazas a la que aspira</th><th>Jornada</th><th>Horas con las que participa</th><th>Borrar</th></tr>
                                        <tbody id="tablaCategorias">
                                            ${dato.desplegarCategoriasAspira(Docente.infoRegistro[0])}
                                        </tbody>
                                    </table>
                                </div>
                                </c:if>
                            
                            </div>
                                  <div class="row">    
                                     <div class="form-group col-md-3">
                                    <label class="control-label">Seleccione el requisito cumplido de acuerdo a su situación:</label><br>
                                    <span id="rbRequisitos">
                                        ${catalogo.desplegarRequisitosCategoria(Docente.infoRegistro[42],Docente.infoRegistro[46])}
                                    </span>                                    
                                    </div>
                                  </div>
                            <div class="row">
                                <div class="checkbox col-md-6">
                                    <c:if test = "${Docente.infoRegistro[48]=='S'}">
                                        <c:set var="checked" value="checked='true'"></c:set>
                                        <c:set var="in" value=""></c:set>
                                    </c:if>
                                    <c:if test = "${Docente.infoRegistro[48]!='S'}">
                                        <c:set var="checked" value=""></c:set>
                                        <c:set var="in" value="in"></c:set>
                                    </c:if>
                                    <label><input type="checkbox" id="notaDesfavorable" ${checked} name="notaDesfavorable" data-toggle="collapse" data-target="#seccionNota" >Marque la casilla si cuenta con nota desfavorable y/o sanción administrativa</label>
                                </div>
                                <div id="seccionNota" class="form-group col-md-6 collapse ${in}">
                                    <label class="control-label" for="btnEvidencia6">Constancia de nota favorable:</label>
                                    <a title="Ver ejemplo" onclick="abrirModalEjemplo(6)"><span class="glyphicon glyphicon-picture"></span></a><br/> 
                                    <c:if test = "${Docente.documentoCargado2('6')==true}">
                                        <input id="btnEvidencia6" type="button" class="btn btn-sm btn-link" value="Ver archivo" onclick="abrirModalArchivo(6)"/>                                    
                                    </c:if>
                                    <c:if test = "${Docente.documentoCargado2('6')==false}">
                                        <input id="btnEvidencia6" type="button" class="btn btn-sm btn-link incompleto" value="Subir archivo" onclick="abrirModalArchivo(6)"/>
                                        <span class="glyphicon glyphicon-exclamation-sign incompleto" title="Sección incompleta" id="alertaBtnEvidencia6"></span>
                                    </c:if>                                    
                                </div> 
                            </div>
                        </div>
                        <div class="col-xs-12 text-right">
                              <c:if test="${!vistaAdmin}">
                                <input  class="btn btn-sm btn-primary" type="reset" value="Limpiar"/>
                                <input class="btn btn-sm btn-primary" id="btnEnviar2" type="submit" value='Guardar y continuar'/>
                              </c:if>
                              <c:if test="${vistaAdmin}">
                                  <c:if test='${sessionScope["permisoActualEdicion"]=="F"}'>
                                      <input class="btn btn-sm btn-primary" id="btnEnviar2" type="submit" value='Validar información' disabled/>
                                  </c:if>
                                  <c:if test='${sessionScope["permisoActualEdicion"]=="V"}'>
                                      <input class="btn btn-sm btn-primary" id="btnEnviar2" type="submit" value='Validar información'/>
                                  </c:if>
                              </c:if>
                              <!--<input type="button" class="btn btn-sm btn-primary" value="Guardar y continuar" onclick="mostrarSiguiente(1)"/>-->
                        </div>
                      </form>
                    
                <c:if test="${vistaAdmin}">
                    <form id="formInfoAcademicaOb2" role="form" action="RegistroInfoAcademica" method="POST">
                      <input type="hidden" id="accion" name="accion" value="observacionesPaso2">
                         <%-- <c:if test='${sessionScope["permisoActualEdicion"]=="F"}'>    --%>
                    <label class="control-label">Observaciones comité revisor:</label>    
                    <textarea ${disabled1}  class="form-control text-uppercase ${disabled1}" id="observacion2P1R" name="observacion2P1R" maxlength="2000" onKeyUp="cambioObservacionesPaso2(this)">${observacionesR[5]}</textarea>
                         <%-- </c:if>--%>
                    <c:if test='${sessionScope["permisoActual"]=="6"}'>
                    <input type="hidden" id="observacion2P1R" name="observacion2P1R" value="">
                    <label class="control-label">Observaciones consejo dictaminador:</label>
                    <textarea  class="form-control text-uppercase" id="observacion2P1D" name="observacion2P1D" maxlength="2000" onKeyUp="cambioObservacionesPaso2(this)"  required>${observacionesR[1]}</textarea>
                    </c:if>
                    <input style="margin-top:10px;" disabled="true" type="submit"  class="btn btn-primary" value="Guardar" id="btnFinalizarOb2" onclick="cerrar(2)" >
                    </form>
                </c:if>
                                    
                  </div>
                </div>
                </div>
                
                <c:if test = "${Docente.infoRegistro[48]=='N'}">                
                    <c:set var="hidden" value=""></c:set>
                    <c:set var="in" value=""></c:set>
                </c:if>
                <c:if test = "${Docente.infoRegistro[48]!='N'}">
                    <c:set var="hidden" value="hidden"></c:set>
                    <c:set var="in" value=""></c:set>
                </c:if>
                <div class="panel panel-default" id="panelInfoHoras" ${hidden}>
                  <div class="panel-heading" id="phInfoHoras">
                    <h4 class="panel-title">
                      <a data-parent="#accordion" data-toggle="collapse" href="#infoHoras" aria-expanded="true" aria-controls="infoHoras">
                      Horas frente a grupo
                        <c:set var="bandera" value="${Docente.verificaSeccion('3')}"></c:set>
                        <c:if test="${!vistaAdmin}">
                        <c:if test = "${bandera==true}">
                            <span class="glyphicon glyphicon-ok-sign completo" title="Sección completa" id="estatusInfoHoras" completo="true"></span>  
                            <c:set var="in" value=""></c:set>
                        </c:if>
                        <c:if test = "${bandera==false}">
                            <span class="glyphicon glyphicon-exclamation-sign incompleto" title="Sección incompleta" id="estatusInfoHoras" completo="false"></span>
                            <c:set var="in" value="in"></c:set>
                        </c:if>
                        </c:if>
                        <c:if test="${vistaAdmin}">
                            <c:set var="in" value=""></c:set>
                            <c:if test="${Docente.infoRegistro[67]!=null}">
                                <span class="glyphicon glyphicon-ok-sign completo" title="Sección completa" id="estatusInfoHoras" completo="true"></span>                                  
                            </c:if>
                            <c:if test="${Docente.infoRegistro[67]==null}">
                                <span class="glyphicon glyphicon-exclamation-sign incompleto" title="Sección incompleta" id="estatusInfoHoras" completo="false"></span>                                
                            </c:if>  
                        </c:if>   
                      </a>
                    </h4>
                    <button type="button" class="collpase-button collapsed" data-parent="#accordion" data-toggle="collapse" href="#infoHoras"></button>
                  </div>
                  <div class="panel-collapse collapse ${in}" id="infoHoras" >
                    <div class="panel-body">
                      <form role="form" id="formInfoHorasGrupo" action="RegistroInfoHoras" method="POST">
                        <div class="checkbox col-md-6">                            
                            <c:if test="${Docente.infoRegistro[59]=='N'}">
                                <c:set var="checked" value=''></c:set>
                                <c:set var="in" value=''></c:set>
                            </c:if>
                            <c:if test="${Docente.infoRegistro[59]!='N'}">
                                <c:set var="checked" value='checked'></c:set>
                                <c:set var="in" value='in'></c:set>
                            </c:if>
                          <label><input type="checkbox" ${checked} name="frenteGrupo" id="frenteGrupo" data-toggle="collapse" data-target="#seccionHoras">Marque la casilla si actualmente se encuentra frente a grupo</label>
                        </div>  
                        <div id="seccionHoras" class="collapse ${in}">
                            <div class="form-group col-md-3">
                              <label class="control-label" for="numHoras">Horas frente a grupo:</label>
                              <c:if test='${sessionScope["subsistema"]!=2}'>
                                  <c:set var="totalHoras" value="${Docente.getTotalHoras()}"></c:set>
                              </c:if>
                              <c:if test='${sessionScope["subsistema"]==2}'>
                                  <c:set var="totalHoras" value="${Docente.getTotalHorasCecyte()}"></c:set>
                              </c:if>
                              <input type="text" class="form-control input-sm" id="numHoras" name="numHoras" value="${totalHoras}" readOnly  required>
                            </div>
                            <div class="form-group col-md-3">
                              <label class="control-label" for="numGrupos">Número de grupos:</label>
                              <c:if test='${sessionScope["subsistema"]!=2}'>
                                  <input type="text" class="form-control input-sm" id="numGrupos" name="numGrupos" value="${Docente.getNumGrupos()}" readOnly required>
                              </c:if>
                              <c:if test='${sessionScope["subsistema"]==2}'>
                                  <input type="text" class="form-control input-sm" id="numGrupos" name="numGrupos" value="${Docente.getNumGruposCecyte()}" readOnly required>
                              </c:if>
                            </div>
                            <c:if test="${vistaAdmin}">
                                <c:if test='${sessionScope["permisoActualEdicion"]=="F" && sessionScope["programa"]!=2 && sessionScope["subsistema"]!=2}'>
                                    <div class="text-center">
                                      <input type="button" class="btn btn-link btn-sm" value="(+) Agregar información" data-toggle="modal" data-target="#modalInformacion" disabled/>
                                    </div>
                                </c:if>
                                <c:if test='${sessionScope["permisoActualEdicion"]=="V" && sessionScope["programa"]!=2 && sessionScope["subsistema"]!=2}'>
                                    <div class="text-center">
                                      <input type="button" class="btn btn-link btn-sm" value="(+) Agregar información" data-toggle="modal" data-target="#modalInformacion"/>
                                    </div>
                                </c:if>
                                <c:if test='${sessionScope["permisoActualEdicion"]=="F" && sessionScope["programa"]==2 && sessionScope["subsistema"]!=2}'>
                                    <div class="text-center">
                                      <input type="button" class="btn btn-link btn-sm" value="(+) Agregar información" data-toggle="modal" data-target="#modalInformacionHoras" disabled/>
                                    </div>
                                </c:if>
                                <c:if test='${sessionScope["permisoActualEdicion"]=="V" && sessionScope["programa"]==2 && sessionScope["subsistema"]!=2}'>
                                    <div class="text-center">
                                      <input type="button" class="btn btn-link btn-sm" value="(+) Agregar información" data-toggle="modal" data-target="#modalInformacionHoras"/>
                                    </div>
                                </c:if>
                            </c:if>
                            <c:if test="${!vistaAdmin}">
                                <div class="text-center">
                                    <c:if test='${sessionScope["programa"]!=2 && sessionScope["subsistema"]!=2}'>
                                        <input type="button" class="btn btn-link btn-sm" value="(+) Agregar información" data-toggle="modal" data-target="#modalInformacionHoras"/>
                                    </c:if>
                                    <c:if test='${sessionScope["programa"]==2 && sessionScope["subsistema"]!=2}'>
                                        <input type="button" class="btn btn-link btn-sm" value="(+) Agregar información" data-toggle="modal" data-target="#modalInformacionHoras"/>
                                    </c:if>
                                </div>
                            </c:if>
                            <c:if test="${vistaAdmin}">
                                    <c:if test='${sessionScope["permisoActualEdicion"]=="F" && sessionScope["subsistema"]==2}'>
                                        <div class='text-center'>
                                            <input type='button' class='btn btn-sm btn-link' value='(+) Agregar información' data-toggle="modal" data-target="#modalInformacionCecyte" disabled/>
                                        </div>
                                    </c:if>
                                    <c:if test='${sessionScope["permisoActualEdicion"]=="V" && sessionScope["subsistema"]==2}'>
                                        <div class='text-center'>
                                            <input type='button' class='btn btn-sm btn-link' value='(+) Agregar información' data-toggle="modal" data-target="#modalInformacionCecyte" />
                                        </div>
                                    </c:if>
                                </c:if>
                                <c:if test="${!vistaAdmin}">
                                    <c:if test='${sessionScope["subsistema"]==2}'>
                                    <div class='text-center'>
                                        <input type='button' class='btn btn-sm btn-link' value='(+) Agregar información' data-toggle="modal" data-target="#modalInformacionCecyte"/>
                                    </div>
                                    </c:if>
                                </c:if>
                            <div>
                              <span>Los datos mostrados a continuación provienen de información institucional.<br/>En cada uno de los renglones con la opción habilitada, presione el botón <span class='glyphicon glyphicon-ok completo'></span> para válidarlos como correctos, de lo contrario presione <span class='glyphicon glyphicon-remove incompleto'></span>.</span>
                              <br/><br/>
                            </div>
                            <div class="table-responsive">
                              <table class="table table-striped table-bordered">
                                <tr>
                                  <th>Información</th>                              
                                  <th>Opciones</th>                        
                                </tr>
                                <tbody id="tablaInfo">
                                    <c:if test='${sessionScope["subsistema"]!=2}'>
                                        ${Docente.mostrarHoras()}
                                    </c:if>
                                    <c:if test='${sessionScope["subsistema"]==2}'>
                                        ${Docente.mostrarHorasCecyte()}
                                    </c:if>
                                    <!--<td colspan="2" class="text-center"><p class="text-danger">Sin información</p></td>-->
                                    
                                </tbody>                                
                              </table>
                            </div>
                            <c:if test="${Docente.getBanderaIngles()==true}">
                                <c:set var="hidden" value=""></c:set>
                                <c:set var="required" value="required"></c:set>
                            </c:if>
                            <c:if test="${Docente.getBanderaIngles()!=true}">
                                <c:set var="hidden" value="hidden"></c:set>
                                <c:set var="required" value=""></c:set>
                            </c:if>
                            <div class="row" id="seccionCENNI" ${hidden}>
                                <div class="form-group col-md-3">
                                  <label class="control-label" for="nivelCENNI">Nivel de Inglés CENNI:</label>
                                  <input type="text" class="form-control input-sm" id="nivelCENNI" name="nivelCENNI" maxlength="2" pattern="[0-9]+" value="${Docente.infoRegistro[51]}" ${required}>                          
                                </div>
                                <div class="form-group col-md-3">
                                  <label class="control-label" for="folio">Folio CENNI:</label>
                                  <input type="text" class="form-control input-sm" id="folio" name="folio" maxlength='15' value="${Docente.infoRegistro[52]}" ${required}>
                                </div>
                                <div class="form-group col-md-6">
                                    <label class="control-label" for="btnEvidencia5">Constancia CENNI:</label>
                                    <a title="Ver ejemplo" onclick="abrirModalEjemplo(5)"><span class="glyphicon glyphicon-picture"></span></a><br/> 
                                    <c:if test = "${Docente.documentoCargado2('5')==true}">
                                        <input id="btnEvidencia5" type="button" class="btn btn-sm btn-link" value="Ver archivo" onclick="abrirModalArchivo(5)"/>                                    
                                    </c:if>
                                    <c:if test = "${Docente.documentoCargado2('5')==false}">
                                        <input id="btnEvidencia5" type="button" class="btn btn-sm btn-link incompleto" value="Subir archivo" onclick="abrirModalArchivo(5)"/>
                                        <span class="glyphicon glyphicon-exclamation-sign incompleto" title="Sección incompleta" id="alertaBtnEvidencia5"></span>
                                    </c:if>
                                    
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="control-label" for="btnEvidencia4">Constancia de horas frente a grupo:</label>  
                                <a title="Ver ejemplo" onclick="abrirModalEjemplo(4)"><span class="glyphicon glyphicon-picture"></span></a><br/>
                                <c:if test = "${Docente.documentoCargado2('4')==true}">
                                    <input id="btnEvidencia4" type="button" class="btn btn-sm btn-link" value="Ver archivo" onclick="abrirModalArchivo(4)"/>                                    
                                </c:if>
                                <c:if test = "${Docente.documentoCargado2('4')==false}">
                                    <input id="btnEvidencia4" type="button" class="btn btn-sm btn-link incompleto" value="Subir archivo" onclick="abrirModalArchivo(4)"/>
                                    <span class="glyphicon glyphicon-exclamation-sign incompleto" title="Sección incompleta" id="alertaBtnEvidencia4"></span>
                                </c:if>                                
                            </div>
                        </div>
                        <div class="col-xs-12 text-right">
                              <c:if test="${!vistaAdmin}">
                                <input  class="btn btn-sm btn-primary" type="reset" value="Limpiar"/>
                                <input class="btn btn-sm btn-primary" id="btnEnviar3" type="submit" value='Guardar y continuar'/>
                              </c:if>
                              <c:if test="${vistaAdmin}">
                                  <c:if test='${sessionScope["permisoActualEdicion"]=="F"}'>
                                      <input class="btn btn-sm btn-primary" id="btnEnviar3" type="submit" value='Validar información' disabled/>
                                  </c:if>
                                  <c:if test='${sessionScope["permisoActualEdicion"]=="V"}'>
                                      <input class="btn btn-sm btn-primary" id="btnEnviar3" type="submit" value='Validar información'/>
                                  </c:if>
                              </c:if>
                              <!--<input type="button" class="btn btn-sm btn-primary" value="Guardar y continuar" onclick="mostrarSiguiente(1)"/>-->
                            </div>
                      </form>
                    
                                
                <c:if test="${vistaAdmin}">
                    <form id="formInfoAcademicaOb3" role="form" action="RegistroInfoAcademica" method="POST">
                      <input type="hidden" id="accion3" name="accion" value="observacionesPaso3">
                         <%-- <c:if test='${sessionScope["permisoActualEdicion"]=="F"}'>    --%>
                    <label class="control-label">Observaciones comité revisor:</label>    
                    <textarea ${disabled1} class="form-control text-uppercase ${disabled1}" id="observacion3P1R" name="observacion3P1R" maxlength="2000" onKeyUp="cambioObservacionesPaso3(this)" >${observacionesR[6]}</textarea>
                         <%-- </c:if>--%>
                    <c:if test='${sessionScope["permisoActual"]=="6"}'>
                   <input type="hidden" id="observacion3P1R" name="observacion3P1R" value="">
                    <label class="control-label">Observaciones consejo dictaminador:</label>
                    <textarea  class="form-control text-uppercase" id="observacion3P1D" name="observacion3P1D" maxlength="2000" onKeyUp="cambioObservacionesPaso3(this)"  required>${observacionesR[2]}</textarea>
                    </c:if>
                    <input style="margin-top:10px;" disabled="true" type="submit"  class="btn btn-primary" value="Guardar" id="btnFinalizarOb3" onclick="cerrar(3)">
                    </form>
                </c:if> 
                                
                                
                    </div>
                  </div>
                </div>                                
                <c:if test = "${Docente.infoRegistro[59]=='S'}">
                    <c:set var="hidden" value=""></c:set>
                    <c:set var="in" value="in"></c:set>
                </c:if>
                <c:if test = "${Docente.infoRegistro[59]!='S'}">
                    <c:set var="hidden" value="hidden"></c:set>
                    <c:set var="in" value=""></c:set>
                </c:if>
                <div class="panel panel-default" id="panelInfoCompatibilidad" ${hidden}>
                  <div class="panel-heading" id="phInfoCompatibilidad">
                    <h4 class="panel-title">
                      <a data-parent="#accordion" data-toggle="collapse" href="#infoCompatibilidad" aria-expanded="true" aria-controls="infoCompatibilidad">
                      Compatibilidad - Carta protesta
                        <c:set var="bandera" value="${Docente.verificaSeccion('7')}"></c:set>
                        <c:if test="${!vistaAdmin}">
                        <c:if test = "${bandera==true}">
                            <span class="glyphicon glyphicon-ok-sign completo" title="Sección completa" id="estatusInfoCompatibilidad" completo="true"></span>  
                            <c:set var="in" value=""></c:set>
                        </c:if>
                        <c:if test = "${bandera==false}">
                            <span class="glyphicon glyphicon-exclamation-sign incompleto" title="Sección incompleta" id="estatusInfoCompatibilidad" completo="false"></span>
                            <c:set var="in" value="in"></c:set>
                        </c:if>
                        </c:if>
                        <c:if test="${vistaAdmin}">
                            <c:set var="in" value=""></c:set>
                            <c:if test="${Docente.infoRegistro[67]!=null}">
                                <span class="glyphicon glyphicon-ok-sign completo" title="Sección completa" id="estatusInfoCompatibilidad" completo="true"></span>                                  
                            </c:if>
                            <c:if test="${Docente.infoRegistro[67]==null}">
                                <span class="glyphicon glyphicon-exclamation-sign incompleto" title="Sección incompleta" id="estatusInfoCompatibilidad" completo="false"></span>                                
                            </c:if>  
                        </c:if>   
                      </a>
                    </h4>
                    <button type="button" class="collpase-button collapsed" data-parent="#accordion" data-toggle="collapse" href="#infoCompatibilidad"></button>
                  </div>
                  <div class="panel-collapse collapse ${in}" id="infoCompatibilidad" >
                    <div class="panel-body">
                      <form role="form" id="formInfoCompatibilidad" method="POST" action="RegistroInfoCompatibilidad" style="margin-bottom:  200px;">                           
                        
                          
                          <div id="seccionCompatibilidad"  >
                                <div class="form-group col-md-4">
                                    <label class="control-label" for="btnEvidencia7">Archivo de evidencia:</label>  
                                    <a title="Ver ejemplo" onclick="abrirModalEjemplo(7)"><span class="glyphicon glyphicon-picture"></span></a><br/>
                                    <c:if test = "${Docente.documentoCargado2('7')==true}">
                                        <input id="btnEvidencia7" type="button" class="btn btn-sm btn-link" value="Ver archivo" onclick="abrirModalArchivo(7)"/>                                    
                                    </c:if>
                                    <c:if test = "${Docente.documentoCargado2('7')==false}">
                                        <input id="btnEvidencia7" type="button" class="btn btn-sm btn-link incompleto" value="Subir archivo" onclick="abrirModalArchivo(7)"/>
                                        <span class="glyphicon glyphicon-exclamation-sign incompleto" title="Sección incompleta" id="alertaBtnEvidencia7"></span>
                                    </c:if>                                    
                                </div> 
                            </div>
                        <div class="checkbox col-xs-12">
                        <c:if test="${Docente.infoRegistro[60]=='S'}">
                            <c:set var="checked" value="checked"></c:set>
                            <c:set var="in" value="in"></c:set>
                        </c:if>
                        <c:if test="${Docente.infoRegistro[60]!='S'}">
                            <c:set var="checked" value=""></c:set>
                            <c:set var="in" value=""></c:set>
                        </c:if>
                          
                            <label><input data-toggle="collapse" ${checked} data-target="#seccionOtro" type="checkbox" name="funcionesOtro" id="funcionesOtro" onClick="limpiarCampatibilidad()">Marque la casilla si desempeña funciones en otro subsistema</label>
                        </div>
                        <div id="seccionOtro" class="collapse ${in}" >
                            <div class="form-group col-md-3">
                              <label class="control-label" for="numHorasOtro">Número de horas:</label>
                              <input type="text" class="form-control input-sm" id="numHorasOtro" name="numHorasOtro" value="${Docente.infoRegistro[50]}" required>
                            </div>
                            <div class="checkbox col-md-4">
                              <c:if test="${Docente.infoRegistro[49]=='S'}">
                                <c:set var="checked" value="checked"></c:set>
                                <c:set var="in" value="in"></c:set>
                              </c:if>
                              <c:if test="${Docente.infoRegistro[49]!='S'}">
                                <c:set var="checked" value=""></c:set>
                                <c:set var="in" value=""></c:set>
                              </c:if>
                              <label><input  type="checkbox" ${checked} name="compatibilidad" id="compatibilidad">Marque la casilla si cuenta con la compatibilidad requerida</label>
                            </div>
                            
                        </div>
                        <div class="col-xs-12 text-right">
                              <c:if test="${!vistaAdmin}">
                                <input  class="btn btn-sm btn-primary" type="reset" value="Limpiar"/>
                                <input class="btn btn-sm btn-primary" id="btnEnviar4" type="submit" value='Guardar y continuar'/>
                              </c:if>
                              <c:if test="${vistaAdmin}">
                                  <c:if test='${sessionScope["permisoActualEdicion"]=="F"}'>
                                      <input class="btn btn-sm btn-primary" id="btnEnviar4" type="submit" value='Validar información' disabled/>
                                  </c:if>
                                  <c:if test='${sessionScope["permisoActualEdicion"]=="V"}'>
                                      <input class="btn btn-sm btn-primary" id="btnEnviar4" type="submit" value='Validar información'/>
                                  </c:if>
                              </c:if>
                              <!--<input type="button" class="btn btn-sm btn-primary" value="Guardar y continuar" onclick="mostrarSiguiente(1)"/>-->
                            </div>
                      </form>
                            
                            
                            <c:if test="${vistaAdmin}">
                                <form id="formInfoAcademicaOb4" role="form" action="RegistroInfoAcademica" method="POST" >
                                   
                                  <input type="hidden" id="accion4" name="accion" value="observacionesPaso4">
                                     <%-- <c:if test='${sessionScope["permisoActualEdicion"]=="F"}'>    --%>
                                <label class="control-label">Observaciones comité revisor:</label>    
                                <textarea ${disabled1} class="form-control text-uppercase ${disabled1}" id="observacion4P1R" name="observacion4P1R" maxlength="2000" onKeyUp="cambioObservacionesPaso4(this)" >${observacionesR[7]}</textarea>
                                     <%-- </c:if>--%>
                                <c:if test='${sessionScope["permisoActual"]=="6"}'>
                                    <input type="hidden" id="observacion4P1R" name="observacion4P1R" value="">
                                <label class="control-label">Observaciones consejo dictaminador:</label>
                                <textarea  class="form-control text-uppercase" id="observacion4P1D" name="observacion4P1D" maxlength="2000" onKeyUp="cambioObservacionesPaso4(this)"  required>${observacionesR[3]}</textarea>
                                </c:if>
                                <input style="margin-top:10px;" disabled="true" type="submit"  class="btn btn-primary" value="Guardar" id="btnFinalizarOb4" onclick="cerrar(4)">
                                </form>
                            </c:if> 
                            
                    </div>
                  </div>
                </div>
                
              </div>
                                
              <!--FIN Paneles colapsables-->
              <c:set var="banderaCompleto" value="true"></c:set>
              <c:set var="hidden" value=""></c:set>
              <c:if test="${Docente.verificaSeccion('1')==false}">
                  <c:set var="banderaCompleto" value="false"></c:set>
                  <c:set var="hidden" value="hidden"></c:set>
              </c:if>
              <c:if test="${Docente.verificaSeccion('2')==false}">
                  <c:set var="banderaCompleto" value="false"></c:set>
                  <c:set var="hidden" value="hidden"></c:set>
              </c:if>
              <c:if test="${Docente.verificaSeccion('3')==false}">
                  <c:set var="banderaCompleto" value="false"></c:set>
                  <c:set var="hidden" value="hidden"></c:set>
              </c:if>
              <c:if test="${Docente.verificaSeccion('4')==false}">
                  <c:set var="banderaCompleto" value="false"></c:set>
                  <c:set var="hidden" value="hidden"></c:set>
              </c:if>
              
              <div class="container text-center" style="margin-bottom:15px;">
                  <form action="FinalizaRegistro" method="POST">
                      <input type="hidden" id="banderaCompleto" name="k" value="${banderaCompleto}">
                        
                        <div id="seccionNotas" class="text-left" ${hidden}>
                          <c:if test="${!vistaAdmin}">
                          <table>
                              <tr>
                                <td valign="top"><input type="checkbox" name="cbProtestaVerdad" id="cbProtestaVerdad" onClick="cambioProtesta()"><td>
                                <td>Declara bajo protesta de decir verdad que cumple con los requisitos establecidos en la Convocatoria para el proceso de promoción en el servicio docente por cambio de categoría en Educación Media Superior, <jsp:include page="seccionesPlantilla/cicloEscolar.jsp" flush="true"/>. Para confirmar su dicho, la DGETI podrá verificar la autenticidad de la documentación que proporciono, por lo que, en caso de alteración o falsificación de la misma, acepta la descalificación inmediata del proceso o, en su caso, la invalidación del nombramiento respectivo, sin perjuicio de las sanciones de tipo administrativo o penal en las que pudiera incurrir.</td>    
                              </tr>
                              <tr>
                                  <td valign="top"><input type="checkbox" name="cbPublico" id="cbPublico" ><td>
                                  <td>Acepta hacer públicos los resultados y recomendaciones individuales que se deriven de su valoración para el proceso de promoción en el servicio docente por cambio de categoría en Educación Media Superior ingreso a la Educación Media Superior, <jsp:include page="seccionesPlantilla/cicloEscolar.jsp" flush="true"/>.<td>
                              </tr>
                          </table>
                          </c:if>
                          <c:if test="${vistaAdmin}">
                              
                              
                            <!--<label class="control-label">Observaciones:</label>-->
                            <c:if test='${sessionScope["permisoActualEdicion"]=="F"}'>
                                <input type="hidden" id="observaciones" name="observaciones" value="paso1" >
                                <%-- <textarea class="form-control text-uppercase" id="observaciones" name="observaciones" maxlength="2000" onKeyUp="cambioObservaciones()" required disabled>${Docente.infoRegistro[67]}</textarea>--%>
                            </c:if>
                            <c:if test='${sessionScope["permisoActualEdicion"]=="V"}'>
                                <input type="hidden" id="observaciones" name="observaciones" value="paso1" >
                                <%-- <textarea class="form-control text-uppercase" id="observaciones" name="observaciones" maxlength="2000" onKeyUp="cambioObservaciones()" required>${Docente.infoRegistro[67]}</textarea>--%>
                            </c:if>
                                
                          </c:if>
                          <br/>
                            <input type="hidden" id="rfc" name="rfc" value="${Docente.rfc}">
                            <input type="hidden" id="idUsuario" name="idUsuario" value="${Docente.idUsuario}">
                              <c:if test="${!vistaAdmin}">
                              <center><input type="button" disabled="true" class="btn btn-primary" value="Continuar" id="btnFinalizar" onclick="validarArchivos()"></center>
                              </c:if>
                              <c:if test="${vistaAdmin}">
                              <center><input type="submit" disabled="true" class="btn btn-primary" value="Continuar" id="btnFinalizar"></center>
                              </c:if>
                      </div>
                      
                       
                      
                  </form>
              </div>
          </div>               
                            
         <!--MODAL-->                 
         <div id="modalArchivo" class="modal fade" role="dialog">
            <div class="modal-dialog">
              <div class="modal-content" style="width: 700px;height: 672px;">
                <div class="modal-header">
                  <button type="button" class="close" data-dismiss="modal">&times;</button>
                  <h4 class="modal-title" id="tituloModal">Carga de archivos</h4>
                </div>
                <div class="modal-body">
                    <iframe name="ifRespuesta" hidden></iframe>
                    <iframe style="width:100%;height: 338px;" id="ifArchivo" name="ifArchivo" src="" hidden></iframe>
                    <%--<c:if test="${!vistaAdmin}">--%>
                    <form id="formArchivo" name="formArchivo" method="POST" enctype="multipart/form-data" >
                        <div class="form-group">
                            <label class="control-label" for="archivo">Seleccione el archivo a cargar:</label>
                            <label class="text-warning" id="alertaCarga"><span class="glyphicon glyphicon-warning-sign"></span>&nbsp;Al seleccionar un nuevo archivo, este se actualizará</label>
                            <input type="hidden" id="idArchivo" name="idArchivo" value="" />
                            <input type="file" class="form-control input-sm" id="archivo" name="archivo" onchange="subirArchivo()" accept=".pdf" />
                        </div>
                    </form>  
                    <%--</c:if>--%>
                    <%--<c:if test="${vistaAdmin}"><p>El documento no puede ser modificado</p></c:if>--%>
                </div>
                <div class="modal-footer">
                  <button type="button" class="btn btn-sm btn-default" data-dismiss="modal">Cerrar</button>
                </div>
              </div>
            </div>
          </div>
         
         <div id="modalEjemplo" class="modal fade" role="dialog">
            <div class="modal-dialog">
              <div class="modal-content" style="width: 700px;height: 672px;">
                <div class="modal-header">
                  <button type="button" class="close" data-dismiss="modal">&times;</button>
                  <h4 class="modal-title" id="tituloModalEjemplo">Carga de archivos</h4>
                </div>
                <div class="modal-body">
                    <iframe style="width:100%;height: 338px;" id="ifArchivoEjemplo" name="ifArchivoEjemplo" src=""></iframe>
                                       
                </div>
                <div class="modal-footer">
                  <button type="button" class="btn btn-sm btn-default" data-dismiss="modal">Cerrar</button>
                </div>
              </div>
            </div>
          </div>
         
         
         <div id="modalInformacion" class="modal fade" role="dialog">
            <div class="modal-dialog">
              <div class="modal-content">
                <div class="modal-header">
                  <button type="button" class="close" data-dismiss="modal">&times;</button>
                  <h4 class="modal-title">Registro información</h4>
                </div>
                <div class="modal-body">
                    <div class="container-fluid">
                        
                        <form id="formHorasGrupo" role="form" method="POST" action="RegistroHorasGrupo">
                            <div class="form-group col-md-6" >
                                <label class="control-label" for="periodo">Periodo:</label>
                                <select class="form-control input-sm" id="periodo" name="periodo" required>
                                    <%=new Catalogos().desplegarOpcionesPeriodos()%>  
                                    
                                </select>                          
                            </div>
                            <div class="form-group col-md-6">
                                <label class="control-label" for="grupo">Grupo:</label>
                                <input type="text" class="form-control input-sm" id="grupo" name="grupo" maxlength="5" required>                                                                 
                            </div>
                            <div class="form-group col-md-6" id="divSemestre">
                                <label class="control-label" for="semestre">Semestre:</label>
                                <select class="form-control input-sm" id="semestre" name="semestre" required>
                                    <option value="">-Seleccione-</option>
                                    <option value="1">1</option>
                                    <option value="2">2</option>
                                    <option value="3">3</option>
                                    <option value="4">4</option>
                                    <option value="5">5</option>
                                    <option value="6">6</option>
                                </select>                          
                            </div>
                            <div class="form-group col-md-6">
                                <label class="control-label" for="tipoInfo">Tipo de información:</label>
                                <select class="form-control input-sm" id="tipoInfo" name="tipoInfo" onchange="cambioTipoInfo(1)" required>
                                    <option value="">-Seleccione-</option>
                                    <option value="cbp">Componente básico y/o propedeútico</option>
                                    <option value="cp">Componente profesional</option>
                                    <option value="tl">Taller / laboratorio</option>
                                </select>                          
                            </div>
                            <div class="form-group col-md-6" id="divVersion" hidden>
                                <label class="control-label" for="version">Versión:</label>
                                <select class="form-control input-sm" id="version" name="version">
                                    <option value="">-Seleccione-</option>                                        
                                </select>                          
                            </div>                            
                            <div class="form-group col-md-6" id="divAsignatura" hidden>
                                <label class="control-label" for="asignatura" >Asignatura:</label>
                                <select class="form-control input-sm" id="asignatura" name="asignatura" onchange="cambioAsignatura()">
                                    <option value="">-Seleccione-</option>                                        
                                </select>                          
                            </div>
                            <div class="form-group col-md-6" id="divCarrera" hidden>
                                <label class="control-label" for="carrera_cp">Carrera:</label>
                                <select class="form-control input-sm" id="carrera_cp" name="carrera_cp" onchange="cambioCarreraCP()">
                                    <option value="">-Seleccione-</option>                                        
                                </select>                          
                            </div>
                            <div class="form-group col-md-6" id="divModulo" hidden>
                                <label class="control-label" for="modulo">Modulo:</label>
                                <select class="form-control input-sm" id="modulo" name="modulo" onchange="cambioModulo()">
                                    <option value="">-Seleccione-</option>                                        
                                </select>                          
                            </div>
                            <div class="form-group col-md-6" id="divSubmodulo" hidden>
                                <label class="control-label" for="submodulo">Submodulo:</label>
                                <select class="form-control input-sm" id="submodulo" name="submodulo" onchange="cambioSubmodulo()">
                                    <option value="">-Seleccione-</option>                                        
                                </select>                          
                            </div>
                            <div id="divTaller" hidden>
                                <div class="form-group col-md-6">
                                    <label class="control-label" for="taller">Taller / laboratorio:</label>
                                    <select class="form-control input-sm" id="taller" name="taller">
                                        <%=new Catalogos().desplegarTalleres()%>                                        
                                    </select>                          
                                </div>
                                
                            </div>
                            <div class="form-group col-md-6">
                                <label class="control-label" for="horas">Horas:</label>
                                <input type="text" class="form-control input-sm" id="horas" name="horas" required>                                                                 
                            </div>
                            <div class="col-xs-12 text-center">
                                <input type="button" class="btn btn-primary btn-sm" value="Cancelar" data-dismiss="modal"/>
                                <input class="btn btn-sm btn-primary" id="btnEnviarHG" type="submit" value='Registrar'/>
                                                                   
                            </div>
                        </form>
                    </div>                                       
                </div>
                <!--<div class="modal-footer">
                  <button type="button" class="btn btn-sm btn-default" data-dismiss="modal">Cerrar</button>
                </div>-->
              </div>
            </div>
          </div>
                                    
          <div id="modalInformacionHoras" class="modal fade" role="dialog">
            <div class="modal-dialog">
              <div class="modal-content">
                <div class="modal-header">
                  <button type="button" class="close" data-dismiss="modal">&times;</button>
                  <h4 class="modal-title">Registro información Horas</h4>
                </div>
                <div class="modal-body">
                    <div class="container-fluid">
                        
                        <form id="formHorasGrupo1" role="form" method="POST" action="RegistroHorasGrupo">
                            <input type="hidden" name="accion" id="accion" value="dgeti"/>
                            <div class="form-group col-md-6" >
                                <label class="control-label" for="periodo">Periodo:</label>
                                <select class="form-control input-sm" id="periodo" name="periodo"  required>
                                    <%=new Catalogos().desplegarOpcionesPeriodos()%>  
                                    
                                </select>                          
                            </div>
                            <div class="form-group col-md-6">
                                <label class="control-label" for="grupo">Grupo:</label>
                                <input type="text" class="form-control input-sm" id="grupo" name="grupo" maxlength="5" required>                                                                 
                            </div>
                            <div class="form-group col-md-12" id="divSemestre1">
                                <label class="control-label" for="semestre1">Semestre:</label>
                                <select class="form-control input-sm" id="semestre1" name="semestre1" onchange="cargaSemestreGeneral()" required>
                                    <option value="">-Seleccione-</option>
                                    <option value="1">1</option>
                                    <option value="2">2</option>
                                    <option value="3">3</option>
                                    <option value="4">4</option>
                                    <option value="5">5</option>
                                    <option value="6">6</option>
                                </select>                          
                            </div>
                           <!-- <div class="form-group col-md-6">
                               
                                <label class="control-label" for="tipoInfo">Tipo de información:</label>
                                <select class="form-control input-sm" id="tipoInfoCecyte" name="tipoInfoCecyte" onchange="cambioTipoInfoCecyte(2)" required>
                                    <option value="">-Seleccione-</option>
                                    <option value="cbp">Componente básico y/o propedeútico</option>
                                    <option value="cp">Componente profesional</option>
                                    <option value="tl">Taller / laboratorio</option>
                                </select>                        
                            </div> -->

                            <div class="form-group col-md-6" id="divVersion1" >
                                <label class="control-label" for="version1">Versión Asignatura:</label>
                                <select class="form-control input-sm" id="version1" name="version1" onchange="cargaAsignaturas1()" required>
                                       
                                   
                                    <%=new Catalogos().desplegarVersionesCompBPDGETI("1")%>   
                                </select>
                                    <%--<!-- comment<input type="text" class="form-control input-sm ${hidden}" id="versionOtro" placeholder="Indique" name="versionOtro" value="" ${required}> --%>
                            </div>                            
                            <div class="form-group col-md-6" id="divAsignatura1" >
                                <label class="control-label" for="asignatura1" >Asignatura:</label>
                                <select class="form-control input-sm" id="asignatura1" name="asignatura1" onchange="cambioAsignatura()" required >
                                    <option value="">-Seleccione-</option>                                        
                                </select>                          
                            </div>
                            <div class="form-group col-md-6" id="divVersion2" >
                                <label class="control-label" for="version1">Versión Carrera:</label>
                                <select class="form-control input-sm" id="version2" name="version2" onchange="cargaCarreras2()" required> 
                                    <%=new Catalogos().desplegarVersionesCompPDGETI()%>                                        
                                </select>
                                    <%-- <input type="text" class="form-control input-sm ${hidden}" id="versionOtro" placeholder="Indique" name="versionOtro" value="" ${required}>--%>
                            </div>
                            <div class="form-group col-md-6" id="divCarrera1" >
                                <label class="control-label" for="carrera_cp1">Carrera:</label>
                                <select class="form-control input-sm" id="carrera_cp1" name="carrera_cp1" onchange="cambioCarreraCP1_1()" required>
                                    <option value="">-Seleccione-</option>                                        
                                </select>
                               <%-- <input type="text" class="form-control input-sm ${hidden}" id="carreraOtro" placeholder="Indique" name="carreraOtro" value="" ${required}> --%>
                            </div>
                            <div class="form-group col-md-6" id="divModulo1" >
                                <label class="control-label" for="modulo1">Modulo:</label>
                                <select class="form-control input-sm" id="modulo1" name="modulo1" onchange="cambioModulo2()" required>
                                    <option value="">-Seleccione-</option>                                        
                                </select>
                               <%-- <input type="text" class="form-control input-sm ${hidden}" id="moduloOtro" placeholder="Indique" name="moduloOtro" value="" ${required}> --%>
                            </div>
                            <div class="form-group col-md-6" id="divSubmodulo1" >
                                <label class="control-label" for="submodulo1">Submodulo:</label>
                                <select class="form-control input-sm" id="submodulo1" name="submodulo1" onchange="cambioSubmodulo()" required>
                                    <option value="">-Seleccione-</option>                                        
                                </select>
                               <%-- <input type="text" class="form-control input-sm ${hidden}" id="submoduloOtro" placeholder="Indique" name="submoduloOtro" value="" ${required}> --%>
                            </div>
                            <div id="divTaller1" >
                                <div class="form-group col-md-6">
                                    <label class="control-label" for="taller1">Taller / laboratorio:</label>
                                    <select class="form-control input-sm" id="taller1" name="taller1" required>
                                        <%=new Catalogos().desplegarTalleres()%>                                        
                                    </select>                          
                                </div>
                                
                            </div>
                            <div class="form-group col-md-6">
                                <label class="control-label" for="horas">Horas:</label>
                                <input type="text" class="form-control input-sm" id="horas" name="horas" required>                                                                 
                            </div>
                            <div class="col-xs-12 text-center">
                                <input type="button" class="btn btn-primary btn-sm" value="Cancelar" data-dismiss="modal"/>
                                <input class="btn btn-sm btn-primary" id="btnEnviarHG" type="submit" value='Registrar'/>
                                                                   
                            </div>
                        </form>
                    </div>                                       
                </div>
                <!--<div class="modal-footer">
                  <button type="button" class="btn btn-sm btn-default" data-dismiss="modal">Cerrar</button>
                </div>-->
              </div>
            </div>
          </div>
         
         <div id="modalInformacionCecyte" class="modal fade" role="dialog">
            <div class="modal-dialog">
              <div class="modal-content">
                <div class="modal-header">
                  <button type="button" class="close" data-dismiss="modal">&times;</button>
                  <h4 class="modal-title">Registro información Cecyte</h4>
                </div>
                <div class="modal-body">
                    <div class="container-fluid">
                        
                        <form id="formGrupoCecyte" role="form" method="POST" action="RegistroGrupoCecyte">
                            <div class="form-group col-md-6" >
                                <label class="control-label" for="periodo2">Periodo:</label>
                                <input type="text" class="form-control input-sm" id="periodo2" name="periodo2" required>
                            </div>
                            <div class="form-group col-md-6">
                                <label class="control-label" for="grupo2">Grupo:</label>
                                <input type="text" class="form-control input-sm" id="grupo2" name="grupo2" maxlength="5" required>                                                                 
                            </div>
                            <div class="form-group col-md-6" id="divSemestre2">
                                <label class="control-label" for="semestre2">Semestre:</label>
                                <input type="text" class="form-control input-sm" id="semestre2" name="semestre2" required>     
                            </div>
                            <div class="form-group col-md-6">
                                <label class="control-label" for="tipoInfo2">Tipo de información:</label>
                                <input type="text" class="form-control input-sm" id="tipoInfoCecyte" name="tipoInfoCecyte" required>
                            </div>
                            <div class="form-group col-md-6" id="divVersion2">
                                <label class="control-label" for="version2">Versión:</label>
                                <input type="text" class="form-control input-sm" id="version2" name="version2" required>
                            </div>
                            <div class="form-group col-md-6" id="divCarrera2">
                                <label class="control-label" for="carrera_cp2">Carrera:</label>
                                <input type="text" class="form-control input-sm" id="carrera_cp2" name="carrera_cp2" required>
                            </div>
                            <div class="form-group col-md-6" id="divModulo2">
                                <label class="control-label" for="modulo2">Modulo:</label>
                                <input type="text" class="form-control input-sm" id="modulo2" name="modulo2" required>
                            </div>
                            <div class="form-group col-md-6" id="divSubmodulo2">
                                <label class="control-label" for="submodulo2">Submodulo:</label>
                                <input type="text" class="form-control input-sm" id="submodulo2" name="submodulo2" required>
                            </div>
                            <div class="form-group col-md-6">
                                <label class="control-label" for="horas2">Horas:</label>
                                <input type="number" class="form-control input-sm" id="horas2" name="horas2" required>                                                                 
                            </div>
                            <div class="form-group col-md-6" id="divAsignatura2">
                                <label class="control-label" for="asignatura2" >Asignatura:</label>    
                                <input type="text" class="form-control input-sm" id="asignatura2" name="asignatura2" required>
                            </div>
                            <div class="col-xs-12 text-center">
                                <input type="button" class="btn btn-primary btn-sm" value="Cancelar" data-dismiss="modal"/>
                                <input class="btn btn-sm btn-primary" id="btnEnviarHG" type="submit" value='Registrar'/>                               
                            </div>
                        </form>
                    </div>                                       
                </div>
              </div>
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
        
        <div class="modal fade" id="modalMensajeFin" role="dialog">
            <div class="modal-dialog">

              <!-- Modal content-->
              <div class="modal-content panel">
                <div class="modal-header">
                  <button type="button" class="close" data-dismiss="modal">&times;</button>
                  <h4 class="modal-title">Aviso</h4>
                </div>
                <div class="modal-body">
                  <p id="mensajeFin">Registro exitoso.</p>
                </div>
                <div class="modal-footer">
                  <!--<a href="SesionDocente">-->
                    <button type="button" onclick="myFunction()" class="btn btn-sm btn-default">Continuar</button>
                 <!--</a>-->
                 <button type="button" class="btn btn-sm btn-default" data-dismiss="modal">Cancelar</button>
                </div>
              </div>

            </div>
        </div>                            
        
        <div class="modal fade" id="modalMensajeFinHoras" role="dialog">
            <div class="modal-dialog">

              <!-- Modal content-->
              <div class="modal-content panel">
                <div class="modal-header">
                  <button type="button" class="close" data-dismiss="modal">&times;</button>
                  <h4 class="modal-title">Aviso</h4>
                </div>
                <div class="modal-body">
                  <p id="mensajeFinHoras">Registro exitoso.</p>
                </div>
                <div class="modal-footer">
                  <!--<a href="SesionDocente">-->
                    <button type="button" onclick="myFunctionHoras()" class="btn btn-sm btn-default">Continuar</button>
                 <!--</a>-->
                 <button type="button" class="btn btn-sm btn-default" data-dismiss="modal">Cancelar</button>
                </div>
              </div>

            </div>
        </div>
                                    
        <div class="modal fade" id="modalConfirmacion" role="dialog">
            <div class="modal-dialog">

              <!-- Modal content-->
              <div class="modal-content panel">
                  <form id="formBitacora" action="RegistroBitacora" method="POST">
                    <div class="modal-header">
                      <button type="button" class="close" data-dismiss="modal">&times;</button>
                      <h4 class="modal-title" id="tituloConfirmacion">Aviso</h4>
                    </div>
                    <div class="modal-body">
                      <p id="mensajeConfirmacion"></p>
                      <input type="hidden" id="idUsuario" name="idUsuario" value="${Docente.idUsuario}">
                      <input type="hidden" id="rfc" name="rfc" value="${Docente.rfc}">
                      <input type="hidden" id="idHora" name="idHora" value="">
                      <input type="hidden" value="" id="descripcionBitacora" name="descripcionBitacora">
                    </div>
                    <div class="modal-footer">
                      <button type="button" class="btn btn-sm btn-default" id="btnConfirmacion">Confirmar</button>
                      <button type="button" class="btn btn-sm btn-default" data-dismiss="modal">Cancelar</button>
                    </div>
                  </form>
              </div>

            </div>
          </div> 
        
          <div class="modal fade" id="modalPlazas" role="dialog">
            <div class="modal-dialog">
              <!-- Modal content-->
              <div class="modal-content panel">
                  <form id="formPlaza" action="AdministracionPlaza" method="POST">
                    <div class="modal-header">
                      <button type="button" class="close" data-dismiss="modal">&times;</button>
                      <h4 class="modal-title">Registro de plaza</h4>
                    </div>
                    <div class="modal-body">
                      <div class="row">
                        <div class="form-group col-md-6">
                          <label class="control-label" for="tipoNombramiento">Tipo de nombramiento:</label>
                          <select class="form-control input-sm" id="tipoNombramiento" name="tipoNombramiento" required>                                    
                            ${catalogo.desplegarOpcionesTipoNombramiento()}
                          </select>                          
                        </div>
                          <div class="form-group col-md-6 datepicker-group">
                          <label class="control-label" for="fechaPlaza" style="font-size: 12px;">Fecha desde que ostenta la plaza:</label>
                          <input class="form-control input-sm fecha" id="fechaPlaza" name="fechaPlaza" type="text"  required>
                        </div>
                      </div>
                      <div class="row">  
                        <div class="form-group col-md-6">
                            <label class="control-label" for="clvPresupUnidad">Clave Presupuestal (9 Dígitos):</label>
                            <input type='hidden' id="valorClavePresupuestal" name="valorClavePresupuestal" value=''>
                            <input type="text" class="form-control input-sm" id="clavePresupUnidad" name="clavePresupUnidad" required />
                        </div>
                        <c:if test='${sessionScope["subsistema"]=="1"}'> 
                            <div class="form-group col-md-6">
                              <label class="control-label" for="clvPresupCategoria">Clave Presupuestal (Categoría):</label>
                              <select class="form-control input-sm" id="categoriaPresupuestal" name="categoriaPresupuestal" onchange="cambioCategoriaPresupuestal()" required>
                                ${catalogo.desplegarCategoriasPresupuestales2()}
                              </select>                          
                            </div>
                        </c:if>  
                      </div>
                      <c:if test='${sessionScope["subsistema"]=="1"}'> 
                            <div class="row">  
                                <div class="form-group col-md-6">
                                      <label class="control-label" for="clvPresupHoras">Clave Presupuestal (2 Dígitos Seguidos Por: .0):</label>
                                      <input type="text" class="form-control input-sm" id="clavePresupHoras" name="clavePresupHoras" required />
                                </div>
                                <div class="form-group col-md-6">
                                    <label class="control-label" for="clvPresupPlaza">Clave Presupuestal (6 Dígitos):</label>
                                    <input type="text" class="form-control input-sm" id="clavePresupPlaza" name="clavePresupPlaza" required />
                                </div>
                              </div>
                      </c:if>
                      <div class="row"> 
                        <div class="form-group col-md-6">
                          <label class="control-label" for="categoria">Categoría:</label>
                          <select class="form-control input-sm" id="categoria" name="categoria" onchange="cambioCategoria()" required>
                            ${catalogo.desplegarOpcionesCategorias()}
                          </select>                          
                        </div>
                      </div>
                      <div class="row"> 
                        <div class="form-group col-md-6">
                          <label class="control-label" for="jornada">Tipo de jornada:</label>
                          <select class="form-control input-sm" id="jornada" name="jornada" onChange="cambioJornada(this)" required>
                              ${catalogo.desplegarOpcionesJornada()}
                          </select>                          
                        </div>
                        <div class="form-group col-md-6 hidden" id="seccionHoras4">
                            <label class="control-label" for="horas">Horas:</label>
                            <input type="text" class="form-control input-sm" id="horas" name="horas" maxlength="2" /> 
                        </div>
                      </div>
                      <div class="row">
                        <div class="form-group col-md-12">
                            <label><input type="checkbox" id="cbDirectivo" name="cbDirectivo" data-toggle="collapse" data-target="#seccionDirectivo">Marque la casilla si desempeña una función como Director, Subdirector o Jefe de Departamento</label>
                        </div>    
                        <div id="seccionDirectivo" class="collapse">
                          <div class="form-group col-md-6">
                            <label class="control-label" for="cargo">Cargo:</label>
                            <select class="form-control input-sm" id="cargo" name="cargo" required>
                                <option value="">-Seleccione-</option>
                                <option value="D">Director</option>
                                <option value="S">Subdirector</option>
                                <option value="J">Jefe de Departamento</option>
                            </select>                          
                          </div>
                          <div class="form-group col-md-6">
                            <label class="control-label" for="fechaRenuncia">Fecha de renuncia al cargo:</label>
                            <input class="form-control input-sm fecha" id="fechaRenuncia" name="fechaRenuncia" type="text" required>
                          </div>
                        </div>
                      </div>
                    </div>
                    <div class="modal-footer">
                      <button type="submit" id="btnGuardarPlaza" class="btn btn-sm btn-default">Guardar</button>
                      <button type="button" class="btn btn-sm btn-default" data-dismiss="modal">Cancelar</button>
                    </div>
                  </form>
              </div>

            </div>
          </div>
          <div class="modal fade" id="modalPlazasHoras" role="dialog">
            <div class="modal-dialog">
              <!-- Modal content-->
              <div class="modal-content panel">
                  <form id="formPlaza1" action="AdministracionPlaza" method="POST">
                    <div class="modal-header">
                      <button type="button" class="close" data-dismiss="modal">&times;</button>
                      <h4 class="modal-title">Registro de plaza horas</h4>
                    </div>
                    <div class="modal-body">
                      <div class="row">
                        <div class="form-group col-md-6">
                          <label class="control-label" for="tipoNombramiento">Tipo de nombramiento:</label>
                          <select class="form-control input-sm" id="tipoNombramiento" name="tipoNombramiento" required>                                    
                            ${catalogo.desplegarOpcionesTipoNombramiento()}
                          </select>                          
                        </div>
                          <div class="form-group col-md-6 datepicker-group">
                          <label class="control-label" for="fechaPlaza" style="font-size: 12px;">Fecha desde que ostenta la plaza:</label>
                          <input class="form-control input-sm fecha" id="fechaPlaza" name="fechaPlaza" type="text"  required>
                        </div>
                      </div>
                      <div class="row">  
                        <div class="form-group col-md-6">
                            <label class="control-label" for="clvPresupUnidad">Clave Presupuestal (9 Dígitos):</label>
                            <input type='hidden' id="valorClavePresupuestal" name="valorClavePresupuestal" value=''>
                            <input type="text" class="form-control input-sm" id="clavePresupUnidad" name="clavePresupUnidad" size="9" required />
                        </div>
                        <div class="form-group col-md-6">
                          <label class="control-label" for="categoria">Categoría:</label>
                          <select class="form-control input-sm" id="categoria" name="categoria" onchange="cambioCategoria()" required>
                            ${catalogo.desplegarOpcionesCategorias()}
                          </select>                          
                        </div>
                      </div>
                      <div class="row"> 
                        <div class="form-group col-md-6">
                          <label class="control-label" for="jornada">Tipo de jornada:</label>
                          <select class="form-control input-sm" id="jornada" name="jornada" onChange="cambioJornada2(this)" required>
                              ${catalogo.desplegarOpcionesJornada()}
                          </select>                          
                        </div>
                        <div class="form-group col-md-6 hidden" id="seccionHoras3">
                            <label class="control-label" for="horas3">Horas:</label>
                            <input type="text" class="form-control input-sm" id="horas3" name="horas3" maxlength="2" />
                        </div>
                      </div>
                      <div class="row">
                        <div class="form-group col-md-12">
                            <label><input type="checkbox" id="cbDirectivoHoras" name="cbDirectivoHoras" onchange="mostrarCamposDirector(this);">Marque la casilla si desempeña una función como Director, Subdirector o Jefe de Departamento</label>
                        </div>    
                        <div style="display:none" id="seccionDirectivoHoras" >
                          <div class="form-group col-md-6">
                            <label class="control-label" for="cargo">Cargo:</label>
                            <select class="form-control input-sm" id="cargo" name="cargo" required>
                                <option value="">-Seleccione-</option>
                                <option value="D">Director</option>
                                <option value="S">Subdirector</option>
                                <option value="J">Jefe de Departamento</option>
                            </select>                          
                          </div>
                          <div class="form-group col-md-6">
                            <label class="control-label" for="fechaRenuncia">Fecha de renuncia al cargo:</label>
                            <input class="form-control input-sm fecha" id="fechaRenuncia" name="fechaRenuncia" type="text" required>
                          </div>
                        </div>
                      </div>
                    </div>
                    <div class="modal-footer">
                      <button type="submit" id="btnGuardarPlaza" class="btn btn-sm btn-default">Guardar</button>
                      <button type="button" class="btn btn-sm btn-default" data-dismiss="modal">Cancelar</button>
                    </div>
                  </form>
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
                    <p id="mensajeConfirmacion">La información seleccionada será borrada<br/>¿Desea continuar?</p>                  
                </div>
                <div class="modal-footer">
                  <button type="button" id="btnConfirmar" class="btn btn-sm btn-default">Sí</button>
                  <button type="button" class="btn btn-sm btn-default" data-dismiss="modal">No</button>
                </div>
              </div>
            </div>
        </div>
        <div id="modalValidarArchivos" class="modal fade" role="dialog">
            <div class="modal-dialog">
              <div class="modal-content" style="width: 123%;">
                <div class="modal-header">
                  <button type="button" class="close" data-dismiss="modal">&times;</button>
                  <h4 class="modal-title" >Archivos cargados en los requisitos</h4>
                </div>
                <div class="modal-body">
                    <p class="control-label"><span class="glyphicon glyphicon-exclamation-sign incompleto" title="Sección incompleta" id="estatusArchivo" completo="false"></span> Información Académica - Documento comprobatorio</p>
                    <p class="control-label"><span class="glyphicon glyphicon-exclamation-sign incompleto" title="Sección incompleta" id="estatusArchivo1" completo="false"></span> Información Laboral - Constancia de antiguedad</p>
                    <p class="control-label"><span class="glyphicon glyphicon-exclamation-sign incompleto" title="Sección incompleta" id="estatusArchivo2" completo="false"></span> Información Laboral - Constancia de nombramiento definitivo</p>
                    <p class="control-label"><span class="glyphicon glyphicon-exclamation-sign incompleto" title="Sección incompleta" id="estatusArchivo3" completo="false"></span> Información Laboral - Constancia de no contar con nota desfavorable</p>
                    <p class="control-label"><span class="glyphicon glyphicon-exclamation-sign incompleto" title="Sección incompleta" id="estatusArchivo4" completo="false"></span> Horas frente a grupo - Constancia de horas frente a grupo</p>
                    <p class="control-label"><span class="glyphicon glyphicon-exclamation-sign incompleto" title="Sección incompleta" id="estatusArchivo5" completo="false"></span> Compatibilidad - Carta protesta - Archivo de evidencia</p>
                    <br>
                    <br>
                    <p class="control-label" style="font-weight: bold;">Nota:</p>
                    <p class="control-label"><span class="glyphicon glyphicon-exclamation-sign incompleto"></span> Sin evidencia</p>
                    <p class="control-label"><span class="glyphicon glyphicon-exclamation-sign completo"></span> Con evidencia</p>
                </div>
                <div class="modal-footer">
                    <button type="button" id="btnConfirmar" class="btn btn-sm btn-default" onclick="myFinRegistro()">Aceptar</button>
                  <button type="button" class="btn btn-sm btn-default" data-dismiss="modal">Cancelar</button>
                </div>
              </div>
            </div>
        </div>
		
         <!--FIN MODAL-->                   
                
        </main>
        <script src="https://framework-gb.cdn.gob.mx/gobmx.js"></script>        
        <script src="https://code.jquery.com/jquery-1.12.4.js"></script>      
        <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>  
        <script src="https://framework-gb.cdn.gob.mx/assets/scripts/jquery-ui-datepicker.js"></script>
        <script src="https://ajax.aspnetcdn.com/ajax/jquery.validate/1.13.1/jquery.validate.min.js"></script>
        <script src="js/funcionesRegistro.js"></script>
        <script>
            function myFunction(){
                var idCategoria=$('#categoria').val();
                var idJornada=$('#jornada').val();
                var horas=$('#horas2').val();
                var fechaPlaza=$('#fechaPlaza').val();
                var idTipoNombramiento=$('#tipoNombramiento').val();
                var clave=$('#clave').val();
                var cargo=$('#cargo').val();
                var fechaRenuncia=$('#fechaRenuncia').val();
                
                $("#modalMensajeFin").modal("hide");
                $.post("FinalizaRegistro", {z:"F"}, function(data){
                    window.location.href = "/procesopromocion/SesionDocente";
                });
                
                $.post("AdministracionPlaza", {z:"F",categoria:idCategoria,jornada:idJornada,
                    horas:horas,fechaPlaza:fechaPlaza,tipoNombramiento:idTipoNombramiento,clave:clave,
                    cargo:cargo,fechaRenuncia:fechaRenuncia}, function(data){
                    if(data.includes("<tr>")){
                        $("#tablaPlazas").html(data);
                    }
                });
            }
            function myFunction1(){
                $("#modalConfirmacion").modal("hide");
                $.post("FinalizaRegistro", {z:"F"}, function(data){
                    window.location.href = "/procesopromocion/SesionDocente";
                });
            }
            function myFunctionHoras(){
                $("#modalMensajeFinHoras").modal("hide");
                $.post("FinalizaRegistro", {z:"F"}, function(data){
                    window.location.href = "/procesopromocion/SesionDocente";
                });
            }
        </script>
        </script>
        <script>
            $( function() {
                var availableTags = [
                    ${catalogo.consultarCarreras()}
                ];
                $( "#carrera" ).autocomplete({
                  source: availableTags
                });
                <c:if test="${vistaAdmin}">
                cambioObservaciones();
                </c:if>
            });
        </script>
        <c:if test="${vistaAdmin}">
            <script>
                function confirmarPlaza(){
                    $("#mensaje").html("Acción no permitida");                    
                    $("#modalMensaje").modal("show");
                }
            </script>
            <script>
                
              function cambioObservacionesPaso1(objeto){
                   if(objeto.value!=""){
                        $("#btnFinalizarOb1").removeAttr("disabled");    
                    }else{
                        $("#btnFinalizarOb1").attr("disabled",true); 
                    }
               }
               
               function cambioObservacionesPaso2(objeto){
                   if(objeto.value!=""){
                        $("#btnFinalizarOb2").removeAttr("disabled");    
                    }else{
                        $("#btnFinalizarOb2").attr("disabled",true); 
                    }
               }
               
                function cambioObservacionesPaso3(objeto){
                   if(objeto.value!=""){
                        $("#btnFinalizarOb3").removeAttr("disabled");    
                    }else{
                        $("#btnFinalizarOb3").attr("disabled",true); 
                    }
               }
               
               function cambioObservacionesPaso4(objeto){
                   if(objeto.value!=""){
                        $("#btnFinalizarOb4").removeAttr("disabled");    
                    }else{
                        $("#btnFinalizarOb4").attr("disabled",true); 
                    }
               }
               
               function cerrar(id){
    console.log(id);
    switch(id){
        case 1:         
            $("#infoLaboral").collapse("show");
            $("#infoAcademica").collapse("hide");
             break
        case 2:         
            $("#infoHoras").collapse("show");
            $("#infoLaboral").collapse("hide");
             break
        case 3:         
            $("#infoCompatibilidad").collapse("show");
            $("#infoHoras").collapse("hide");
             break
        case 4:         
            //$("#infoCompatibilidad").collapse("show");
            $("#infoCompatibilidad").collapse("hide");
             $("#btnFinalizar").removeAttr("disabled");
             break 
           }           
               }
            </script>
        </c:if>
		<script>
        function myFinRegistro(){
                var k=$('#banderaCompleto').val();
                var cbPublico=$('#cbPublico').val();
                
                $.post("FinalizaRegistro", {k:k,cbPublico:cbPublico}, function(data){
                     window.location.href = "/procesopromocion/SesionDocente";
                });
            }
            function validarArchivos(){
                if($("#btnEvidencia1").val().includes("Ver")){
                    $("#estatusArchivo").attr("class","glyphicon glyphicon-ok-sign completo");
                    $("#estatusArchivo").attr("title","Sección completa");
                    $("#estatusArchivo").attr("completo",true);
                }else{
                    $("#estatusArchivo").attr("class","glyphicon glyphicon-exclamation-sign incompleto");
                    $("#estatusArchivo").attr("title","Sección incompleta");
                    $("#estatusArchivo").attr("completo",false);                            
                }
                if($("#btnEvidencia2").val().includes("Ver")){
                    $("#estatusArchivo1").attr("class","glyphicon glyphicon-ok-sign completo");
                    $("#estatusArchivo1").attr("title","Sección completa");
                    $("#estatusArchivo").attr("completo",true);
                }else{
                    $("#estatusArchivo1").attr("class","glyphicon glyphicon-exclamation-sign incompleto");
                    $("#estatusArchivo1").attr("title","Sección incompleta");
                    $("#estatusArchivo1").attr("completo",false);                            
                }
                if($("#btnEvidencia3").val().includes("Ver")){
                    $("#estatusArchivo2").attr("class","glyphicon glyphicon-ok-sign completo");
                    $("#estatusArchivo2").attr("title","Sección completa");
                    $("#estatusArchivo2").attr("completo",true);
                }else{
                    $("#estatusArchivo2").attr("class","glyphicon glyphicon-exclamation-sign incompleto");
                    $("#estatusArchivo2").attr("title","Sección incompleta");
                    $("#estatusArchivo2").attr("completo",false);                            
                }
                if($("#btnEvidencia6").val().includes("Ver")){
                    $("#estatusArchivo3").attr("class","glyphicon glyphicon-ok-sign completo");
                    $("#estatusArchivo3").attr("title","Sección completa");
                    $("#estatusArchivo3").attr("completo",true);
                }else{
                    $("#estatusArchivo3").attr("class","glyphicon glyphicon-exclamation-sign incompleto");
                    $("#estatusArchivo3").attr("title","Sección incompleta");
                    $("#estatusArchivo3").attr("completo",false);                            
                }
                if($("#btnEvidencia4").val().includes("Ver")){
                    $("#estatusArchivo4").attr("class","glyphicon glyphicon-ok-sign completo");
                    $("#estatusArchivo4").attr("title","Sección completa");
                    $("#estatusArchivo4").attr("completo",true);
                }else{
                    $("#estatusArchivo4").attr("class","glyphicon glyphicon-exclamation-sign incompleto");
                    $("#estatusArchivo4").attr("title","Sección incompleta");
                    $("#estatusArchivo4").attr("completo",false);                            
                }
                if($("#btnEvidencia7").val().includes("Ver")){
                    $("#estatusArchivo5").attr("class","glyphicon glyphicon-ok-sign completo");
                    $("#estatusArchivo5").attr("title","Sección completa");
                    $("#estatusArchivo5").attr("completo",true);
                }else{
                    $("#estatusArchivo5").attr("class","glyphicon glyphicon-exclamation-sign incompleto");
                    $("#estatusArchivo5").attr("title","Sección incompleta");
                    $("#estatusArchivo5").attr("completo",false);                            
                }
                $("#modalValidarArchivos").modal("show");
            }
            function myAgregarCategoria(){
                var idCategoriaAspira=$('#categoriaAspira').val();
                var idJornadaAspira=$('#jornadaAspira').val();
                var horasAspira=$("#numhoras option:selected").text();
                var idCategoria=$("#categoriaAspira option:selected").attr('idCategoria');
                
                $.post("AgregarCategoriasAspira", {categoria:idCategoriaAspira,jornada:idJornadaAspira,horas:horasAspira,idCategoria:idCategoria}, function(data){
                    if(data.includes("<tr>")){
                        $("#tablaCategorias").html(data);
                    }else{
                        $("#mensaje").html(data);            
                        $("#modalMensaje").modal("show");
                    }
                });
            }
            function confirmarCategoriaAspira(id){
                $("#btnConfirmar").attr("onClick","borrarCategoriaAspira("+id+")");
                $("#modalConfirmacion2").modal("show");
            }
            function borrarCategoriaAspira(id){
                $("#modalConfirmacion2").modal("hide");
                $.post("AgregarCategoriasAspira", {id: id,k:"B"}, function(data){
                    if(data.includes("<tr>")){            
                        $("#tablaCategorias").html(data);
                    }
                    else{
                        $("#mensaje").html(data);            
                        $("#modalMensaje").modal("show");
                    } 
                });
            }
        </script>
        
    </body>
</html>