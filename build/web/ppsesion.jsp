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
                                <a>${Docente.infoRegistro[1]}
                                &nbsp;
                                ${Docente.infoRegistro[2]}
                                &nbsp;
                                ${Docente.infoRegistro[3]}</a>
                            </li>
                            <li><a href="login.jsp">Cerrar Sesión</a></li>
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

            <div class="articulosses">
                <c:if test = "${Docente.infoRegistro[61]==null}">                    
                    <article class="articleses">
                        <a href="Registro"><img src="<%=Imagen.muestraImagen("C:/ArchivosPromocion/imagenes/EvidReg.jpg")%>" alt=""></a>
                        <a href="Registro"><h3>Registro de aspirante</h3></a>
                    </article>                    
                </c:if>
                <c:if test = "${Docente.infoRegistro[61]!=null}">
                    <c:if test = "${Docente.infoRegistro[63]==null}">
                        <article class="articleses">
                            <a href="FichaRegistroIncompleto"><img src="<%=Imagen.muestraImagen("C:/ArchivosPromocion/imagenes/EvidVal.jpg")%>" alt=""></a>
                            <a href="FichaRegistroIncompleto"><h3>Ficha de registro incompleto</h3></a>
                        </article>
                    </c:if>
                    <c:if test = "${Docente.infoRegistro[63]!=null}">
                        <article class="articleses">
                            <a href="evidenciaRegistroDocentes.html"><img src="<%=Imagen.muestraImagen("C:/ArchivosPromocion/imagenes/EvidVal.jpg")%>" alt=""></a>
                            <a href="evidenciaRegistroDocentes.html"><h3>Evidencias de valoración</h3></a>
                        </article>
                    </c:if>
                </c:if>
                <!--
                <article class="articleses">
                    <a href="articulo.html"><img src="<%=Imagen.muestraImagen("C:/ArchivosPromocion/imagenes/Resultados.jpg")%>" alt=""></a>
                    <a href="articulo.html"><h3>Emisión de Resultados</h3></a>
                </article>
                -->
            </div>
            <!-- JS  para el framework del gobierno-->
            <script src="https://framework-gb.cdn.gob.mx/gobmx.js"></script>
        </div>

    </body>
</html>
