<%-- 
    Document   : aviso_guardar
    Created on : 29-jul-2020, 17:29:12
    Author     : charl
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, user-scalable=no, initial-scale=1.0, maximun-scale=1.0, minimun-scale=1.0">
        <link rel="stylesheet" href="css/estilos.css">         
    </head>
    <body>   
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
            if (request.getAttribute("ver") != null) { %>
        <form class="form-horizontal" role="form" method="POST" action="Servlet_guardar">
            <%
                session.setAttribute("idUsuario", idUsuario);
                session.setAttribute("rfc", rfc);
            %>
            <input type="checkbox" id="cerrar">

            <label for="ventana2" id="btn-cerrar">X</label>
            <div class="modal">
                <div class="contenido">
                    <br>
                    <input class="aviso_guardar" type="text" name="aviso_guardar" id="aviso_guardar" value="<%=request.getAttribute("aviso_nom")%>">
                    <br><br>
                    <img src="imagenes/palomita.png">
                    <br><br>
                    <h2>Tu información ha sido guardada</h2>
                </div>
            </div>  
            <input type="submit" value="Enviar" name="guardar" id="ventana2" >
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
    </body>
</html>
