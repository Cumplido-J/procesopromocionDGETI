<%@page import="java.sql.ResultSet"%>
<jsp:useBean id="cx" class="metodos_sql.Metodos_sql" scope="page"></jsp:useBean>
<%
    String tipo = request.getParameter("n_plantel2");
    String s_opc = request.getParameter("f_opc4");
    String h[]={"","","","","","","","","","","","","","","","","","","","","","",""};
    int i=0;
    
    if (s_opc.equals("1")) {
%>
<select name="n_plantel4" required>
    <option value="0">Escoge una opcion</option>
    <%
        String com = "Select * from catcategoriarequisitoplaza WHERE idCategoria= '" + tipo + "'";
        ResultSet rs2 = cx.mostrar(com);
        while (rs2.next()) {
          if(rs2.getString("idRequisitoPlaza")!="0"){            
            h[i] = rs2.getString("idRequisitoPlaza");
            i++;
          }
    %>
    
    <%}%>
    
     <%
        String com2 = "Select * from catrequisitosplaza WHERE id= '" + h[0]+ "' || id='" + h[1] + "' || id = '"+  h[2] + "' || id = '"+  h[3] + "' || id = '"+  h[4] + "' || id = '"+  h[5] + "' || id = '"+  h[6] + "' || id = '"+  h[7] + "' || id = '"+  h[8] + "' || id = '"+  h[9] + "' || id = '"+  h[10] + "' || id = '"+  h[11] + "' || id = '"+  h[12] + "' || id = '"+  h[13] + "' || id = '"+  h[14] + "' || id = '"+  h[15] + "' || id = '"+  h[16] + "' || id = '"+  h[17] + "' || id = '"+  h[18] + "' || id = '"+  h[19] + "' || id = '"+  h[20] + "' || id = '"+  h[21] + "' || id = '"+  h[22] + "'";
        ResultSet rs3 = cx.mostrar(com2);
        while (rs3.next()) {%>
    <option  value = "<%=rs3.getString("id")%>"><%=rs3.getString("requisito")%></option>
    <%}%>

</select>
<%}%>