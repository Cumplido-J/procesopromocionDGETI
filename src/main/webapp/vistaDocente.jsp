<%-- 
    Document   : vistaDocente
    Created on : 17 sep 2020, 15:42:18
    Author     : David Reyna
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@page import='herramientas.Catalogos'%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>DGETI | gob.mx</title>
        <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@500&display=swap" rel="stylesheet">
        <link rel="stylesheet" href="css/estilos.css">
        <link href="/favicon.ico" rel="shortcut icon">
        <link href="https://framework-gb.cdn.gob.mx/assets/styles/main.css" rel="stylesheet">
        <%@page import='herramientas.Imagen'%>
        <%@page import='herramientas.RutaConfig'%>
        <jsp:useBean id="catalogo" class="herramientas.Catalogos" />
        
    </head>
    <body>
        <div>
            <!--  para el framework del gobierno-->
            <nav class="navbar navbar-inverse sub-navbar navbar-fixed-top">
                <div class="container">
                    <div class="navbar-header">
                        <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#subenlaces">
                            <span class="sr-only">Interruptor de Navegación</span>
                            <span class="icon-bar"></span>
                            <span class="icon-bar"></span>
                            <span class="icon-bar"></span>
                        </button>
                        <a class="navbar-brand" href="/">DGETI-CECYTE</a>
                    </div>

                    <div class="collapse navbar-collapse" id="subenlaces">
                        <ul class="nav navbar-nav navbar-right">
                            <li><a href="#"><%=session.getAttribute("nombre").toString()%></a></li>                            
                            <li><a href="busquedaDocente.jsp">Regresar</a></li>
                            <li><a href="Servlet_cerrarsesion">Cerrar Sesión</a></li>
                        </ul>
                    </div>
                </div>
            </nav>
        </div>
        <!--	  Termina para el framework del gobierno-->


        <div class="padre">
            
            <header class="headerart">
                <div class="titulo">
                    <p>Dirección General de Educación Tecnológica Industrial y de Servicios</p>
                </div>
                <div class="texto-principalart margen-interno">
                    <p>Programa de Promoción en el Servicio Docente en Educación Media Superior</p>
                    
                </div>
                <p>${Docente.infoRegistro[1]}
                                &nbsp;
                                ${Docente.infoRegistro[2]}
                                &nbsp;
                                ${Docente.infoRegistro[3]} (Consulta información)</p>
            </header>
            
            <c:set var="finIncompleto" value="false"></c:set>            
            <c:if test = "${Docente.infoRegistro[61]==null||Docente.infoRegistro[66]=='1'}">  <!--Si no ha finalizado el registro-->
                <c:set var="disabled1" value=""></c:set>
                <c:set var="hidden1" value="hidden"></c:set>
                <c:set var="disabled2" value="disabled"></c:set>
                <c:set var="hidden2" value="hidden"></c:set>
                <c:set var="disabled3" value="disabled"></c:set>
                <c:set var="hidden3" value="hidden"></c:set>
                <c:set var="disabled4" value="disabled"></c:set>
                <c:set var="hidden4" value="disabled"></c:set>
                <c:set var="disabled5" value="disabled"></c:set>
            </c:if>
            
            <c:if test = "${Docente.infoRegistro[61]!=null&&Docente.infoRegistro[66]!='1'}">  <!--Si ya finalizó el registro-->
                <c:set var="disabled1" value="disabled"></c:set>
                <c:set var="disabled4" value="disabled"></c:set>
                <c:set var="disabled5" value="disabled"></c:set>                
                <c:if test = "${Docente.infoRegistro[66]=='3'}"><!--Si el registro finalizó como incompleto-->
                    <c:set var="finIncompleto" value="true"></c:set>
                </c:if>
                <c:if test = "${Docente.infoRegistro[66]=='2'}"><!--Si el registro finalizó como completo-->
                    <c:set var="finCompleto" value="true"></c:set>
                </c:if>
                <c:if test = "${Docente.totalEncuestados<30}"> <!--Si no ha registrado a 30 encuestados-->
                    <c:set var="disabled2" value=""></c:set>
                    <c:set var="hidden2" value="hidden"></c:set>
                    <c:set var="disabled3" value=""></c:set>
                    <c:set var="hidden3" value="hidden"></c:set>
                </c:if>
            </c:if>
            
            <c:if test = "${Docente.totalEncuestados==30}"> <!--Si ya registró a 30 encuestados-->
                    <c:set var="disabled2" value=""></c:set>
                    <c:set var="hidden2" value=""></c:set>
            </c:if>
            
            <c:if test = "${Docente.infoRegistro[66]>=6}">
                        <c:set var="disabled3" value="disabled"></c:set>
                        <c:set var="hidden3" value=""></c:set>
                        <c:set var="disabled4" value=""></c:set>
                        <c:set var="hidden4" value=""></c:set>    
            </c:if>
            
            <c:if test = "${Docente.documentoCargado3('1')==true}"><!--Si la carta aceptacion fue cargada correctamente-->
                    <c:set var="disabled4" value=""></c:set>
                    <c:set var="hidden4" value=""></c:set>
                    <c:set var="disabled5" value=""></c:set>                    
            </c:if>
                
            <c:if test='${sessionScope["fechaDictaminacion"]=="1"}'>
                <c:set var="disabled1" value="disabled"></c:set>
                <c:set var="hidden1" value="hidden"></c:set>
                <c:set var="disabled2" value="disabled"></c:set>
                <c:set var="hidden2" value="hidden"></c:set>
                <c:set var="disabled3" value="disabled"></c:set>
                <c:set var="hidden3" value="hidden"></c:set>
                <c:set var="disabled4" value="disabled"></c:set>
                <c:set var="hidden4" value="disabled"></c:set>
                <c:set var="disabled5" value="disabled"></c:set>
                <c:set var="disabled6" value=""></c:set>
            </c:if>
            
            <div class="articulosses">
                <c:if test = "${!finIncompleto}">
                    <article class="articleses">
                        <h3>Paso 1 </h3>
                        <a  href="Registro" ><img src="<%=Imagen.muestraImagen(RutaConfig.getRutaCarpeta()+"imagenes/EvidReg.jpg")%>" alt=""></a>
                        <a  href="Registro" ><h3>Registro de aspirante</h3></a>
                    </article>                    
                </c:if>
               
                <c:if test = "${finIncompleto}">
                    <c:set var="finIncompleto" value="true"></c:set>
                    <article class="articleses ">
                        
                        <a href="FichaRegistroIncompleto" target="_blank"><img src="<%=Imagen.muestraImagen(RutaConfig.getRutaCarpeta()+"imagenes/EvidVal.jpg")%>" alt=""></a>
                        <a href="FichaRegistroIncompleto" target="_blank"><h3>Ficha de registro incompleto</h3></a>
                    </article>
                </c:if>
                <c:if test = "${!finIncompleto}">
                    <article class="articleses">
                        <h3>Paso 2: </h3>
                        <a href="RegistroEncuestados"><img src="<%=Imagen.muestraImagen(RutaConfig.getRutaCarpeta()+"imagenes/EvidReg.jpg")%>" alt=""></a>
                        <a href="RegistroEncuestados"><h3>Registro encuestados</h3></a>                        
                    </article>

                    <article class="articleses ">
                        <h3>Paso 3: </h3>
                        <a href="RegistroCriterios" ><img src="<%=Imagen.muestraImagen(RutaConfig.getRutaCarpeta()+"imagenes/EvidReg.jpg")%>" alt=""></a>
                        <a href="RegistroCriterios" ><h3>Evidencias de los criterios de valoración</h3></a>
                    </article>
                    <article class="articleses ">
                        <h3>Paso 4: </h3>
