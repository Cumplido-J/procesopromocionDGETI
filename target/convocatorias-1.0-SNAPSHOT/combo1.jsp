<%@page import="java.sql.ResultSet"%>
<jsp:useBean id="cx" class="metodos_sql.Metodos_sql" scope="page"></jsp:useBean>
  
<%
    String entidadtexto = request.getParameter("selected");
    String entidadindex = request.getParameter("cod");
    
   
    String entidad = request.getParameter("entidad");
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