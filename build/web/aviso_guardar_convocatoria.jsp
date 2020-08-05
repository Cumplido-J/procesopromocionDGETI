<%-- 
    Document   : aviso_guardar_convocatoria
    Created on : 30-jul-2020, 21:26:26
    Author     : charl
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title></title>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">        
        <link href="https://framework-gb.cdn.gob.mx/assets/styles/main.css" rel="stylesheet">
        <link rel="stylesheet" href="css/estilosRegistro.css">   
    </head>
    <body>   
        <main class="page">
            <div class="container">   
        <%
            session = (HttpSession) request.getSession(true);
            String idUsuario = "";
            String rfc = "";
            if (session.getAttribute("idUsuario") != null && session.getAttribute("rfc") != null) {
                idUsuario = session.getAttribute("idUsuario").toString();
                rfc = session.getAttribute("rfc").toString();
                session.setAttribute("idUsuario", idUsuario);
                session.setAttribute("rfc", rfc);
        %>
        <%
            if (request.getAttribute("ver") != null) {%>
        <form class="form-horizontal" role="form" method="POST" action="Servlet_guardar_convocatoria2">
            <!--<input type="checkbox" id="cerrar">

            <label for="ventana2" id="btn-cerrar">X</label>-->
            <div class="modal">
                <div class="contenido">
                    <br>
                    <input class="aviso_guardar" type="text" name="aviso_guardar_usuario" id="aviso_guardar_usuario" value="<%=request.getAttribute("nom")%>">
                     <%
                            session.setAttribute("idUsuario", idUsuario);
                            session.setAttribute("rfc", rfc);
                        %>
                    <input type="hidden" name="permiso1" id="permiso1" value="<%=request.getAttribute("per1")%>">
                    <input type="hidden" name="permiso3" id="permiso3" value="<%=request.getAttribute("per3")%>">
                    <input type="hidden" name="permiso4" id="permiso4" value="<%=request.getAttribute("per4")%>">
                    <input type="hidden" name="nombre" id="nombre" value="<%=request.getAttribute("nom")%>">
                    <input type="hidden" name="dato_ent" id="dato_ent" value="<%=request.getAttribute("dato_ent")%>">
                    <input type="hidden" name="dato_pla" id="dato_pla" value="<%=request.getAttribute("dato_pla")%>">
                    <input type="hidden" name="dato_rfc" id="dato_rfc" value="<%=request.getAttribute("dato_rfc")%>">
                    <br><br>
                    <img src="imagenes/palomita.png">
                    <br><br>
                    <h2>La convocatoria ha sido guardada</h2>
                </div>
            </div>  
                    <br/><br/>
            <h2>La convocatoria ha sido guardada</h2>
            <input type="submit" value="Continuar" name="guardar" id="ventana2" >
            <br/>
        </form> <%
            } else {
                response.sendRedirect("login.jsp");
            }
        %>

 <%
            } else {
                response.sendRedirect("login.jsp");
            }
        %>
        </div>
        </main>
        <script src="https://framework-gb.cdn.gob.mx/gobmx.js"></script>
    </body>
</html>

