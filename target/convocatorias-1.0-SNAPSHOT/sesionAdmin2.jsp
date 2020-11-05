<%-- 
    Document   : sesionAdmin2
    Created on : 30 oct 2020, 13:47:20
    Author     : David Reyna
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix ="fmt"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
    <head>
        <jsp:include page="seccionesPlantilla/head.jsp"/>
        <!--Agregar estilos aquí-->
    </head>
    <body>
        <main class="page">
            <jsp:include page="seccionesPlantilla/barraSuperior.jsp"/>
            <div class="container">
                <!--Agregar contenido de página aquí-->
                <h3>Panel de control de administradores</h3>     
                <h5>Seleccione una opción:</h5>
                <ol>
                    <c:forEach items="${vinculos}" var="vinculo">
                        <li><a href="${vinculo[2]}">${vinculo[1]}</a></li>
                    </c:forEach>
                </ol>
            </div>
        </main>
        <!--Agregar modals aquí-->
        <jsp:include page="seccionesPlantilla/scripts.jsp"/>
        <!--Agregar scripts aquí-->
        
    </body>
</html>
