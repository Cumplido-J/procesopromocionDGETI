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
        <link rel="stylesheet" href="css/jquery.dataTables.min.css">
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
                    $("#convocatoria").html("<option value=''>-Seleccione-</option>");
                });
            }

            function categoria() {
                var combo = document.getElementById("i_plantel2");
                var selected = combo.options[combo.selectedIndex].text;
                document.data.campotipo.value = selected;

                if (document.getElementById("i_plantel2").value == "0")
                {
                    $("#n40").text("Selecciona una CATEGORIA").css("color", "red");
                    $("#i_plantel2").css("border", "1px solid red");

                } else {
                    document.getElementById("n40").innerHTML = "";
                    $("#i_plantel2").css("border", "none");
                }

                $("#i_opc3").val("1");
                $.post("combo3.jsp", $("#data").serialize(), function (data) {
                    $("#i_plantel3").html(data);
                });

                /*      $("#i_opc4").val("1");
                 $.post("combo4.jsp", $("#data").serialize(), function (data) {
                 $("#i_plantel4").html(data);
                 });*/
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
                                            String nom1 = String.valueOf(request.getAttribute("nom"));
                                            out.print(nom1);
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
                <p> UEMSTIS > Promoción Docente > Alta de Vacancia</p>
            </div>
            <section class="sectionreg">                
                <p>Alta de Vacancia </p>
                <jsp:useBean id="cn" class="metodos_sql.Metodos_sql" scope="page"></jsp:useBean>
                    <form id="data"   name="data" method="POST" action="Servlet_agregar_vacantes" onSubmit="return validate();">
                    <%if (request.getAttribute("control_combobox").equals("true")) { %>
                    <div class="registro">
                        <div class="caja">
                            <input type="hidden" name="f_opc" id="i_opc">
                            <input type="hidden" name="campoentidad" id="campoentidad" >
                            <p>Entidad

                                <%
                                    ResultSet rs = cn.mostrar("Select id, entidad from catentidades");
                                %>

                                <select class="form-control" name="entidad" id="entidad" disabled="true">
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
                                <select class="form-control" name="n_plantel" id="i_plantel" disabled="true">
                                    <option value="0">Escoge una opcion</option>                                     
                                </select>
                            </p>
                            <div id="n7"></div>

                        </div>

                        <div class="caja">
                            <input type="hidden" name="f_opc2" id="i_opc2">
                            <p>Categoria de Plaza                                    
                                <select class="form-control" name="entidad2" onchange="plaza()" id="plaza1" >
                                    <option value="0">Escoge una opcion</option>
                                    <option value="TD">Tecnico docente</option> 
                                    <option value="D">Docente</option>
                                </select>
                            </p>
                            <div id="n30"></div>
                        </div>    
                    </div>


                    <div class="registro">
                        <div class="caja">
                            <p>Cantidad de Plazas<input id="cantidad" class="form-control" type="text" name="cantidad" size="33" placeholder="No. plazas vacantes" maxlength="3"></p>
                            <div id="n100"></div>
                        </div>
                        <div class="caja">
                            <input type="hidden" name="campotipo" id="campotipo" >
                            <p>Tipo de Categoria
                                <select class="form-control" name="n_plantel2" id="i_plantel2" onchange="categoria()">
                                    <option value="0">Escoge una opcion</option>                                       
                                </select>
                            </p>
                            <div id="n40"></div>
                        </div> 


                    </div>

                    <div class="registro">
                        <div class="caja">
                            <input type="hidden" name="f_opc3" id="i_opc3">
                            <input type="hidden" name="campojornada" id="campojornada" >
                            <p>Jornada
                                <select class="form-control" name="n_plantel3" id="i_plantel3" onchange="jornada1()">
                                    <option value="0">Escoge una opcion</option>                                                                       
                                </select>           
                            </p>
                            <div id="n50"></div>
                        </div>

                        <!--       <div class="caja">
                                    <input type="hidden" name="f_opc4" id="i_opc4">
                                    <input type="hidden" name="campogrado1" id="campogrado1" >
                                   <p>Grado Academico
                                        <select class="form-control" name="n_plantel4" id="i_plantel4" onchange="grado1()">
                                           <option value="0">Escoge una opcion</option>
                                       </select>
                                   </p>
                                   <div id="n60"></div>
                               </div>  -->

                        <div class="caja">
                            <p>Tipo de Vacancia
                                <select class="form-control" name="tipovacancia" id="tipovacancia" onchange="vacancia1()">
                                    <option value="0">Escoge una opcion</option>
                                    <option value="Real">Real</option> 
                                    <option value="Cadena">Cadena</option>
                                </select>
                            </p>
                            <div id="n70"></div>
                        </div>         


                 <div class="caja">
                            <p>Programa                    
                                <%
                                    String h[] = {"", "", "", ""};
                                    int i = 0;
                                    ResultSet rs4 = cn.mostrar("Select * from convocatoria where idPlantel='" + request.getAttribute("dato_pla") + "'");
                                %>
                                <select class="form-control" name="convocatoria" id="convocatoria" onchange="convocatoria1()">
                                    <option value="">Escoge una opcion</option>
                                    <%
                                        while (rs4.next()) {
                                            if (rs4.getString("idPrograma") != "0") {
                                                h[i] = rs4.getString("idPrograma");
                                                i++;
                                            }
                                        }
                                        String com2 = "Select * from catProgramas WHERE id= '" + h[0] + "' || id='" + h[1] + "' || id = '" + h[2] + "'";
                                        ResultSet rs5 = cn.mostrar(com2);
                                        while (rs5.next()) {

                                    %>

                                    <option value="<%=rs5.getString("id")%>"><%=rs5.getString("programa")%></option>

                                    <%//              regresa del combobox         muestra en el combo box
                                        }

                                    %>                                              
                                </select>           
                            </p>                         

                            <div id="n80"></div>
                        </div>       
                    </div>

                    <% } //FIN OPCION VERDADERA COMBOBOX
                    else {%> <%--OPCION FALSA COMBOBOX --%>
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
                            <input type="hidden" name="f_opc2" id="i_opc2">
                            <p>Categoria de Plaza                                    
                                <select class="form-control" name="entidad2" onchange="plaza()" id="plaza1" >
                                    <option value="0">Escoge una opcion</option>
                                    <option value="TD">Tecnico docente</option> 
                                    <option value="D">Docente</option>
                                </select>
                            </p>
                            <div id="n30"></div>
                        </div>    
                    </div>


                    <div class="registro">
                        <div class="caja">
                            <p>Cantidad de Plazas<input id="cantidad" class="form-control" type="text" name="cantidad" size="33" placeholder="No. plazas vacantes" maxlength="3"></p>
                            <div id="n100"></div>
                        </div>
                        <div class="caja">
                            <input type="hidden" name="campotipo" id="campotipo" >
                            <p>Tipo de Categoria
                                <select class="form-control" name="n_plantel2" id="i_plantel2" onchange="categoria()">
                                    <option value="0">Escoge una opcion</option>                                       
                                </select>
                            </p>
                            <div id="n40"></div>
                        </div> 


                    </div>

                    <div class="registro">
                        <div class="caja">
                            <input type="hidden" name="f_opc3" id="i_opc3">
                            <input type="hidden" name="campojornada" id="campojornada" >
                            <p>Jornada
                                <select class="form-control" name="n_plantel3" id="i_plantel3" onchange="jornada1()">
                                    <option value="0">Escoge una opcion</option>                                                                       
                                </select>           
                            </p>
                            <div id="n50"></div>
                        </div>

                        <!--       <div class="caja">
                                    <input type="hidden" name="f_opc4" id="i_opc4">
                                    <input type="hidden" name="campogrado1" id="campogrado1" >
                                   <p>Grado Academico
                                        <select class="form-control" name="n_plantel4" id="i_plantel4" onchange="grado1()">
                                           <option value="0">Escoge una opcion</option>
                                       </select>
                                   </p>
                                   <div id="n60"></div>
                               </div>  -->

                        <div class="caja">
                            <p>Tipo de Vacancia
                                <select class="form-control" name="tipovacancia" id="tipovacancia" onchange="vacancia1()">
                                    <option value="0">Escoge una opcion</option>
                                    <option value="Real">Real</option> 
                                    <option value="Cadena">Cadena</option>
                                </select>
                            </p>
                            <div id="n70"></div>
                        </div>         


                      <div class="caja">
                            <p>Programa                    
                                <%
                                    String h[] = {"", "", "", ""};
                                    int i = 0;
                                    ResultSet rs4 = cn.mostrar("SELECT c.id,p.programa FROM bdpromocion.convocatoria c inner join catprogramas p on c.idPrograma=p.id where c.idplantel='" + request.getAttribute("dato_pla") + "';");
                                %>
                                <select class="form-control" name="convocatoria" id="convocatoria" onchange="convocatoria1()">
                                    <option value="">Escoge una opcion</option>
                                    
                                    <%
                                        while (rs4.next()) {
                                       out.print("<option value='"+rs4.getString("id")+"'>"+rs4.getString("programa")+"</option>");
                                            
                                        }
                                    %>

                                                                                
                                </select>           
                            </p>                         

                            <div id="n80"></div>
                        </div>      
                    </div>



                    <%}%>










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

                        <button class="btn btn-primary pull-right" type="submit" name="agregarvacantes">Agregar</button>

                    </div>
                    <%
                        session.setAttribute("idUsuario", idUsuario);
                        session.setAttribute("rfc", rfc);
                    %>
                    <input type="hidden" name="control_combobox" id="control_combobox" value="<%=request.getAttribute("control_combobox")%>">
                    <input type="hidden" name="permiso1" id="permiso1" value="<%=request.getAttribute("per1")%>">
                    <input type="hidden" name="permiso2" id="permiso2" value="<%=request.getAttribute("per2")%>">
                    <input type="hidden" name="permiso4" id="permiso4" value="<%=request.getAttribute("per4")%>">
                    <input type="hidden" name="nombre" id="nombre" value="<%=request.getAttribute("nom")%>">
                    <input type="hidden" name="dato_ent" id="dato_ent" value="<%=request.getAttribute("dato_ent")%>">
                    <input type="hidden" name="dato_pla" id="dato_pla" value="<%=request.getAttribute("dato_pla")%>">
                    <input type="hidden" name="dato_rfc" id="dato_rfc" value="<%=request.getAttribute("dato_rfc")%>">
                </form>
            </section>
            <form id="data2" class="form-horizontal" role="form" method="POST" action="Servlet_regresar2">
                <div class="posision1">   
                    <button class="btn btn-primary pull-right posision2" type="submit" name="regresa2" id="check">Regresar</button></a>
                </div>
                <%
                    session.setAttribute("idUsuario", idUsuario);
                    session.setAttribute("rfc", rfc);
                %>
                <input type="hidden" name="control_combobox" id="control_combobox" value="<%=request.getAttribute("control_combobox")%>">
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
            <script src="js/notificaciones3.js"></script>
        </div>
        <%
            } else {
                response.sendRedirect("login.jsp");
            }
        %>
    </body>
</html>
