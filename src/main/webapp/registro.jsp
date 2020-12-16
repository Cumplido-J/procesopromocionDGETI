<%-- 
    Document   : registro
    Created on : 8 jun 2020, 14:51:58
    Author     : David Reyna
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import='herramientas.Catalogos'%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
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
        <input type="hidden" id="programa" value="${Docente.infoRegistro[64]}" />
        <input type="hidden" id="plantel" value="${Docente.infoRegistro[6]}" />
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
                <h4>Programa de Promoción en el Servicio Docente por Cambio de Categoría en Educación Media Superior</h4>
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
                        <div class="row">
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
                            </div>
                            <div class="form-group col-md-3">
                              <label class="control-label" for="cct">CCT:</label>
                              <select class="form-control input-sm" id="cct" name="cct" onChange="cambioCCT()">
                                ${catalogo.desplegarOpcionesCCT(Docente.infoRegistro[56],Docente.infoRegistro[53])}
                              </select>
                              <input type="text" class="form-control input-sm" id="cctOtro" name="cctOtro" hidden>
                            </div>
                        </div>
                        <div class="row">
                            <div class="form-group col-md-3">
                              <label class="control-label" for="escuela">Escuela o Facultad:</label>
                              <select class="form-control input-sm" id="escuela" name="escuela" required>
                                ${catalogo.desplegarOpcionesEscuelas(Docente.infoRegistro[56],Docente.infoRegistro[14])}
                              </select>
                            </div>
                            <div class="form-group col-md-3">
                              <label class="control-label" for="grado">Grado Académico:</label>
                              <select class="form-control input-sm" id="grado" name="grado" required>                                
                                ${catalogo.desplegarOpcionesGrado(Docente.infoRegistro[19])}
                              </select>
                            </div>
                            <div class="form-group col-md-3">
                              <label class="control-label" for="carrera">Carrera:</label>                              
                              <input type="text" class="form-control input-sm" id="carrera" name="carrera" value="${Docente.infoRegistro[17]}" required onchange="cambioCarrera()">
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
                                <label class="control-label" for="btnEvidencia1">Título:</label>
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
                              <label class="control-label" for="documento">Documento comprobatorio:</label>
                              <select class="form-control input-sm" id="documento" name="documento" onchange="cambioDocumento(this)" required>
                                  <option value="">-Seleccionar-</option>                                  
                                  <c:if test = "${Docente.infoRegistro[24]==null}">
                                      <option value="acta" selected>Acta de grado</option>
                                      <option value="cedula">Cédula profesional</option>
                                  </c:if>
                                  <c:if test = "${Docente.infoRegistro[24]!=null}">
                                      <option value="acta">Acta de grado</option>
                                      <option value="cedula" selected>Cédula profesional</option>
                                  </c:if>
                              </select>
                            </div>
                        </div>
                        <div class="row">
                            <c:if test = "${Docente.infoRegistro[24]==null}">
                                <c:set var="hidden" value="hidden"></c:set>
                            </c:if>
                            <div id="seccionCedula" ${hidden}>
                                <div class="form-group col-md-3">
                                  <label class="control-label" for="cedula">Número de Cédula:</label>
                                  <input type="text" class="form-control input-sm" id="cedula" name="cedula" value="${Docente.infoRegistro[24]}">
                                </div>
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
                                </div> 
                            </div>
                        </div>     
                        
                            <div class="col-xs-12 text-right">
                              <c:if test="${!vistaAdmin}">
                                <input  class="btn btn-sm btn-primary" type="reset" value="Limpiar"/>
                                <input class="btn btn-sm btn-primary" id="btnEnviar1" type="submit" value='Guardar y continuar'/>
                              </c:if>
                              <c:if test="${vistaAdmin}">
                                <input class="btn btn-sm btn-primary" id="btnEnviar1" type="submit" value='Validar información'/>
                              </c:if>
                              <!--<input type="button" class="btn btn-sm btn-primary" value="Guardar y continuar" onclick="mostrarSiguiente(1)"/>-->
                            </div>
                        
                      </form>
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
                                  <input type="text" class="form-control input-sm" id="ingresoSubsistema" name="ingresoSubsistema" value="${fecha.formatoImprimir(Docente.infoRegistro[26])}" required>

                                </div>
                                <div class="form-group col-md-3 datepicker-group">
                                  <label class="control-label" for="ingresoPlantel">Fecha de ingreso al plantel:</label>
                                  <input class="form-control input-sm" id="ingresoPlantel" name="ingresoPlantel" type="text" value="${fecha.formatoImprimir(Docente.infoRegistro[27])}" required>

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
                                <div class='text-center'>
                                    <input type='button' class='btn btn-sm btn-link' value='(+) Agregar información de plazas' onclick="abrirModalPlazas();" />
                                </div>
                                <div class='table-responsive'>
                                    <table class='table table-bordered table-condensed'>
                                        <tr><th>Clave presupuestal</th><th>Fecha desde que ostenta la plaza</th><th>Tipo de nombramiento</th><th>Categoria</th><th>Jornada</th><th>Borrar</th></tr>
                                        <tbody id="tablaPlazas">
                                            ${dato.desplegarPlazas(Docente.infoRegistro[0])}
                                        </tbody>
                                    </table>
                                </div>                              
                            </div>
                            <div class="row"> 
                                <div class="form-group col-md-3 datepicker-group">
                                  <label class="control-label" for="fechaPromocion">Fecha de su última promoción:</label>
                                  <input class="form-control input-sm" id="fechaPromocion" name="fechaPromocion" type="text" value="${fecha.formatoImprimir(Docente.infoRegistro[39])}" required>
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
                                     ${catalogo.desplegarOpcionesCategoriasVacantes(Docente.infoRegistro[6],Docente.infoRegistro[64],Docente.infoRegistro[42])}
                                  </select>  
                                  <label class="error" id="alertaCategoria" hidden >No puede participar a esta categoría</label>
                                </div>
                                <div class="form-group col-md-3">
                                  <label class="control-label" for="jornadaAspira">Tipo de jornada:</label>
                                  <select class="form-control input-sm" id="jornadaAspira" name="jornadaAspira" onchange="cambioJornadaAspira()" required>
                                      ${catalogo.desplegarOpcionesJornadaVacante(Docente.infoRegistro[42],Docente.infoRegistro[6],Docente.infoRegistro[64],Docente.infoRegistro[44])}
                                  </select>  
                                  <label class="error" id="alertaJornada" hidden >No puede participar para esta jornada</label>
                                </div>
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
                                <input class="btn btn-sm btn-primary" id="btnEnviar2" type="submit" value='Validar información'/>
                              </c:if>
                              <!--<input type="button" class="btn btn-sm btn-primary" value="Guardar y continuar" onclick="mostrarSiguiente(1)"/>-->
                            </div>
                      </form>
                    
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
                              <c:set var="totalHoras" value="${Docente.getTotalHoras()}"></c:set>
                              <input type="text" class="form-control input-sm" id="numHoras" name="numHoras" value="${totalHoras}" readOnly  required>
                            </div>
                            <div class="form-group col-md-3">
                              <label class="control-label" for="numGrupos">Número de grupos:</label>
                              <input type="text" class="form-control input-sm" id="numGrupos" name="numGrupos" value="${Docente.getNumGrupos()}" readOnly required>
                            </div>
                            <div class="text-center">
                              <input type="button" class="btn btn-link btn-sm" value="(+) Agregar información" data-toggle="modal" data-target="#modalInformacion"/>
                            </div>
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
                                    ${Docente.mostrarHoras()}
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
                                <input class="btn btn-sm btn-primary" id="btnEnviar3" type="submit" value='Validar información'/>
                              </c:if>
                              <!--<input type="button" class="btn btn-sm btn-primary" value="Guardar y continuar" onclick="mostrarSiguiente(1)"/>-->
                            </div>
                      </form>
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
                      Compatibilidad
                        <c:set var="bandera" value="${Docente.verificaSeccion('4')}"></c:set>
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
                      <form role="form" id="formInfoCompatibilidad" method="POST" action="RegistroInfoCompatibilidad">                           
                        <div class="checkbox col-xs-12">
                          
                        <c:if test="${Docente.infoRegistro[60]=='S'}">
                            <c:set var="checked" value="checked"></c:set>
                            <c:set var="in" value="in"></c:set>
                        </c:if>
                        <c:if test="${Docente.infoRegistro[60]!='S'}">
                            <c:set var="checked" value=""></c:set>
                            <c:set var="in" value=""></c:set>
                        </c:if>
                          
                          <label><input data-toggle="collapse" ${checked} data-target="#seccionOtro" type="checkbox" name="funcionesOtro" id="funcionesOtro">Marque la casilla si desempeña funciones en otro subsistema</label>
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
                              <label><input data-toggle="collapse" data-target="#seccionCompatibilidad" type="checkbox" ${checked} name="compatibilidad" id="compatibilidad">Marque la casilla si cuenta con la compatibilidad requerida</label>
                            </div>
                            <div id="seccionCompatibilidad" class="collapse ${in}" >
                                <div class="form-group col-md-4">
                                    <label class="control-label" for="btnEvidencia7">Constancia de compatibilidad:</label>  
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
                        </div>
                        <div class="col-xs-12 text-right">
                              <c:if test="${!vistaAdmin}">
                                <input  class="btn btn-sm btn-primary" type="reset" value="Limpiar"/>
                                <input class="btn btn-sm btn-primary" id="btnEnviar4" type="submit" value='Guardar y continuar'/>
                              </c:if>
                              <c:if test="${vistaAdmin}">
                                <input class="btn btn-sm btn-primary" id="btnEnviar4" type="submit" value='Validar información'/>
                              </c:if>
                              <!--<input type="button" class="btn btn-sm btn-primary" value="Guardar y continuar" onclick="mostrarSiguiente(1)"/>-->
                            </div>
                      </form>
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
                                <td>Declara bajo protesta de decir verdad que cumple con los requisitos establecidos en la Convocatoria para el proceso de promoción en el servicio docente por cambio de categoría en Educación Media Superior, Ciclo Escolar 2020-2021. Para confirmar su dicho, la DGETI podrá verificar la autenticidad de la documentación que proporciono, por lo que, en caso de alteración o falsificación de la misma, acepta la descalificación inmediata del proceso o, en su caso, la invalidación del nombramiento respectivo, sin perjuicio de las sanciones de tipo administrativo o penal en las que pudiera incurrir.</td>    
                              </tr>
                              <tr>
                                  <td valign="top"><input type="checkbox" name="cbPublico" id="cbPublico" ><td>
                                  <td>Acepta hacer públicos los resultados y recomendaciones individuales que se deriven de su valoración para el proceso de promoción en el servicio docente por cambio de categoría en Educación Media Superior ingreso a la Educación Media Superior, Ciclo Escolar 2020-2021.<td>
                              </tr>
                          </table>
                          </c:if>
                          <c:if test="${vistaAdmin}">
                            <label class="control-label">Observaciones:</label>
                            <textarea class="form-control text-uppercase" id="observaciones" name="observaciones" maxlength="200" onKeyUp="cambioObservaciones()" required>${Docente.infoRegistro[67]}</textarea>
                          </c:if>
                          <br/>                          
                          <input type="submit" disabled="true" class="btn btn-primary" value="Continuar" id="btnFinalizar">                      
                      </div>
                      
                       
                      
                  </form>
              </div>
          </div>               
                            
         <!--MODAL-->                 
         <div id="modalArchivo" class="modal fade" role="dialog">
            <div class="modal-dialog">
              <div class="modal-content">
                <div class="modal-header">
                  <button type="button" class="close" data-dismiss="modal">&times;</button>
                  <h4 class="modal-title" id="tituloModal">Carga de archivos</h4>
                </div>
                <div class="modal-body">
                    <iframe name="ifRespuesta" hidden></iframe>
                    <iframe style="width:100%;" id="ifArchivo" name="ifArchivo" src="" hidden></iframe>
                    <c:if test="${!vistaAdmin}">
                    <form id="formArchivo" name="formArchivo" method="POST" enctype="multipart/form-data" >
                        <div class="form-group">
                            <label class="control-label" for="archivo">Seleccione el archivo a cargar:</label>
                            <input type="hidden" id="idArchivo" name="idArchivo" value="" />
                            <input type="file" class="form-control input-sm" id="archivo" name="archivo" onchange="subirArchivo()" accept=".pdf" />
                        </div>
                    </form>  
                    </c:if>
                    <c:if test="${vistaAdmin}"><p>El documento no puede ser modificado</p></c:if>
                </div>
                <div class="modal-footer">
                  <button type="button" class="btn btn-sm btn-default" data-dismiss="modal">Cerrar</button>
                </div>
              </div>
            </div>
          </div>
         
         <div id="modalEjemplo" class="modal fade" role="dialog">
            <div class="modal-dialog">
              <div class="modal-content">
                <div class="modal-header">
                  <button type="button" class="close" data-dismiss="modal">&times;</button>
                  <h4 class="modal-title" id="tituloModalEjemplo">Carga de archivos</h4>
                </div>
                <div class="modal-body">
                    <iframe style="width:100%;" id="ifArchivoEjemplo" name="ifArchivoEjemplo" src=""></iframe>
                                       
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
                                <input type="text" class="form-control input-sm" id="grupo" name="grupo" required>                                                                 
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
                                <select class="form-control input-sm" id="tipoInfo" name="tipoInfo" onchange="cambioTipoInfo()" required>
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
                      <button type="button" id="btnConfirmacion" class="btn btn-sm btn-default">Confirmar</button>
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
                            <label class="control-label" for="tipoNombramiento">Clave presupuestal:</label>
                            <input type="text" class="form-control input-sm" id="clave" name="clave" required /> 
                        </div>    
                        <div class="form-group col-md-6 datepicker-group">
                          <label class="control-label" for="fechaPlaza" style="font-size: 12px;">Fecha desde que ostenta la plaza:</label>
                          <input class="form-control input-sm" id="fechaPlaza" name="fechaPlaza" type="text"  required>
                        </div>
                      </div>
                      <div class="row">  
                        <div class="form-group col-md-6">
                          <label class="control-label" for="tipoNombramiento">Tipo de nombramiento:</label>
                          <select class="form-control input-sm" id="tipoNombramiento" name="tipoNombramiento" required>                                    
                            ${catalogo.desplegarOpcionesTipoNombramiento()}
                          </select>                          
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
                          <select class="form-control input-sm" id="jornada" name="jornada" onChange="cambioJornada(this)" required>
                              <option value="">-Seleccione-</option>
                          </select>                          
                        </div>
                        <div class="form-group col-md-6 hidden" id="seccionHoras2">
                            <label class="control-label" for="horas">Horas:</label>
                            <input type="text" class="form-control input-sm" id="horas2" name="horas" maxlength="2" /> 
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
         
         <!--FIN MODAL-->                   
                
        </main>
        <script src="https://framework-gb.cdn.gob.mx/gobmx.js"></script>        
        <script src="https://code.jquery.com/jquery-1.12.4.js"></script>      
        <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>  
        <script src="https://framework-gb.cdn.gob.mx/assets/scripts/jquery-ui-datepicker.js"></script>
        <script src="https://ajax.aspnetcdn.com/ajax/jquery.validate/1.13.1/jquery.validate.min.js"></script>
        <script src="js/funcionesRegistro.js"></script> 
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
        
    </body>
</html>

