<%-- 
    Document   : vistaDocente
    Created on : 17 sep 2020, 15:42:18
    Author     : David Reyna
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
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
                        <a class="navbar-brand" href="/">DGETI</a>
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
            <c:if test = "${Docente.infoRegistro[61]==null}">  <!--Si no ha finalizado el registro-->
                <c:set var="disabled1" value=""></c:set>
                <c:set var="hidden1" value="hidden"></c:set>
                <c:set var="disabled2" value="disabled"></c:set>
                <c:set var="hidden2" value="hidden"></c:set>
                <c:set var="disabled3" value="disabled"></c:set>
                <c:set var="hidden3" value="hidden"></c:set>
            </c:if>
            <c:if test = "${Docente.infoRegistro[61]!=null}">  <!--Si ya finalizó el registro-->
                <c:set var="disabled1" value="disabled"></c:set>
                <c:set var="hidden1" value=""></c:set>
                <c:if test = "${Docente.infoRegistro[63]==null}"><!--Si el registro finalizó como incompleto-->
                    <c:set var="finIncompleto" value="true"></c:set>
                </c:if>
                <c:if test = "${Docente.infoRegistro[63]!=null}"><!--Si el registro finalizó como completo-->
                    <c:set var="finCompleto" value="true"></c:set>
                </c:if>
                <c:if test = "${Docente.totalEncuestados<30}"> <!--Si no ha registrado a 30 encuestados-->
                    <c:set var="disabled2" value=""></c:set>
                    <c:set var="hidden2" value="hidden"></c:set>
                    <c:set var="disabled3" value=""></c:set>
                    <c:set var="hidden3" value="hidden"></c:set>                    
                </c:if>
                <c:if test = "${Docente.totalEncuestados==30}"> <!--Si ya registró a 30 encuestados-->
                    <c:set var="disabled2" value="disabled"></c:set>
                    <c:set var="hidden2" value=""></c:set>
                    <c:set var="disabled3" value=""></c:set>
                    <c:set var="hidden3" value="hidden"></c:set>
                </c:if>
            </c:if>
            
            <div class="articulosses">
                <article class="articleses">
                    <h3>Paso 1 </h3>
                    <a  href="Registro" ><img src="<%=Imagen.muestraImagen(RutaConfig.getRutaCarpeta()+"imagenes/EvidReg.jpg")%>" alt=""></a>
                    <a  href="Registro" ><h3>Registro de aspirante</h3></a>
                </article>                    
                
               
                <c:if test = "${finIncompleto}">
                    <c:set var="finIncompleto" value="true"></c:set>
                    <article class="articleses ">
                        <h3>Paso 2:</h3>
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
                    <article class="articleses">
                        <h3>Paso 4:</h3>
                        <a href="FichaRegistro" target="_blank" ><img src="<%=Imagen.muestraImagen(RutaConfig.getRutaCarpeta()+"imagenes/EvidVal.jpg")%>" alt=""></a>
                        <a href="FichaRegistro"  target="_blank" ><h3>Ficha de <br/> registro </h3></a>
                    </article>
                </c:if>
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
        <!-- JS  para el framework del gobierno-->
        <script src="https://framework-gb.cdn.gob.mx/gobmx.js"></script>        
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
        
    </body>
</html>