<!--                                <a title="Ver ejemplo" onclick="abrirModalEjemplo(1)"></a>
                                  <a><img src="<%=Imagen.muestraImagen(RutaConfig.getRutaCarpeta()+"imagenes/EvidReg.jpg")%>" alt=""></a><br> -->
                                <c:if test = "${Docente.documentoCargado3('1')==true}">
                                    <a href="#" onclick="abrirModalArchivoCarta(1)"><img src="<%=Imagen.muestraImagen(RutaConfig.getRutaCarpeta()+"imagenes/EvidVal.jpg")%>" alt=""></a>
                                    <input id="btnEvidencia1" type="button" class="btn btn-sm btn-link" value="Ver documento" onclick="abrirModalArchivoCarta(1)"/>
                                    <a onclick="abrirModalArchivoCarta(1)" ><h3>Carta de aceptación</h3></a>
                                </c:if>
                                <c:if test = "${Docente.documentoCargado3('1')==false}">
                                    <a onclick="abrirModalArchivoCarta(1)" ><img src="<%=Imagen.muestraImagen(RutaConfig.getRutaCarpeta()+"imagenes/EvidReg.jpg")%>" alt=""></a>
                                    <input id="btnEvidencia1" type="button" class="btn btn-sm btn-link incompleto" value="Subir" onclick="abrirModalArchivoCarta(1)"/>
                                    <a onclick="abrirModalArchivoCarta(1)" ><h3>Carta de aceptación</h3></a>
                                </c:if> 
