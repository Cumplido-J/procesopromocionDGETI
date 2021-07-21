<%-- 
    Document   : registroEncuestados
    Created on : 6 ago 2020, 12:50:07
    Author     : David Reyna
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>DGETI | gob.mx</title>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">        
        <link href="https://framework-gb.cdn.gob.mx/assets/styles/main.css" rel="stylesheet">
        <link href="css/estilosRegistro.css" rel="stylesheet"/>        
        <jsp:useBean id="mensaje" class="com.aplicacion.beans.Mensaje" />
        <jsp:useBean id="catalogo" class="herramientas.Catalogos" />        
    </head>
    <body>
         <c:if test='${sessionScope["rol"]=="D"}'> 
            <c:if test = "${docente.infoRegistro[61]==null||Docente.infoRegistro[66]=='1'}">
             <%
                response.sendRedirect("/procesopromocion/SesionDocente");
             %>   
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
                        <li><a href="SesionDocente">Regresar</a></li>
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
                <li class="active">Registro de encuestados</li>
              </ol>
              <!--FIN Breadcrumbs-->
              <div class="container">
                  A continuación se muestran tres secciones, en cada una deberá registrar el CURP y correo de diez personas para la aplicación de encuestas.
                  <br/><br/>
              </div>
              <c:if test="${!vistaAdmin}">
              <div class="text-center">
                <input type="button" class="btn btn-link btn-sm" id="btnAgregar" value="(+) Agregar información" onClick="mostrarModal()"/>
                <br/><br/>
              </div>
              </c:if>
              <ul class="nav nav-tabs">                  
                <li class="active">
                    <a data-toggle="tab" href="#seccion1">Alumnos
                    <c:if test="${filas[0][1]=='10'}">
                        <span class="glyphicon glyphicon-ok-sign completo" title="Sección completa" id="estatus1" completo="true"></span>                                        
                    </c:if>
                    <c:if test="${filas[0][1]!='10'}">
                        <span class="glyphicon glyphicon-exclamation-sign incompleto" title="Sección incompleta" id="estatus1" completo="false"></span>
                    </c:if>                    
                    </a>
                </li>                
                <li>
                    <a data-toggle="tab" href="#seccion2">Compañeros de trabajo
                    <c:if test="${filas[1][1]=='10'}">
                        <span class="glyphicon glyphicon-ok-sign completo" title="Sección completa" id="estatus2" completo="true"></span>                                        
                    </c:if>
                    <c:if test="${filas[1][1]!='10'}">
                        <span class="glyphicon glyphicon-exclamation-sign incompleto" title="Sección incompleta" id="estatus2" completo="false"></span>
                    </c:if> 
                    </a>
                </li>
                <li>
                    <a data-toggle="tab" href="#seccion3">Madres y padres de familia o tutores
                    <c:if test="${filas[2][1]=='10'}">
                        <span class="glyphicon glyphicon-ok-sign completo" title="Sección completa" id="estatus3" completo="true"></span>                                        
                    </c:if>
                    <c:if test="${filas[2][1]!='10'}">
                        <span class="glyphicon glyphicon-exclamation-sign incompleto" title="Sección incompleta" id="estatus3" completo="false"></span>
                    </c:if> 
                    </a>
                </li>
              </ul>             

              <div class="tab-content">               
                  <div id="seccion1" class="tab-pane fade in active">
                      <div>
                      <table class="table table-striped table-condensed tablaEncuestado">
                      <thead>
                        <tr>
                          <th>CURP</th>
                          <th>Correo</th>
                          <th>Opciones</th>
                          <th>PIN</th>
                        </tr>                        
                      </thead>
                      <tbody id="tabla1">
                          <c:if test="${filas[0][0]==''}">
                            <tr>
                                <td colspan="3">Sin información</td>
                            </tr> 
                          </c:if>
                          <c:if test="${filas[0][0]!=''}">
                              ${filas[0][0]}
                          </c:if>
                      </tbody>
                  </table>
                </div>
                      <div class="text-right"><span id="c1"><c:out value="${filas[0][1]}"></c:out></span> de 10 registrados</div>
                </div>
                <div id="seccion2" class="tab-pane fade">
                    <div>
                  <table class="table table-striped table-condensed tablaEncuestado">
                      <thead>
                        <tr>
                          <th>CURP</th>
                          <th>Correo</th>
                          <th>Opciones</th>
                          <th>PIN</th>
                        </tr>                        
                      </thead>
                      <tbody id="tabla2">
                          <c:if test="${filas[1][0]==''}">
                            <tr>
                                <td colspan="3">Sin información</td>
                            </tr> 
                          </c:if>
                          <c:if test="${filas[1][0]!=''}">
                              ${filas[1][0]}
                          </c:if>
                      </tbody>
                  </table>
                        </div>
                  <div class="text-right"><span id="c2"><c:out value="${filas[1][1]}"></c:out></span> de 10 registrados</div>
                </div>                
                <div id="seccion3" class="tab-pane fade">
                    <div>
                  <table class="table table-striped table-condensed tablaEncuestado">
                      <thead>
                        <tr>
                          <th>CURP</th>
                          <th>Correo</th>
                          <th>Opciones</th>
                          <th>PIN</th>
                        </tr>                        
                      </thead>
                      <tbody id="tabla3">
                          <c:if test="${filas[2][0]==''}">
                            <tr>
                                <td colspan="3">Sin información</td>
                            </tr> 
                          </c:if>
                          <c:if test="${filas[2][0]!=''}">
                              ${filas[2][0]}
                          </c:if>
                      </tbody>
                  </table></div>
                  <div class="text-right"><span id="c3"><c:out value="${filas[2][1]}"></c:out></span> de 10 registrados</div>
                </div>
              </div>
              <c:if test="${vistaAdmin}">
                <div class="container text-center">
                    <form action="FinalizaEncuestados" method="POST">
                        <label class="control-label">Observaciones:</label>
                        <textarea class="form-control text-uppercase" id="observaciones" name="observaciones" maxlength="2000" onChange="cambioObservaciones(this)" required>${docente.infoRegistro[68]}</textarea>                      
                        <br/>
                        <input type="submit" disabled="true" class="btn btn-primary" value="Continuar" id="btnFinalizar">                      
                    </form>
                </div>
              </c:if>
              <c:if test="${!vistaAdmin}">
              <div class="text-center">
                  <a href="RegistroCriterios" class="btn btn-primary disabled" id="btnFinalizar">Continuar</a>
              </div>
              </c:if>
            </div> 
            
        </main>        
                
        <div id="modalConfirmacion" class="modal fade" role="dialog">
            <div class="modal-dialog">
              <div class="modal-content">
                <div class="modal-header">
                  <button type="button" class="close" data-dismiss="modal">&times;</button>
                  <c:if test="${!vistaAdmin}">
                  <h4 class="modal-title" >Confirmación</h4>
                  </c:if>
                  <c:if test="${vistaAdmin}">
                  <h4 class="modal-title" >Aviso</h4>
                  </c:if>
                </div>
                <c:if test="${!vistaAdmin}">
                    <div class="modal-body">
                        <p>La información seleccionada será borrada<br/>¿Desea continuar?</p>                  
                    </div>
                    <div class="modal-footer">
                      <button type="button" id="btnCancelaPin" class="btn btn-sm btn-default">Sí</button>
                      <button type="button" class="btn btn-sm btn-default" data-dismiss="modal">No</button>
                    </div>
                </c:if>
              <c:if test="${vistaAdmin}">
                  <div class="modal-body">
                    <p>La información seleccionada no puede ser borrada</p>                  
                </div>
              </c:if>
              </div>
            </div>
        </div>
        <div class="modal fade" id="modalRegistro" role="dialog">
            <div class="modal-dialog">

              <!-- Modal content-->
              <div class="modal-content panel">
                  <form id="formRegistro" action="RegistroEncuestado" method="POST">
                    <div class="modal-header">
                      <button type="button" class="close" data-dismiss="modal">&times;</button>
                      <h4 class="modal-title">Registro</h4>
                    </div>
                    <div class="modal-body">
                        <div class="row">
                            <div class="text-center"><h4 class="text-danger" id="respuesta"></h4></div>
                            <div class="form-group col-md-6">
                                <label class="control-label" for="curp">CURP encuestado:</label>
                                <input type="text" class="form-control input-sm" id="curp" name="curp" maxlength="18" onChange="cambioEncuesta()" required>                                                                 
                                <label class="error" id="alertaCURP" hidden >CURP inválido, verifique en <a href="https://www.gob.mx/curp/" target="_blank">RENAPO</a></label>
                            </div>
                            <div class="form-group col-md-6">
                                <label class="control-label" for="correo">Correo encuestado:</label>
                                <input type="text" class="form-control input-sm" id="correo" name="correo" onChange="cambioEncuesta()" required>  
                                <label class="error" id="alertaCorreo" hidden >Correo inválido</label>
                            </div>
                        </div>
                        <div class="row">
                            <div class="form-group col-md-6">
                                <label class="control-label" for="tipoEncuesta">Tipo encuesta:</label>
                                <select class="form-control input-sm" id="tipoEncuesta" name="tipoEncuesta" onChange="cambioEncuesta()" required>
                                    <option value=''>-Seleccione-</option>
                                    <option value="1">A alumnos</option>
                                    <option value="2">A compañeros de trabajo</option>
                                    <option value="3">A madres y padres de familia o tutores</option>
                                </select> 
                            </div>
                        </div>
                        <div id="seccionConfirmacion" hidden>
                            <p>La información ingresada no podrá ser modificada.<br/>¿Confirma que los datos ingresados son correctos?</p>                                          
                        </div>
                    </div>                    
                    <div class="modal-footer"> 
                        <div id="seccionBotonesConfirmacion" hidden>
                            <button type="button" class="btn btn-sm btn-default" id="btnSi" onclick="enviar()">Sí</button>
                            <button type="button" class="btn btn-sm btn-default" onclick="cancelar()">No</button>
                        </div>
                        <div id="seccionBotones">
                            <button type="submit" class="btn btn-sm btn-default" id="btnEnviar">Registrar</button>
                            <button type="button" class="btn btn-sm btn-default" data-dismiss="modal">Cancelar</button>
                        </div>
                    </div>
                  </form>
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

        <script src="https://framework-gb.cdn.gob.mx/gobmx.js"></script>
        <script src="https://code.jquery.com/jquery-1.12.4.js"></script>   
        <script src="https://ajax.aspnetcdn.com/ajax/jquery.validate/1.13.1/jquery.validate.min.js"></script>
        <script src="js/funcionesEncuestados.js"></script> 
    </body>
</html>
