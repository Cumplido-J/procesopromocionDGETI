<%-- 
    Document   : ppsesion
    Created on : 01-jun-2020, 12:57:56
    Author     : charl
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Unidad de Educación Media Superior Tecnológica Industrial y de Servicios | gob.mx</title>
        <link rel="stylesheet" href="css/all.css">
        <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@500&display=swap" rel="stylesheet">
        <link rel="stylesheet" href="css/estilos.css">
        <link href="/favicon.ico" rel="shortcut icon">
        <link href="https://framework-gb.cdn.gob.mx/assets/styles/main.css" rel="stylesheet">
        <%@page import='herramientas.Imagen'%>
        
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
                        <a class="navbar-brand" href="/">UEMSTIS</a>
                    </div>

                    <div class="collapse navbar-collapse" id="subenlaces">
                        <ul class="nav navbar-nav navbar-right">
                            <li aling="navbar-center">
                                <a class="text-uppercase">${Docente.infoRegistro[1]}
                                &nbsp;
                                ${Docente.infoRegistro[2]}
                                &nbsp;
                                ${Docente.infoRegistro[3]}</a>
                            </li>
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
                    <p>Unidad de Educación Media Superior Tecnológica Industrial y de Servicios</p>
                </div>
                <div class="texto-principalart margen-interno">
                    <p>Programa de Promoción en el Servicio Docente en Educación Media Superior</p>
                </div>
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
                <c:if test = "${Docente.totalEncuestados<30}"> <!--Si no ha registrado a 30 encuestados-->
                    <c:set var="disabled2" value=""></c:set>
                    <c:set var="hidden2" value="hidden"></c:set>
                    <c:set var="disabled3" value="disabled"></c:set>
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
                <article class="articleses ${disabled1}">
                    <h3>Paso 1 <span class="glyphicon glyphicon-ok-sign completo ${hidden1}" title="Sección completa"></span></h3>
                    <a  href="Registro" ><img src="<%=Imagen.muestraImagen("C:/ArchivosPromocion/imagenes/EvidReg.jpg")%>" alt=""></a>
                    <a  href="Registro" ><h3>Registro de aspirante</h3></a>
                </article>                    
                
               
                <c:if test = "${finIncompleto}">
                    <c:set var="finIncompleto" value="true"></c:set>
                    <article class="articleses ">
                        <h3>Paso 2:</h3>
                        <a href="FichaRegistroIncompleto" target="_blank"><img src="<%=Imagen.muestraImagen("C:/ArchivosPromocion/imagenes/EvidVal.jpg")%>" alt=""></a>
                        <a href="FichaRegistroIncompleto" target="_blank"><h3>Ficha de registro incompleto</h3></a>
                    </article>
                </c:if>
                <c:if test = "${!finIncompleto}">
                    <article class="articleses ${disabled2}">
                        <h3>Paso 2: <span class="glyphicon glyphicon-ok-sign completo ${hidden2}" title="Sección completa"></span></h3>
                        <a href="RegistroEncuestados"><img src="<%=Imagen.muestraImagen("C:/ArchivosPromocion/imagenes/EvidReg.jpg")%>" alt=""></a>
                        <a href="RegistroEncuestados"><h3>Registro encuestados</h3></a>
                    </article>

                    <article class="articleses ${disabled3}">
                        <h3>Paso 3: <span class="glyphicon glyphicon-ok-sign completo hidden" title="Sección completa"></span></h3>
                        <a href="evidenciaRegistro.jsp" ><img src="<%=Imagen.muestraImagen("C:/ArchivosPromocion/imagenes/EvidReg.jpg")%>" alt=""></a>
                        <a href="evidenciaRegistro.jsp" ><h3>Criterios de valoración</h3></a>
                    </article>
                    <article class="articleses disabled">
                        <h3>Paso 4:<span class="glyphicon glyphicon-ok-sign completo hidden" title="Sección completa"></span></h3>
                        <a href="FichaRegistro" target="_blank" ><img src="<%=Imagen.muestraImagen("C:/ArchivosPromocion/imagenes/EvidVal.jpg")%>" alt=""></a>
                        <a href="FichaRegistro" target="_blank" ><h3>Ficha de <br/> registro </h3></a>
                    </article>
                </c:if>
                <!--
                <article class="articleses">
                    <h3>Paso 5:<span class="glyphicon glyphicon-ok-sign completo hidden" title="Sección completa"></span></h3>
                    <a href="articulo.html" class="disabled"><img src="<%=Imagen.muestraImagen("C:/ArchivosPromocion/imagenes/Resultados.jpg")%>" alt=""></a>
                    <a href="articulo.html" class="disabled"><h3>Emisión de Resultados</h3></a>
                </article>-->
                    
                
                
                
            </div>
            <!-- JS  para el framework del gobierno-->
            <script src="https://framework-gb.cdn.gob.mx/gobmx.js"></script>
        </div>

    </body>
</html>
