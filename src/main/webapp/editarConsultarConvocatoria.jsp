<%-- 
    Document   : editarConsultarConvocatoria
    Created on : 21/08/2020, 08:30:54 PM
    Author     : Iker Fernando
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <p>Me ha llegado <%
            session.getAttribute("entidad");
        %></p>
        
        <input type="text" value="<%=session.getAttribute("entidad")%>"/>
        
        
    </body>
</html>
