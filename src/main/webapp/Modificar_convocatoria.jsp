<%-- 
    Document   : Modificar_convocatoria
    Created on : 16-ago-2020, 13:19:18
    Author     : charl
--%>

<%@page import="java.sql.ResultSet"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
    <head>
        <meta charset="utf-8">
        <title>DGETI | gob.mx</title>
        <meta name="viewport" content="width=device-width, user-scalable=no, initial-scale=1.0, maximun-scale=1.0, minimun-scale=1.0">
        <link rel="stylesheet" href="css/all.css">
        <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@500&display=swap" rel="stylesheet">
        <link rel="stylesheet" href="css/estilos.css">

        <link href="/favicon.ico" rel="shortcut icon">
        <link href="https://framework-gb.cdn.gob.mx/assets/styles/main.css" rel="stylesheet"> 
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@9"></script>

        <script src="sweetalert2.all.min.js"></script>
        <!-- Optional: include a polyfill for ES6 Promises for IE11 -->
        <script src="https://cdn.jsdelivr.net/npm/promise-polyfill"></script>

        <style>
            #mensaje { color: #FF0000; }
        </style>
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



            var thecontents = new Array()
            thecontents[0] = "imagenes/nada.png"
            thecontents[1] = "imagenes/sems.jpg"
            thecontents[2] = "imagenes/uemstis.png"

            function changecontent(which) {

                imagen.src = thecontents[document.regconv.selectbox.selectedIndex]
                /*  document.regconv.contentbox.value = thecontents[document.regconv.selectbox.selectedIndex]*/
            }



        </script> 
        <jsp:useBean id="catalogo" class="herramientas.Catalogos" />
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

            <!--<header class="headerart">
                <div class="titulo">
                    <p>Direcci??n General de Educaci??n Tecnol??gica Industrial y de Servicios</p>
                </div> 
                <div class="texto-principalart margen-interno">
                    <p>Programa de Promoci??n en el Servicio Docente en Educaci??n Media Superior</p>
                </div> 
            </header>
            <div class="ruta">
                <p> DGETI > Promoci??n Docente > Registro de Convocatoria</p>
            </div>-->


            <section class="sectionreg">
                <div class="articulosart">
                    <jsp:useBean id="cn" class="metodos_sql.Metodos_sql" scope="page"></jsp:useBean>
                        <form  name="data" id="data" method="POST" action="Servlet_cargar_convocatoria" onSubmit="return validar_datos();">
                            <br>
                            <br>
                        <%
                            String elegir1 = "0";

                            elegir1 = String.valueOf(request.getAttribute("opc"));
                            ResultSet rs2 = null;
                            String id_convocatoria = "";
                            if (elegir1.equals("1")) {
                        %>
                        <div class="registro">
                            <div class="caja">
                                <h4>MODIFICAR CONVOCATORIA</h4> 
                            </div>
                            <%--      <div class="caja" align="right">
                                      <div id="rfc_13digitos">
                                          <%
                                              String rfc1 = String.valueOf(request.getAttribute("dato_rfc"));
                                              out.print(rfc1);
                                          %>
                                      </div>
                                      <div id="nombre_completo">
                                          <%
                                              String nom1 = String.valueOf(request.getAttribute("nom"));
                                              out.print(nom1);
                                          %>
                                      </div> 
                                      <div id="cerrar_sesion">
                                          <input  class="boton_personalizado" type="submit" value="Cerrar Sesion" name="cerrar" form="data4">
                                      </div>
                                  </div> --%>
                        </div>

                        <%--     <div class="registro_cct_plantel">                         
                                 <div id="cct" style="text-indent: 1cm;">
                                     <%
                                         //String ent1 = String.valueOf(request.getAttribute("dato_ent"));
                                         ResultSet rs6 = cn.mostrar("Select entidad from catentidades where id='" + request.getAttribute("dato_ent") + "'");
                                         while (rs6.next()) {
                                             out.print(rs6.getString("entidad") + " - ");
                                         }

                                %>
                            </div>                          
                            <div id="plantel">
                                <%                                    //String pla1 = String.valueOf(request.getAttribute("dato_pla"));
                                    ResultSet rs7 = cn.mostrar("Select plantel from catplanteles where id='" + request.getAttribute("dato_pla") + "'");
                                    while (rs7.next()) {
                                        out.print(rs7.getString("plantel"));
                                    }
                                %>
                            </div>
                        </div>  --%>

                        <br>
                        <!--         <input type="hidden" name="f_opc" id="i_opc">
                                 <div class="registro"> 
                                     <div class="caja">
                                         <p>Carga de Logo
                                             <select class="form-control" id="selectbox" name="selectbox" id="logo" onChange="changecontent(this)" >
                                                 <option value="0">Escoge una opcion</option>
                                                 <option value="1">Logo SEMS</option>
                                                 <option value="2">Logo DGETI</option>                                            
                                             </select>	
                                         </p>
                                         <div id="n100"></div>
                                     </div>
         
         
         
                                     <div class="caja" align="center">
                                         <img name="imagen" src=""/>
                                     </div>
                                 </div> -->

                        <div class="registro">    
                            <div class="caja">
                                <iframe style="display:none" id="frame" width="310" height=150" frameborder="0"></iframe>
                            </div>
                        </div>
                        <%
                            if (request.getAttribute("nacional").equals("1")) {
                        %>
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
                        </div>
                        <div class="registro">    
                            <div class="caja">
                                <p>Programa:<br>
                                    <select class="form-control" name="programa" id="programa">
                                        ${catalogo.desplegarOpcionesProgramas()}
                                    </select>
                                <div id="c1"></div>
                                <div id="mensaje"><%out.print(request.getAttribute("mensaje"));%></div>
                            </div>
                        </div>
                        <%
                            }
                            if (request.getAttribute("nacional").equals("2")) {
                        %>
                            <div class="registro">
                            <div class="caja">
                                <input type="hidden" name="f_opc" id="i_opc">
                                <input type="hidden" name="campoentidad" id="campoentidad" >
                                <p>Entidad
                                    <%
                                        ResultSet rs = cn.mostrar("Select id, entidad from catentidades WHERE id='"+ent1+"'");
                                    %>

                                    <select class="form-control" name="entidad" id="entidad" onchange="plantel()">
                                   <%--     <option value="0">Escoge una opcion</option>  --%>
                                        <%
                                            while (rs.next()) {
                                        %>
                                        <option value="<%=rs.getString("id")%>" ><%=rs.getString("entidad")%></option>

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
                                            ResultSet rs1 = cn.mostrar("Select * from catplanteles WHERE idEntidad='" + ent1 + "'");
                                        %>
                                        <select class="form-control" name="n_plantel" id="i_plantel" onchange="validarentrada3()">
                                            <option value="0">Escoge una opcion</option>   
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
                        </div>
                        <div class="registro">    
                            <div class="caja">
                                <p>Programa:<br>
                                    <select class="form-control" name="programa" id="programa">
                                        ${catalogo.desplegarOpcionesProgramas()}
                                    </select>
                                <div id="c1"></div>
                                <div id="mensaje"><%out.print(request.getAttribute("mensaje"));%></div>
                            </div>
                        </div>
                        <%
                            }
                            if (request.getAttribute("nacional").equals("3")) {
                        %>
                         <div class="registro">
                            <div class="caja">
                                <input type="hidden" name="f_opc" id="i_opc">
                                <input type="hidden" name="campoentidad" id="campoentidad" >
                                <p>Entidad
                                    <%
                                        ResultSet rs = cn.mostrar("Select id, entidad from catentidades WHERE id='"+ent1+"'");
                                    %>

                                    <select class="form-control" name="entidad" id="entidad" onchange="plantel()">
                                   <%--     <option value="0">Escoge una opcion</option>  --%>
                                        <%
                                            while (rs.next()) {
                                        %>
                                        <option value="<%=rs.getString("id")%>" ><%=rs.getString("entidad")%></option>

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
                                            ResultSet rs1 = cn.mostrar("Select * from catplanteles WHERE id='" + pla1 + "'");
                                        %>
                                        <select class="form-control" name="n_plantel" id="i_plantel" onchange="validarentrada3()">
                                           <%--  <option value="0">Escoge una opcion</option>   --%>
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
                        </div>
                        <div class="registro">    
                            <div class="caja">
                                <p>Programa:<br>
                                    <select class="form-control" name="programa" id="programa">
                                        ${catalogo.desplegarOpcionesProgramas()}
                                    </select>
                                <div id="c1"></div>
                                <div id="mensaje"><%out.print(request.getAttribute("mensaje"));%></div>
                            </div>
                        </div>
                        <%
                            }
                        %>
                        




                        <input  class="btn btn-primary pull-right" type="submit" value="Buscar Convocatoria" name="buscar" onclick="valor()">       

                        <br><br><br>
                        <%-----------------------------------------------------------------------------------------------%>
                        <div class="registro">    
                            <div class="caja">

                                <%
                                    //String ent1 = String.valueOf(request.getAttribute("dato_ent"));
                                    ResultSet rs6 = cn.mostrar("Select entidad from catentidades where id='" + request.getAttribute("entidad") + "'");
                                    while (rs6.next()) {
                                        out.print(rs6.getString("entidad") + " - ");
                                    }
                                %>                                 

                                <%                                    //String pla1 = String.valueOf(request.getAttribute("dato_pla"));
                                    ResultSet rs7 = cn.mostrar("Select plantel from catplanteles where id='" + request.getAttribute("plantel") + "'");
                                    while (rs7.next()) {
                                        out.print(rs7.getString("plantel"));
                                    }
                                %>
                                <br>
                                <%                                    //String pla1 = String.valueOf(request.getAttribute("dato_pla"));
                                    ResultSet rs8 = cn.mostrar("Select programa from catprogramas where id='" + request.getAttribute("programa") + "'");
                                    while (rs8.next()) {
                                        out.print(rs8.getString("programa"));
                                    }
                                %>
                            </div>
                        </div> 
                        <br>


                        <% if (request.getAttribute("ver").equals("0")) {%>

                        <div class="registro">    
                            <div class="caja">
                                <p>Fecha de publicaci??n de convocatoria
                                    <input type="date" id="publicacion" name="publicacion" value="" min="2020-01-01" max="2020-12-31" disabled="true">
                                </p>
                                <div id="c2"></div>
                            </div>
                        </div>

                        <br>
                        <div class="registro">    
                            <div class="caja">
                                <p>Periodo de registro</p>
                                Inicio <input type="date" id="periodo_registro_inicio" name="periodo_registro_inicio" value="" min="2020-01-01" max="2020-12-31" disabled="true">
                                <div id="c3"></div>
                                <br>  Final &nbsp;<input type="date" id="periodo_registro_fin" name="periodo_registro_fin" value="" min="2020-01-01" max="2020-12-31" disabled="true"> 
                                <div id="c4"></div>
                            </div>

                            <div class="caja">
                                <p>Periodo de valoraci??n</p>
                                Inicio <input type="date" id="periodo_valoracion_inicio" name="periodo_valoracion_inicio" value="" min="2020-01-01" max="2020-12-31" disabled="true">
                                <div id="c5"></div>
                                <br>  Final &nbsp;<input type="date" id="periodo_valoracion_fin" name="periodo_valoracion_fin" value="" min="2020-01-01" max="2020-12-31" disabled="true"> 
                                <div id="c6"></div>
                            </div>

                            <div class="caja">
                                <p>Periodo de dictaminaci??n</p>
                                Inicio <input type="date" id="periodo_dictaminacion_inicio" name="periodo_dictaminacion_inicio" value="" min="2020-01-01" max="2020-12-31" disabled="true">
                                <div id="c7"></div>
                                <br>  Final &nbsp;<input type="date" id="periodo_dictaminacion_fin" name="periodo_dictaminacion_fin" value="" min="2020-01-01" max="2020-12-31" disabled="true"> 
                                <div id="c8"></div>
                            </div>
                        </div>

                        <br>
                        <div class="registro">    
                            <div class="caja">
                                <p>Publicaci??n de resultados
                                    <input type="date" id="publicacion_resultados" name="publicacion_resultados" value="" min="2020-01-01" max="2020-12-31" disabled="true">
                                </p>
                                <div id="c9"></div>
                            </div>
                        </div>

                        <div class="registro">    
                            <div class="caja">
                                <p>Estatus
                                    <select class="form-control" name="estatus" id="estatus" disabled="true">
                                        <option value="TEMPORAL">TEMPORAL</option> 
                                        <%-- <option value="definitiva" disabled="true">Definitiva</option> --%>
                                    </select>
                                </p>
                                <div id="c10"></div>
                            </div>
                        </div>
                        <input  class="btn btn-primary pull-right" type="submit" value="Guardar Cambios" name="guardar" disabled="true">
                        <% }//fin condicion verdadera = 0
                        else if (request.getAttribute("ver").equals("1")) {%>
                        <input type="hidden" name="id" id="id" value="<%=request.getAttribute("id")%>">

                        <div class="registro">    
                            <div class="caja">
                                <p>Fecha de publicaci??n de convocatoria
                                    <input type="date" id="publicacion" name="publicacion" value="<%=request.getAttribute("publ")%>" >
                                </p>
                                <div id="c2"></div>
                            </div>
                        </div>

                        <br>
                        <div class="registro">    
                            <div class="caja">
                                <p>Periodo de registro</p>
                                Inicio <input type="date" id="periodo_registro_inicio" name="periodo_registro_inicio" value="<%=request.getAttribute("ireg")%>" >
                                <div id="c3"></div>
                                <br>  Final &nbsp;<input type="date" id="periodo_registro_fin" name="periodo_registro_fin" value="<%=request.getAttribute("freg")%>" > 
                                <div id="c4"></div>
                            </div>

                            <div class="caja">
                                <p>Periodo de valoraci??n</p>
                                Inicio <input type="date" id="periodo_valoracion_inicio" name="periodo_valoracion_inicio" value="<%=request.getAttribute("ival")%>" >
                                <div id="c5"></div>
                                <br>  Final &nbsp;<input type="date" id="periodo_valoracion_fin" name="periodo_valoracion_fin" value="<%=request.getAttribute("fval")%>" > 
                                <div id="c6"></div>
                            </div>

                            <div class="caja">
                                <p>Periodo de dictaminaci??n</p>
                                Inicio <input type="date" id="periodo_dictaminacion_inicio" name="periodo_dictaminacion_inicio" value="<%=request.getAttribute("idic")%>">
                                <div id="c7"></div>
                                <br>  Final &nbsp;<input type="date" id="periodo_dictaminacion_fin" name="periodo_dictaminacion_fin" value="<%=request.getAttribute("fdic")%>"> 
                                <div id="c8"></div>
                            </div>
                        </div>

                        <br>
                        <div class="registro">    
                            <div class="caja">
                                <p>Publicaci??n de resultados
                                    <input type="date" id="publicacion_resultados" name="publicacion_resultados" value="<%=request.getAttribute("resu")%>" >
                                </p>
                                <div id="c9"></div>
                            </div>
                        </div>

                        <div class="registro">    
                            <div class="caja">
                                <p>Estatus
                                    <%
                                        rs2 = cn.mostrar_usuarios("SELECT idConvocatoria FROM vacancia WHERE idConvocatoria='" + request.getAttribute("id") + "'");
                                    %>
                                    <select class="form-control" name="estatus" id="estatus" onchange="mensaje()">
                                        <option value="TEMPORAL">TEMPORAL</option> 
                                        <%
                                            while (rs2.next()) {
                                                id_convocatoria = rs2.getString("idConvocatoria");
                                            }

                                            if (id_convocatoria.equals(request.getAttribute("id"))) {
                                        %>
                                        <option value="DEFINITIVA">DEFINITIVA</option>
                                        <%
                                        } else {
                                        %>
                                        <option value="DEFINITIVA" disabled="true">DEFINITIVA</option>
                                        <%
                                            }

                                        %>
                                    </select>
                                </p>
                                <div id="c10"></div>
                            </div>
                        </div>

                        <input  class="btn btn-primary pull-right" type="submit" value="Guardar Cambios" name="guardar1">
                        <% }//fin de la condicion ver= 1                        
                        else if (request.getAttribute("ver").equals("2") && (request.getAttribute("nacional").equals("2") || request.getAttribute("nacional").equals("3"))) {%>
                        <input type="hidden" name="id" id="id" value="<%=request.getAttribute("id")%>">

                        <div class="registro">    
                            <div class="caja">
                                <p>Fecha de publicaci??n de convocatoria
                                    <input type="date" id="publicacion" name="publicacion" value="<%=request.getAttribute("publ")%>" disabled="true">
                                </p>
                                <div id="c2"></div>
                            </div>
                        </div>

                        <br>
                        <div class="registro">    
                            <div class="caja">
                                <p>Periodo de registro</p>
                                Inicio <input type="date" id="periodo_registro_inicio" name="periodo_registro_inicio" value="<%=request.getAttribute("ireg")%>" disabled="true">
                                <div id="c3"></div>
                                <br>  Final &nbsp;<input type="date" id="periodo_registro_fin" name="periodo_registro_fin" value="<%=request.getAttribute("freg")%>" disabled="true"> 
                                <div id="c4"></div>
                            </div>

                            <div class="caja">
                                <p>Periodo de valoraci??n</p>
                                Inicio <input type="date" id="periodo_valoracion_inicio" name="periodo_valoracion_inicio" value="<%=request.getAttribute("ival")%>" disabled="true">
                                <div id="c5"></div>
                                <br>  Final &nbsp;<input type="date" id="periodo_valoracion_fin" name="periodo_valoracion_fin" value="<%=request.getAttribute("fval")%>" disabled="true"> 
                                <div id="c6"></div>
                            </div>

                            <div class="caja">
                                <p>Periodo de dictaminaci??n</p>
                                Inicio <input type="date" id="periodo_dictaminacion_inicio" name="periodo_dictaminacion_inicio" value="<%=request.getAttribute("idic")%>" disabled="true">
                                <div id="c7"></div>
                                <br>  Final &nbsp;<input type="date" id="periodo_dictaminacion_fin" name="periodo_dictaminacion_fin" value="<%=request.getAttribute("fdic")%>" disabled="true"> 
                                <div id="c8"></div>
                            </div>
                        </div>

                        <br>
                        <div class="registro">    
                            <div class="caja">
                                <p>Publicaci??n de resultados
                                    <input type="date" id="publicacion_resultados" name="publicacion_resultados" value="<%=request.getAttribute("resu")%>" disabled="true">
                                </p>
                                <div id="c9"></div>
                            </div>
                        </div>

                        <div class="registro">    
                            <div class="caja">
                                <p>Estatus
                                    <select class="form-control" name="estatus" id="estatus" onchange="mensaje()" disabled="true">
                                        <option value="DEFINITIVA">DEFINITIVA</option>                                         
                                    </select>
                                </p>
                                <div id="c10"></div>
                            </div>
                        </div>

                        <input  class="btn btn-primary pull-right" type="submit" value="Guardar Cambios" name="guardar2" disabled="true">
                        <% }//fin de la condicion ver=2
                        else if (request.getAttribute("ver").equals("2") && request.getAttribute("nacional").equals("1")) {
                        %>
                        <input type="hidden" name="id" id="id" value="<%=request.getAttribute("id")%>">

                        <div class="registro">    
                            <div class="caja">
                                <p>Fecha de publicaci??n de convocatoria
                                    <input type="date" id="publicacion" name="publicacion" value="<%=request.getAttribute("publ")%>" >
                                </p>
                                <div id="c2"></div>
                            </div>
                        </div>

                        <br>
                        <div class="registro">    
                            <div class="caja">
                                <p>Periodo de registro</p>
                                Inicio <input type="date" id="periodo_registro_inicio" name="periodo_registro_inicio" value="<%=request.getAttribute("ireg")%>" >
                                <div id="c3"></div>
                                <br>  Final &nbsp;<input type="date" id="periodo_registro_fin" name="periodo_registro_fin" value="<%=request.getAttribute("freg")%>" > 
                                <div id="c4"></div>
                            </div>

                            <div class="caja">
                                <p>Periodo de valoraci??n</p>
                                Inicio <input type="date" id="periodo_valoracion_inicio" name="periodo_valoracion_inicio" value="<%=request.getAttribute("ival")%>" >
                                <div id="c5"></div>
                                <br>  Final &nbsp;<input type="date" id="periodo_valoracion_fin" name="periodo_valoracion_fin" value="<%=request.getAttribute("fval")%>" > 
                                <div id="c6"></div>
                            </div>

                            <div class="caja">
                                <p>Periodo de dictaminaci??n</p>
                                Inicio <input type="date" id="periodo_dictaminacion_inicio" name="periodo_dictaminacion_inicio" value="<%=request.getAttribute("idic")%>">
                                <div id="c7"></div>
                                <br>  Final &nbsp;<input type="date" id="periodo_dictaminacion_fin" name="periodo_dictaminacion_fin" value="<%=request.getAttribute("fdic")%>"> 
                                <div id="c8"></div>
                            </div>
                        </div>

                        <br>
                        <div class="registro">    
                            <div class="caja">
                                <p>Publicaci??n de resultados
                                    <input type="date" id="publicacion_resultados" name="publicacion_resultados" value="<%=request.getAttribute("resu")%>" >
                                </p>
                                <div id="c9"></div>
                            </div>
                        </div>

                        <div class="registro">    
                            <div class="caja">
                                <p>Estatus
                                    <%
                                        rs2 = cn.mostrar_usuarios("SELECT idConvocatoria FROM vacancia WHERE idConvocatoria='" + request.getAttribute("id") + "'");
                                    %>
                                    <select class="form-control" name="estatus" id="estatus" onchange="mensaje()">
                                        <option value="TEMPORAL">TEMPORAL</option> 
                                        <%
                                            while (rs2.next()) {
                                                id_convocatoria = rs2.getString("idConvocatoria");
                                            }

                                            if (id_convocatoria.equals(request.getAttribute("id"))) {
                                        %>
                                        <option value="DEFINITIVA" selected="true">DEFINITIVA</option>
                                        <%
                                        } else {
                                        %>
                                        <option value="DEFINITIVA" disabled="true">DEFINITIVA</option>
                                        <%
                                            }

                                        %>
                                    </select>
                                </p>
                                <div id="c10"></div>
                            </div>
                        </div>

                        <input  class="btn btn-primary pull-right" type="submit" value="Guardar Cambios" name="guardar1">
                        <%                            }
                        %>



                        <%
                            } else {
                                response.sendRedirect("login.jsp");
                            }
                        %>

                        <div class="registro">  
                            <div class="caja">
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
                        </div>
                    </form>  



                </div>
                <asideart class="asideart">

                </asideart>




                <form id="data4" class="form-horizontal" role="form" method="POST" action="Servlet_cerrarsesion">

                </form>


            </section>	


            <!-- JS  para el framework del gobierno-->
            <script src="https://framework-gb.cdn.gob.mx/gobmx.js"></script>        
            <script src='https://code.jquery.com/jquery-1.12.4.min.js'></script>
            <script src="js/notificaciones5.js"></script>
        </div>
        <%
            } else {
                response.sendRedirect("login.jsp");
            }
        %>

    </body>  
</html>