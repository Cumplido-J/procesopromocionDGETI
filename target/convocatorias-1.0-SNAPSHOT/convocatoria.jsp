<%-- 
    Document   : convocatoria
    Created on : 30-jul-2020, 14:29:31
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


        <%--<script type="text/javascript" src="js/jquery-1.11.1.min.js"></script> --%>
        <link rel="stylesheet" href="css/jquery.dataTables.min.css">
        <%-- <script src="js/jquery-3.5.1.min.js"></script> --%>
        <script src="js/jquery.dataTables.min.js"></script>
        <script type="text/javascript">

            function seleccion_subsistema() {
                $("#entidad").val("0");
                $("#i_plantel").val("0");
            }

            function plantel() {
                $("#i_opc").val("1");
                $.post("combo9.jsp", $("#data").serialize(), function (data) {
                    $("#i_plantel").html(data);
                });
            }

            function plantel2() {
                if (document.getElementById("i_plantel").value == "0")
                {
                    $("#n8").text("Selecciona un plantel").css("color", "green");
                } else {
                    $("#n8").text("").css("color", "red");
                }
            }


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

            $(document).ready(function () {
                $('#tabla_usuarios').DataTable();
            
                var modal = document.getElementById("modal").value;
                //alert(modal);
                if (modal == "1") {
                    $("#modalMensaje").modal("show");
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
                if (session.getAttribute("idUsuario") != null && session.getAttribute("rfc") != null) {
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
                    <p> DGETI > Promoción Docente > Convocatoria</p>
                </div>
                <section class="sectionart">
                    <div class="articulosart">
                        <center><h4>Carga de Convocatoria</h4></center>
                        <br>
                        <jsp:useBean id="cn" class="metodos_sql.Metodos_sql" scope="page"></jsp:useBean>
                            <form id="data" class="form-horizontal" role="form" method="POST" action="Servlet_buscar_convocatoria">
                                <input type="hidden" name="modal" id="modal" value="<%=request.getAttribute("modal")%>">
                            <%-------------------------------------------------------------------OPCION super usuario nacional COMBO BOX----------------------------%>   
                            <%if (request.getAttribute("control_combobox").equals("false") && request.getAttribute("nacional").equals("1")) { %> <%--SUPER USUARIO--%>
                            <center>
                                <div class="registro">
                                    <div class="caja">
                                        <label>Subsistema</label><br>
                                        <%
                                            ResultSet rs9 = cn.mostrar("Select id, subsistema from catsubsistema");
                                        %>

                                        <select class="form-control" name="subsistema" id="subsistema" onchange="seleccion_subsistema()">
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
                                    </div>




                                    <div class="caja">
                                        <input type="hidden" name="f_opc" id="i_opc">
                                        <input type="hidden" name="campoentidad" id="campoentidad" >
                                        <label>Entidad</label><br>

                                        <%
                                            ResultSet rs = cn.mostrar("Select id, entidad from catentidades");
                                        %>

                                        <select class="form-control" name="entidad" id="entidad" onchange="plantel()">
                                            <option value="0">Escoge una opcion</option>
                                            <%
                                                while (rs.next()) {
                                            %>
                                            <option value="<%=rs.getString("id")%>"><%=rs.getString("entidad")%></option>

                                            <%//              regresa del combobox         muestra en el combo box
                                                }
                                            %>                                              
                                        </select>           
                                        <div id="n8"></div>
                                    </div>

                                    <div class="caja">   
                                        <label>Plantel</label><br>
                                        <select class="form-control" name="n_plantel" id="i_plantel" onchange="plantel2()">
                                            <option value="0">Escoge una opcion</option>                                     
                                        </select>
                                        </td></div>

                                    <div class="caja"> 
                                        <label>Estatus</label><br>
                                        <select class="form-control" name="estatus" id="estatus" >
                                            <option value="0">Escoge una opcion</option>
                                            <option value="temporal">Temporal</option>
                                            <option value="definitiva">Definitiva</option>
                                        </select>
                                        </td></div>

                                    <div class="caja">                                          
                                        <input type="hidden" name="publicaciont" id="publicaciont" >
                                        <label>Publicación</label><br>
                                        <input class="form-control" type="date" id="publicacion" name="publicacion" value="" min="2020-01-01" max="2020-12-31">
                                    </div>

                                    <div class="caja">
                                        <input type="hidden" name="resultadost" id="resultadost" >
                                        <label>Resultados</label><br>
                                        <input class="form-control" type="date" id="resultados" name="resultados" value="" min="2020-01-01" max="2020-12-31">
                                    </div>
                                </div>
                            </center>
                            <br><br>

                            <div class="registro">

                                <button class="btn btn-primary pull-right" type="submit" name="buscar_convocatoria">Buscar</button>
                                <button class="btn btn-primary pull-right" type="submit" name="agregar_convocatoria" form="data2">Agregar</button>
                                <button class="btn btn-primary pull-right" type="submit" name="modificar_convocatoria" form="data6">Modificar</button>



                            </div>
                            <br><br>

                            <table  border="1"  id="tabla_usuarios" class="display">  
                                <thead>
                                    <tr>
                                        <th>Subsistema</th>
                                        <th>Nombre</th>
                                        <th>Publicacion</th>
                                        <th>Inicio Registro</th>
                                        <th>Fin Registro</th>
                                        <th>Inicio Valoracion</th>
                                        <th>Fin Valoracion</th> 
                                        <th>Inicio Dictaminación</th>
                                        <th>Fin Dictaminación</th>
                                        <th>Resultados</th>
                                        <th>Estatus</th>
                                    </tr>
                                </thead>
                                <%
                                    String elegir1 = "0";
                                    String cadena = "";
                                    String nombre_subsistema = "";
                                    String nombre_entidad = "";
                                    String nombre_plantel = "";
                                    String tipo_categoria = "";
                                    String nombre_jornada = "";

                                    if (request.getAttribute("cadena") == null) {
                                        cadena="SELECT a.*,b.programa, d.idEntidad,e.subsistema,f.entidad,d.plantel FROM convocatoria a join catprogramas b on a.idPrograma=b.id join catplanteles d on a.idPlantel=d.id join catsubsistema e on d.idSubsistema=e.id join catentidades f on d.idEntidad=f.id;";
                                    } else {
                                        cadena = request.getAttribute("cadena").toString();
                                        System.out.println("cadena="+cadena);
                                    }

                                    elegir1 = String.valueOf(request.getAttribute("opc"));

                                    if (elegir1.equals("1")) {
                                        ResultSet rs20 = null;
                                        if (request.getAttribute("consulta").equals("0")) {
                                            //rs2 = cn.mostrar_usuarios("SELECT * FROM convocatoria WHERE estatus='temporal'");                                            
                                            rs20 = cn.mostrar_usuarios(cadena);
                                        }

                                        if (request.getAttribute("consulta").equals("1")) {
                                            rs20 = cn.mostrar_usuarios(cadena);
                                        }

                                        if (request.getAttribute("consulta").equals("2")) {
                                            //rs20 = cn.mostrar_usuarios("SELECT a.*,b.programa FROM convocatoria a join catProgramas b on a.idPrograma=b.id WHERE publicacion='" + request.getAttribute("pub") + "'");
                                            rs20 = cn.mostrar_usuarios(cadena);
                                        }

                                        if (request.getAttribute("consulta").equals("3")) {
                                            //rs20 = cn.mostrar_usuarios("SELECT a.*,b.programa FROM convocatoria a join catProgramas b on a.idPrograma=b.id WHERE publicacion='" + request.getAttribute("pub") + "' && resultados='" + request.getAttribute("res") + "'");
                                            rs20 = cn.mostrar_usuarios(cadena);
                                        }

                                        if (request.getAttribute("consulta").equals("4")) {
                                            //rs20 = cn.mostrar_usuarios("SELECT a.*,b.programa FROM convocatoria a join catProgramas b on a.idPrograma=b.id WHERE estatus='" + request.getAttribute("est") + "'");
                                            rs20 = cn.mostrar_usuarios(cadena);
                                        }

                                        if (request.getAttribute("consulta").equals("5")) {
                                            //rs20 = cn.mostrar_usuarios("SELECT a.*,b.programa FROM convocatoria a join catProgramas b on a.idPrograma=b.id WHERE estatus='" + request.getAttribute("est") + "' && resultados='" + request.getAttribute("res") + "'");
                                            rs20 = cn.mostrar_usuarios(cadena);
                                        }

                                        if (request.getAttribute("consulta").equals("6")) {
                                            //rs20 = cn.mostrar_usuarios("SELECT a.*,b.programa FROM convocatoria a join catProgramas b on a.idPrograma=b.id WHERE estatus='" + request.getAttribute("est") + "' && publicacion='" + request.getAttribute("pub") + "'");
                                            rs20 = cn.mostrar_usuarios(cadena);
                                        }

                                        if (request.getAttribute("consulta").equals("7")) {
                                            //rs20 = cn.mostrar_usuarios("SELECT a.*,b.programa FROM convocatoria a join catProgramas b on a.idPrograma=b.id WHERE estatus='" + request.getAttribute("est") + "' && publicacion='" + request.getAttribute("pub") + "' && resultados='" + request.getAttribute("res") + "'");
                                            rs20 = cn.mostrar_usuarios(cadena);
                                        }

                                        if (request.getAttribute("consulta").equals("8")) {
                                            //rs20 = cn.mostrar_usuarios("SELECT a.*,b.programa FROM convocatoria a join catProgramas b on a.idPrograma=b.id WHERE idPlantel='" + request.getAttribute("pla") + "'");
                                            rs20 = cn.mostrar_usuarios(cadena);
                                        }

                                        if (request.getAttribute("consulta").equals("9")) {
                                            //rs20 = cn.mostrar_usuarios("SELECT a.*,b.programa FROM convocatoria a join catProgramas b on a.idPrograma=b.id WHERE idPlantel='" + request.getAttribute("pla") + "' && resultados='" + request.getAttribute("res") + "'");
                                            rs20 = cn.mostrar_usuarios(cadena);
                                        }

                                        if (request.getAttribute("consulta").equals("10")) {
                                            //rs20 = cn.mostrar_usuarios("SELECT a.*,b.programa FROM convocatoria a join catProgramas b on a.idPrograma=b.id WHERE idPlantel='" + request.getAttribute("pla") + "' && publicacion='" + request.getAttribute("pub") + "'");
                                            rs20 = cn.mostrar_usuarios(cadena);
                                        }

                                        if (request.getAttribute("consulta").equals("11")) {
                                            //rs20 = cn.mostrar_usuarios("SELECT a.*,b.programa FROM convocatoria a join catProgramas b on a.idPrograma=b.id WHERE idPlantel='" + request.getAttribute("pla") + "' && publicacion='" + request.getAttribute("pub") + "' && resultados='" + request.getAttribute("res") + "'");
                                            rs20 = cn.mostrar_usuarios(cadena);
                                        }

                                        if (request.getAttribute("consulta").equals("12")) {
                                            //rs20 = cn.mostrar_usuarios("SELECT a.*,b.programa FROM convocatoria a join catProgramas b on a.idPrograma=b.id WHERE idPlantel='" + request.getAttribute("pla") + "' && estatus='" + request.getAttribute("est") + "'");
                                            rs20 = cn.mostrar_usuarios(cadena);
                                        }

                                        if (request.getAttribute("consulta").equals("13")) {
                                            //rs20 = cn.mostrar_usuarios("SELECT a.*,b.programa FROM convocatoria a join catProgramas b on a.idPrograma=b.id WHERE idPlantel='" + request.getAttribute("pla") + "' && estatus='" + request.getAttribute("est") + "' && resultados='" + request.getAttribute("res") + "'");
                                            rs20 = cn.mostrar_usuarios(cadena);
                                        }

                                        if (request.getAttribute("consulta").equals("14")) {
                                            //rs20 = cn.mostrar_usuarios("SELECT a.*,b.programa FROM convocatoria a join catProgramas b on a.idPrograma=b.id WHERE idPlantel='" + request.getAttribute("pla") + "' && estatus='" + request.getAttribute("est") + "' && publicacion='" + request.getAttribute("pub") + "'");
                                            rs20 = cn.mostrar_usuarios(cadena);
                                        }

                                        if (request.getAttribute("consulta").equals("15")) {
                                            //rs20 = cn.mostrar_usuarios("SELECT a.*,b.programa FROM convocatoria a join catProgramas b on a.idPrograma=b.id WHERE idPlantel='" + request.getAttribute("pla") + "' && estatus='" + request.getAttribute("est") + "' && publicacion='" + request.getAttribute("pub") + "' && resultados='" + request.getAttribute("res") + "'");
                                            rs20 = cn.mostrar_usuarios(cadena);
                                        }

                                        if (request.getAttribute("consulta").equals("16")) {
                                            //rs20 = cn.mostrar_usuarios("SELECT a.*,b.programa, d.idEntidad FROM convocatoria a join catProgramas b on a.idPrograma=b.id join catplanteles d on a.idPlantel=d.id where d.idEntidad='" + request.getAttribute("ent") + "'");
                                            rs20 = cn.mostrar_usuarios(cadena);
                                        }

                                        if (request.getAttribute("consulta").equals("17")) {
                                            //rs20 = cn.mostrar_usuarios("SELECT a.*,b.programa, d.idEntidad FROM convocatoria a join catProgramas b on a.idPrograma=b.id join catplanteles d on a.idPlantel=d.id where d.idEntidad='" + request.getAttribute("ent") + "' && resultados='" + request.getAttribute("res") + "'");
                                            rs20 = cn.mostrar_usuarios(cadena);
                                        }

                                        if (request.getAttribute("consulta").equals("18")) {
                                            //rs20 = cn.mostrar_usuarios("SELECT a.*,b.programa, d.idEntidad FROM convocatoria a join catProgramas b on a.idPrograma=b.id join catplanteles d on a.idPlantel=d.id where d.idEntidad='" + request.getAttribute("ent") + "' && publicacion='" + request.getAttribute("pub") + "'");
                                            rs20 = cn.mostrar_usuarios(cadena);
                                        }

                                        if (request.getAttribute("consulta").equals("19")) {
                                            //rs20 = cn.mostrar_usuarios("SELECT a.*,b.programa, d.idEntidad FROM convocatoria a join catProgramas b on a.idPrograma=b.id join catplanteles d on a.idPlantel=d.id where d.idEntidad='" + request.getAttribute("ent") + "' && publicacion='" + request.getAttribute("pub") + "' && resultados='" + request.getAttribute("res") + "'");
                                            rs20 = cn.mostrar_usuarios(cadena);
                                        }

                                        if (request.getAttribute("consulta").equals("20")) {
                                            //rs20 = cn.mostrar_usuarios("SELECT a.*,b.programa, d.idEntidad FROM convocatoria a join catProgramas b on a.idPrograma=b.id join catplanteles d on a.idPlantel=d.id where d.idEntidad='" + request.getAttribute("ent") + "' && estatus='" + request.getAttribute("est") + "'");
                                            rs20 = cn.mostrar_usuarios(cadena);
                                        }

                                        if (request.getAttribute("consulta").equals("21")) {
                                            //rs20 = cn.mostrar_usuarios("SELECT a.*,b.programa, d.idEntidad FROM convocatoria a join catProgramas b on a.idPrograma=b.id join catplanteles d on a.idPlantel=d.id where d.idEntidad='" + request.getAttribute("ent") + "' && estatus='" + request.getAttribute("est") + "' && resultados='" + request.getAttribute("res") + "'");
                                            rs20 = cn.mostrar_usuarios(cadena);
                                        }

                                        if (request.getAttribute("consulta").equals("22")) {
                                            //rs20 = cn.mostrar_usuarios("SELECT a.*,b.programa, d.idEntidad FROM convocatoria a join catProgramas b on a.idPrograma=b.id join catplanteles d on a.idPlantel=d.id where d.idEntidad='" + request.getAttribute("ent") + "' && estatus='" + request.getAttribute("est") + "' && publicacion='" + request.getAttribute("pub") + "'");
                                            rs20 = cn.mostrar_usuarios(cadena);
                                        }

                                        if (request.getAttribute("consulta").equals("23")) {
                                            //rs20 = cn.mostrar_usuarios("SELECT a.*,b.programa, d.idEntidad FROM convocatoria a join catProgramas b on a.idPrograma=b.id join catplanteles d on a.idPlantel=d.id where d.idEntidad='" + request.getAttribute("ent") + "' && estatus='" + request.getAttribute("est") + "' && publicacion='" + request.getAttribute("pub") + "' && resultados='" + request.getAttribute("res") + "'");
                                            rs20 = cn.mostrar_usuarios(cadena);
                                        }

                                        while (rs20.next()) {
                                %>
                                <tr>
                                    <td align="center">
                                        <div class="datos_tabla"> 
                                            <%
                                                
                                                out.print(rs20.getString("subsistema"));
                                            %>
                                    </td>
                                    <td align="center">
                                        <div class="datos_tabla"> 
                                            <% 
                                                out.println(rs20.getString("entidad")+"-"+rs20.getString("plantel")+"<br/>");
                                                if (rs20.getString("programa") == null) {
                                                    out.println("");
                                                } else {
                                                    out.println(rs20.getString("programa"));
                                                }                                                
                                            %>
                                        </div>
                                    </td>
                                    <td align="center">
                                        <div class="datos_tabla"> 
                                            <% if (rs20.getString("publicacion") == null) {
                                                    out.print("");
                                                } else {
                                                    out.print(rs20.getString("publicacion"));
                                                }
                                            %>
                                        </div>
                                    </td>
                                    <td align="center">
                                        <div class="datos_tabla"> 
                                            <% if (rs20.getString("inicioRegistro") == null) {
                                                    out.print("");
                                                } else {
                                                    out.print(rs20.getString("inicioRegistro"));
                                                }
                                            %>
                                        </div>
                                    </td>
                                    <td align="center">
                                        <div class="datos_tabla"> 
                                            <% if (rs20.getString("finRegistro") == null) {
                                                    out.print("");
                                                } else {
                                                    out.print(rs20.getString("finRegistro"));
                                                }
                                            %>
                                        </div>
                                    </td>
                                    <td align="center">
                                        <div class="datos_tabla"> 
                                            <% if (rs20.getString("inicioValoracion") == null) {
                                                    out.print("");
                                                } else {
                                                    out.print(rs20.getString("inicioValoracion"));
                                                }
                                            %>
                                        </div>
                                    </td>
                                    <td align="center">
                                        <div class="datos_tabla"> 
                                            <% if (rs20.getString("finValoracion") == null) {
                                                    out.print("");
                                                } else {
                                                    out.print(rs20.getString("finValoracion"));
                                                }
                                            %>
                                        </div>
                                    </td>

                                    <td align="center">
                                        <div class="datos_tabla"> 
                                            <% if (rs20.getString("inicioDictaminacion") == null) {
                                                    out.print("");
                                                } else {
                                                    out.print(rs20.getString("inicioDictaminacion"));
                                                }
                                            %>
                                        </div>
                                    </td>

                                    <td align="center">
                                        <div class="datos_tabla"> 
                                            <% if (rs20.getString("finDictaminacion") == null) {
                                                    out.print("");
                                                } else {
                                                    out.print(rs20.getString("finDictaminacion"));
                                                }
                                            %>
                                        </div>
                                    </td>

                                    <td align="center">
                                        <div class="datos_tabla"> 
                                            <% if (rs20.getString("resultados") == null) {
                                                    out.print("");
                                                } else {
                                                    out.print(rs20.getString("resultados"));
                                                    //out.print(idUsuario);
                                                    //out.print(rfc);
                                                }
                                            %>
                                        </div>
                                    </td>

                                    <td align="center">
                                        <div class="datos_tabla"> 
                                            <% if (rs20.getString("estatus") == null) {
                                                    out.print("");
                                                } else {
                                                    out.print(rs20.getString("estatus"));
                                                }
                                            %>

                                        </div>
                                    </td>
                                </tr>
                                <%
                                        }
                                    }//fin if elegir
                                    else {
                                        response.sendRedirect("login.jsp");
                                    }
                                %>
                            </table><br><br>
                            <%}//FIN SUPER USUARIO NACIONAL
                            else if (request.getAttribute("control_combobox").equals("true") && request.getAttribute("nacional").equals("1")) {//ADMINISTRADOR NACIONA
                            %>
                            <center>
                                <div class="registro">

                                    <div class="caja">
                                        <label>Subsistema</label><br>
                                        <%
                                            ResultSet rs9 = cn.mostrar("Select id, subsistema from catsubsistema");
                                        %>

                                        <select class="form-control" name="subsistema" id="subsistema" onchange="seleccion_subsistema()">
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
                                    </div>

                                    <div class="caja">
                                        <input type="hidden" name="f_opc" id="i_opc">
                                        <input type="hidden" name="campoentidad" id="campoentidad" >
                                        <label>Entidad</label><br>

                                        <%
                                            ResultSet rs = cn.mostrar("Select id, entidad from catentidades");
                                        %>

                                        <select class="form-control" name="entidad" id="entidad" onchange="plantel()">
                                            <option value="0">Escoge una opcion</option>
                                            <%
                                                while (rs.next()) {
                                            %>
                                            <option value="<%=rs.getString("id")%>"><%=rs.getString("entidad")%></option>

                                            <%//              regresa del combobox         muestra en el combo box
                                                }
                                            %>                                              
                                        </select>           
                                        <div id="n8"></div>
                                    </div>

                                    <div class="caja">   
                                        <label>Plantel</label><br>
                                        <select class="form-control" name="n_plantel" id="i_plantel" onchange="plantel2()">
                                            <option value="0">Escoge una opcion</option>                                     
                                        </select>
                                        </td></div>

                                    <div class="caja"> 
                                        <label>Estatus</label><br>
                                        <select class="form-control" name="estatus" id="estatus" >
                                            <option value="0">Escoge una opcion</option>
                                            <option value="temporal">Temporal</option>
                                            <option value="definitiva">Definitiva</option>
                                        </select>
                                        </td></div>

                                    <div class="caja">                                          
                                        <input type="hidden" name="publicaciont" id="publicaciont" >
                                        <label>Publicación</label><br>
                                        <input class="form-control" type="date" id="publicacion" name="publicacion" value="" min="2020-01-01" max="2020-12-31">
                                    </div>>

                                    <div class="caja">
                                        <input type="hidden" name="resultadost" id="resultadost" >
                                        <label>Resultados</label><br>
                                        <input class="form-control" type="date" id="resultados" name="resultados" value="" min="2020-01-01" max="2020-12-31">
                                    </div>
                                </div>
                            </center>
                            <br><br>

                            <div class="registro">

                                <button class="btn btn-primary pull-right" type="submit" name="buscar_convocatoria">Buscar</button>
                                <button class="btn btn-primary pull-right" type="submit" name="agregar_convocatoria" form="data2">Agregar</button>
                                <button class="btn btn-primary pull-right" type="submit" name="modificar_convocatoria" form="data6">Modificar</button>



                            </div>
                            <br><br>

                            <table  border="1"  id="tabla_usuarios" class="display">  
                                <thead>
                                    <tr>
                                        <th>Subsistema</th>
                                        <th>Nombre</th>
                                        <th>Publicacion</th>
                                        <th>Inicio Registro</th>
                                        <th>Fin Registro</th>
                                        <th>Inicio Valoracion</th>
                                        <th>Fin Valoracion</th> 
                                        <th>Inicio Dictaminación</th>
                                        <th>Fin Dictaminación</th>
                                        <th>Resultados</th>
                                        <th>Estatus</th>
                                    </tr>
                                </thead>
                                <%
                                    String elegir1 = "0";
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
                                        if (request.getAttribute("consulta").equals("0")) {
                                            //rs2 = cn.mostrar_usuarios("SELECT * FROM convocatoria WHERE estatus='temporal'");
                                            //rs2 = cn.mostrar_usuarios("SELECT a.*,b.programa FROM convocatoria a join catProgramas b on a.idPrograma=b.id WHERE a.id != 0");
                                            rs2 = cn.mostrar_usuarios(cadena);
                                        }

                                        if (request.getAttribute("consulta").equals("1")) {
                                            //rs2 = cn.mostrar_usuarios("SELECT a.*,b.programa FROM convocatoria a join catProgramas b on a.idPrograma=b.id WHERE resultados='" + request.getAttribute("res") + "'");
                                            rs2 = cn.mostrar_usuarios(cadena);
                                        }

                                        if (request.getAttribute("consulta").equals("2")) {
                                            //rs2 = cn.mostrar_usuarios("SELECT a.*,b.programa FROM convocatoria a join catProgramas b on a.idPrograma=b.id WHERE publicacion='" + request.getAttribute("pub") + "'");
                                            rs2 = cn.mostrar_usuarios(cadena);
                                        }

                                        if (request.getAttribute("consulta").equals("3")) {
                                            //rs2 = cn.mostrar_usuarios("SELECT a.*,b.programa FROM convocatoria a join catProgramas b on a.idPrograma=b.id WHERE publicacion='" + request.getAttribute("pub") + "' && resultados='" + request.getAttribute("res") + "'");
                                            rs2 = cn.mostrar_usuarios(cadena);
                                        }

                                        if (request.getAttribute("consulta").equals("4")) {
                                            //rs2 = cn.mostrar_usuarios("SELECT a.*,b.programa FROM convocatoria a join catProgramas b on a.idPrograma=b.id WHERE estatus='" + request.getAttribute("est") + "'");
                                            rs2 = cn.mostrar_usuarios(cadena);
                                        }

                                        if (request.getAttribute("consulta").equals("5")) {
                                            //rs2 = cn.mostrar_usuarios("SELECT a.*,b.programa FROM convocatoria a join catProgramas b on a.idPrograma=b.id WHERE estatus='" + request.getAttribute("est") + "' && resultados='" + request.getAttribute("res") + "'");
                                            rs2 = cn.mostrar_usuarios(cadena);
                                        }

                                        if (request.getAttribute("consulta").equals("6")) {
                                            //rs2 = cn.mostrar_usuarios("SELECT a.*,b.programa FROM convocatoria a join catProgramas b on a.idPrograma=b.id WHERE estatus='" + request.getAttribute("est") + "' && publicacion='" + request.getAttribute("pub") + "'");
                                            rs2 = cn.mostrar_usuarios(cadena);
                                        }

                                        if (request.getAttribute("consulta").equals("7")) {
                                            //rs2 = cn.mostrar_usuarios("SELECT a.*,b.programa FROM convocatoria a join catProgramas b on a.idPrograma=b.id WHERE estatus='" + request.getAttribute("est") + "' && publicacion='" + request.getAttribute("pub") + "' && resultados='" + request.getAttribute("res") + "'");
                                            rs2 = cn.mostrar_usuarios(cadena);
                                        }

                                        if (request.getAttribute("consulta").equals("8")) {
                                            //rs2 = cn.mostrar_usuarios("SELECT a.*,b.programa FROM convocatoria a join catProgramas b on a.idPrograma=b.id WHERE idPlantel='" + request.getAttribute("pla") + "'");
                                            rs2 = cn.mostrar_usuarios(cadena);
                                        }

                                        if (request.getAttribute("consulta").equals("9")) {
                                            //rs2 = cn.mostrar_usuarios("SELECT a.*,b.programa FROM convocatoria a join catProgramas b on a.idPrograma=b.id WHERE idPlantel='" + request.getAttribute("pla") + "' && resultados='" + request.getAttribute("res") + "'");
                                            rs2 = cn.mostrar_usuarios(cadena);
                                        }

                                        if (request.getAttribute("consulta").equals("10")) {
                                            //rs2 = cn.mostrar_usuarios("SELECT a.*,b.programa FROM convocatoria a join catProgramas b on a.idPrograma=b.id WHERE idPlantel='" + request.getAttribute("pla") + "' && publicacion='" + request.getAttribute("pub") + "'");rs2 = cn.mostrar_usuarios(cadena);
                                            rs2 = cn.mostrar_usuarios(cadena);
                                        }

                                        if (request.getAttribute("consulta").equals("11")) {
                                            //rs2 = cn.mostrar_usuarios("SELECT a.*,b.programa FROM convocatoria a join catProgramas b on a.idPrograma=b.id WHERE idPlantel='" + request.getAttribute("pla") + "' && publicacion='" + request.getAttribute("pub") + "' && resultados='" + request.getAttribute("res") + "'");
                                            rs2 = cn.mostrar_usuarios(cadena);
                                        }

                                        if (request.getAttribute("consulta").equals("12")) {
                                            //rs2 = cn.mostrar_usuarios("SELECT a.*,b.programa FROM convocatoria a join catProgramas b on a.idPrograma=b.id WHERE idPlantel='" + request.getAttribute("pla") + "' && estatus='" + request.getAttribute("est") + "'");
                                            rs2 = cn.mostrar_usuarios(cadena);
                                        }

                                        if (request.getAttribute("consulta").equals("13")) {
                                            //rs2 = cn.mostrar_usuarios("SELECT a.*,b.programa FROM convocatoria a join catProgramas b on a.idPrograma=b.id WHERE idPlantel='" + request.getAttribute("pla") + "' && estatus='" + request.getAttribute("est") + "' && resultados='" + request.getAttribute("res") + "'");
                                            rs2 = cn.mostrar_usuarios(cadena);
                                        }

                                        if (request.getAttribute("consulta").equals("14")) {
                                            //rs2 = cn.mostrar_usuarios("SELECT a.*,b.programa FROM convocatoria a join catProgramas b on a.idPrograma=b.id WHERE idPlantel='" + request.getAttribute("pla") + "' && estatus='" + request.getAttribute("est") + "' && publicacion='" + request.getAttribute("pub") + "'");
                                            rs2 = cn.mostrar_usuarios(cadena);
                                        }

                                        if (request.getAttribute("consulta").equals("15")) {
                                            //rs2 = cn.mostrar_usuarios("SELECT a.*,b.programa FROM convocatoria a join catProgramas b on a.idPrograma=b.id WHERE idPlantel='" + request.getAttribute("pla") + "' && estatus='" + request.getAttribute("est") + "' && publicacion='" + request.getAttribute("pub") + "' && resultados='" + request.getAttribute("res") + "'");
                                            rs2 = cn.mostrar_usuarios(cadena);
                                        }

                                        if (request.getAttribute("consulta").equals("16")) {
                                            //rs2 = cn.mostrar_usuarios("SELECT a.*,b.programa, d.idEntidad FROM convocatoria a join catProgramas b on a.idPrograma=b.id join catplanteles d on a.idPlantel=d.id where d.idEntidad='" + request.getAttribute("ent") + "'");
                                            rs2 = cn.mostrar_usuarios(cadena);
                                        }

                                        if (request.getAttribute("consulta").equals("17")) {
                                            //rs2 = cn.mostrar_usuarios("SELECT a.*,b.programa, d.idEntidad FROM convocatoria a join catProgramas b on a.idPrograma=b.id join catplanteles d on a.idPlantel=d.id where d.idEntidad='" + request.getAttribute("ent") + "' && resultados='" + request.getAttribute("res") + "'");
                                            rs2 = cn.mostrar_usuarios(cadena);
                                        }

                                        if (request.getAttribute("consulta").equals("18")) {
                                            //rs2 = cn.mostrar_usuarios("SELECT a.*,b.programa, d.idEntidad FROM convocatoria a join catProgramas b on a.idPrograma=b.id join catplanteles d on a.idPlantel=d.id where d.idEntidad='" + request.getAttribute("ent") + "' && publicacion='" + request.getAttribute("pub") + "'");
                                            rs2 = cn.mostrar_usuarios(cadena);
                                        }

                                        if (request.getAttribute("consulta").equals("19")) {
                                            //rs2 = cn.mostrar_usuarios("SELECT a.*,b.programa, d.idEntidad FROM convocatoria a join catProgramas b on a.idPrograma=b.id join catplanteles d on a.idPlantel=d.id where d.idEntidad='" + request.getAttribute("ent") + "' && publicacion='" + request.getAttribute("pub") + "' && resultados='" + request.getAttribute("res") + "'");
                                            rs2 = cn.mostrar_usuarios(cadena);
                                        }

                                        if (request.getAttribute("consulta").equals("20")) {
                                            //rs2 = cn.mostrar_usuarios("SELECT a.*,b.programa, d.idEntidad FROM convocatoria a join catProgramas b on a.idPrograma=b.id join catplanteles d on a.idPlantel=d.id where d.idEntidad='" + request.getAttribute("ent") + "' && estatus='" + request.getAttribute("est") + "'");
                                            rs2 = cn.mostrar_usuarios(cadena);
                                        }

                                        if (request.getAttribute("consulta").equals("21")) {
                                            //rs2 = cn.mostrar_usuarios("SELECT a.*,b.programa, d.idEntidad FROM convocatoria a join catProgramas b on a.idPrograma=b.id join catplanteles d on a.idPlantel=d.id where d.idEntidad='" + request.getAttribute("ent") + "' && estatus='" + request.getAttribute("est") + "' && resultados='" + request.getAttribute("res") + "'");
                                            rs2 = cn.mostrar_usuarios(cadena);
                                        }

                                        if (request.getAttribute("consulta").equals("22")) {
                                            //rs2 = cn.mostrar_usuarios("SELECT a.*,b.programa, d.idEntidad FROM convocatoria a join catProgramas b on a.idPrograma=b.id join catplanteles d on a.idPlantel=d.id where d.idEntidad='" + request.getAttribute("ent") + "' && estatus='" + request.getAttribute("est") + "' && publicacion='" + request.getAttribute("pub") + "'");
                                            rs2 = cn.mostrar_usuarios(cadena);
                                        }

                                        if (request.getAttribute("consulta").equals("23")) {
                                            //rs2 = cn.mostrar_usuarios("SELECT a.*,b.programa, d.idEntidad FROM convocatoria a join catProgramas b on a.idPrograma=b.id join catplanteles d on a.idPlantel=d.id where d.idEntidad='" + request.getAttribute("ent") + "' && estatus='" + request.getAttribute("est") + "' && publicacion='" + request.getAttribute("pub") + "' && resultados='" + request.getAttribute("res") + "'");
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
                                            <% if (rs2.getString("programa") == null) {
                                                    out.print("");
                                                } else {
                                                    out.print(rs2.getString("programa"));
                                                }
                                            %>
                                        </div>
                                    </td>
                                    <td align="center">
                                        <div class="datos_tabla"> 
                                            <% if (rs2.getString("publicacion") == null) {
                                                    out.print("");
                                                } else {
                                                    out.print(rs2.getString("publicacion"));
                                                }
                                            %>
                                        </div>
                                    </td>
                                    <td align="center">
                                        <div class="datos_tabla"> 
                                            <% if (rs2.getString("inicioRegistro") == null) {
                                                    out.print("");
                                                } else {
                                                    out.print(rs2.getString("inicioRegistro"));
                                                }
                                            %>
                                        </div>
                                    </td>
                                    <td align="center">
                                        <div class="datos_tabla"> 
                                            <% if (rs2.getString("finRegistro") == null) {
                                                    out.print("");
                                                } else {
                                                    out.print(rs2.getString("finRegistro"));
                                                }
                                            %>
                                        </div>
                                    </td>
                                    <td align="center">
                                        <div class="datos_tabla"> 
                                            <% if (rs2.getString("inicioValoracion") == null) {
                                                    out.print("");
                                                } else {
                                                    out.print(rs2.getString("inicioValoracion"));
                                                }
                                            %>
                                        </div>
                                    </td>
                                    <td align="center">
                                        <div class="datos_tabla"> 
                                            <% if (rs2.getString("finValoracion") == null) {
                                                    out.print("");
                                                } else {
                                                    out.print(rs2.getString("finValoracion"));
                                                }
                                            %>
                                        </div>
                                    </td>

                                    <td align="center">
                                        <div class="datos_tabla"> 
                                            <% if (rs2.getString("inicioDictaminacion") == null) {
                                                    out.print("");
                                                } else {
                                                    out.print(rs2.getString("inicioDictaminacion"));
                                                }
                                            %>
                                        </div>
                                    </td>

                                    <td align="center">
                                        <div class="datos_tabla"> 
                                            <% if (rs2.getString("finDictaminacion") == null) {
                                                    out.print("");
                                                } else {
                                                    out.print(rs2.getString("finDictaminacion"));
                                                }
                                            %>
                                        </div>
                                    </td>

                                    <td align="center">
                                        <div class="datos_tabla"> 
                                            <% if (rs2.getString("resultados") == null) {
                                                    out.print("");
                                                } else {
                                                    out.print(rs2.getString("resultados"));
                                                    //out.print(idUsuario);
                                                    //out.print(rfc);
                                                }
                                            %>
                                        </div>
                                    </td>

                                    <td align="center">
                                        <div class="datos_tabla"> 
                                            <% if (rs2.getString("estatus") == null) {
                                                    out.print("");
                                                } else {
                                                    out.print(rs2.getString("estatus"));
                                                }
                                            %>

                                        </div>
                                    </td>
                                </tr>
                                <%
                                        }
                                    }//fin if elegir
                                    else {
                                        response.sendRedirect("login.jsp");
                                    }
                                %>
                            </table><br><br>

                            <%}//FIN ADMINISTRADOR NACIONAL
                            else if (request.getAttribute("control_combobox").equals("true") && request.getAttribute("nacional").equals("2")) {//ADMINISTRADOR ESTATAL
                                String sub = "1";
                            %>
                            <center>
                                <div class="registro">
                                    <div class="caja">                                 
                                        <label>Subsistema</label><br>                                    <%
                                            ResultSet rs9 = cn.mostrar("Select * from usuario WHERE entidad='" + request.getAttribute("dato_ent") + "' && plantel='" + request.getAttribute("dato_pla") + "' && nombre='" + request.getAttribute("nom") + "' && curp='" + request.getAttribute("dato_rfc") + "'");
                                        %>

                                        <select class="form-control" name="subsistema" id="subsistema" disabled="true" onchange="seleccion_subsistema()">                                        <%
                                            while (rs9.next()) {
                                                if (rs9.getString("idSubsistema").equals("1")) {
                                                    sub = "1";
                                            %>

                                            <option value="UEMSTIS">DGETI</option> 
                                            <input type="hidden" name="sub1" id="sub1" value="1">
                                            <%} else {
                                                sub = "2";
                                            %>

                                            <option value="CECyTE">CECyTE</option>
                                            <input type="hidden" name="sub1" id="sub1" value="2">
                                            <% }
                                            %>


                                            <%//              regresa del combobox         muestra en el combo box
                                                }
                                            %>                                              
                                        </select>   

                                        <div id="nsub"></div>


                                    </div>






                                    <div class="caja">


                                        <input type="hidden" name="f_opc" id="i_opc">
                                        <input type="hidden" name="campoentidad" id="campoentidad" >
                                        <label>Entidad</label><br>

                                        <%
                                            ResultSet rs = cn.mostrar("Select id, entidad from catentidades WHERE id='" + request.getAttribute("dato_ent") + "'");
                                        %>

                                        <select class="form-control" name="entidad" id="entidad" onchange="plantel()" disabled="true">

                                            <%
                                                while (rs.next()) {
                                            %>
                                            <option value="<%=rs.getString("id")%>"><%=rs.getString("entidad")%></option>

                                            <%//              regresa del combobox         muestra en el combo box
                                                }
                                            %>                                              
                                        </select>           
                                        <div id="n8"></div>
                                    </div>

                                    <div class="caja">   
                                        <label>Plantel</label><br>
                                        <%
                                            ResultSet rs10 = cn.mostrar("Select * from catplanteles WHERE idEntidad='" + request.getAttribute("dato_ent") + "'&& idSubsistema='" + sub + "'");
                                        %>
                                        <select class="form-control" name="n_plantel" id="i_plantel">
                                            <option value="0">Escoge una opcion</option>
                                            <%
                                                while (rs10.next()) {
                                            %>                 
                                            <option value="<%=rs10.getString("id")%>"><%=rs10.getString("plantel")%></option>
                                            <%
                                                }
                                            %>
                                        </select>

                                        </td></div>

                                    <div class="caja"> 
                                        <label>Estatus</label><br>
                                        <select class="form-control" name="estatus" id="estatus" >
                                            <option value="0">Escoge una opcion</option>
                                            <option value="temporal">Temporal</option>
                                            <option value="definitiva">Definitiva</option>
                                        </select>
                                        </td></div>

                                    <div class="caja">                                          
                                        <input type="hidden" name="publicaciont" id="publicaciont" >
                                        <label>Publicación</label><br>
                                        <input class="form-control" type="date" id="publicacion" name="publicacion" value="" min="2020-01-01" max="2020-12-31">
                                    </div>>

                                    <div class="caja">
                                        <input type="hidden" name="resultadost" id="resultadost" >
                                        <label>Resultados</label><br>
                                        <input class="form-control" type="date" id="resultados" name="resultados" value="" min="2020-01-01" max="2020-12-31">
                                    </div>
                                </div>
                            </center>
                            <br><br>

                            <div class="registro">

                                <button class="btn btn-primary pull-right" type="submit" name="buscar_convocatoria">Buscar</button>
                                <button class="btn btn-primary pull-right" type="submit" name="agregar_convocatoria" form="data2">Agregar</button>
                                <button class="btn btn-primary pull-right" type="submit" name="modificar_convocatoria" form="data6">Modificar</button>



                            </div>
                            <br><br>

                            <table  border="1"  id="tabla_usuarios" class="display">  
                                <thead>
                                    <tr>
                                        <th>Subsistema</th>
                                        <th>Nombre</th>
                                        <th>Publicacion</th>
                                        <th>Inicio Registro</th>
                                        <th>Fin Registro</th>
                                        <th>Inicio Valoracion</th>
                                        <th>Fin Valoracion</th> 
                                        <th>Inicio Dictaminación</th>
                                        <th>Fin Dictaminación</th>
                                        <th>Resultados</th>
                                        <th>Estatus</th>
                                    </tr>
                                </thead>
                                <%
                                    String elegir1 = "0";
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

                                        if (request.getAttribute("consulta").equals("0")) {
                                            //rs2 = cn.mostrar_usuarios("SELECT a.*,b.programa, d.idEntidad FROM convocatoria a join catProgramas b on a.idPrograma=b.id join catplanteles d on a.idPlantel=d.id where d.idEntidad='" + request.getAttribute("dato_ent") + "'");
                                            rs2 = cn.mostrar_usuarios(cadena);
                                        }

                                        if (request.getAttribute("consulta").equals("1")) {
                                            //rs2 = cn.mostrar_usuarios("SELECT a.*,b.programa, d.idEntidad FROM convocatoria a join catProgramas b on a.idPrograma=b.id join catplanteles d on a.idPlantel=d.id where d.idEntidad='" + request.getAttribute("dato_ent") + "' && resultados='" + request.getAttribute("res") + "'");
                                            rs2 = cn.mostrar_usuarios(cadena);
                                        }

                                        if (request.getAttribute("consulta").equals("2")) {
                                            //rs2 = cn.mostrar_usuarios("SELECT a.*,b.programa, d.idEntidad FROM convocatoria a join catProgramas b on a.idPrograma=b.id join catplanteles d on a.idPlantel=d.id where d.idEntidad='" + request.getAttribute("dato_ent") + "' && publicacion='" + request.getAttribute("pub") + "'");
                                            rs2 = cn.mostrar_usuarios(cadena);
                                        }

                                        if (request.getAttribute("consulta").equals("3")) {
                                            //rs2 = cn.mostrar_usuarios("SELECT a.*,b.programa, d.idEntidad FROM convocatoria a join catProgramas b on a.idPrograma=b.id join catplanteles d on a.idPlantel=d.id where d.idEntidad='" + request.getAttribute("dato_ent") + "' && publicacion='" + request.getAttribute("pub") + "' && resultados='" + request.getAttribute("res") + "'");
                                            rs2 = cn.mostrar_usuarios(cadena);
                                        }

                                        if (request.getAttribute("consulta").equals("4")) {
                                            //rs2 = cn.mostrar_usuarios("SELECT a.*,b.programa, d.idEntidad FROM convocatoria a join catProgramas b on a.idPrograma=b.id join catplanteles d on a.idPlantel=d.id where d.idEntidad='" + request.getAttribute("dato_ent") + "' && estatus='" + request.getAttribute("est") + "'");
                                            rs2 = cn.mostrar_usuarios(cadena);
                                        }

                                        if (request.getAttribute("consulta").equals("5")) {
                                            //rs2 = cn.mostrar_usuarios("SELECT a.*,b.programa, d.idEntidad FROM convocatoria a join catProgramas b on a.idPrograma=b.id join catplanteles d on a.idPlantel=d.id where d.idEntidad='" + request.getAttribute("dato_ent") + "' && estatus='" + request.getAttribute("est") + "' && resultados='" + request.getAttribute("res") + "'");
                                            rs2 = cn.mostrar_usuarios(cadena);
                                        }

                                        if (request.getAttribute("consulta").equals("6")) {
                                            //rs2 = cn.mostrar_usuarios("SELECT a.*,b.programa, d.idEntidad FROM convocatoria a join catProgramas b on a.idPrograma=b.id join catplanteles d on a.idPlantel=d.id where d.idEntidad='" + request.getAttribute("dato_ent") + "' && estatus='" + request.getAttribute("est") + "' && publicacion='" + request.getAttribute("pub") + "'");
                                            rs2 = cn.mostrar_usuarios(cadena);
                                        }

                                        if (request.getAttribute("consulta").equals("7")) {
                                            //rs2 = cn.mostrar_usuarios("SELECT a.*,b.programa, d.idEntidad FROM convocatoria a join catProgramas b on a.idPrograma=b.id join catplanteles d on a.idPlantel=d.id where d.idEntidad='" + request.getAttribute("dato_ent") + "' && estatus='" + request.getAttribute("est") + "' && publicacion='" + request.getAttribute("pub") + "' && resultados='" + request.getAttribute("res") + "'");
                                            rs2 = cn.mostrar_usuarios(cadena);
                                        }

                                        if (request.getAttribute("consulta").equals("8")) {
                                            //rs2 = cn.mostrar_usuarios("SELECT a.*,b.programa, d.idEntidad FROM convocatoria a join catProgramas b on a.idPrograma=b.id join catplanteles d on a.idPlantel=d.id where d.idEntidad='" + request.getAttribute("dato_ent") + "' && idPlantel='" + request.getAttribute("pla") + "'");
                                            rs2 = cn.mostrar_usuarios(cadena);
                                        }

                                        if (request.getAttribute("consulta").equals("9")) {
                                            //rs2 = cn.mostrar_usuarios("SELECT a.*,b.programa, d.idEntidad FROM convocatoria a join catProgramas b on a.idPrograma=b.id join catplanteles d on a.idPlantel=d.id where d.idEntidad='" + request.getAttribute("dato_ent") + "' && idPlantel='" + request.getAttribute("pla") + "' && resultados='" + request.getAttribute("res") + "'");
                                            rs2 = cn.mostrar_usuarios(cadena);
                                        }

                                        if (request.getAttribute("consulta").equals("10")) {
                                            //rs2 = cn.mostrar_usuarios("SELECT a.*,b.programa, d.idEntidad FROM convocatoria a join catProgramas b on a.idPrograma=b.id join catplanteles d on a.idPlantel=d.id where d.idEntidad='" + request.getAttribute("dato_ent") + "' && idPlantel='" + request.getAttribute("pla") + "' && publicacion='" + request.getAttribute("pub") + "'");
                                            rs2 = cn.mostrar_usuarios(cadena);
                                        }

                                        if (request.getAttribute("consulta").equals("11")) {
                                            //rs2 = cn.mostrar_usuarios("SELECT a.*,b.programa, d.idEntidad FROM convocatoria a join catProgramas b on a.idPrograma=b.id join catplanteles d on a.idPlantel=d.id where d.idEntidad='" + request.getAttribute("dato_ent") + "' && idPlantel='" + request.getAttribute("pla") + "' && publicacion='" + request.getAttribute("pub") + "' && resultados='" + request.getAttribute("res") + "'");
                                            rs2 = cn.mostrar_usuarios(cadena);
                                        }

                                        if (request.getAttribute("consulta").equals("12")) {
                                            //rs2 = cn.mostrar_usuarios("SELECT a.*,b.programa, d.idEntidad FROM convocatoria a join catProgramas b on a.idPrograma=b.id join catplanteles d on a.idPlantel=d.id where d.idEntidad='" + request.getAttribute("dato_ent") + "' && idPlantel='" + request.getAttribute("pla") + "' && estatus='" + request.getAttribute("est") + "'");
                                            rs2 = cn.mostrar_usuarios(cadena);
                                        }

                                        if (request.getAttribute("consulta").equals("13")) {
                                            //rs2 = cn.mostrar_usuarios("SELECT a.*,b.programa, d.idEntidad FROM convocatoria a join catProgramas b on a.idPrograma=b.id join catplanteles d on a.idPlantel=d.id where d.idEntidad='" + request.getAttribute("dato_ent") + "' && idPlantel='" + request.getAttribute("pla") + "' && estatus='" + request.getAttribute("est") + "' && resultados='" + request.getAttribute("res") + "'");
                                            rs2 = cn.mostrar_usuarios(cadena);
                                        }

                                        if (request.getAttribute("consulta").equals("14")) {
                                            //rs2 = cn.mostrar_usuarios("SELECT a.*,b.programa, d.idEntidad FROM convocatoria a join catProgramas b on a.idPrograma=b.id join catplanteles d on a.idPlantel=d.id where d.idEntidad='" + request.getAttribute("dato_ent") + "' && idPlantel='" + request.getAttribute("pla") + "' && estatus='" + request.getAttribute("est") + "' && publicacion='" + request.getAttribute("pub") + "'");
                                            rs2 = cn.mostrar_usuarios(cadena);
                                        }

                                        if (request.getAttribute("consulta").equals("15")) {
                                            //rs2 = cn.mostrar_usuarios("SELECT a.*,b.programa, d.idEntidad FROM convocatoria a join catProgramas b on a.idPrograma=b.id join catplanteles d on a.idPlantel=d.id where d.idEntidad='" + request.getAttribute("dato_ent") + "' && idPlantel='" + request.getAttribute("pla") + "' && estatus='" + request.getAttribute("est") + "' && publicacion='" + request.getAttribute("pub") + "' && resultados='" + request.getAttribute("res") + "'");
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
                                            <% if (rs2.getString("programa") == null) {
                                                    out.print("");
                                                } else {
                                                    out.print(rs2.getString("programa"));
                                                }
                                            %>
                                        </div>
                                    </td>
                                    <td align="center">
                                        <div class="datos_tabla"> 
                                            <% if (rs2.getString("publicacion") == null) {
                                                    out.print("");
                                                } else {
                                                    out.print(rs2.getString("publicacion"));
                                                }
                                            %>
                                        </div>
                                    </td>
                                    <td align="center">
                                        <div class="datos_tabla"> 
                                            <% if (rs2.getString("inicioRegistro") == null) {
                                                    out.print("");
                                                } else {
                                                    out.print(rs2.getString("inicioRegistro"));
                                                }
                                            %>
                                        </div>
                                    </td>
                                    <td align="center">
                                        <div class="datos_tabla"> 
                                            <% if (rs2.getString("finRegistro") == null) {
                                                    out.print("");
                                                } else {
                                                    out.print(rs2.getString("finRegistro"));
                                                }
                                            %>
                                        </div>
                                    </td>
                                    <td align="center">
                                        <div class="datos_tabla"> 
                                            <% if (rs2.getString("inicioValoracion") == null) {
                                                    out.print("");
                                                } else {
                                                    out.print(rs2.getString("inicioValoracion"));
                                                }
                                            %>
                                        </div>
                                    </td>
                                    <td align="center">
                                        <div class="datos_tabla"> 
                                            <% if (rs2.getString("finValoracion") == null) {
                                                    out.print("");
                                                } else {
                                                    out.print(rs2.getString("finValoracion"));
                                                }
                                            %>
                                        </div>
                                    </td>

                                    <td align="center">
                                        <div class="datos_tabla"> 
                                            <% if (rs2.getString("inicioDictaminacion") == null) {
                                                    out.print("");
                                                } else {
                                                    out.print(rs2.getString("inicioDictaminacion"));
                                                }
                                            %>
                                        </div>
                                    </td>

                                    <td align="center">
                                        <div class="datos_tabla"> 
                                            <% if (rs2.getString("finDictaminacion") == null) {
                                                    out.print("");
                                                } else {
                                                    out.print(rs2.getString("finDictaminacion"));
                                                }
                                            %>
                                        </div>
                                    </td>

                                    <td align="center">
                                        <div class="datos_tabla"> 
                                            <% if (rs2.getString("resultados") == null) {
                                                    out.print("");
                                                } else {
                                                    out.print(rs2.getString("resultados"));
                                                    //out.print(idUsuario);
                                                    //out.print(rfc);
                                                }
                                            %>
                                        </div>
                                    </td>

                                    <td align="center">
                                        <div class="datos_tabla"> 
                                            <% if (rs2.getString("estatus") == null) {
                                                    out.print("");
                                                } else {
                                                    out.print(rs2.getString("estatus"));
                                                }
                                            %>

                                        </div>
                                    </td>
                                </tr>
                                <%
                                        }
                                    }//fin if elegir
                                    else {
                                        response.sendRedirect("login.jsp");
                                    }
                                %>
                            </table><br><br>
                            <%}//FIN ADMINISTRADOR ESTATAL
                            else if (request.getAttribute("control_combobox").equals("true") && request.getAttribute("nacional").equals("3")) {//ADMINISTRADOR PLANTEL   
                                String sub = "1";
                            %>
                            <center>
                                <div class="registro">
                                    <div class="caja">                                 
                                        <label>Subsistema</label><br>                                    <%
                                            ResultSet rs9 = cn.mostrar("Select * from usuario WHERE entidad='" + request.getAttribute("dato_ent") + "' && plantel='" + request.getAttribute("dato_pla") + "' && nombre='" + request.getAttribute("nom") + "' && curp='" + request.getAttribute("dato_rfc") + "'");
                                        %>

                                        <select class="form-control" name="subsistema" id="subsistema" disabled="true" onchange="seleccion_subsistema()">                                        <%
                                            while (rs9.next()) {
                                                if (rs9.getString("idSubsistema").equals("1")) {
                                                    sub = "1";
                                            %>

                                            <option value="UEMSTIS">DGETI</option> 
                                            <input type="hidden" name="sub1" id="sub1" value="1">
                                            <%} else {
                                                sub = "2";
                                            %>

                                            <option value="CECyTE">CECyTE</option>
                                            <input type="hidden" name="sub1" id="sub1" value="2">
                                            <% }
                                            %>


                                            <%//              regresa del combobox         muestra en el combo box
                                                }
                                            %>                                              
                                        </select>   

                                        <div id="nsub"></div>


                                    </div>



                                    <div class="caja">


                                        <input type="hidden" name="f_opc" id="i_opc">
                                        <input type="hidden" name="campoentidad" id="campoentidad" >
                                        <label>Entidad</label><br>

                                        <%
                                            ResultSet rs = cn.mostrar("Select id, entidad from catentidades WHERE id='" + request.getAttribute("dato_ent") + "'");
                                        %>

                                        <select class="form-control" name="entidad" id="entidad" onchange="plantel()" disabled="true">

                                            <%
                                                while (rs.next()) {
                                            %>
                                            <option value="<%=rs.getString("id")%>"><%=rs.getString("entidad")%></option>

                                            <%//              regresa del combobox         muestra en el combo box
                                                }
                                            %>                                              
                                        </select>           
                                        <div id="n8"></div>
                                    </div>

                                    <div class="caja">   
                                        <label>Plantel</label><br>
                                        <%
                                            ResultSet rs10 = cn.mostrar("Select * from catplanteles WHERE id='" + request.getAttribute("dato_pla") + "'");
                                        %>

                                        <select class="form-control" name="n_plantel" id="i_plantel" disabled="true">
                                            <%
                                                while (rs10.next()) {
                                            %>
                                            <option value="<%=rs10.getString("id")%>"><%=rs10.getString("plantel")%></option>
                                            <%
                                                }
                                            %>
                                        </select>

                                        </td></div>

                                    <div class="caja"> 
                                        <label>Estatus</label><br>
                                        <select class="form-control" name="estatus" id="estatus" >
                                            <option value="0">Escoge una opcion</option>
                                            <option value="temporal">Temporal</option>
                                            <option value="definitiva">Definitiva</option>
                                        </select>
                                        </td></div>

                                    <div class="caja">                                          
                                        <input type="hidden" name="publicaciont" id="publicaciont" >
                                        <label>Publicación</label><br>
                                        <input class="form-control" type="date" id="publicacion" name="publicacion" value="" min="2020-01-01" max="2020-12-31">
                                    </div>>

                                    <div class="caja">
                                        <input type="hidden" name="resultadost" id="resultadost" >
                                        <label>Resultados</label><br>
                                        <input class="form-control" type="date" id="resultados" name="resultados" value="" min="2020-01-01" max="2020-12-31">
                                    </div>
                                </div>
                            </center>
                            <br><br>

                            <div class="registro">

                                <button class="btn btn-primary pull-right" type="submit" name="buscar_convocatoria">Buscar</button>
                                <button class="btn btn-primary pull-right" type="submit" name="agregar_convocatoria" form="data2">Agregar</button>
                                <button class="btn btn-primary pull-right" type="submit" name="modificar_convocatoria" form="data6">Modificar</button>



                            </div>
                            <br><br>

                            <table  border="1"  id="tabla_usuarios" class="display">  
                                <thead>
                                    <tr>
                                        <th>Subsistema</th>
                                        <th>Nombre</th>
                                        <th>Publicacion</th>
                                        <th>Inicio Registro</th>
                                        <th>Fin Registro</th>
                                        <th>Inicio Valoracion</th>
                                        <th>Fin Valoracion</th> 
                                        <th>Inicio Dictaminación</th>
                                        <th>Fin Dictaminación</th>
                                        <th>Resultados</th>
                                        <th>Estatus</th>
                                    </tr>
                                </thead>
                                <%
                                    String elegir1 = "0";
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

                                        if (request.getAttribute("consulta").equals("0")) {
                                            //rs2 = cn.mostrar_usuarios("SELECT a.*,b.programa, d.idEntidad FROM convocatoria a join catProgramas b on a.idPrograma=b.id join catplanteles d on a.idPlantel=d.id where d.idEntidad='" + request.getAttribute("dato_ent") + "' && idPlantel='" + request.getAttribute("dato_pla") + "'");
                                            rs2 = cn.mostrar_usuarios(cadena);
                                        }

                                        if (request.getAttribute("consulta").equals("1")) {
                                            //rs2 = cn.mostrar_usuarios("SELECT a.*,b.programa, d.idEntidad FROM convocatoria a join catProgramas b on a.idPrograma=b.id join catplanteles d on a.idPlantel=d.id where d.idEntidad='" + request.getAttribute("dato_ent") + "' && idPlantel='" + request.getAttribute("dato_pla") + "' && resultados='" + request.getAttribute("res") + "'");
                                            rs2 = cn.mostrar_usuarios(cadena);
                                        }

                                        if (request.getAttribute("consulta").equals("2")) {
                                            //rs2 = cn.mostrar_usuarios("SELECT a.*,b.programa, d.idEntidad FROM convocatoria a join catProgramas b on a.idPrograma=b.id join catplanteles d on a.idPlantel=d.id where d.idEntidad='" + request.getAttribute("dato_ent") + "' && idPlantel='" + request.getAttribute("dato_pla") + "' && publicacion='" + request.getAttribute("pub") + "'");
                                            rs2 = cn.mostrar_usuarios(cadena);
                                        }

                                        if (request.getAttribute("consulta").equals("3")) {
                                            //rs2 = cn.mostrar_usuarios("SELECT a.*,b.programa, d.idEntidad FROM convocatoria a join catProgramas b on a.idPrograma=b.id join catplanteles d on a.idPlantel=d.id where d.idEntidad='" + request.getAttribute("dato_ent") + "' && idPlantel='" + request.getAttribute("dato_pla") + "' && publicacion='" + request.getAttribute("pub") + "' && resultados='" + request.getAttribute("res") + "'");
                                            rs2 = cn.mostrar_usuarios(cadena);
                                        }

                                        if (request.getAttribute("consulta").equals("4")) {
                                            //rs2 = cn.mostrar_usuarios("SELECT a.*,b.programa, d.idEntidad FROM convocatoria a join catProgramas b on a.idPrograma=b.id join catplanteles d on a.idPlantel=d.id where d.idEntidad='" + request.getAttribute("dato_ent") + "' && idPlantel='" + request.getAttribute("dato_pla") + "' && estatus='" + request.getAttribute("est") + "'");
                                            rs2 = cn.mostrar_usuarios(cadena);
                                        }

                                        if (request.getAttribute("consulta").equals("5")) {
                                            //rs2 = cn.mostrar_usuarios("SELECT a.*,b.programa, d.idEntidad FROM convocatoria a join catProgramas b on a.idPrograma=b.id join catplanteles d on a.idPlantel=d.id where d.idEntidad='" + request.getAttribute("dato_ent") + "' && idPlantel='" + request.getAttribute("dato_pla") + "' && estatus='" + request.getAttribute("est") + "' && resultados='" + request.getAttribute("res") + "'");
                                            rs2 = cn.mostrar_usuarios(cadena);
                                        }

                                        if (request.getAttribute("consulta").equals("6")) {
                                            //rs2 = cn.mostrar_usuarios("SELECT a.*,b.programa, d.idEntidad FROM convocatoria a join catProgramas b on a.idPrograma=b.id join catplanteles d on a.idPlantel=d.id where d.idEntidad='" + request.getAttribute("dato_ent") + "' && idPlantel='" + request.getAttribute("dato_pla") + "' && estatus='" + request.getAttribute("est") + "' && publicacion='" + request.getAttribute("pub") + "'");
                                            rs2 = cn.mostrar_usuarios(cadena);
                                        }

                                        if (request.getAttribute("consulta").equals("7")) {
                                            //rs2 = cn.mostrar_usuarios("SELECT a.*,b.programa, d.idEntidad FROM convocatoria a join catProgramas b on a.idPrograma=b.id join catplanteles d on a.idPlantel=d.id where d.idEntidad='" + request.getAttribute("dato_ent") + "' && idPlantel='" + request.getAttribute("dato_pla") + "' && estatus='" + request.getAttribute("est") + "' && publicacion='" + request.getAttribute("pub") + "' && resultados='" + request.getAttribute("res") + "'");
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
                                            <% if (rs2.getString("programa") == null) {
                                                    out.print("");
                                                } else {
                                                    out.print(rs2.getString("programa"));
                                                }
                                            %>
                                        </div>
                                    </td>
                                    <td align="center">
                                        <div class="datos_tabla"> 
                                            <% if (rs2.getString("publicacion") == null) {
                                                    out.print("");
                                                } else {
                                                    out.print(rs2.getString("publicacion"));
                                                }
                                            %>
                                        </div>
                                    </td>
                                    <td align="center">
                                        <div class="datos_tabla"> 
                                            <% if (rs2.getString("inicioRegistro") == null) {
                                                    out.print("");
                                                } else {
                                                    out.print(rs2.getString("inicioRegistro"));
                                                }
                                            %>
                                        </div>
                                    </td>
                                    <td align="center">
                                        <div class="datos_tabla"> 
                                            <% if (rs2.getString("finRegistro") == null) {
                                                    out.print("");
                                                } else {
                                                    out.print(rs2.getString("finRegistro"));
                                                }
                                            %>
                                        </div>
                                    </td>
                                    <td align="center">
                                        <div class="datos_tabla"> 
                                            <% if (rs2.getString("inicioValoracion") == null) {
                                                    out.print("");
                                                } else {
                                                    out.print(rs2.getString("inicioValoracion"));
                                                }
                                            %>
                                        </div>
                                    </td>
                                    <td align="center">
                                        <div class="datos_tabla"> 
                                            <% if (rs2.getString("finValoracion") == null) {
                                                    out.print("");
                                                } else {
                                                    out.print(rs2.getString("finValoracion"));
                                                }
                                            %>
                                        </div>
                                    </td>

                                    <td align="center">
                                        <div class="datos_tabla"> 
                                            <% if (rs2.getString("inicioDictaminacion") == null) {
                                                    out.print("");
                                                } else {
                                                    out.print(rs2.getString("inicioDictaminacion"));
                                                }
                                            %>
                                        </div>
                                    </td>

                                    <td align="center">
                                        <div class="datos_tabla"> 
                                            <% if (rs2.getString("finDictaminacion") == null) {
                                                    out.print("");
                                                } else {
                                                    out.print(rs2.getString("finDictaminacion"));
                                                }
                                            %>
                                        </div>
                                    </td>

                                    <td align="center">
                                        <div class="datos_tabla"> 
                                            <% if (rs2.getString("resultados") == null) {
                                                    out.print("");
                                                } else {
                                                    out.print(rs2.getString("resultados"));
                                                    //out.print(idUsuario);
                                                    //out.print(rfc);
                                                }
                                            %>
                                        </div>
                                    </td>

                                    <td align="center">
                                        <div class="datos_tabla"> 
                                            <% if (rs2.getString("estatus") == null) {
                                                    out.print("");
                                                } else {
                                                    out.print(rs2.getString("estatus"));
                                                }
                                            %>

                                        </div>
                                    </td>
                                </tr>
                                <%
                                        }
                                    }//fin if elegir
                                    else {
                                        response.sendRedirect("login.jsp");
                                    }
                                %>
                            </table><br><br>

                            <%
                                }//FIN ADMINISTRADOR PLANTEL
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

                <form id="data2" class="form-horizontal" role="form" method="POST" action="Servlet_agregar_convocatoria">
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

                <form id="data6" class="form-horizontal" role="form" method="POST" action="Servlet_modificar_convocatoria">
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
