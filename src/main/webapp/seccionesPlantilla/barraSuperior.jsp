
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<script src="js/funcionesPermisoActual.js?v=1"></script>

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
        <a class="navbar-brand" href="/">DGETI - CECyTEs</a>
      </div>
      <div class="collapse navbar-collapse" >
        <ul class="nav navbar-nav navbar-right" id="subenlaces"> 
            <c:if test='${sessionScope["nombre"]!=null}'>
            <li><a href="#"><%=session.getAttribute("nombre").toString()%></a></li>            
            <c:if test="${vinculos!=null}">
                <li class="dropdown">
                    <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false">Opciones administrador<span class="caret"></span></a>
                    <ul class="dropdown-menu" role="menu">
                        <c:forEach items="${vinculos}" var="vinculo">
                            <li><a onclick="establecerPermisoActual(${vinculo[0]},'${vinculo[3]}','${vinculo[4]}')" href="${vinculo[2]}">${vinculo[1]}</a></li>
                        </c:forEach>
                    </ul>
                </li>
            </c:if>
            </c:if>
            <li><a href="#" onclick="javascript:window.history.back();">Regresar</a></li>
            <li><a href="Servlet_cerrarsesion" id="login">Cerrar sesión</a></li> 
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