<!--                        <input id="btnEvidencia2" type="button" class="btn btn-sm btn-link incompleto" value="Subir archivo" onclick="abrirModalArchivo(2)"/>
                        <span class="glyphicon glyphicon-exclamation-sign incompleto" id="alertaBtnEvidencia2" title="Sección incompleta"></span>-->
                    </article>
                    <c:if test='${sessionScope["permisoActual"]=="5"}'>
                        
                            <article class="articleses">
                                <h3>Paso 5:</h3>
                                <a href="FichaRegistroClon" target="_blank" ><img src="<%=Imagen.muestraImagen(RutaConfig.getRutaCarpeta()+"imagenes/EvidVal.jpg")%>" alt=""></a>
                                <a href="FichaRegistroClon"  target="_blank" ><h3>Ficha de <br/> registro Docente</h3></a>
                            </article>
                           
                    </c:if>            
                    <c:if test='${sessionScope["permisoActual"]!="5"}'>
                        <article class="articleses">
                            <h3>Paso 5:</h3>
                            <a href="FichaRegistroClon" target="_blank" ><img src="<%=Imagen.muestraImagen(RutaConfig.getRutaCarpeta()+"imagenes/EvidVal.jpg")%>" alt=""></a>
                            <a href="FichaRegistroClon"  target="_blank" ><h3>Ficha de <br/> registro Docente</h3></a>
                        </article>
                    </c:if>
                    <c:if test='${sessionScope["permisoActual"]!="5"}'>            
                        <article class="articleses">
                            <h3>Paso 5.1:</h3>
                            <a href="FichaRegistro" target="_blank" ><img src="<%=Imagen.muestraImagen(RutaConfig.getRutaCarpeta()+"imagenes/EvidVal.jpg")%>" alt=""></a>
                            <a href="FichaRegistro"  target="_blank" ><h3>Ficha de <br/>revisor </h3></a>
                        </article>
                    </c:if>
                </c:if>
                    <c:if test='${sessionScope["permisoActual"]=="5" || sessionScope["permisoActual"]=="6"}'>
                        <c:if test = "${!finIncompleto}">
                            <article class="articleses ">
                                <h3>Paso 6: </h3>
                                <%--                                <a title="Ver ejemplo" onclick="abrirModalEjemplo(1)"></a>
                                                                  <a><img src="<%=Imagen.muestraImagen(RutaConfig.getRutaCarpeta() + "imagenes/EvidReg.jpg")%>" alt=""></a><br> --%>
                                <c:if test = "${Docente.documentoCargado4('1')==true}">
                                    <a href="#" onclick="abrirModalRevisorFile(1)"><img src="<%=Imagen.muestraImagen(RutaConfig.getRutaCarpeta() + "imagenes/EvidVal.jpg")%>" alt=""></a>
                                    <input id="btnEvidenciaR" type="button" class="btn btn-sm btn-link" value="Ver documento" onclick="abrirModalRevisorFile(1)"/>
                                    <a onclick="abrirModalRevisorFile(1)" ><h3>Lista de cotejo <br/>de revisor</h3></a>
                                </c:if>
                                <c:if test = "${Docente.documentoCargado4('1')==false}">
                                    <a onclick="abrirModalRevisorFile(1)" ><img src="<%=Imagen.muestraImagen(RutaConfig.getRutaCarpeta() + "imagenes/EvidReg.jpg")%>" alt=""></a>
                                    <input id="btnEvidenciaR" type="button" class="btn btn-sm btn-link incompleto" value="" onclick="abrirModalRevisorFile(1)"/>
                                    <a onclick="abrirModalRevisorFile(1)" ><h3>Lista de cotejo <br/>de revisor</h3></a>
                                </c:if>
                            </article>
                        </c:if>
                    </c:if>
                    <!--<c:if test='${sessionScope["permisoActual"]=="5"}'>
                    <article id="pasoFicha" for="pasoFicha" name="pasoFicha" class="articleses" >
                            <h3>Paso 7:</h3>
                            <a href="FichaDictamen" target="_blank" ><img src="<%=Imagen.muestraImagen(RutaConfig.getRutaCarpeta()+"imagenes/EvidVal.jpg")%>" alt=""></a>
                            <a href="FichaDictamen"  target="_blank" ><h3>Ficha de <br/> dictamen </h3></a>
                    </article>
                    </c:if>-->
                    <c:if test='${sessionScope["permisoActual"]=="6"}'>
                                    <c:if test = "${!finIncompleto}">
                            <article id="pasoFicha" for="pasoFicha" name="pasoFicha" class="articleses" >
                                    <h3>Paso 7:</h3>
                                    <a href="FichaDictamen" target="_blank" ><img src="<%=Imagen.muestraImagen(RutaConfig.getRutaCarpeta()+"imagenes/EvidVal.jpg")%>" alt=""></a>
                                    <a href="FichaDictamen"  target="_blank" ><h3>Ficha de <br/> dictamen </h3></a>
                            </article>
                                    </c:if>
                    </c:if>
                    <c:choose>
                        <c:when test='${sessionScope["permisoActual"]=="6"}'>
                                        <c:if test = "${!finIncompleto}">
                                <article class="articleses">
                                    <form id="formFinal" role="form" action="RevisionFinal" method="POST">
                                        <h3></h3>
                                        <a href=""  target="_blank" ><h3>Revision final:</h3></a>
                                        <c:if test='${sessionScope["permisoActualEdicion"]=="F"}'>
                                            <select class="form-control input-sm" id="revisionfinal" name="revisionfinal" required disabled>
                                                ${catalogo.desplegarCatalogosEstatusFinal(sessionScope["idDocente"])}                                
                                            </select>
                                        </c:if>
                                        <c:if test='${sessionScope["permisoActualEdicion"]=="V"}'>
                                            <select class="form-control input-sm" id="revisionfinal" name="revisionfinal" required>
                                                ${catalogo.desplegarCatalogosEstatusFinal(sessionScope["idDocente"])}                                
                                            </select>
                                        </c:if>
                                        <c:if test = "${validacionConvocatoria >= 0 || sessionScope['permisoTablaUsuarioEdicion']=='V'}">
                                            <div style="margin-top: 10px;">
                                                <c:if test='${sessionScope["permisoActualEdicion"]=="F"}'>
                                                    <input class="btn btn-sm btn-primary" id="btnEnviarCurso" type="submit" value='Guardar' style="margin-right: 105px;" disabled=""/>
                                                </c:if>
                                                <c:if test='${sessionScope["permisoActualEdicion"]=="V"}'>
                                                    <input class="btn btn-sm btn-primary" id="btnEnviarCurso" type="submit" value='Guardar' style="margin-right: 105px;"/>
                                                </c:if>
                                            </div>
                                       </c:if>
                                    </form>
                                </article>
                                        </c:if>
                        </c:when>
                    </c:choose>        
                <!--
                <article class="articleses">
                    <h3>Paso 5:<span class="glyphicon glyphicon-ok-sign completo hidden" title="Sección completa"></span></h3>
                    <a href="articulo.html" class="disabled"><img src="<%=Imagen.muestraImagen(RutaConfig.getRutaCarpeta()+"imagenes/Resultados.jpg")%>" alt=""></a>
                    <a href="articulo.html" class="disabled"><h3>Emisión de Resultados</h3></a>
                </article>-->
                  
            </div>
        </div>
        <div class="modal fade" id="modalCriterios" role="dialog">
            <div class="modal-dialog">

              <!-- Modal content-->
              <div class="modal-content panel">
                <div class="modal-header">
                  <button type="button" class="close" data-dismiss="modal">&times;</button>
                  <h4 class="modal-title">Criterios de valoración</h4>
                </div>
                <div class="modal-body" style="font-size:10px;text-align:justify">
                  <p >La Promoción en el servicio docente por cambio de categoría se llevará a cabo mediante un proceso de selección respecto al cumplimiento de los criterios de valoración establecidos por la Ley General del Sistema para la Carrera de las Maestras y los Maestros listados a continuación:</p>
                  <table class="table table-responsive">
                      <tr>
                          <th>No.</th>
                          <th>Criterio</th>
                      </tr>
                      <tr>
                          <td>1</td>
                          <td>Antig&uuml;edad en el servicio.</td>
                      </tr>
                      <tr>
                          <td>2</td>
                          <td>Experiencia y tiempo de trabajo en zonas de marginación, pobreza y descomposición social. </td>
                      </tr>
                      <tr>
                          <td>3</td>
                          <td>El reconocimiento al buen desempeño por la comunidad educativa, con la participación de madres y padres de familia o tutores, alumnos y compañeros de trabajo.
                              <br/><span class="text-danger"><span class="glyphicon glyphicon-info-sign"></span>El docente deberá registrar (en el "Paso 2") diez personas de la comunidad educativa, diez madres y padres de familia o tutores y diez compañeros de trabajo a quienes se le aplicará una encuesta que permitirá evaluar este criterio.</span>
                          </td>
                      </tr>
                      <tr>
                          <td>4</td>
                          <td>La formación académica y de posgrado. </td>
                      </tr>
                      <tr>
                          <td>5</td>
                          <td>La capacitación y actualización.</td>
                      </tr>
                      <tr>
                          <td>6</td>
                          <td>Las aportaciones en materia de mejora continua en la educación, la docencia o la investigación.</td>
                      </tr>
                      <tr>
                          <td>7</td>
                          <td>Participación en eventos y actividades de fortalecimiento académico y formación integral del educando. </td>
                      </tr>
                      <tr>
                          <td>8</td>
                          <td>Actividades de tutoría o acompañamiento docente.</td>
                      </tr>
                      <tr>
                          <td>9</td>
                          <td>Las publicaciones académicas o de investigación. </td>
                      </tr>
                      <tr>
                          <td>10</td>
                          <td>El desempeño en el plantel o subsistema en el que realice su labor.</td>
                      </tr>
                  </table>
                </div>
                <div class="modal-footer">                  
                  <button type="button" class="btn btn-sm btn-default" data-dismiss="modal">Cerrar</button>
                </div>
              </div>

            </div>
          </div>
        <div id="modalArchivo" class="modal fade" role="dialog">
            <div class="modal-dialog">
              <div class="modal-content" style="width: 700px;height: 672px;">
                <div class="modal-header">
                  <button type="button" class="close" data-dismiss="modal">&times;</button>
                  <h4 class="modal-title" >Carta de aceptación</h4>
                </div>
                <div class="modal-body">
                    <iframe name="ifRespuesta" hidden></iframe>
                    <iframe style="width:100%;height: 338px;" id="ifArchivo" name="ifArchivo" src="" hidden></iframe>
                    <div id="seccionCarga">
                                                <c:if test = "${validacionConvocatoria >= 0 || sessionScope['permisoTablaUsuarioEdicion']=='V'}">
                        <form id="formArchivo" name="formArchivo" method="POST" enctype="multipart/form-data" >
                                <label class="text-warning" id="alertaCarga"><span class="glyphicon glyphicon-warning-sign"></span>&nbsp;Cárgue su archivo de evidencia ya firmado.</label>
                                <label class="control-label" for="archivo">Seleccione el archivo a cargar:</label>
                                <input type="hidden" id="idArchivo" name="idArchivo" value="" />
                                <input type="file" class="form-control input-sm" id="archivoCarta" name="archivoCarta" onchange="subirArchivo_();" accept=".pdf" />
                        </form>
                                                </c:if>
                    </div>
                </div>
                <div class="modal-footer">
                  <button type="button" class="btn btn-sm btn-default" data-dismiss="modal">Cerrar</button>
                </div>
              </div>
            </div>
        </div>
        
        <div id="modalArchivoR" class="modal fade" role="dialog">
            <div class="modal-dialog">
              <div class="modal-content" style="width: 700px;height: 672px;">
                <div class="modal-header">
                  <button type="button" class="close" data-dismiss="modal">&times;</button>
                  <h4 class="modal-title" >Lista de cotejo de revisor</h4>
                </div>
                <div class="modal-body">
                    <iframe name="ifArchivoRevisor" hidden></iframe>
                    <iframe style="width:100%;height: 338px;" id="ifArchivoRevisor" name="ifArchivoRevisor" src="" hidden></iframe>
                    <div id="seccionCarga">
                        <form id="formArchivo1" name="formArchivo1" method="POST" enctype="multipart/form-data" >
                                <label class="text-warning" id="alertaCarga"><span class="glyphicon glyphicon-warning-sign"></span>&nbsp;Cárgue su archivo de evidencia ya firmado.</label>
                                <label class="control-label" for="archivo">Seleccione el archivo a cargar:</label>
                                <input type="hidden" id="idArchivoR" name="idArchivoR" value="1" />
                                <input type="file" class="form-control input-sm" id="archivoCartaRevisor" name="archivoCartaRevisor" onchange="subirArchivoR_();" accept=".pdf" />
                                <c:if test = '${sessionScope["programa"]=="1"}'>
                                <a href="descargas/listadecotejoparaelcomitérevisorcambiodecategoría10092021.pdf" download>
                                    Descarga lista de cotejo revisor
                                </a>
                                </c:if>
                                <c:if test = '${sessionScope["programa"]=="2"}'>
                                <a href="descargas/listadecotejoparaelcomitérevisorhorasadicionales10092021.pdf" download>
                                    Descarga lista de cotejo revisor
                                </a>
                                </c:if>
                        </form>  
                    </div>
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
        <!-- JS  para el framework del gobierno-->
        <script src="https://framework-gb.cdn.gob.mx/gobmx.js"></script>        
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
        <script src="https://framework-gb.cdn.gob.mx/assets/scripts/jquery-ui-datepicker.js"></script>
        <script src="https://ajax.aspnetcdn.com/ajax/jquery.validate/1.13.1/jquery.validate.min.js"></script>
        <script src="js/funcionesRegistro.js"></script> 
        <script>
            function subirArchivo_(){
                $("#modalArchivo").modal("hide");

                if(validaArchivo_()){
                    document.formArchivo.target="ifRespuesta";
                    document.formArchivo.action="GuardarArchivo";
                    document.formArchivo.submit();
                    var id=$("#idArchivo").val(); 
                    $("#btnEvidencia"+id).attr("value","Ver documento");
                    $("#alertaBtnEvidencia"+id).attr("style","display:none;");
                    $("#mensaje").html("El archivo fue cargado correctamente");
                }
                $("#modalMensaje").modal("show");
            }
            function subirArchivoR_(){
                $("#modalArchivo").modal("hide");

                if(validaArchivoR_()){
                    document.formArchivo1.target="ifArchivoRevisor";
                    document.formArchivo1.action="GuardarArchivo";
                    document.formArchivo1.submit();
                    var id=$("#idArchivoR").val(); 
                    $("#btnEvidenciaR").attr("value","Ver documento");
                    $("#alertaBtnEvidencia"+id).attr("style","display:none;");
                    $("#mensaje").html("El archivo fue cargado correctamente");
                }
                $("#modalMensaje").modal("show");
            }
