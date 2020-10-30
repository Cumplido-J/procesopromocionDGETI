<%-- 
    Document   : agregar_vacantes
    Created on : 12-jun-2020, 15:03:22
    Author     : charl
--%>
<%@page import="java.sql.ResultSet"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>DGETI | gob.mx</title>
        <meta name="viewport" content="width=device-width, user-scalable=no, initial-scale=1.0, maximun-scale=1.0, minimun-scale=1.0">
        <link rel="stylesheet" href="css/all.css">
        <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@500&display=swap" rel="stylesheet">
        <link rel="stylesheet" href="css/estilos.css">

        <link rel="stylesheet" type="text/css" href="bootstrap/css/bootstrap.css">
        <script src="js/jquery-3.1.1.min.js"></script>
        <script src="bootstrap/js/bootstrap.js"></script>
        <!-- para el framework del gobierno-->
        <!-- CSS -->
        <link href="/favicon.ico" rel="shortcut icon">
        <link href="https://framework-gb.cdn.gob.mx/assets/styles/main.css" rel="stylesheet">

        <%-- <script type="text/javascript" src="js/jquery-1.11.1.min.js"></script> --%>
        <link rel="stylesheet" href="css/jquery.dataTables.min.css">
        <%-- <script src="js/jquery-3.5.1.min.js"></script> --%>
        <script src="js/jquery.dataTables.min.js"></script>
        <script type="text/javascript">
            function habilitar() {
                var camp1 = document.getElementById("permiso1");
                var camp2 = document.getElementById("permiso2");
                var camp4 = document.getElementById("permiso4");
                var boton1 = document.getElementById("activado_usuario");
                var boton2 = document.getElementById("activado_convocatoria");
                var boton4 = document.getElementById("activado_vacancia");

                if (camp1.value == "true") {
                    boton1.disabled = true;
                    boton1.style.color = "#FF3000";
                } else
                {
                    boton1.disabled = false;
                    boton1.style.color = "#FFFFFF";
                }

                if (camp2.value == "true") {
                    boton2.disabled = true;
                    boton2.style.color = "#FF3000";
                } else
                {
                    boton2.disabled = false;
                    boton2.style.color = "#FFFFFF";
                }

                if (camp4.value == "true") {
                    boton4.disabled = true;
                    boton4.style.color = "#FF3000";
                } else
                {
                    boton4.disabled = false;
                    boton4.style.color = "#FFFFFF";
                }
            }

            function seleccion_subsistema() {
                $("#entidad").val("0");
                $("#i_plantel").val("0");
            }

            function plantel() {
                var combo70 = document.getElementById("entidad");
                var selected70 = combo70.options[combo70.selectedIndex].text;
                $("#campoentidad70").val(selected70);

                $("#i_opc").val("1");
                $.post("combo9.jsp", $("#data").serialize(), function (data) {
                    $("#i_plantel").html(data);
                });

            }

            $(document).ready(function () {
                $('#tabla_usuarios').DataTable();
            });


            $(document).ready(function ()
            {
                var modal = document.getElementById("modal").value;
                //alert(modal);
                if (modal == "1") {
                    $("#modalMensaje").modal("show");
                } else
                {

                }
            });
        </script>    
        <!-- Respond.js soporte de media queries para Internet Explorer 8 -->
        <!-- ie8.js EventTarget para cada nodo en Internet Explorer 8 -->
        <!--[if lt IE 9]>
          <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
          <script src="https://cdnjs.cloudflare.com/ajax/libs/ie8/0.2.2/ie8.js"></script>
        <![endif]-->
        <!--Termina  para el framework del gobierno-->
    </head>
    <body>
        <main class="page">
            <%
                session = (HttpSession) request.getSession(true);
                String idUsuario = "";
                String rfc = "";
                if (session.getAttribute("idUsuario").toString() != null && session.getAttribute("rfc").toString() != null) {
                    idUsuario = session.getAttribute("idUsuario").toString();
                    rfc = session.getAttribute("rfc").toString();
                    session.setAttribute("idUsuario", idUsuario);
                    session.setAttribute("rfc", rfc);
            %>
            <div>
                <!--  para el framework del gobierno-->
                <nav class="navbar navbar-inverse sub-navbar navbar-fixed-top">
                    <div class="container">
                        <div class="navbar-header">
                            <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#subenlaces">
                                <span class="sr-only">Interruptor de Navegación</span>
                                <span class="icon-bar"></span>
                                <span class="icon-bar"></span>
                                <span class="icon-bar"></span>
                            </button>
                            <a class="navbar-brand" href="/">DGETI</a>
                        </div>
                        <div class="collapse navbar-collapse" id="subenlaces">
                            <ul class="nav navbar-nav navbar-right">
                                <nav class="navegacion">
                                    <ul class="menu">
                                        <li aling="navbar-center">
                                            <%
                                                String nom1 = String.valueOf(request.getAttribute("nom"));
                                                out.print(nom1);
                                            %>

                                        </li>                                    
                                        <li><a href="#">Administrador</a>
                                            <ul class="submenu">
                                                <li>
                                                    <form id="data3"  role="form" method="POST" action="Servlet_regresar">
                                                        <button class="propiedadesboton" type="submit" name="regresa" id="activado_usuario" onmouseover="habilitar();">Usuario</button>
                                                        <%
                                                            session.setAttribute("idUsuario", idUsuario);
                                                            session.setAttribute("rfc", rfc);
                                                        %>
                                                        <input type="hidden" name="control_combobox" id="control_combobox" value="<%=request.getAttribute("control_combobox")%>">
                                                        <input type="hidden" name="nacional" id="nacional" value="<%=request.getAttribute("nacional")%>"> <%--AGREGAR--%>
                                                        <input type="hidden" name="permiso1" id="permiso1" value="<%=request.getAttribute("per1")%>">
                                                        <input type="hidden" name="permiso2" id="permiso2" value="<%=request.getAttribute("per2")%>">
                                                        <input type="hidden" name="permiso4" id="permiso4" value="<%=request.getAttribute("per4")%>">
                                                        <input type="hidden" name="nombre" id="nombre" value="<%=request.getAttribute("nom")%>">
                                                        <input type="hidden" name="dato_ent" id="dato_ent" value="<%=request.getAttribute("dato_ent")%>">
                                                        <input type="hidden" name="dato_pla" id="dato_pla" value="<%=request.getAttribute("dato_pla")%>">
                                                        <input type="hidden" name="dato_rfc" id="dato_rfc" value="<%=request.getAttribute("dato_rfc")%>">
                                                    </form>
                                                </li>   
                                                <li>
                                                    <form id="data4"  role="form" method="POST" action="Servlet_convocatoria">
                                                        <button class="propiedadesboton" type="submit" name="convocatoria" id="activado_convocatoria" onmouseover="habilitar();">Convocatoria</button>
                                                        <%
                                                            session.setAttribute("idUsuario", idUsuario);
                                                            session.setAttribute("rfc", rfc);
                                                        %>
                                                        <input type="hidden" name="control_combobox" id="control_combobox" value="<%=request.getAttribute("control_combobox")%>">
                                                        <input type="hidden" name="nacional" id="nacional" value="<%=request.getAttribute("nacional")%>"> <%--AGREGAR--%>
                                                        <input type="hidden" name="permiso1" id="permiso1" value="<%=request.getAttribute("per1")%>">
                                                        <input type="hidden" name="permiso2" id="permiso2" value="<%=request.getAttribute("per2")%>">
                                                        <input type="hidden" name="permiso4" id="permiso4" value="<%=request.getAttribute("per4")%>">
                                                        <input type="hidden" name="nombre" id="nombre" value="<%=request.getAttribute("nom")%>">
                                                        <input type="hidden" name="dato_ent" id="dato_ent" value="<%=request.getAttribute("dato_ent")%>">
                                                        <input type="hidden" name="dato_pla" id="dato_pla" value="<%=request.getAttribute("dato_pla")%>">
                                                        <input type="hidden" name="dato_rfc" id="dato_rfc" value="<%=request.getAttribute("dato_rfc")%>">
                                                    </form>
                                                </li>
                                                <li>
                                                    <form id="data3"  role="form" method="POST" action="Servlet_ir_a_vacantes">
                                                        <button class="propiedadesboton" type="submit" name="ir" id="activado_vacancia" onmouseover="habilitar();">Vacancia</button>
                                                        <%
                                                            session.setAttribute("idUsuario", idUsuario);
                                                            session.setAttribute("rfc", rfc);
                                                        %>
                                                        <input type="hidden" name="control_combobox" id="control_combobox" value="<%=request.getAttribute("control_combobox")%>">
                                                        <input type="hidden" name="nacional" id="nacional" value="<%=request.getAttribute("nacional")%>"> <%--AGREGAR--%>
                                                        <input type="hidden" name="permiso1" id="permiso1" value="<%=request.getAttribute("per1")%>">
                                                        <input type="hidden" name="permiso2" id="permiso2" value="<%=request.getAttribute("per2")%>">
                                                        <input type="hidden" name="permiso4" id="permiso4" value="<%=request.getAttribute("per4")%>">
                                                        <input type="hidden" name="nombre" id="nombre" value="<%=request.getAttribute("nom")%>">
                                                        <input type="hidden" name="dato_ent" id="dato_ent" value="<%=request.getAttribute("dato_ent")%>">
                                                        <input type="hidden" name="dato_pla" id="dato_pla" value="<%=request.getAttribute("dato_pla")%>">
                                                        <input type="hidden" name="dato_rfc" id="dato_rfc" value="<%=request.getAttribute("dato_rfc")%>">
                                                    </form>
                                                </li>
                                            </ul> 
                                        </li> 
                                        <li><a href="login.jsp">Cerrar sesión</a></li>
                                    </ul>
                                </nav>
                            </ul>
                        </div>
                    </div>
                </nav>
            </div>
            <!--	  Termina para el framework del gobierno-->


            <div class="padre">

                <header class="headerart">
                    <div class="titulo">
                        <p>Dirección General de Educación Tecnológica Industrial y de Servicios</p>
                    </div>
                    <div class="texto-principalart margen-interno">
                        <p>Programa de Promoción en el Servicio Docente en Educación Media Superior</p>
                    </div>
                </header>
                <div class="ruta">
                    <p> DGETI > Promoción Docente > Vacantes</p>
                </div>
                <section class="sectionart">
                    <div class="articulosart">
                        <h3>Carga de vacancia en los planteles</h3>
                        <jsp:useBean id="cn" class="metodos_sql.Metodos_sql" scope="page"></jsp:useBean>
                            <form id="data" class="form-horizontal" role="form" method="POST" action="Servlet_buscar_vacancia">
                                <input type="hidden" name="modal" id="modal" value="<%=request.getAttribute("modal")%>">
                            <%-------------------------------------------------------------------OPCION VERDADERA COMBO BOX----------------------------%>   
                            <%if (request.getAttribute("control_combobox").equals("false") && request.getAttribute("nacional").equals("1")) { %>
                            <table  border="0" width="120%">   
                                <tr>
                                    <td align="center">
                                        <label>Subsistema</label><br>
                                        <%
                                            ResultSet rs9 = cn.mostrar("Select id, subsistema from catsubsistema");
                                        %>

                                        <select class="select" name="subsistema" id="subsistema" onchange="seleccion_subsistema()">
                                            <option value="0">Escoge una opcion</option>
                                            <%
                                                while (rs9.next()) {
                                            %>
                                            <option value="<%=rs9.getString("id")%>"><%=rs9.getString("subsistema")%></option>

                                            <%//              regresa del combobox         muestra en el combo box
                                                }
                                            %>                                              
                                        </select>   

                                        <div id="nsub"></div>
                                    </td>


                                    <td align="center">
                                        <input type="hidden" name="f_opc" id="i_opc">
                                        <input type="hidden" name="campoentidad70" id="campoentidad70" >
                                        <label>Entidad</label><br>

                                        <%
                                            ResultSet rs = cn.mostrar("Select id, entidad from catentidades");
                                        %>

                                        <select class="select" name="entidad" id="entidad" onchange="plantel()">
                                            <option value="0">Escoge una opcion</option>
                                            <%
                                                while (rs.next()) {
                                            %>
                                            <option value="<%=rs.getString("id")%>"><%=rs.getString("entidad")%></option>
                                            <%
                                                }
                                            %>
                                        </select>
                                    </td>
                                    <td align="center">
                                        <label>Plantel</label><br>                                 

                                        <select class="select" name="n_plantel" id="i_plantel">
                                            <option value="0">Escoge una opcion</option>
                                        </select>
                                    </td>
                                    <td align="center">
                                        <label>Categoria Plaza</label><br>
                                        <select class="select" name="categoria" id="i_plantel">
                                            <option value="0">Escoge una opcion</option>
                                            <option value="TD">Tecnico docente</option> 
                                            <option value="D">Docente</option>
                                        </select>

                                    </td>
                                </tr>
                                <tr>
                                    <td></td>
                                    <td></td>
                                    <td>
                                        <div class="error"> 
                                            <% if (request.getAttribute("error") == null) {
                                                    out.print("");
                                                } else {
                                                    out.print(request.getAttribute("error"));
                                                }


                                            %>
                                        </div>
                                    </td>
                                </tr>

                            </table><br><br>

                            <div class="form-group">
                                <button class="btn btn-primary pull-right" type="submit" name="pVacancia" form="data2">Agregar</button>
                                <button class="btn btn-primary pull-right" type="submit" name="buscarvacancia">Buscar</button>

                            </div>
                            <br><br>

                            <table  border="1" width="160%" id="tabla_usuarios" class="display">  
                                <thead>
                                    <tr>
                                        <th>Subsistema</th>
                                        <th>Estado</th>
                                        <th>Plantel</th>
                                        <th>Plaza</th>
                                        <th>#Plazas</th>
                                        <th>Tipo de Categoria</th>
                                        <th>Jornada</th> 
                                        <th>Vacancia</th>
                                    </tr>
                                </thead>
                                <%                                String elegir1 = "0";
                                    String cadena = "";
                                    String nombre_subsistema = "";
                                    String nombre_entidad = "";
                                    String nombre_plantel = "";
                                    String tipo_categoria = "";
                                    String nombre_jornada = "";

                                    if (request.getAttribute("cadena") == null) {
                                        cadena="SELECT a.*,c.subsistema FROM vacancia a join catplanteles b on a.plantel=b.id join catsubsistema c on b.idSubsistema=c.id";
                                    } else {
                                        cadena = request.getAttribute("cadena").toString();
                                    }

                                    elegir1 = String.valueOf(request.getAttribute("opc"));

                                    if (elegir1.equals("1")) {
                                        ResultSet rs2 = null;
                                        if (request.getAttribute("consulta").equals("1")) {
                                            //rs2 = cn.mostrar_usuarios("SELECT * FROM vacancia && idSubsistema='" + request.getAttribute("subsistema") + "'");
                                            rs2 = cn.mostrar_usuarios(cadena);
                                        }

                                        if (request.getAttribute("consulta").equals("3")) {
                                            //rs2 = cn.mostrar_usuarios("SELECT * FROM vacancia WHERE entidad='" + request.getAttribute("est") + "' && plantel='" + request.getAttribute("pla") + "'");
                                            rs2 = cn.mostrar_usuarios(cadena);
                                        }

                                        if (request.getAttribute("consulta").equals("2")) {
                                            //rs2 = cn.mostrar_usuarios("SELECT * FROM vacancia WHERE entidad='" + request.getAttribute("est") + "'");
                                            rs2 = cn.mostrar_usuarios(cadena);
                                        }

                                        if (request.getAttribute("consulta").equals("4")) {
                                            //rs2 = cn.mostrar_usuarios("SELECT * FROM vacancia WHERE plaza='" + request.getAttribute("cat") + "'");
                                            rs2 = cn.mostrar_usuarios(cadena);
                                        }

                                        if (request.getAttribute("consulta").equals("5")) {
                                            //rs2 = cn.mostrar_usuarios("SELECT * FROM vacancia WHERE entidad='" + request.getAttribute("est") + "' && plaza='" + request.getAttribute("cat") + "'");
                                            rs2 = cn.mostrar_usuarios(cadena);
                                        }

                                        if (request.getAttribute("consulta").equals("6")) {
                                            //rs2 = cn.mostrar_usuarios("SELECT * FROM vacancia WHERE entidad='" + request.getAttribute("est") + "' && plantel='" + request.getAttribute("pla") + "' && plaza='" + request.getAttribute("cat") + "'");
                                            rs2 = cn.mostrar_usuarios(cadena);
                                        }

                                        while (rs2.next()) {
                                %>
                                <tr>
                                    <td align="center">
                                        <div class="datos_tabla"> 
                                            <%
                                                /*nombre_subsistema = cn.buscarsubsistema("SELECT * FROM catsubsistema WHERE id='" + request.getAttribute("subsistema") + "'");
                                                if (nombre_subsistema == null) {
                                                    out.print("");
                                                } else {
                                                    out.print(nombre_subsistema);
                                                }*/
                                                out.print(rs2.getString("subsistema"));
                                            %>
                                    </td>
                                    <td align="center">
                                        <div class="datos_tabla"> 
                                            <%
                                                nombre_entidad = cn.buscarentidad("SELECT * FROM catentidades WHERE id='" + rs2.getString("entidad") + "'");
                                                if (nombre_entidad == null) {
                                                    out.print("");
                                                } else {
                                                    out.print(nombre_entidad);
                                                }
                                            %>
                                        </div>
                                    </td>
                                    <td align="center">
                                        <div class="datos_tabla"> 
                                            <%
                                                nombre_plantel = cn.buscarplantel("SELECT * FROM catplanteles WHERE id='" + rs2.getString("plantel") + "'");
                                                if (nombre_plantel == null) {
                                                    out.print("");
                                                } else {
                                                    out.print(nombre_plantel);
                                                }
                                            %>
                                        </div>
                                    </td>
                                    <td align="center">
                                        <div class="datos_tabla"> 
                                            <% if (rs2.getString("plaza") == null) {
                                                    out.print("");
                                                } else {
                                                    out.print(rs2.getString("plaza"));
                                                }
                                            %>
                                        </div>
                                    </td>
                                    <td align="center">
                                        <div class="datos_tabla"> 
                                            <% if (rs2.getString("cantidadplazas") == null) {
                                                    out.print("");
                                                } else {
                                                    out.print(rs2.getString("cantidadplazas"));
                                                }
                                            %>
                                        </div>
                                    </td>
                                    <td align="center">
                                        <div class="c_nom"> 
                                            <%
                                                tipo_categoria = cn.buscartipocategoria("SELECT * FROM catcategoriasplaza WHERE id='" + rs2.getString("tipocategoria") + "'");
                                                if (tipo_categoria == null) {
                                                    out.print("");
                                                } else {
                                                    out.print(tipo_categoria);
                                                }


                                            %>
                                        </div>
                                    </td>
                                    <td align="center">
                                        <div class="c_nom"> 
                                            <%                                            nombre_jornada = cn.buscarjornada("SELECT * FROM catjornada WHERE id='" + rs2.getString("jornada") + "'");
                                                if (nombre_jornada == null) {
                                                    out.print("");
                                                } else {
                                                    out.print(nombre_jornada);
                                                }
                                            %>
                                        </div>
                                    </td>

                                    <td align="center">
                                        <div class="datos_tabla"> 
                                            <% if (rs2.getString("vacancia") == null) {
                                                    out.print("");
                                                } else {
                                                    out.print(rs2.getString("vacancia"));
                                                }
                                            %>
                                        </div>
                                    </td>
                                </tr>
                                <%}
                                    }//fin if elegir
                                    else {
                                        response.sendRedirect("login.jsp");
                                    }
                                %>
                            </table><br><br>
                            <% } //FIN OPCION SUPER USUARIO NACIONAL COMBOBOX
                            else if (request.getAttribute("control_combobox").equals("true") && request.getAttribute("nacional").equals("1")) {%> <%--OPCION ADMINISTRADOR NACIONAL --%>
                            <table  border="0" width="120%">   
                                <tr>
                                    <td align="center">
                                        <label>Subsistema</label><br>
                                        <%
                                            ResultSet rs9 = cn.mostrar("Select id, subsistema from catsubsistema");
                                        %>

                                        <select class="select" name="subsistema" id="subsistema" onchange="seleccion_subsistema()">
                                            <option value="0">Escoge una opcion</option>
                                            <%
                                                while (rs9.next()) {
                                            %>
                                            <option value="<%=rs9.getString("id")%>"><%=rs9.getString("subsistema")%></option>

                                            <%//              regresa del combobox         muestra en el combo box
                                                }
                                            %>                                              
                                        </select>   

                                        <div id="nsub"></div>
                                    </td>


                                    <td align="center">
                                        <input type="hidden" name="f_opc" id="i_opc">
                                        <input type="hidden" name="campoentidad70" id="campoentidad70" >
                                        <label>Entidad</label><br>

                                        <%
                                            ResultSet rs = cn.mostrar("Select id, entidad from catentidades");
                                        %>

                                        <select class="select" name="entidad" id="entidad" onchange="plantel()">
                                            <option value="0">Escoge una opcion</option>
                                            <%
                                                while (rs.next()) {
                                            %>
                                            <option value="<%=rs.getString("id")%>"><%=rs.getString("entidad")%></option>
                                            <%
                                                }
                                            %>
                                        </select>
                                    </td>
                                    <td align="center">
                                        <label>Plantel</label><br>                                 

                                        <select class="select" name="n_plantel" id="i_plantel">
                                            <option value="0">Escoge una opcion</option>
                                        </select>
                                    </td>
                                    <td align="center">
                                        <label>Categoria Plaza</label><br>
                                        <select class="select" name="categoria" id="i_plantel">
                                            <option value="0">Escoge una opcion</option>
                                            <option value="TD">Tecnico docente</option> 
                                            <option value="D">Docente</option>
                                        </select>

                                    </td>
                                </tr>
                                <tr>
                                    <td></td>
                                    <td></td>
                                    <td>
                                        <div class="error"> 
                                            <% if (request.getAttribute("error") == null) {
                                                    out.print("");
                                                } else {
                                                    out.print(request.getAttribute("error"));
                                                }


                                            %>
                                        </div>
                                    </td>
                                </tr>

                            </table><br><br>

                            <div class="form-group">
                                <button class="btn btn-primary pull-right" type="submit" name="pVacancia" form="data2">Agregar</button>
                                <button class="btn btn-primary pull-right" type="submit" name="buscarvacancia">Buscar</button>

                            </div>
                            <br><br>

                            <table  border="1" width="160%" id="tabla_usuarios" class="display">  
                                <thead>
                                    <tr>
                                        <th>Subsistema</th>
                                        <th>Estado</th>
                                        <th>Plantel</th>
                                        <th>Plaza</th>
                                        <th>#Plazas</th>
                                        <th>Tipo de Categoria</th>
                                        <th>Jornada</th> 
                                        <th>Vacancia</th>
                                    </tr>
                                </thead>
                                <%                                String elegir1 = "0";
                                    String cadena = "";
                                    String nombre_subsistema = "";
                                    String nombre_entidad = "";
                                    String nombre_plantel = "";
                                    String tipo_categoria = "";
                                    String nombre_jornada = "";

                                    if (request.getAttribute("cadena") == null) {
                                    } else {
                                        cadena = request.getAttribute("cadena").toString();
                                    }

                                    elegir1 = String.valueOf(request.getAttribute("opc"));

                                    if (elegir1.equals("1")) {
                                        ResultSet rs2 = null;
                                        if (request.getAttribute("consulta").equals("1")) {
                                            //rs2 = cn.mostrar_usuarios("SELECT * FROM vacancia && idSubsistema='" + request.getAttribute("subsistema") + "'");
                                            rs2 = cn.mostrar_usuarios(cadena);
                                        }

                                        if (request.getAttribute("consulta").equals("3")) {
                                            //rs2 = cn.mostrar_usuarios("SELECT * FROM vacancia WHERE entidad='" + request.getAttribute("est") + "' && plantel='" + request.getAttribute("pla") + "'");
                                            rs2 = cn.mostrar_usuarios(cadena);
                                        }

                                        if (request.getAttribute("consulta").equals("2")) {
                                            //rs2 = cn.mostrar_usuarios("SELECT * FROM vacancia WHERE entidad='" + request.getAttribute("est") + "'");
                                            rs2 = cn.mostrar_usuarios(cadena);
                                        }

                                        if (request.getAttribute("consulta").equals("4")) {
                                            //rs2 = cn.mostrar_usuarios("SELECT * FROM vacancia WHERE plaza='" + request.getAttribute("cat") + "'");
                                            rs2 = cn.mostrar_usuarios(cadena);
                                        }

                                        if (request.getAttribute("consulta").equals("5")) {
                                            //rs2 = cn.mostrar_usuarios("SELECT * FROM vacancia WHERE entidad='" + request.getAttribute("est") + "' && plaza='" + request.getAttribute("cat") + "'");
                                            rs2 = cn.mostrar_usuarios(cadena);
                                        }

                                        if (request.getAttribute("consulta").equals("6")) {
                                            //rs2 = cn.mostrar_usuarios("SELECT * FROM vacancia WHERE entidad='" + request.getAttribute("est") + "' && plantel='" + request.getAttribute("pla") + "' && plaza='" + request.getAttribute("cat") + "'");
                                            rs2 = cn.mostrar_usuarios(cadena);
                                        }

                                        while (rs2.next()) {
                                %>
                                <tr>
                                    <td align="center">
                                        <div class="datos_tabla"> 
                                            <%
                                                nombre_subsistema = cn.buscarsubsistema("SELECT * FROM catsubsistema WHERE id='" + request.getAttribute("subsistema") + "'");
                                                if (nombre_subsistema == null) {
                                                    out.print("");
                                                } else {
                                                    out.print(nombre_subsistema);
                                                }
                                            %>
                                    </td>
                                    <td align="center">
                                        <div class="datos_tabla"> 
                                            <%
                                                nombre_entidad = cn.buscarentidad("SELECT * FROM catentidades WHERE id='" + rs2.getString("entidad") + "'");
                                                if (nombre_entidad == null) {
                                                    out.print("");
                                                } else {
                                                    out.print(nombre_entidad);
                                                }
                                            %>
                                        </div>
                                    </td>
                                    <td align="center">
                                        <div class="datos_tabla"> 
                                            <%
                                                nombre_plantel = cn.buscarplantel("SELECT * FROM catplanteles WHERE id='" + rs2.getString("plantel") + "'");
                                                if (nombre_plantel == null) {
                                                    out.print("");
                                                } else {
                                                    out.print(nombre_plantel);
                                                }
                                            %>
                                        </div>
                                    </td>
                                    <td align="center">
                                        <div class="datos_tabla"> 
                                            <% if (rs2.getString("plaza") == null) {
                                                    out.print("");
                                                } else {
                                                    out.print(rs2.getString("plaza"));
                                                }
                                            %>
                                        </div>
                                    </td>
                                    <td align="center">
                                        <div class="datos_tabla"> 
                                            <% if (rs2.getString("cantidadplazas") == null) {
                                                    out.print("");
                                                } else {
                                                    out.print(rs2.getString("cantidadplazas"));
                                                }
                                            %>
                                        </div>
                                    </td>
                                    <td align="center">
                                        <div class="c_nom"> 
                                            <%
                                                tipo_categoria = cn.buscartipocategoria("SELECT * FROM catcategoriasplaza WHERE id='" + rs2.getString("tipocategoria") + "'");
                                                if (tipo_categoria == null) {
                                                    out.print("");
                                                } else {
                                                    out.print(tipo_categoria);
                                                }


                                            %>
                                        </div>
                                    </td>
                                    <td align="center">
                                        <div class="c_nom"> 
                                            <%                                            nombre_jornada = cn.buscarjornada("SELECT * FROM catjornada WHERE id='" + rs2.getString("jornada") + "'");
                                                if (nombre_jornada == null) {
                                                    out.print("");
                                                } else {
                                                    out.print(nombre_jornada);
                                                }
                                            %>
                                        </div>
                                    </td>

                                    <td align="center">
                                        <div class="datos_tabla"> 
                                            <% if (rs2.getString("vacancia") == null) {
                                                    out.print("");
                                                } else {
                                                    out.print(rs2.getString("vacancia"));
                                                }
                                            %>
                                        </div>
                                    </td>
                                </tr>
                                <%}
                                    }//fin if elegir
                                    else {
                                        response.sendRedirect("login.jsp");
                                    }
                                %>
                            </table><br><br>
                            <%} else if (request.getAttribute("control_combobox").equals("true") && request.getAttribute("nacional").equals("2")) {
                                String sub = "1";
                            %> <%--OPCION ADMINISTRADOR ESTATAL --%>
                            <table  border="0" width="120%">   
                                <tr>
                                    <td align="center">
                                        <label>Subsistema</label><br>
                                        <%
                                            ResultSet rs9 = cn.mostrar("Select * from usuario WHERE entidad='" + request.getAttribute("dato_ent") + "' && plantel='" + request.getAttribute("dato_pla") + "' && nombre='" + request.getAttribute("nom") + "' && curp='" + request.getAttribute("dato_rfc") + "'");
                                        %>

                                        <select name="subsistema" id="subsistema" disabled="true" onchange="seleccion_subsistema()">
                                            <%
                                                while (rs9.next()) {
                                                    if (rs9.getString("idSubsistema").equals("1")) {
                                                        sub = "1";
                                            %>
                                            <option value="UEMSTIS">DGETI</option> 
                                            <input type="hidden" name="num_sub" id="num_sub" value="1">
                                            <%} else {
                                                sub = "2";
                                            %>
                                            <option value="CECyTE">CECyTE</option>
                                            <input type="hidden" name="num_sub" id="num_sub" value="2">
                                            <% }
                                            %>


                                            <%//              regresa del combobox         muestra en el combo box
                                                }
                                            %>                                              
                                        </select>   

                                        <div id="nsub"></div>
                                    </td>

                                    <td align="center">
                                        <input type="hidden" name="f_opc" id="i_opc">
                                        <input type="hidden" name="campoentidad70" id="campoentidad70" >
                                        <label>Entidad</label><br>

                                        <%
                                            ResultSet rs = cn.mostrar("Select id, entidad from catentidades WHERE id='" + request.getAttribute("dato_ent") + "'");
                                        %>

                                        <select class="select" name="entidad" id="entidad" disabled="true">
                                            <%
                                                while (rs.next()) {
                                            %>
                                            <option value="<%=rs.getString("id")%>"><%=rs.getString("entidad")%></option>
                                            <%
                                                }
                                            %>
                                        </select>
                                    </td>
                                    <td align="center">
                                        <label>Plantel</label><br>                                 
                                        <%
                                            ResultSet rs10 = cn.mostrar("Select * from catplanteles WHERE idEntidad='" + request.getAttribute("dato_ent") + "' && idSubsistema='"+sub+"'");
                                        %>
                                        <select class="select" name="n_plantel" id="i_plantel">
                                            <option value="0">Escoge una opcion</option>
                                            <%
                                                while (rs10.next()) {
                                            %>                 
                                            <option value="<%=rs10.getString("id")%>"><%=rs10.getString("plantel")%></option>
                                            <%
                                                }
                                            %>
                                        </select>
                                    </td>
                                    <td align="center">
                                        <label>Categoria Plaza</label><br>
                                        <select class="select" name="categoria" id="i_plantel">
                                            <option value="0">Escoge una opcion</option>
                                            <option value="TD">Tecnico docente</option> 
                                            <option value="D">Docente</option>
                                        </select>

                                    </td>
                                </tr>
                                <tr>
                                    <td></td>
                                    <td></td>
                                    <td>
                                        <div class="error"> 
                                            <% if (request.getAttribute("error") == null) {
                                                    out.print("");
                                                } else {
                                                    out.print(request.getAttribute("error"));
                                                }


                                            %>
                                        </div>
                                    </td>
                                </tr>

                            </table><br><br>

                            <div class="form-group">
                                <button class="btn btn-primary pull-right" type="submit" name="pVacancia" form="data2">Agregar</button>
                                <button class="btn btn-primary pull-right" type="submit" name="buscarvacancia">Buscar</button>

                            </div>
                            <br><br>

                            <table  border="1" width="160%" id="tabla_usuarios" class="display">  
                                <thead>
                                    <tr>
                                        <th>Subsistema</th>
                                        <th>Estado</th>
                                        <th>Plantel</th>
                                        <th>Plaza</th>
                                        <th>#Plazas</th>
                                        <th>Tipo de Categoria</th>
                                        <th>Jornada</th> 
                                        <th>Vacancia</th>
                                    </tr>
                                </thead>
                                <%  String cadena="";
                                    String elegir1 = "0";
                                    String nombre_subsistema = "";
                                    String nombre_entidad = "";
                                    String nombre_plantel = "";
                                    String tipo_categoria = "";
                                    String nombre_jornada = "";

                                    if (request.getAttribute("cadena") == null) {
                                        cadena="SELECT a.*,c.subsistema FROM vacancia a join catplanteles b on a.plantel=b.id join catsubsistema c on b.idSubsistema=c.id;";
                                    } else {
                                        cadena = request.getAttribute("cadena").toString();
                                    }
                                    
                                    elegir1 = String.valueOf(request.getAttribute("opc"));

                                    if (elegir1.equals("1")) {
                                        ResultSet rs2 = null;
                                        if (request.getAttribute("consulta").equals("1")) {
                                          //rs2 = cn.mostrar_usuarios("SELECT * FROM vacancia WHERE entidad='" + request.getAttribute("dato_ent") + "'");
                                            rs2 = cn.mostrar_usuarios(cadena);
                                        }

                                        if (request.getAttribute("consulta").equals("3")) {
                                           //rs2 = cn.mostrar_usuarios("SELECT * FROM vacancia WHERE entidad='" + request.getAttribute("dato_ent") + "' && plantel='" + request.getAttribute("pla") + "'");
                                           rs2 = cn.mostrar_usuarios(cadena);
                                        }

                                        if (request.getAttribute("consulta").equals("5")) {
                                            //rs2 = cn.mostrar_usuarios("SELECT * FROM vacancia WHERE entidad='" + request.getAttribute("dato_ent") + "' && plaza='" + request.getAttribute("cat") + "'");
                                            rs2 = cn.mostrar_usuarios(cadena);
                                        }

                                        if (request.getAttribute("consulta").equals("6")) {
                                            //rs2 = cn.mostrar_usuarios("SELECT * FROM vacancia WHERE entidad='" + request.getAttribute("dato_ent") + "' && plantel='" + request.getAttribute("pla") + "' && plaza='" + request.getAttribute("cat") + "'");
                                            rs2 = cn.mostrar_usuarios(cadena);
                                        }

                                        while (rs2.next()) {
                                %>
                                <tr>
                                    <td align="center">
                                        <div class="datos_tabla"> 
                                            <%
                                                nombre_subsistema = cn.buscarsubsistema("SELECT * FROM catsubsistema WHERE id='" + sub + "'");
                                                if (nombre_subsistema == null) {
                                                    out.print("");
                                                } else {
                                                    out.print(nombre_subsistema);
                                                }
                                            %>
                                    </td>
                                    
                                    <td align="center">
                                        <div class="datos_tabla"> 
                                            <%
                                                nombre_entidad = cn.buscarentidad("SELECT * FROM catentidades WHERE id='" + rs2.getString("entidad") + "'");
                                                if (nombre_entidad == null) {
                                                    out.print("");
                                                } else {
                                                    out.print(nombre_entidad);
                                                }
                                            %>
                                        </div>
                                    </td>
                                    <td align="center">
                                        <div class="datos_tabla"> 
                                            <%
                                                nombre_plantel = cn.buscarplantel("SELECT * FROM catplanteles WHERE id='" + rs2.getString("plantel") + "'");
                                                if (nombre_plantel == null) {
                                                    out.print("");
                                                } else {
                                                    out.print(nombre_plantel);
                                                }
                                            %>
                                        </div>
                                    </td>
                                    <td align="center">
                                        <div class="datos_tabla"> 
                                            <% if (rs2.getString("plaza") == null) {
                                                    out.print("");
                                                } else {
                                                    out.print(rs2.getString("plaza"));
                                                }
                                            %>
                                        </div>
                                    </td>
                                    <td align="center">
                                        <div class="datos_tabla"> 
                                            <% if (rs2.getString("cantidadplazas") == null) {
                                                    out.print("");
                                                } else {
                                                    out.print(rs2.getString("cantidadplazas"));
                                                }
                                            %>
                                        </div>
                                    </td>
                                    <td align="center">
                                        <div class="c_nom"> 
                                            <%
                                                tipo_categoria = cn.buscartipocategoria("SELECT * FROM catcategoriasplaza WHERE id='" + rs2.getString("tipocategoria") + "'");
                                                if (tipo_categoria == null) {
                                                    out.print("");
                                                } else {
                                                    out.print(tipo_categoria);
                                                }


                                            %>
                                        </div>
                                    </td>
                                    <td align="center">
                                        <div class="c_nom"> 
                                            <%                                            nombre_jornada = cn.buscarjornada("SELECT * FROM catjornada WHERE id='" + rs2.getString("jornada") + "'");
                                                if (nombre_jornada == null) {
                                                    out.print("");
                                                } else {
                                                    out.print(nombre_jornada);
                                                }
                                            %>
                                        </div>
                                    </td>

                                    <td align="center">
                                        <div class="datos_tabla"> 
                                            <% if (rs2.getString("vacancia") == null) {
                                                    out.print("");
                                                } else {
                                                    out.print(rs2.getString("vacancia"));
                                                }
                                            %>
                                        </div>
                                    </td>
                                </tr>
                                <%}
                                    }//fin if elegir
                                    else {
                                        response.sendRedirect("login.jsp");
                                    }
                                %>
                            </table><br><br>

                            <%} else if (request.getAttribute("control_combobox").equals("true") && request.getAttribute("nacional").equals("3")) {
                            String sub = "1";%> <%--OPCION ADMINISTRADOR PLANTEL --%>
                            <table  border="0" width="120%">   
                                <tr>
                                    
                                    <td align="center">
                                        <label>Subsistema</label><br>
                                        <%
                                            ResultSet rs9 = cn.mostrar("Select * from usuario WHERE entidad='" + request.getAttribute("dato_ent") + "' && plantel='" + request.getAttribute("dato_pla") + "' && nombre='" + request.getAttribute("nom") + "' && curp='" + request.getAttribute("dato_rfc") + "'");
                                        %>

                                        <select name="subsistema" id="subsistema" disabled="true" onchange="seleccion_subsistema()">
                                            <%
                                                while (rs9.next()) {
                                                    if (rs9.getString("idSubsistema").equals("1")) {
                                                        sub = "1";
                                            %>
                                            <option value="UEMSTIS">DGETI</option> 
                                            <input type="hidden" name="num_sub" id="num_sub" value="1">
                                            <%} else {
                                                sub = "2";
                                            %>
                                            <option value="CECyTE">CECyTE</option>
                                            <input type="hidden" name="num_sub" id="num_sub" value="2">
                                            <% }
                                            %>


                                            <%//              regresa del combobox         muestra en el combo box
                                                }
                                            %>                                              
                                        </select>   

                                        <div id="nsub"></div>
                                    </td>
                                    
                                    <td align="center">
                                        <input type="hidden" name="f_opc" id="i_opc">
                                        <input type="hidden" name="campoentidad70" id="campoentidad70" >
                                        <label>Entidad</label><br>

                                        <%
                                            ResultSet rs = cn.mostrar("Select id, entidad from catentidades WHERE id='" + request.getAttribute("dato_ent") + "'");
                                        %>

                                        <select class="select" name="entidad" id="entidad" onchange="plantel()" disabled="true">
                                            <%
                                                while (rs.next()) {
                                            %>
                                            <option value="<%=rs.getString("id")%>"><%=rs.getString("entidad")%></option>
                                            <%
                                                }
                                            %>
                                        </select>
                                    </td>
                                    <td align="center">
                                        <label>Plantel</label><br>                                 
                                        <%
                                            ResultSet rs10 = cn.mostrar("Select * from catplanteles WHERE id='" + request.getAttribute("dato_pla") + "'");
                                        %>

                                        <select class="select" name="n_plantel" id="i_plantel" disabled="true">
                                            <%
                                                while (rs10.next()) {
                                            %>
                                            <option value="<%=rs10.getString("id")%>"><%=rs10.getString("plantel")%></option>
                                            <%
                                                }
                                            %>
                                        </select>
                                    </td>
                                    <td align="center">
                                        <label>Categoria Plaza</label><br>
                                        <select class="select" name="categoria" id="i_plantel">
                                            <option value="0">Escoge una opcion</option>
                                            <option value="TD">Tecnico docente</option> 
                                            <option value="D">Docente</option>
                                        </select>

                                    </td>
                                </tr>
                                <tr>
                                    <td></td>
                                    <td></td>
                                    <td>
                                        <div class="error"> 
                                            <% if (request.getAttribute("error") == null) {
                                                    out.print("");
                                                } else {
                                                    out.print(request.getAttribute("error"));
                                                }


                                            %>
                                        </div>
                                    </td>
                                </tr>

                            </table><br><br>

                            <div class="form-group">
                                <button class="btn btn-primary pull-right" type="submit" name="pVacancia" form="data2">Agregar</button>
                                <button class="btn btn-primary pull-right" type="submit" name="buscarvacancia">Buscar</button>

                            </div>
                            <br><br>

                            <table  border="1" width="160%" id="tabla_usuarios" class="display">  
                                <thead>
                                    <tr>
                                        <th>Subsistema</th>
                                        <th>Estado</th>
                                        <th>Plantel</th>
                                        <th>Plaza</th>
                                        <th>#Plazas</th>
                                        <th>Tipo de Categoria</th>
                                        <th>Jornada</th> 
                                        <th>Vacancia</th>
                                    </tr>
                                </thead>
                                <%  
                                    String cadena = "";
                                    String elegir1 = "0";
                                    String nombre_subsistema = "";
                                    String nombre_entidad = "";
                                    String nombre_plantel = "";
                                    String tipo_categoria = "";
                                    String nombre_jornada = "";

                                    if (request.getAttribute("cadena") == null) {
                                    } else {
                                        cadena = request.getAttribute("cadena").toString();
                                    }
                                    
                                    elegir1 = String.valueOf(request.getAttribute("opc"));

                                    if (elegir1.equals("1")) {
                                        ResultSet rs2 = null;
                                        if (request.getAttribute("consulta").equals("1")) {
                                            //rs2 = cn.mostrar_usuarios("SELECT * FROM vacancia WHERE entidad='" + request.getAttribute("dato_ent") + "' && plantel='" + request.getAttribute("dato_pla") + "'");
                                            rs2 = cn.mostrar_usuarios(cadena);
                                        }

                                        if (request.getAttribute("consulta").equals("2")) {

                                            //rs2 = cn.mostrar_usuarios("SELECT * FROM vacancia WHERE entidad='" + request.getAttribute("dato_ent") + "' && plantel='" + request.getAttribute("dato_pla") + "' && plaza='" + request.getAttribute("cat") + "'");
                                            rs2 = cn.mostrar_usuarios(cadena);
                                        }

                                        while (rs2.next()) {
                                %>
                                <tr>
                                    
                                    <td align="center">
                                    <div class="datos_tabla"> 
                                        <%
                                            nombre_subsistema = cn.buscarsubsistema("SELECT * FROM catsubsistema WHERE id='" + sub + "'");
                                            if (nombre_subsistema == null) {
                                                out.print("");
                                            } else {
                                                out.print(nombre_subsistema);
                                            }
                                        %>
                                </td>
                                    
                                    <td align="center">
                                        <div class="datos_tabla"> 
                                            <%
                                                nombre_entidad = cn.buscarentidad("SELECT * FROM catentidades WHERE id='" + rs2.getString("entidad") + "'");
                                                if (nombre_entidad == null) {
                                                    out.print("");
                                                } else {
                                                    out.print(nombre_entidad);
                                                }
                                            %>
                                        </div>
                                    </td>
                                    <td align="center">
                                        <div class="datos_tabla"> 
                                            <%
                                                nombre_plantel = cn.buscarplantel("SELECT * FROM catplanteles WHERE id='" + rs2.getString("plantel") + "'");
                                                if (nombre_plantel == null) {
                                                    out.print("");
                                                } else {
                                                    out.print(nombre_plantel);
                                                }
                                            %>
                                        </div>
                                    </td>
                                    <td align="center">
                                        <div class="datos_tabla"> 
                                            <% if (rs2.getString("plaza") == null) {
                                                    out.print("");
                                                } else {
                                                    out.print(rs2.getString("plaza"));
                                                }
                                            %>
                                        </div>
                                    </td>
                                    <td align="center">
                                        <div class="datos_tabla"> 
                                            <% if (rs2.getString("cantidadplazas") == null) {
                                                    out.print("");
                                                } else {
                                                    out.print(rs2.getString("cantidadplazas"));
                                                }
                                            %>
                                        </div>
                                    </td>
                                    <td align="center">
                                        <div class="c_nom"> 
                                            <%
                                                tipo_categoria = cn.buscartipocategoria("SELECT * FROM catcategoriasplaza WHERE id='" + rs2.getString("tipocategoria") + "'");
                                                if (tipo_categoria == null) {
                                                    out.print("");
                                                } else {
                                                    out.print(tipo_categoria);
                                                }


                                            %>
                                        </div>
                                    </td>
                                    <td align="center">
                                        <div class="c_nom"> 
                                            <%                                            nombre_jornada = cn.buscarjornada("SELECT * FROM catjornada WHERE id='" + rs2.getString("jornada") + "'");
                                                if (nombre_jornada == null) {
                                                    out.print("");
                                                } else {
                                                    out.print(nombre_jornada);
                                                }
                                            %>
                                        </div>
                                    </td>

                                    <td align="center">
                                        <div class="datos_tabla"> 
                                            <% if (rs2.getString("vacancia") == null) {
                                                    out.print("");
                                                } else {
                                                    out.print(rs2.getString("vacancia"));
                                                }
                                            %>
                                        </div>
                                    </td>
                                </tr>
                                <%}
                                    }//fin if elegir
                                    else {
                                        response.sendRedirect("login.jsp");
                                    }
                                %>
                            </table><br><br>


                            <%}
                            %>
                            <%
                                session.setAttribute("idUsuario", idUsuario);
                                session.setAttribute("rfc", rfc);
                            %>
                            <input type="hidden" name="control_combobox" id="control_combobox" value="<%=request.getAttribute("control_combobox")%>">
                            <input type="hidden" name="nacional" id="nacional" value="<%=request.getAttribute("nacional")%>"> <%--AGREGAR--%>
                            <input type="hidden" name="permiso1" id="permiso1" value="<%=request.getAttribute("per1")%>">
                            <input type="hidden" name="permiso2" id="permiso2" value="<%=request.getAttribute("per2")%>">
                            <input type="hidden" name="permiso4" id="permiso4" value="<%=request.getAttribute("per4")%>">
                            <input type="hidden" name="nombre" id="nombre" value="<%=request.getAttribute("nom")%>">
                            <input type="hidden" name="dato_ent" id="dato_ent" value="<%=request.getAttribute("dato_ent")%>">
                            <input type="hidden" name="dato_pla" id="dato_pla" value="<%=request.getAttribute("dato_pla")%>">
                            <input type="hidden" name="dato_rfc" id="dato_rfc" value="<%=request.getAttribute("dato_rfc")%>">
                        </form>   
                    </div>
                    <asideart class="asideart">

                    </asideart>
                </section> 
                <form id="data2" class="form-horizontal" role="form" method="POST" action="Servlet_P_Vacancia">
                    <%
                        session.setAttribute("idUsuario", idUsuario);
                        session.setAttribute("rfc", rfc);
                    %>
                    <input type="hidden" name="control_combobox" id="control_combobox" value="<%=request.getAttribute("control_combobox")%>">
                    <input type="hidden" name="nacional" id="nacional" value="<%=request.getAttribute("nacional")%>"> <%--AGREGAR--%>
                    <input type="hidden" name="permiso1" id="permiso1" value="<%=request.getAttribute("per1")%>">
                    <input type="hidden" name="permiso2" id="permiso2" value="<%=request.getAttribute("per2")%>">
                    <input type="hidden" name="permiso4" id="permiso4" value="<%=request.getAttribute("per4")%>">
                    <input type="hidden" name="nombre" id="nombre" value="<%=request.getAttribute("nom")%>">
                    <input type="hidden" name="dato_ent" id="dato_ent" value="<%=request.getAttribute("dato_ent")%>">
                    <input type="hidden" name="dato_pla" id="dato_pla" value="<%=request.getAttribute("dato_pla")%>">
                    <input type="hidden" name="dato_rfc" id="dato_rfc" value="<%=request.getAttribute("dato_rfc")%>">


                </form>



                <!-- JS  para el framework del gobierno-->
                <script src="https://framework-gb.cdn.gob.mx/gobmx.js"></script>
            </div>
            <%
                } else {
                    response.sendRedirect("login.jsp");
                }
            %>
            <!-- Modal -->
            <div class="modal fade" id="modalMensaje" role="dialog">
                <div class="modal-dialog">

                    <!-- Modal content-->
                    <div class="modal-content panel">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal">&times;</button>
                            <h4 class="modal-title">Aviso</h4>
                        </div>
                        <div class="modal-body">
                            <p id="mensaje">Datos Guardados</p>
                        </div>
                        <div class="modal-footer">
                            <%--  <a id="btnContinuar" href="login.jsp" class="btn btn-sm btn-default">Continuar</a> --%>
                            <button id="btnCerrar" type="button" class="btn btn-sm btn-default" data-dismiss="modal">Cerrar</button>
                        </div>
                    </div>

                </div>
            </div> 


        </main>
    </body>
</html>
