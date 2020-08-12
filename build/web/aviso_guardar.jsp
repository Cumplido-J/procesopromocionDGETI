<%-- 
    Document   : aviso_guardar
    Created on : 29-jul-2020, 17:29:12
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
            //session = (HttpSession) request.getSession(true);
            String idUsuario = "";
            String rfc = "";
            /*if (session.getAttribute("idUsuario") != null && session.getAttribute("rfc") != null) {
                idUsuario = session.getAttribute("idUsuario").toString();
                rfc = session.getAttribute("rfc").toString();
                session.setAttribute("idUsuario", idUsuario);
                session.setAttribute("rfc", rfc);*/
        %>
        <%
            if (request.getAttribute("ver") != null) { %>
        <form class="form-horizontal" role="form" method="POST" action="Servlet_guardar">
            <%
                //session.setAttribute("idUsuario", idUsuario);
                //session.setAttribute("rfc", rfc);
            %>
            <!--<input type="checkbox" id="cerrar">

            <label for="ventana2" id="btn-cerrar">X</label>-->
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
                    <br/><br/>
            <h2>Tu información ha sido guardada</h2>
            <input type="submit" value="Continuar" name="guardar" id="ventana2" >
            <br/>
        </form> <%
            } else {
                response.sendRedirect("login.jsp");
            }
        %>

        <%
            /*} else {
                response.sendRedirect("login.jsp");
            }*/
        %>
        </div>
        </main>
        <script src="https://framework-gb.cdn.gob.mx/gobmx.js"></script>
    </body>
</html>
