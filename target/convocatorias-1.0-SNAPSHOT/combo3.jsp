<%@page import="java.sql.ResultSet"%>
<jsp:useBean id="cx" class="metodos_sql.Metodos_sql" scope="page"></jsp:useBean>
<%
    String tipo = request.getParameter("n_plantel2");
    String s_opc = request.getParameter("f_opc3");
    String h[]={"","","",""};
    int i=0;
    
    if (s_opc.equals("1")) {
%>
<select name="n_plantel3" required>
    <option value="0">Escoge una opcion</option>
    <%
        String com = "Select * from catcategoriajornada WHERE idCategoria= '" + tipo + "'";
        ResultSet rs2 = cx.mostrar(com);
        while (rs2.next()) {
          if(rs2.getString("idJornada")!="0"){            
            h[i] = rs2.getString("idJornada");
            i++;
          }
    %>
    
    <%}%>
    
     <%
        String com2 = "Select * from catjornada WHERE id= '" + h[0]+ "' || id='" + h[1] + "' || id = '"+  h[2] +"'";
        ResultSet rs3 = cx.mostrar(com2);
        while (rs3.next()) {%>
    <option  value = "<%=rs3.getString("id")%>"><%=rs3.getString("jornada")%></option>
    <%}%>

</select>
<%}%>