<%@page import="java.sql.ResultSet"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
    <head>
        <meta charset="utf-8">
        <title>Unidad de Educación Media Superior Tecnológica Industrial y de Servicios | gob.mx</title>
        <meta name="viewport" content="width=device-width, user-scalable=no, initial-scale=1.0, maximun-scale=1.0, minimun-scale=1.0">
        <link rel="stylesheet" href="css/all.css">
        <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@500&display=swap" rel="stylesheet">
        <link rel="stylesheet" href="css/estilos.css">
    
        <link href="/favicon.ico" rel="shortcut icon">
        <link href="https://framework-gb.cdn.gob.mx/assets/styles/main.css" rel="stylesheet">
        
   <script type="text/javascript">
            function plantel() {
                var combo7 = document.getElementById("entidad");
                var selected7 = combo7.options[combo7.selectedIndex].text;
                $("#campoentidad7").val(selected7);
                //document.data.campoentidad7.value = selected7;
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
    </head>
    <body>


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
                            <li><a href="index.html">Inicio</a></li>
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
                <p> UEMSTIS > Promoción Docente > Registro de participante</p>
            </div>
            
            
                  <section class="sectionreg">
                <div class="articulosart">
                    <p>Registro de participante</p>
                    <jsp:useBean id="cn" class="metodos_sql.Metodos_sql" scope="page"></jsp:useBean>
                        <form  id="data" method="POST" action="Servlet_crearcuenta" onSubmit="return validate();">
                            <div class="registro">
                                <div class="caja">
                                    <p>Programa por el que participa
                                      	 <%
                                        ResultSet rs2 = cn.mostrar("Select id, programa from catprogramas");
                                    %>

                                    <select class="form-control" name="programa" id="prog" onchange="programa1()">
                                        <option value="0">Escoge una opcion</option>
                                        <%
                                            while (rs2.next()) {
                                        %>
                                        <option value="<%=rs2.getString("id")%>"><%=rs2.getString("programa")%></option>

                                        <%
                                            }
                                        %>
                                    </select>
                                    </p>
                                     <div id="n100"></div>
                                </div>
                            </div>


                            <div class="registro">
                                <div class="caja">
                                    <input type="hidden" name="f_opc" id="i_opc">
                                    <input type="hidden" name="campoentidad7" id="campoentidad7" >
                                    <p>Entidad donde participa                               
                                    <%
                                        ResultSet rs = cn.mostrar("Select id, entidad from catentidades");
                                    %>

                                    <select class="form-control" name="entidad" id="entidad" onchange="plantel()">
                                        <option value="0">Escoge una opcion</option>
                                        <%
                                            while (rs.next()) {
                                        %>
                                        <option value="<%=rs.getString("id")%>"><%=rs.getString("entidad")%></option>

                                        <%
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
                                <p>Nombre<input id="nombre_nom" class="form-control" type="text" name="Nombre" size="33" placeholder="Nombre" ></p>
                                <div id="n"></div>
                            </div>


                            <div class="caja">
                                <p>Primer Apellido<input id="ap" class="form-control" type="text" name="primerApellido" size="33" placeholder="Apellido Paterno" ></p>
                                <div id="n1"></div>
                            </div>
                            <div class="caja">
                                <p>Segundo Apellido<input id="am" class="form-control" type="text" name="segundoApellido" size="33" placeholder="Apellido Materno" ></p>
                                <div id="n2"></div>
                            </div>

                        </div>
                        <div class="registro">
                            <div class="caja">
                                <p>RFC<input id="rfc" style="text-transform: uppercase" class="form-control" type="text" name="rfc" size="13" maxlength="13" placeholder="RFC"  ></p>
                                <div id="n3"></div>
                            </div>
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
                                <p>Consideraciones particulares<textarea class="form-control" name="texto" rows="4" cols="108" placeholder="Consideraciones particulares"></textarea></p>
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
                      
                          
                                <input  class="btn btn-primary pull-right" type="submit" value="Enviar" name="crearcuenta" id="ventana1" >
                              
                                <input  class="btn btn-primary pull-right" type="reset" value="Borrar">
                          
                        
                    </form>
                </div>
                <asideart class="asideart">

                </asideart>
            </section>	


            <!-- JS  para el framework del gobierno-->
            <script src="https://framework-gb.cdn.gob.mx/gobmx.js"></script>
            <script src="js/notificaciones2.js"></script>
            <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.4/js/bootstrap.min.js"></script>
        </div>

       
    </body>  
</html>