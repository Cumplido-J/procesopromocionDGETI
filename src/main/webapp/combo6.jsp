<%-- 
    Document   : combo6
    Created on : 21-ago-2020, 21:20:47
    Author     : charl
--%>

<%@page import="java.sql.ResultSet"%>
<jsp:useBean id="cx" class="metodos_sql.Metodos_sql" scope="page"></jsp:useBean>
  
<%
   
    String plantel = request.getParameter("dato_pla");
    String s_opc = request.getParameter("f_opc");
    if (s_opc.equals("1")) {
%>
<select name="n_plantel" required>
        <%
        String com = "Select * from catplanteles WHERE id= '" + plantel + "'";
        ResultSet rs2 = cx.mostrar(com);
        while (rs2.next()) {%>
    <option  value = "<%=rs2.getString("id")%>"><%=rs2.getString("plantel")%></option>
    <%}%>
  

</select>
<%}%>
