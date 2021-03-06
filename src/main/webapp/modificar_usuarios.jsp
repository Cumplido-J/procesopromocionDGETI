<%-- 
    Document   : modificar_usuarios
    Created on : 28-ago-2020, 10:33:01
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

        <!-- para el framework del gobierno-->
        <!-- CSS -->
        <link href="/favicon.ico" rel="shortcut icon">
        <link href="https://framework-gb.cdn.gob.mx/assets/styles/main.css" rel="stylesheet">

        <script type="text/javascript" src="js/jquery-1.11.1.min.js"></script>
        <link rel="stylesheet" href="js/jquery.dataTables.min.css">
        <script src="js/jquery-3.5.1.min.js"></script>
        <script src="js/jquery.dataTables.min.js"></script>
        <script type="text/javascript">

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
            ResultSet rs29 = null;
            ResultSet rs30 = null;
            String dato_id = "";
            String dato_nivel = "";
            String dato_entidad = "";
            String dato_plantel = "";
            String dato_usuario = "";
            String dato_nombre = "";
            String dato_ap = "";
            String dato_am = "";
            String dato_tel = "";
            String dato_cel = "";
            String dato_correo = "";
            String dato_clave = "";
            String claveencriptada = "";

            char[] datos = new char[431];
            char[] id = new char[10];
            char[] control_combobox = new char[5];
            char[] nacional = new char[1];
            char[] per1 = new char[5];
            char[] per2 = new char[5];
            char[] per4 = new char[5];
            char[] dato_ent = new char[100];
            char[] dato_pla = new char[100];
            char[] dato_rfc = new char[100];
            char[] nombre_sesion = new char[50];

            int signo = 0, n = 0;//6

            String lineaLeida = request.getParameter("id");
            datos = lineaLeida.toCharArray();
            for (int i = 0; i < datos.length; i++) {
                if (datos[i] == ' ' && signo <= 8) {
                    signo += 1;
                    n = 0;
                }//fin if
                else {
                    switch (signo) {
                        case 0:
                            id[n] = datos[i];
                            n++;
                            break;

                        case 1:
                            control_combobox[n] = datos[i];
                            n++;
                            break;

                        case 2:
                            nacional[n] = datos[i];
                            n++;
                            break;

                        case 3:
                            per1[n] = datos[i];
                            n++;
                            break;

                        case 4:
                            per2[n] = datos[i];
                            n++;
                            break;

                        case 5:
                            per4[n] = datos[i];
                            n++;
                            break;

                        case 6:
                            dato_ent[n] = datos[i];
                            n++;
                            break;
                        case 7:
                            dato_pla[n] = datos[i];
                            n++;
                            break;
                        case 8:
                            dato_rfc[n] = datos[i];
                            n++;
                            break;
                        case 9:
                            if (datos[i] == '1') {
                            } else {
                                nombre_sesion[n] = datos[i];
                                n++;
                            }
                            break;

                    }//fin switch
                }
            }//fin for      
            String id1 = String.valueOf(id).trim();
            String control_combobox1 = String.valueOf(control_combobox).trim();
            String nacional1 = String.valueOf(nacional).trim();
            String per11 = String.valueOf(per1).trim();
            String per21 = String.valueOf(per2).trim();
            String per41 = String.valueOf(per4).trim();
            String dato_ent1 = String.valueOf(dato_ent).trim();
            String dato_pla1 = String.valueOf(dato_pla).trim();
            String dato_rfc1 = String.valueOf(dato_rfc).trim();
            String dato_nom1 = String.valueOf(nombre_sesion).trim();
            String ver = String.valueOf(datos[datos.length - 1]);
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
                                        <%                                            String ent1 = dato_ent1;
                                            String pla1 = dato_pla1;

                                            String rfc1 = dato_rfc1;

                                            //request.setAttribute("nom2", nom1);
                                        %>


                                    </li>
                                    <li><a href="login.jsp">Inicio</a></li>
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
                <p>Modificar Usuarios </p>
                <jsp:useBean id="cn" class="metodos_sql.Metodos_sql" scope="page"></jsp:useBean>
                    <form id="data"   name="data" method="POST" action="Servlet_modificar_usuario" onSubmit="return validate();">
                    <%                        rs30 = cn.mostrar("Select * from usuario WHERE id='" + id1 + "'");
                        while (rs30.next()) {
                            dato_id = rs30.getString("id");
                            dato_nivel = rs30.getString("nacional");
                            dato_entidad = rs30.getString("entidad");
                            dato_plantel = rs30.getString("plantel");
                            dato_usuario = rs30.getString("curp");
                            dato_nombre = rs30.getString("nombre");
                            dato_ap = rs30.getString("primerApellido");
                            dato_am = rs30.getString("segundoApellido");
                            dato_tel = rs30.getString("telfijo");
                            dato_cel = rs30.getString("telcel");
                            dato_correo = rs30.getString("correo");
                            claveencriptada = rs30.getString("clave");
                        }
                        dato_clave = seguridad.Encriptar_Desencriptar.desencriptar(claveencriptada);

                        int[] check = new int[10];
                        int indice = 0;
                        rs29 = cn.mostrar("Select * from usuariopermiso WHERE idUsuario='" + dato_id + "'");
                        while (rs29.next()) {
                            check[indice] = rs29.getInt("idPermiso");
                           out.println(check[indice]);                            
                            indice++;
                        }
                        // out.print(dato_nom1);
                        if (control_combobox1.equals("false") && nacional1.equals("1")) {
                            if (dato_entidad == null && dato_plantel == null) {
                    %>
                    <%-------------------------------------------------------------------OPCION SUPER USUARIO NACIONAL COMBO BOX----------------------------%>   

                    <div class="registro">
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
                                    <option value="0" >Escoge una opcion</option>
                                    <%
                                        while (rs.next()) {
                                            if (rs.getString("id").equals(dato_entidad)) {

                                    %>

                                    <option selected="true" value="<%=rs.getString("id")%>"><%=rs.getString("entidad")%></option>

                                    <%//              regresa del combobox         muestra en el combo box
                                    }//fin if
                                    else {
                                    %>
                                    <option value="<%=rs.getString("id")%>"><%=rs.getString("entidad")%></option>
                                    <%
                                            }
                                        }//fi while
                                    %>                                              
                                </select>           
                            </p>
                            <div id="n8"></div>
                        </div>

                        <div class="caja">
                            <p>Plantel
                                <%
                                    ResultSet rs10 = cn.mostrar("Select * from catplanteles WHERE idEntidad='" + dato_entidad + "'");
                                %>
                                <select class="form-control" name="n_plantel" id="i_plantel" onchange="validarentrada3()" disabled="true">
                                    <option value="0">Escoge una opcion</option>
                                    <%
                                        while (rs10.next()) {
                                            if (rs10.getString("id").equals(dato_plantel)) {
                                    %>                 
                                    <option selected="true" value="<%=rs10.getString("id")%>"><%=rs10.getString("plantel")%></option>
                                    <%
                                    }//fin if
                                    else {
                                    %>
                                    <option value="<%=rs10.getString("id")%>"><%=rs10.getString("plantel")%></option>
                                    <%
                                            }
                                        }//fin while
                                    %>
                                </select>
                            </p>
                            <div id="n7"></div>


                        </div>
                        <div class="caja">
                            <p>Usuario                               
                                <input  class="form-control" id="usuario" placeholder="Usuario" type="text" name="usuario" maxlength="13" value="<%=dato_usuario%>">
                            <div id="n10"></div>
                            </p>
                        </div>
                    </div>
                    <% }
                        if (dato_entidad != null && dato_plantel == null) {%>
                    <div class="registro">
                        <div class="caja">
                            <p>Nivel
                                <select class="form-control" name="nivel" id="nivel" onchange="seleccion_nivel()">
                                    <option value="1">Nacional</option> 
                                    <option value="2" selected="true">Estatal</option>
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

                                <select class="form-control" name="entidad" id="entidad" onchange="plantel()" >
                                    <option value="0" >Escoge una opcion</option>
                                    <%
                                        while (rs.next()) {
                                            if (rs.getString("id").equals(dato_entidad)) {

                                    %>

                                    <option selected="true" value="<%=rs.getString("id")%>"><%=rs.getString("entidad")%></option>

                                    <%//              regresa del combobox         muestra en el combo box
                                    }//fin if
                                    else {
                                    %>
                                    <option value="<%=rs.getString("id")%>"><%=rs.getString("entidad")%></option>
                                    <%
                                            }
                                        }//fi while
                                    %>                                              
                                </select>           
                            </p>
                            <div id="n8"></div>
                        </div>

                        <div class="caja">
                            <p>Plantel
                                <%
                                    ResultSet rs10 = cn.mostrar("Select * from catplanteles WHERE idEntidad='" + dato_entidad + "'");
                                %>
                                <select class="form-control" name="n_plantel" id="i_plantel" onchange="validarentrada3()" disabled="true">
                                    <option value="0">Escoge una opcion</option>
                                    <%
                                        while (rs10.next()) {
                                            if (rs10.getString("id").equals(dato_plantel)) {
                                    %>                 
                                    <option selected="true" value="<%=rs10.getString("id")%>"><%=rs10.getString("plantel")%></option>
                                    <%
                                    }//fin if
                                    else {
                                    %>
                                    <option value="<%=rs10.getString("id")%>"><%=rs10.getString("plantel")%></option>
                                    <%
                                            }
                                        }//fin while
                                    %>
                                </select>
                            </p>
                            <div id="n7"></div>


                        </div>
                        <div class="caja">
                            <p>Usuario                               
                                <input  class="form-control" id="usuario" placeholder="Usuario" type="text" name="usuario" maxlength="13" value="<%=dato_usuario%>">
                            <div id="n10"></div>
                            </p>
                        </div>
                    </div>
                    <%
                        }
                        if (dato_entidad != null && dato_plantel != null) {%>
                    <div class="registro">
                        <div class="caja">
                            <p>Nivel
                                <select class="form-control" name="nivel" id="nivel" onchange="seleccion_nivel()">
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
                                    ResultSet rs = cn.mostrar("Select id, entidad from catentidades");
                                %>

                                <select class="form-control" name="entidad" id="entidad" onchange="plantel()" >
                                    <option value="0" >Escoge una opcion</option>
                                    <%
                                        while (rs.next()) {
                                            if (rs.getString("id").equals(dato_entidad)) {

                                    %>

                                    <option selected="true" value="<%=rs.getString("id")%>"><%=rs.getString("entidad")%></option>

                                    <%//              regresa del combobox         muestra en el combo box
                                    }//fin if
                                    else {
                                    %>
                                    <option value="<%=rs.getString("id")%>"><%=rs.getString("entidad")%></option>
                                    <%
                                            }
                                        }//fi while
                                    %>                                              
                                </select>           
                            </p>
                            <div id="n8"></div>
                        </div>

                        <div class="caja">
                            <p>Plantel
                                <%
                                    ResultSet rs10 = cn.mostrar("Select * from catplanteles WHERE idEntidad='" + dato_entidad + "'");
                                %>
                                <select class="form-control" name="n_plantel" id="i_plantel" onchange="validarentrada3()" >
                                    <option value="0">Escoge una opcion</option>
                                    <%
                                        while (rs10.next()) {
                                            if (rs10.getString("id").equals(dato_plantel)) {
                                    %>                 
                                    <option selected="true" value="<%=rs10.getString("id")%>"><%=rs10.getString("plantel")%></option>
                                    <%
                                    }//fin if
                                    else {
                                    %>
                                    <option value="<%=rs10.getString("id")%>"><%=rs10.getString("plantel")%></option>
                                    <%
                                            }
                                        }//fin while
                                    %>
                                </select>
                            </p>
                            <div id="n7"></div>


                        </div>
                        <div class="caja">
                            <p>Usuario                               
                                <input  class="form-control" id="usuario" placeholder="Usuario" type="text" name="usuario" maxlength="13" value="<%=dato_usuario%>">
                            <div id="n10"></div>
                            </p>
                        </div>
                    </div>
                    <% }
                    }//OPCION ADMINISTRADOR NACIONAL COMBO BOX------------------------------------------------------------
                    else if (control_combobox1.equals("true") && nacional1.equals("1")) {
                        if (dato_entidad == null && dato_plantel == null) {
                    %> <%--OPCION FALSA COMBOBOX --%>             
                    <%-------------------------------------------------------------------OPCION ADMINISTRADOR NACIONAL COMBO BOX----------------------------%>   
                    <div class="registro">
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
                                    <option value="0" >Escoge una opcion</option>
                                    <%
                                        while (rs.next()) {
                                            if (rs.getString("id").equals(dato_entidad)) {

                                    %>

                                    <option selected="true" value="<%=rs.getString("id")%>"><%=rs.getString("entidad")%></option>

                                    <%//              regresa del combobox         muestra en el combo box
                                    }//fin if
                                    else {
                                    %>
                                    <option value="<%=rs.getString("id")%>"><%=rs.getString("entidad")%></option>
                                    <%
                                            }
                                        }//fi while
                                    %>                                              
                                </select>           
                            </p>
                            <div id="n8"></div>
                        </div>

                        <div class="caja">
                            <p>Plantel
                                <%
                                    ResultSet rs10 = cn.mostrar("Select * from catplanteles WHERE idEntidad='" + dato_entidad + "'");
                                %>
                                <select class="form-control" name="n_plantel" id="i_plantel" onchange="validarentrada3()" disabled="true">
                                    <option value="0">Escoge una opcion</option>
                                    <%
                                        while (rs10.next()) {
                                            if (rs10.getString("id").equals(dato_plantel)) {
                                    %>                 
                                    <option selected="true" value="<%=rs10.getString("id")%>"><%=rs10.getString("plantel")%></option>
                                    <%
                                    }//fin if
                                    else {
                                    %>
                                    <option value="<%=rs10.getString("id")%>"><%=rs10.getString("plantel")%></option>
                                    <%
                                            }
                                        }//fin while
                                    %>
                                </select>
                            </p>
                            <div id="n7"></div>

                        </div>
                        <div class="caja">
                            <p>Usuario                               
                                <input  class="form-control" id="usuario" placeholder="Usuario" type="text" name="usuario" maxlength="13" value="<%=dato_usuario%>">
                            <div id="n10"></div>
                            </p>
                        </div>
                    </div>
                    <%}//OPCION ADMINISTRADOR ESTATAL COMBO BOX
                        if (dato_entidad != null && dato_plantel == null) {%>
                         <div class="registro">
                        <div class="caja">
                            <p>Nivel
                                <select class="form-control" name="nivel" id="nivel" onchange="seleccion_nivel()">
                                    <option value="1" >Nacional</option> 
                                    <option value="2" selected="true">Estatal</option>
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

                                <select class="form-control" name="entidad" id="entidad" onchange="plantel()">
                                    <option value="0" >Escoge una opcion</option>
                                    <%
                                        while (rs.next()) {
                                            if (rs.getString("id").equals(dato_entidad)) {

                                    %>

                                    <option selected="true" value="<%=rs.getString("id")%>"><%=rs.getString("entidad")%></option>

                                    <%//              regresa del combobox         muestra en el combo box
                                    }//fin if
                                    else {
                                    %>
                                    <option value="<%=rs.getString("id")%>"><%=rs.getString("entidad")%></option>
                                    <%
                                            }
                                        }//fi while
                                    %>                                              
                                </select>           
                            </p>
                            <div id="n8"></div>
                        </div>

                        <div class="caja">
                            <p>Plantel
                                <%
                                    ResultSet rs10 = cn.mostrar("Select * from catplanteles WHERE idEntidad='" + dato_entidad + "'");
                                %>
                                <select class="form-control" name="n_plantel" id="i_plantel" onchange="validarentrada3()" disabled="true">
                                    <option value="0">Escoge una opcion</option>
                                    <%
                                        while (rs10.next()) {
                                            if (rs10.getString("id").equals(dato_plantel)) {
                                    %>                 
                                    <option selected="true" value="<%=rs10.getString("id")%>"><%=rs10.getString("plantel")%></option>
                                    <%
                                    }//fin if
                                    else {
                                    %>
                                    <option value="<%=rs10.getString("id")%>"><%=rs10.getString("plantel")%></option>
                                    <%
                                            }
                                        }//fin while
                                    %>
                                </select>
                            </p>
                            <div id="n7"></div>

                        </div>
                        <div class="caja">
                            <p>Usuario                               
                                <input  class="form-control" id="usuario" placeholder="Usuario" type="text" name="usuario" maxlength="13" value="<%=dato_usuario%>">
                            <div id="n10"></div>
                            </p>
                        </div>
                    </div>
                       <% } 
                       if (dato_entidad != null && dato_plantel != null) {%>
                       <div class="registro">
                        <div class="caja">
                            <p>Nivel
                                <select class="form-control" name="nivel" id="nivel" onchange="seleccion_nivel()">
                                    <option value="1" >Nacional</option> 
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
                                    ResultSet rs = cn.mostrar("Select id, entidad from catentidades");
                                %>

                                <select class="form-control" name="entidad" id="entidad" onchange="plantel()">
                                    <option value="0" >Escoge una opcion</option>
                                    <%
                                        while (rs.next()) {
                                            if (rs.getString("id").equals(dato_entidad)) {

                                    %>

                                    <option selected="true" value="<%=rs.getString("id")%>"><%=rs.getString("entidad")%></option>

                                    <%//              regresa del combobox         muestra en el combo box
                                    }//fin if
                                    else {
                                    %>
                                    <option value="<%=rs.getString("id")%>"><%=rs.getString("entidad")%></option>
                                    <%
                                            }
                                        }//fi while
                                    %>                                              
                                </select>           
                            </p>
                            <div id="n8"></div>
                        </div>

                        <div class="caja">
                            <p>Plantel
                                <%
                                    ResultSet rs10 = cn.mostrar("Select * from catplanteles WHERE idEntidad='" + dato_entidad + "'");
                                %>
                                <select class="form-control" name="n_plantel" id="i_plantel" onchange="validarentrada3()" >
                                    <option value="0">Escoge una opcion</option>
                                    <%
                                        while (rs10.next()) {
                                            if (rs10.getString("id").equals(dato_plantel)) {
                                    %>                 
                                    <option selected="true" value="<%=rs10.getString("id")%>"><%=rs10.getString("plantel")%></option>
                                    <%
                                    }//fin if
                                    else {
                                    %>
                                    <option value="<%=rs10.getString("id")%>"><%=rs10.getString("plantel")%></option>
                                    <%
                                            }
                                        }//fin while
                                    %>
                                </select>
                            </p>
                            <div id="n7"></div>

                        </div>
                        <div class="caja">
                            <p>Usuario                               
                                <input  class="form-control" id="usuario" placeholder="Usuario" type="text" name="usuario" maxlength="13" value="<%=dato_usuario%>">
                            <div id="n10"></div>
                            </p>
                        </div>
                    </div>
                     <% }}else if (control_combobox1.equals("true") && nacional1.equals("2")) {
                     if (dato_entidad == null && dato_plantel == null) {
                     %> 
                    <div class="registro">
                        <div class="caja">
                            <p>Nivel
                                <select class="form-control" name="nivel" id="nivel" onchange="seleccion_nivel()" disabled="true">
                                    <option value="1" selected="true">Nacional</option> 
                                    <option value="2">Estatal</option>
                                    <option value="3" >Plantel</option>
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
                                    <option value="0" >Escoge una opcion</option>
                                    <%
                                        while (rs.next()) {
                                            if (rs.getString("id").equals(dato_entidad)) {

                                    %>

                                    <option selected="true" value="<%=rs.getString("id")%>"><%=rs.getString("entidad")%></option>

                                    <%//              regresa del combobox         muestra en el combo box
                                    }//fin if
                                    else {
                                    %>
                                    <option value="<%=rs.getString("id")%>"><%=rs.getString("entidad")%></option>
                                    <%
                                            }
                                        }//fi while
                                    %>                                              
                                </select>           
                            </p>
                            <div id="n8"></div>
                        </div>

                        <div class="caja">
                            <p>Plantel
                                <%
                                    ResultSet rs10 = cn.mostrar("Select * from catplanteles WHERE idEntidad='" + dato_entidad + "'");
                                %>
                                <select class="form-control" name="n_plantel" id="i_plantel" onchange="validarentrada3()" disabled="true">
                                    <option value="0">Escoge una opcion</option>
                                    <%
                                        while (rs10.next()) {
                                            if (rs10.getString("id").equals(dato_plantel)) {
                                    %>                 
                                    <option selected="true" value="<%=rs10.getString("id")%>"><%=rs10.getString("plantel")%></option>
                                    <%
                                    }//fin if
                                    else {
                                    %>
                                    <option value="<%=rs10.getString("id")%>"><%=rs10.getString("plantel")%></option>
                                    <%
                                            }
                                        }//fin while
%>
                                </select>
                            </p>
                            <div id="n7"></div>

                        </div>
                        <div class="caja">
                            <p>Usuario                               
                                <input  class="form-control" id="usuario" placeholder="Usuario" type="text" name="usuario" maxlength="13" value="<%=dato_usuario%>">
                            <div id="n10"></div>
                            </p>
                        </div>
                    </div>
                    <%}//OPCION ADMINISTRADOR PLANTEL COMBO BOX
                        if (dato_entidad != null && dato_plantel == null) {%>
                      <div class="registro">
                        <div class="caja">
                            <p>Nivel
                                <select class="form-control" name="nivel" id="nivel" onchange="seleccion_nivel()" >
                                 <%--<option value="1" >Nacional</option> --%>
                                    <option value="2" selected="true">Estatal</option>
                                  <%--  <option value="3" >Plantel</option> --%>
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

                                <select class="form-control" name="entidad" id="entidad" onchange="plantel()" >
                                    <option value="0" >Escoge una opcion</option>
                                    <%
                                        while (rs.next()) {
                                            if (rs.getString("id").equals(dato_entidad)) {

                                    %>

                                    <option selected="true" value="<%=rs.getString("id")%>"><%=rs.getString("entidad")%></option>

                                    <%//              regresa del combobox         muestra en el combo box
                                    }//fin if
                                    else {
                                    %>
                                    <option value="<%=rs.getString("id")%>"><%=rs.getString("entidad")%></option>
                                    <%
                                            }
                                        }//fi while
                                    %>                                              
                                </select>           
                            </p>
                            <div id="n8"></div>
                        </div>

                        <div class="caja">
                            <p>Plantel
                                <%
                                    ResultSet rs10 = cn.mostrar("Select * from catplanteles WHERE idEntidad='" + dato_entidad + "'");
                                %>
                                <select class="form-control" name="n_plantel" id="i_plantel" onchange="validarentrada3()" disabled="true">
                                    <option value="0">Escoge una opcion</option>
                                    <%
                                        while (rs10.next()) {
                                            if (rs10.getString("id").equals(dato_plantel)) {
                                    %>                 
                                    <option selected="true" value="<%=rs10.getString("id")%>"><%=rs10.getString("plantel")%></option>
                                    <%
                                    }//fin if
                                    else {
                                    %>
                                    <option value="<%=rs10.getString("id")%>"><%=rs10.getString("plantel")%></option>
                                    <%
                                            }
                                        }//fin while
%>
                                </select>
                            </p>
                            <div id="n7"></div>

                        </div>
                        <div class="caja">
                            <p>Usuario                               
                                <input  class="form-control" id="usuario" placeholder="Usuario" type="text" name="usuario" maxlength="13" value="<%=dato_usuario%>">
                            <div id="n10"></div>
                            </p>
                        </div>
                    </div>  
                        <%}
                        if (dato_entidad != null && dato_plantel != null) {%>
                        
                         <div class="registro">
                        <div class="caja">
                            <p>Nivel
                                <select class="form-control" name="nivel" id="nivel" onchange="seleccion_nivel()" >
                                  <%--  <option value="1" >Nacional</option>  --%>
                                  <%--  <option value="2" >Estatal</option>  --%>
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
                                    ResultSet rs = cn.mostrar("Select id, entidad from catentidades");
                                %>

                                <select class="form-control" name="entidad" id="entidad" onchange="plantel()" disabled="true" >
                                    <option value="0" >Escoge una opcion</option>
                                    <%
                                        while (rs.next()) {
                                            if (rs.getString("id").equals(dato_entidad)) {

                                    %>

                                    <option selected="true" value="<%=rs.getString("id")%>"><%=rs.getString("entidad")%></option>

                                    <%//              regresa del combobox         muestra en el combo box
                                    }//fin if
                                    else {
                                    %>
                                    <option value="<%=rs.getString("id")%>"><%=rs.getString("entidad")%></option>
                                    <%
                                            }
                                        }//fi while
                                    %>                                              
                                </select>           
                            </p>
                            <div id="n8"></div>
                        </div>

                        <div class="caja">
                            <p>Plantel
                                <%
                                    ResultSet rs10 = cn.mostrar("Select * from catplanteles WHERE idEntidad='" + dato_entidad + "'");
                                %>
                                <select class="form-control" name="n_plantel" id="i_plantel" onchange="validarentrada3()">
                                    <option value="0">Escoge una opcion</option>
                                    <%
                                        while (rs10.next()) {
                                            if (rs10.getString("id").equals(dato_plantel)) {
                                    %>                 
                                    <option selected="true" value="<%=rs10.getString("id")%>"><%=rs10.getString("plantel")%></option>
                                    <%
                                    }//fin if
                                    else {
                                    %>
                                    <option value="<%=rs10.getString("id")%>"><%=rs10.getString("plantel")%></option>
                                    <%
                                            }
                                        }//fin while
%>
                                </select>
                            </p>
                            <div id="n7"></div>

                        </div>
                        <div class="caja">
                            <p>Usuario                               
                                <input  class="form-control" id="usuario" placeholder="Usuario" type="text" name="usuario" maxlength="13" value="<%=dato_usuario%>">
                            <div id="n10"></div>
                            </p>
                        </div>
                    </div>  
                    <%} }else if (control_combobox1.equals("true") && nacional1.equals("3")) {
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
                        <div class="caja">
                            <p>Usuario
                                <input  class="form-control" id="usuario" placeholder="Usuario" type="text" name="usuario" maxlength="13">
                            <div id="n10"></div>
                            </p>
                        </div>
                    </div>
                    <%}
                    %>








                    <div class="registro">
                        <div class="caja">
                            <p>Nombre<input id="nombre_nom" class="form-control" type="text" name="Nombre" size="33" placeholder="Nombre" value="<%=dato_nombre%>"></p>
                            <div id="n"></div>
                        </div>


                        <div class="caja">
                            <p>Primer Apellido<input id="ap" class="form-control" type="text" name="primerApellido" size="33" placeholder="Apellido Paterno" value="<%=dato_ap%>"></p>
                            <div id="n1"></div>
                        </div>
                        <div class="caja">
                            <p>Segundo Apellido(opcional)<input id="am" class="form-control" type="text" name="segundoApellido" size="33" placeholder="Apellido Materno" value="<%=dato_am%>"></p>
                            <div id="n2"></div>
                        </div>
                    </div>

                    <div class="registro">

                        <div class="caja">
                            <p>Tel??fono fijo<input id="tel" class="form-control" type="tel" name="telfijo" size="10" placeholder="Tel??fono fijo" maxlength="10" value="<%=dato_tel%>"></p>
                            <div id="n4"></div>
                        </div>
                        <div class="caja">
                            <p>Tel??fono celular<input id="cel" class="form-control" type="tel" name="telcel" size="10" placeholder="Tel??fono celular" maxlength="10" value="<%=dato_cel%>"></p>
                            <div id="n5"></div>
                        </div>
                        <div class="caja">
                            <p>Correo electr??nico<input id="correo" class="form-control" type="email" name="correo" size="50" placeholder="usuario@servidor.com" value="<%=dato_correo%>"></p>
                            <div id="n6"></div>
                        </div>
                    </div>



                    <div class="registro">
                        <div class="caja">
                            <p>Contrase??a<input class="form-control" type="password" name="clave" placeholder="Escribir contrase??a"  id="pass1" value="<%=dato_clave%>"></p>    
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
                                    int i = 1, p = 1, q = 0;
                                    String listado[] = new String[10];
                                    ResultSet rs3 = null;
                                    rs3 = cn.mostrar_usuarios("SELECT permiso FROM catpermisos");
                                    while (rs3.next()) {
                                        if (check[q] == p) {

                                %>
                                <input type="checkbox" id="ckl" name="ckl" value="<%=i++%>" checked="true"> <label for="ckl"><% out.print(rs3.getString("permiso"));%></label>  <br> 
                                <%
                                    q++;
                                } else {
                                %>
                                <input type="checkbox" id="ckl" name="ckl" value="<%=i++%>" > <label for="ckl"><% out.print(rs3.getString("permiso"));%></label>  <br> 
                                <%
                                        }
                                        p++;
                                    }
                                %>
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

                            if (ver != null) {
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
                        <input type="hidden" name="id" id="id" value="<%=id1%>">
                        <input type="hidden" name="control_combobox" id="control_combobox" value="<%=control_combobox1%>">
                        <input type="hidden" name="nacional" id="nacional" value="<%=nacional1%>"> <%--AGREGAR--%>
                        <input type="hidden" name="permiso1" id="permiso1" value="<%=per11%>">
                        <input type="hidden" name="permiso2" id="permiso2" value="<%=per21%>">
                        <input type="hidden" name="permiso4" id="permiso4" value="<%=per41%>">  
                        <input type="hidden" name="nombre" id="nombre" value="<%=dato_nom1%>">
                        <input type="hidden" name="dato_ent" id="dato_ent" value="<%=dato_ent1%>">
                        <input type="hidden" name="dato_pla" id="dato_pla" value="<%=dato_pla1%>">
                        <input type="hidden" name="dato_rfc" id="dato_rfc" value="<%=dato_rfc1%>">  
                        <input type="hidden" name="id_modificar" id="id_modificar" value="<%=id1%>">
                        <button class="btn btn-primary pull-right" type="submit" name="modificarusuario">Guardar</button>

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
                    <input type="hidden" name="id" id="id" value="<%=id1%>">
                    <input type="hidden" name="control_combobox" id="control_combobox" value="<%=control_combobox1%>">
                    <input type="hidden" name="nacional" id="nacional" value="<%=nacional1%>"> <%--AGREGAR--%>
                    <input type="hidden" name="permiso1" id="permiso1" value="<%=per11%>">
                    <input type="hidden" name="permiso2" id="permiso2" value="<%=per21%>">
                    <input type="hidden" name="permiso4" id="permiso4" value="<%=per41%>">  
                    <input type="hidden" name="nombre" id="nombre" value="<%=dato_nom1%>">
                    <input type="hidden" name="dato_ent" id="dato_ent" value="<%=dato_ent1%>">
                    <input type="hidden" name="dato_pla" id="dato_pla" value="<%=dato_pla1%>">
                    <input type="hidden" name="dato_rfc" id="dato_rfc" value="<%=dato_rfc1%>">                                  
                </div>
            </form>




            <!-- JS  para el framework del gobierno-->
            <script src="https://framework-gb.cdn.gob.mx/gobmx.js"></script>
            <script src="js/notificaciones6.js"></script>
        </div>
        <%
            } else {
                response.sendRedirect("login.jsp");
            }
        %>







    </body>
</html>