function validaArchivo_(){
    var retorno=true;
    var elemento=document.getElementById("archivoCarta");
    var fileName = elemento.files[0].name;
    var fileSize = elemento.files[0].size;

    if(fileSize > 1000000){
            $("#mensaje").html("El archivo no debe superar 1MB");    
            elemento.value = '';
            retorno=false;
    }else{
            var ext = fileName.split('.').pop();
            ext = ext.toLowerCase();            
            if(ext!="pdf"){
               $("#mensaje").html("Solo se aceptan archivos PDF"); 
               elemento.value = ''; // reset del valor               
               retorno=false;
            }            
    }
    return retorno;
}
function validaArchivoR_(){
    var retorno=true;
    var elemento=document.getElementById("archivoCartaRevisor");
    var fileName = elemento.files[0].name;
    var fileSize = elemento.files[0].size;

    if(fileSize > 1000000){
            $("#mensaje").html("El archivo no debe superar 1MB");    
            elemento.value = '';
            retorno=false;
    }else{
            var ext = fileName.split('.').pop();
            ext = ext.toLowerCase();            
            if(ext!="pdf"){
               $("#mensaje").html("Solo se aceptan archivos PDF"); 
               elemento.value = ''; // reset del valor               
               retorno=false;
            }            
    }
    return retorno;
}
        </script>
        <script>
            function abrirModalArchivoCarta(id){    
                if($("#btnEvidencia"+id).attr("value")=="Ver documento"){
                    $("#ifArchivo").attr("src","Archivo?i="+id); 
                    $("#ifArchivo").removeAttr("hidden");
                }else{
                    $("#ifArchivo").attr("src","Archivo?i="+id); 
                    $("#ifArchivo").removeAttr("hidden");
                }

                $("#idArchivo").val(id);
                
                $("#modalArchivo").modal("show");
            }
            function abrirModalRevisorFile(id){    
                if($("#btnEvidenciaR").attr("value")=="Ver documento"){
                    $("#ifArchivoRevisor").attr("src","Archivo?z="+id); 
                    $("#ifArchivoRevisor").removeAttr("hidden");
                }else{
                    $("#ifArchivoRevisor").attr("src","Archivo?z="+id); 
                    $("#ifArchivoRevisor").removeAttr("hidden");
                }

                $("#idArchivoR").val(id);
                
                $("#modalArchivoR").modal("show");
            }
        </script>
    </body>
</html>
