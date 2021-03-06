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
        <title>DGETI | gob.mx</title>
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

            function seleccion_subsistema() {
                document.getElementById("entidad").disabled = true;
                document.getElementById("i_plantel").disabled = true;
                $("#nivel").val(1);
                $("#entidad").val(0);
                $("#i_plantel").val(0);
            }

            function seleccion_subsistema2() {
                document.getElementById("i_plantel").disabled = false;
                $("#i_plantel").val(0);

                $("#i_opc").val("1");
                $.post("combo8.jsp", $("#data").serialize(), function (data) {
                    $("#i_plantel").html(data);
                });
            }

         

            function seleccion_nivel() {

            if (document.getElementById("nivel").value == "1") {
                document.getElementById("entidad").disabled = true;
                document.getElementById("i_plantel").disabled = true;
                $("#entidad").val(0);
                //$("#entidad").change();
                $("#entidad").css("border", "none");
                $("#n8").text("").css("color", "red");
                $("#i_plantel").css("border", "none");
                $("#n7").text("").css("color", "red");
            } else if (document.getElementById("nivel").value == "2") {
                document.getElementById("entidad").disabled = false;
                document.getElementById("i_plantel").disabled = true;
                $("#i_opc").val("1");
                $.post("combo5.jsp", $("#data").serialize(), function (data) {
                    $("#i_plantel").html(data);
                });
                //$("#entidad").val(dato_ent);

                $("#entidad").css("border", "none");
                $("#n8").text("").css("color", "red");
                $("#i_plantel").css("border", "none");
                $("#n7").text("").css("color", "red");
            } else if (document.getElementById("nivel").value == "3") {
                document.getElementById("entidad").disabled = false;
                document.getElementById("i_plantel").disabled = false;
                $("#entidad").val(0);
                $("#i_opc").val("1");
                //$.post("combo6.jsp", $("#data").serialize(), function (data) {
                $.post("combo1.jsp", $("#data").serialize(), function (data) {
                    $("#i_plantel").html(data);
                });

                $("#entidad").css("border", "none");
                $("#n8").text("").css("color", "red");
                $("#i_plantel").css("border", "none");
                $("#n7").text("").css("color", "red");
                }
            }


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
                $.post("combo7.jsp", $("#data").serialize(), function (data) {
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
            ResultSet rs8;

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
                            <span class="sr-only">Interruptor de Navegaci??n</span>
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
                                            String ent1 = String.valueOf(request.getAttribute("dato_ent"));
                                            String pla1 = String.valueOf(request.getAttribute("dato_pla"));
                                            String nom1 = String.valueOf(request.getAttribute("nom"));
                                            String rfc1 = String.valueOf(request.getAttribute("dato_rfc"));
                                            out.print(nom1);
                                            //request.setAttribute("nom2", nom1);
                                        %>


                                    </li>
                                    <li><a href="login.jsp">Cerrar sesi??n</a></li>
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
                    <p>Direcci??n General de Educaci??n Tecnol??gica Industrial y de Servicios</p>
                </div>
                <div class="texto-principalart margen-interno">
                    <p>Programa de Promoci??n en el Servicio Docente en Educaci??n Media Superior</p>
                </div>
            </header>
            <div class="ruta">
                <p> DGETI > Promoci??n Docente > Alta de Usuarios</p>
            </div>
            <section class="sectionreg">                
                <p>Alta de Usuarios </p>
                <jsp:useBean id="cn" class="metodos_sql.Metodos_sql" scope="page"></jsp:useBean>
                    <form id="data"   name="data" method="POST" action="Servlet_agregar_usuario" onSubmit="return validate();">
                    <%-------------------------------------------------------------------OPCION SUPER USUARIO NACIONAL COMBO BOX----------------------------%>   
                    <%if (request.getAttribute("control_combobox").equals("false") && request.getAttribute("nacional").equals("1")) {%>

                    <div class="registro">
                        <div class="caja">
                            <p>Subsistema
                                <%
                                    ResultSet rs9 = cn.mostrar("Select id, subsistema from catsubsistema");
                                %>

                                <select class="form-control" name="subsistema" id="subsistema" onchange="seleccion_subsistema()">
                                    <%
                                        while (rs9.next()) {
                                    %>
                                    <option value="<%=rs9.getString("id")%>"><%=rs9.getString("subsistema")%></option>

                                    <%//              regresa del combobox         muestra en el combo box
                                        }
                                    %>                                              
                                </select>   
                            </p>
                            <div id="nnivel"></div>
                        </div>
                        <div class="caja">
                            <p>Nivel
                                <select class="form-control" name="nivel" id="nivel" onchange="seleccion_nivel()">
                                    <option value="1" selected="true">Nacional</option> 
                                    <option value="2">Estatal</option>
                                    <option value="3">Plantel</option>
                                </select>
                            </p>
                            <div id="nnivel"></div>
                        </div>
                    </div>

                    <div class="registro">

                        <div class="caja">
                            <input type="hidden" name="f_opc" id="i_opc">
                            <input type="hidden" name="campoentidad" id="campoentidad" >
                            <p>Entidad

                                <%
                                    ResultSet rs = cn.mostrar("Select id, entidad from catentidades");
                                %>

                                <select class="form-control" name="entidad" id="entidad" onchange="plantel()" disabled="true">
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
                                <select class="form-control" name="n_plantel" id="i_plantel" onchange="validarentrada3()" disabled="true">
                                    <option value="0">Escoge una opcion</option>                                     
                                </select>
                            </p>
                            <div id="n7"></div>

                        </div>
                        <% } //OPCION ADMINISTRADOR NACIONAL COMBO BOX------------------------------------------------------------
                        else if (request.getAttribute("control_combobox").equals("true") && request.getAttribute("nacional").equals("1")) {%> <%--OPCION FALSA COMBOBOX --%>             
                        <div class="registro">
                            <div class="caja">
                                <p>Subsistema
                                    <%
                                        ResultSet rs9 = cn.mostrar("Select id, subsistema from catsubsistema");
                                    %>

                                    <select class="form-control" name="subsistema" id="subsistema" onchange="seleccion_subsistema()">
                                        <%
                                            while (rs9.next()) {
                                        %>
                                        <option value="<%=rs9.getString("id")%>"><%=rs9.getString("subsistema")%></option>

                                        <%//              regresa del combobox         muestra en el combo box
                                            }
                                        %>                                              
                                    </select>   
                                </p>
                                <div id="nnivel"></div>
                            </div>
                            <div class="caja">
                                <p>Nivel
                                    <select class="form-control" name="nivel" id="nivel" onchange="seleccion_nivel()">
                                        <option value="1" selected="true">Nacional</option> 
                                        <option value="2">Estatal</option>
                                        <option value="3">Plantel</option>
                                    </select>
                                </p>
                                <div id="nnivel"></div>
                            </div>
                        </div>

                        <div class="registro">

                            <div class="caja">
                                <input type="hidden" name="f_opc" id="i_opc">
                                <input type="hidden" name="campoentidad" id="campoentidad" >
                                <p>Entidad

                                    <%
                                        ResultSet rs = cn.mostrar("Select id, entidad from catentidades");
                                    %>

                                    <select class="form-control" name="entidad" id="entidad" onchange="plantel()" disabled="true">
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
                                    <select class="form-control" name="n_plantel" id="i_plantel" onchange="validarentrada3()" disabled="true">
                                        <option value="0">Escoge una opcion</option>                                     
                                    </select>
                                </p>
                                <div id="n7"></div>

                            </div>
                            <%}//OPCION ADMINISTRADOR ESTATAL COMBO BOX
                            else if (request.getAttribute("control_combobox").equals("true") && request.getAttribute("nacional").equals("2")) {%> 
                            <div class="registro">
                                <div class="caja">
                                    <input type="hidden" name="f_opc" id="i_opc">
                                    <p>Subsistema
                                        <%
                                            rs8 = cn.mostrar("Select id, subsistema from catsubsistema");
                                        %>

                                        <select class="form-control" name="subsistema" id="subsistema" onchange="seleccion_subsistema2()">
                                            <%
                                                while (rs8.next()) {
                                            %>
                                            <option value="<%=rs8.getString("id")%>"><%=rs8.getString("subsistema")%></option>

                                            <%//              regresa del combobox         muestra en el combo box

                                                }

                                            %>                                              
                                        </select>   
                                    </p>
                                    <div id="nnivel"></div>
                                </div>
                                <div class="caja">
                                    <p>Nivel
                                        <select class="form-control" name="nivel" id="nivel" onchange="seleccion_nivel()" disabled="true">
                                            <option value="1">Nacional</option> 
                                            <option value="2">Estatal</option>
                                            <option value="3" selected="true">Plantel</option>
                                        </select>
                                    </p>
                                    <input type="hidden" name="nivel_plantel" id="nivel_plantel" value="3">
                                    <div id="nnivel"></div>
                                </div>
                            </div>

                            <div class="registro">

                                <div class="caja">
                                    <input type="hidden" name="f_opc" id="i_opc">
                                    <input type="hidden" name="campoentidad" id="campoentidad" >
                                    <p>Entidad

                                        <%                                            ResultSet rs = cn.mostrar("Select id, entidad from catentidades WHERE id='" + request.getAttribute("dato_ent") + "'");
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
                                <%}//OPCION ADMINISTRADOR PLANTEL COMBO BOX
                                else if (request.getAttribute("control_combobox").equals("true") && request.getAttribute("nacional").equals("3")) {
                                %>
                                <div class="registro">
                                    <div class="caja">
                                        <p>Nivel
                                            <select class="form-control" name="nivel" id="nivel" onchange="seleccion_nivel()" disabled="true">
                                                <option value="1">Nacional</option> 
                                                <option value="2" >Estatal</option>
                                                <option value="3" selected="true">Plantel</option>
                                            </select>
                                        </p>
                                        <div id="nnivel"></div>
                                    </div>
                                </div>

                                <div class="registro">

                                    <div class="caja">
                                        <input type="hidden" name="f_opc" id="i_opc">
                                        <input type="hidden" name="campoentidad" id="campoentidad" >
                                        <p>Entidad

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
                                        </p>
                                        <div id="n8"></div>
                                    </div>

                                    <div class="caja">
                                        <p>Plantel
                                            <%
                                                ResultSet rs1 = cn.mostrar("Select * from catplanteles WHERE id='" + request.getAttribute("dato_pla") + "'");
                                            %>
                                            <select class="form-control" name="n_plantel" id="i_plantel" onchange="validarentrada3()" disabled="true">

                                                <%
                                                    while (rs1.next()) {
                                                %>
                                                <option value="<%=rs1.getString("id")%>"><%=rs1.getString("plantel")%></option>

                                                <%//              regresa del combobox         muestra en el combo box
                                                    }
                                                %>   
                                            </select>
                                        </p>
                                        <div id="n7"></div>
                                    </div>
                                    <%}
                                    %>




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
                                        <p>Tel??fono fijo<input id="tel" class="form-control" type="tel" name="telfijo" size="10" placeholder="Tel??fono fijo" maxlength="10"></p>
                                        <div id="n4"></div>
                                    </div>
                                    <div class="caja">
                                        <p>Tel??fono celular<input id="cel" class="form-control" type="tel" name="telcel" size="10" placeholder="Tel??fono celular" maxlength="10"></p>
                                        <div id="n5"></div>
                                    </div>
                                    <div class="caja">
                                        <p>Correo electr??nico<input id="correo" class="form-control" type="email" name="correo" size="50" placeholder="usuario@servidor.com"></p>
                                        <div id="n6"></div>
                                    </div>
                                </div>



                                <div class="registro">
                                    <div class="caja">
                                        <p>Contrase??a<input class="form-control" type="password" name="clave" placeholder="Escribir contrase??a"  id="pass1" ></p>    
                                        <div id="error1"></div>
                                    </div>


                                    <div class="caja">
                                        <p>Repetir contrase??a<input class="form-control" type="password" name="clave2" placeholder="Repetir contrase??a" id="pass2" ></p>
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
                                                rs3 = cn.mostrar_usuarios("SELECT id,permiso FROM catpermisos");
                                                while (rs3.next()) {
                                            %>

                                            <input type="checkbox" id="ckl" name="ckl" value="<% out.print(rs3.getString("id"));%>" > <label for="ckl"><% out.print(rs3.getString("permiso"));%></label>  <br> <%} %>

                                        </p>
                                        <div id="n11"></div>
                                    </div>
                                </div>

                                <%-------------------------------------------------------------------FIN OPCION VERDADERA COMBO BOX----------------------------%>   

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
                                    <input type="hidden" name="control_combobox" id="control_combobox" value="<%=request.getAttribute("control_combobox")%>">
                                    <input type="hidden" name="nacional" id="nacional" value="<%=request.getAttribute("nacional")%>"> <%--AGREGAR--%>
                                    <input type="hidden" name="permiso1" id="permiso1" value="<%=request.getAttribute("per1")%>">
                                    <input type="hidden" name="permiso2" id="permiso2" value="<%=request.getAttribute("per2")%>">
                                    <input type="hidden" name="permiso4" id="permiso4" value="<%=request.getAttribute("per4")%>">
                                    <input type="hidden" name="nombre" id="nombre" value="<%=request.getAttribute("nom")%>">
                                    <input type="hidden" name="dato_ent" id="dato_ent" value="<%=request.getAttribute("dato_ent")%>">
                                    <input type="hidden" name="dato_pla" id="dato_pla" value="<%=request.getAttribute("dato_pla")%>">
                                    <input type="hidden" name="dato_rfc" id="dato_rfc" value="<%=request.getAttribute("dato_rfc")%>">
                                    <button class="btn btn-primary pull-right" type="submit" name="agregarusuario">Guardar</button>

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
                                        <input type="hidden" name="control_combobox" id="control_combobox" value="<%=request.getAttribute("control_combobox")%>">
                                        <input type="hidden" name="nacional" id="nacional" value="<%=request.getAttribute("nacional")%>"> <%--AGREGAR--%>
                                        <input type="hidden" name="permiso1" id="permiso1" value="<%=request.getAttribute("per1")%>">
                                        <input type="hidden" name="permiso2" id="permiso2" value="<%=request.getAttribute("per2")%>">
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
  <script type="text/javascript">
            $("#i_opc").val("1");
                    $.post("combo8.jsp", $("#data").serialize(), function (data) {
                    $("#i_plantel").html(data);
                    });
            </script>

                            </div>
                            <%
                                } else {
                                    response.sendRedirect("login.jsp");
                                }
                            %>
                            </body>

                            </html>
