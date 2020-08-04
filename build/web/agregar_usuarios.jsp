<%-- 
    Document   : administracion_usuarios
    Created on : 06-jun-2020, 9:09:41
    Author     : charl
--%>
<%@page import="java.sql.ResultSet"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <style>
            input:invalid {
                border: 1px solid red;
            }

            input:valid {

            }
        </style>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Unidad de Educación Media Superior Tecnológica Industrial y de Servicios | gob.mx</title>
        <meta name="viewport" content="width=device-width, user-scalable=no, initial-scale=1.0, maximun-scale=1.0, minimun-scale=1.0">
        <link rel="stylesheet" href="css/all.css">
        <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@500&display=swap" rel="stylesheet">
        <link rel="stylesheet" href="css/estilos.css">

        <!-- para el framework del gobierno-->
        <!-- CSS -->
        <link href="/favicon.ico" rel="shortcut icon">
        <link href="https://framework-gb.cdn.gob.mx/assets/styles/main.css" rel="stylesheet">

        <script type="text/javascript" src="js/jquery-1.11.1.min.js"></script>
        <link rel="stylesheet" href="js/jquery.dataTables.min.css">
        <script src="js/jquery-3.5.1.min.js"></script>
        <script src="js/jquery.dataTables.min.js"></script>
        <script type="text/javascript">
            function plantel() {
                /* Para obtener el texto */
                var combo = document.getElementById("entidad");
                var selected = combo.options[combo.selectedIndex].text;
                document.data.campoentidad.value = selected;

                if (document.getElementById("entidad").value == "0")
                {
                    $("#n8").text("Selecciona una ENTIDAD").css("color", "red");
                    $("#entidad").css("border", "1px solid red");

                } else {
                    document.getElementById("n8").innerHTML = "";
                    $("#entidad").css("border", "none");
                }

                $("#i_opc").val("1");
                $.post("combo1.jsp", $("#data").serialize(), function (data) {
                    $("#i_plantel").html(data);
                });


            }
        </script> 

        <script>
            document.getElementById("nombre_nom").validity.patternMismatch;

        </script>
    </head>
    <body>
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
                        <a class="navbar-brand" href="/">UEMSTIS</a>
                    </div>
                    <div class="collapse navbar-collapse" id="subenlaces">
                        <ul class="nav navbar-nav navbar-right">

                            <nav class="navegacion">
                                <ul class="menu">
                                    <li aling="navbar-center">
                                        <%
                                            String ent1 = String.valueOf(request.getAttribute("dato_ent"));
                                            String pla1 = String.valueOf(request.getAttribute("dato_pla"));
                                            String nom1 = String.valueOf(request.getAttribute("nom"));
                                            String rfc1 = String.valueOf(request.getAttribute("dato_rfc"));
                                            out.print(nom1);
                                            //request.setAttribute("nom2", nom1);
                                        %>


                                    </li>
                                    <li><a href="index.html">Inicio</a></li>
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
                    <p>Unidad de Educación Media Superior Tecnológica Industrial y de Servicios</p>
                </div>
                <div class="texto-principalart margen-interno">
                    <p>Programa de Promoción en el Servicio Docente en Educación Media Superior</p>
                </div>
            </header>
            <div class="ruta">
                <p> UEMSTIS > Promoción Docente > Alta de Usuarios</p>
            </div>
            <section class="sectionreg">                
                <p>Alta de Usuarios </p>
                <jsp:useBean id="cn" class="metodos_sql.Metodos_sql" scope="page"></jsp:useBean>
                    <form id="data"   name="data" method="POST" action="Servlet_agregar_usuario" onSubmit="return validate();">
                        <div class="registro">
                            <div class="caja">
                                <input type="hidden" name="f_opc" id="i_opc">
                                <input type="hidden" name="campoentidad" id="campoentidad" >
                                <p>Entidad

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
                            </p>
                            <div id="n8"></div>
                        </div>

                        <div class="caja">
                            <p>Plantel
                                <select class="form-control" name="n_plantel" id="i_plantel" onchange="validarentrada3()">
                                    <option value="0">Escoge una opcion</option>                                     
                                </select>
                            </p>
                            <div id="n7"></div>

                        </div>

                        <div class="caja">
                            <p>Usuario
                                <input  class="form-control" id="usuario" placeholder="Usuario" type="text" name="usuario" maxlength="13">
                            <div id="n10"></div>
                            </p>
                        </div>
                    </div>


                    <div class="registro">
                        <div class="caja">
                            <p>Nombre<input id="nombre_nom" class="form-control" type="text" name="Nombre" size="33" placeholder="Nombre" ></p>
                            <div id="n"></div>
                        </div>


                        <div class="caja">
                            <p>Primer Apellido<input id="ap" class="form-control" type="text" name="primerApellido" size="33" placeholder="Apellido Paterno" ></p>
                            <div id="n1"></div>
                        </div>
                        <div class="caja">
                            <p>Segundo Apellido(opcional)<input id="am" class="form-control" type="text" name="segundoApellido" size="33" placeholder="Apellido Materno" ></p>
                            <div id="n2"></div>
                        </div>
                    </div>

                    <div class="registro">

                        <div class="caja">
                            <p>Teléfono fijo<input id="tel" class="form-control" type="tel" name="telfijo" size="10" placeholder="Teléfono fijo" maxlength="10"></p>
                            <div id="n4"></div>
                        </div>
                        <div class="caja">
                            <p>Teléfono celular<input id="cel" class="form-control" type="tel" name="telcel" size="10" placeholder="Teléfono celular" maxlength="10"></p>
                            <div id="n5"></div>
                        </div>
                        <div class="caja">
                            <p>Correo electrónico<input id="correo" class="form-control" type="email" name="correo" size="50" placeholder="usuario@servidor.com"></p>
                            <div id="n6"></div>
                        </div>
                    </div>



                    <div class="registro">
                        <div class="caja">
                            <p>Contraseña<input class="form-control" type="password" name="clave" placeholder="Escribir contraseña"  id="pass1" ></p>    
                            <div id="error1"></div>
                        </div>


                        <div class="caja">
                            <p>Repetir contraseña<input class="form-control" type="password" name="clave2" placeholder="Repetir contraseña" id="pass2" ></p>
                            <div id="error2"></div>
                        </div>

                    </div>






                    <div class="registro">
                        <div class="caja">
                            <p> 
                                Permisos:<br><br>
                                <%
                                    int i = 1;
                                    String listado[] = new String[10];
                                    ResultSet rs3 = null;
                                    rs3 = cn.mostrar_usuarios("SELECT permiso FROM catpermisos");
                                    while (rs3.next()) {
                                %>

                                <input type="checkbox" id="ckl" name="ckl" value="<%=i++%>" > <label for="ckl"><% out.print(rs3.getString("permiso"));%></label>  <br> <%} %>

                            </p>
                            <div id="n11"></div>
                        </div>
                    </div>


                    <div class="error"> 
                        <% if (request.getAttribute("error") == null) {
                                out.print("");
                            } else {
                                out.print(request.getAttribute("error"));
                            }

                            if (request.getAttribute("ver") != null) {
                                out.print("");
                            } else {
                                response.sendRedirect("login.jsp");
                            }
                        %>
                    </div>


                    <div class="form-group">
                          <%
                            session.setAttribute("idUsuario", idUsuario);
                            session.setAttribute("rfc", rfc);
                        %>
                        <input type="hidden" name="permiso1" id="permiso1" value="<%=request.getAttribute("per1")%>">
                        <input type="hidden" name="permiso3" id="permiso3" value="<%=request.getAttribute("per3")%>">
                        <input type="hidden" name="permiso4" id="permiso4" value="<%=request.getAttribute("per4")%>">
                        <input type="hidden" name="nombre" id="nombre" value="<%=request.getAttribute("nom")%>">
                        <input type="hidden" name="dato_ent" id="dato_ent" value="<%=request.getAttribute("dato_ent")%>">
                        <input type="hidden" name="dato_pla" id="dato_pla" value="<%=request.getAttribute("dato_pla")%>">
                        <input type="hidden" name="dato_rfc" id="dato_rfc" value="<%=request.getAttribute("dato_rfc")%>">
                        <button class="btn btn-primary pull-right" type="submit" name="agregarusuario">Agregar</button>

                    </div>
                </form>
            </section>
            <form id="data2" class="form-horizontal" role="form" method="POST" action="Servlet_regresar">
                <div class="posision1">   
                    <button class="btn btn-primary pull-right posision2" type="submit" name="regresa" id="check">Regresar</button>
                      <%
                            session.setAttribute("idUsuario", idUsuario);
                            session.setAttribute("rfc", rfc);
                        %>
                    <input type="hidden" name="permiso1" id="permiso1" value="<%=request.getAttribute("per1")%>">
                    <input type="hidden" name="permiso3" id="permiso3" value="<%=request.getAttribute("per3")%>">
                    <input type="hidden" name="permiso4" id="permiso4" value="<%=request.getAttribute("per4")%>">
                    <input type="hidden" name="nombre" id="nombre" value="<%=request.getAttribute("nom")%>">
                    <input type="hidden" name="dato_ent" id="dato_ent" value="<%=request.getAttribute("dato_ent")%>">
                    <input type="hidden" name="dato_pla" id="dato_pla" value="<%=request.getAttribute("dato_pla")%>">
                    <input type="hidden" name="dato_rfc" id="dato_rfc" value="<%=request.getAttribute("dato_rfc")%>">
                </div>
            </form>




            <!-- JS  para el framework del gobierno-->
            <script src="https://framework-gb.cdn.gob.mx/gobmx.js"></script>
            <script src="js/notificaciones.js"></script>
        </div>
                 <%
            } else {
                response.sendRedirect("login.jsp");
            }
        %>
    </body>
</html>
