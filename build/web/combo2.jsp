<%@page import="java.sql.ResultSet"%>
<jsp:useBean id="cx" class="metodos_sql.Metodos_sql" scope="page"></jsp:useBean>
<%
    String entidad = request.getParameter("entidad2");
    String s_opc = request.getParameter("f_opc2");
    if (s_opc.equals("1")) {
%>
<select name="n_plantel2" required>
    <option value="0">Escoge una opcion</option>
    <%
        String com = "Select * from catcategoriasplaza WHERE tipo= '" + entidad + "'";
        ResultSet rs2 = cx.mostrar(com);
        while (rs2.next()) {%>
    <option  value = "<%=rs2.getString("id")%>"><%=rs2.getString("categoria")%></option>
    <%}%>
    

</select>
<%}%>