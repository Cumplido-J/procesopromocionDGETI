<%-- 
    Document   : combo5
    Created on : 21-ago-2020, 14:42:28
    Author     : charl
--%>

<%@page import="java.sql.ResultSet"%>
<jsp:useBean id="cx" class="metodos_sql.Metodos_sql" scope="page"></jsp:useBean>
  
<%  
    String entidad = request.getParameter("dato_ent");
    String s_opc = request.getParameter("f_opc");
    if (s_opc.equals("1")) {
%>
<select name="n_plantel" required>
    <option value="0">Escoge una opcion</option>
    <%
        String com = "Select id, idEntidad, plantel from catplanteles WHERE idEntidad= '" + entidad + "'";
        ResultSet rs2 = cx.mostrar(com);
        while (rs2.next()) {%>
    <option  value = "<%=rs2.getString("id")%>"><%=rs2.getString("plantel")%></option>
    <%}%>
  

</select>
<%}%>