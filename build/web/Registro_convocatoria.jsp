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
            var thecontents = new Array()
            thecontents[0] = "imagenes/nada.png"
            thecontents[1] = "imagenes/sems.jpg"
            thecontents[2] = "imagenes/uemstis.png"

            function changecontent(which) {

                imagen.src = thecontents[document.regconv.selectbox.selectedIndex]
                /*  document.regconv.contentbox.value = thecontents[document.regconv.selectbox.selectedIndex]*/
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

                            <nav class="navegacion">
                                <ul class="menu">

                                    <li><a href="#">Administrador</a>
                                        <ul class="submenu">
                                            <li>
                                                <form id="data3"  role="form" method="POST" action="Servlet_regresar">
                                                    <button class="propiedadesboton" type="submit" name="regresa">Usuario</button>
                                                    <input type="hidden" name="nombre" id="nombre" value="<%=request.getAttribute("nom")%>">
                                                    <input type="hidden" name="dato_ent" id="dato_ent" value="<%=request.getAttribute("dato_ent")%>">
                                                    <input type="hidden" name="dato_pla" id="dato_pla" value="<%=request.getAttribute("dato_pla")%>">
                                                    <input type="hidden" name="dato_rfc" id="dato_rfc" value="<%=request.getAttribute("dato_rfc")%>">
                                                </form>
                                            </li>   
                                            <li>
                                                <form id="data4"  role="form" method="POST" action="Servlet_convocatoria">
                                                    <button class="propiedadesboton" type="submit" name="convocatoria" id="activado_convocatoria">Convocatoria</button>
                                                    <input type="hidden" name="nombre" id="nombre" value="<%=request.getAttribute("nom")%>">
                                                    <input type="hidden" name="dato_ent" id="dato_ent" value="<%=request.getAttribute("dato_ent")%>">
                                                    <input type="hidden" name="dato_pla" id="dato_pla" value="<%=request.getAttribute("dato_pla")%>">
                                                    <input type="hidden" name="dato_rfc" id="dato_rfc" value="<%=request.getAttribute("dato_rfc")%>">
                                                </form>
                                            </li>
                                            <li>
                                                <form id="data3"  role="form" method="POST" action="Servlet_ir_a_vacantes">
                                                    <button class="propiedadesboton" type="submit" name="ir" id="activado_vacancia">Vacancia</button>
                                                    <input type="hidden" name="nombre" id="nombre" value="<%=request.getAttribute("nom")%>">
                                                    <input type="hidden" name="dato_ent" id="dato_ent" value="<%=request.getAttribute("dato_ent")%>">
                                                    <input type="hidden" name="dato_pla" id="dato_pla" value="<%=request.getAttribute("dato_pla")%>">
                                                    <input type="hidden" name="dato_rfc" id="dato_rfc" value="<%=request.getAttribute("dato_rfc")%>">
                                                </form>
                                            </li>
                                        </ul> 
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

            <!--<header class="headerart">
                <div class="titulo">
                    <p>Unidad de Educación Media Superior Tecnológica Industrial y de Servicios</p>
                </div> 
                <div class="texto-principalart margen-interno">
                    <p>Programa de Promoción en el Servicio Docente en Educación Media Superior</p>
                </div> 
            </header>
            <div class="ruta">
                <p> UEMSTIS > Promoción Docente > Registro de Convocatoria</p>
            </div>-->


            <section class="sectionreg">
                <div class="articulosart">
                    <jsp:useBean id="cn" class="metodos_sql.Metodos_sql" scope="page"></jsp:useBean>
                        <form  name="regconv" id="regconv" method="POST" action="Servlet_guardar_convocatoria" onSubmit="return validar_datos();">
                            <br>
                            <br>
                        <%
                            String elegir1 = "0";

                            elegir1 = String.valueOf(request.getAttribute("opc"));

                            if (elegir1.equals("1")) {
                        %>
                        <div class="registro">
                            <div class="caja">
                                <h4>REGISTRO DE CONVOCATORIA</h4> 
                            </div>
                            <div class="caja" align="right">
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
                            </div>
                        </div>

                        <div class="registro_cct_plantel">                         
                            <div id="cct" style="text-indent: 1cm;">
                                <%
                                    String ent1 = String.valueOf(request.getAttribute("dato_ent"));
                                    out.print(ent1 + " - ");
                                %>
                            </div>                          
                            <div id="plantel">
                                <%
                                    String pla1 = String.valueOf(request.getAttribute("dato_pla"));
                                    out.print(pla1);
                                %>
                            </div>
                        </div>

                        <br>
                        <!--         <input type="hidden" name="f_opc" id="i_opc">
                                 <div class="registro"> 
                                     <div class="caja">
                                         <p>Carga de Logo
                                             <select class="form-control" id="selectbox" name="selectbox" id="logo" onChange="changecontent(this)" >
                                                 <option value="0">Escoge una opcion</option>
                                                 <option value="1">Logo SEMS</option>
                                                 <option value="2">Logo UEMSTIS</option>                                            
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

                        <div class="registro">    
                            <div class="caja">
                                <p>Titulo de la Convocatoria<textarea id="textarea" name="textarea" rows="3" cols="100%"></textarea></p>
                                <div id="c1"></div>
                            </div>

                        </div>

                        <br>
                        <div class="registro">    
                            <div class="caja">
                                <p>Fecha de publicación de convocatoria
                                    <input type="date" id="publicacion" name="publicacion" value="" min="2020-01-01" max="2020-12-31">
                                </p>
                                <div id="c2"></div>
                            </div>
                        </div>

                        <br>
                        <div class="registro">    
                            <div class="caja">
                                <p>Periodo de registro</p>
                                Inicio <input type="date" id="periodo_registro_inicio" name="periodo_registro_inicio" value="" min="2020-01-01" max="2020-12-31">
                                <div id="c3"></div>
                                <br>  Final &nbsp;<input type="date" id="periodo_registro_fin" name="periodo_registro_fin" value="" min="2020-01-01" max="2020-12-31"> 
                                <div id="c4"></div>
                            </div>

                            <div class="caja">
                                <p>Periodo de valoración</p>
                                Inicio <input type="date" id="periodo_valoracion_inicio" name="periodo_valoracion_inicio" value="" min="2020-01-01" max="2020-12-31">
                                 <div id="c5"></div>
                                <br>  Final &nbsp;<input type="date" id="periodo_valoracion_fin" name="periodo_valoracion_fin" value="" min="2020-01-01" max="2020-12-31"> 
                                 <div id="c6"></div>
                            </div>

                            <div class="caja">
                                <p>Periodo de dictaminación</p>
                                Inicio <input type="date" id="periodo_dictaminacion_inicio" name="periodo_dictaminacion_inicio" value="" min="2020-01-01" max="2020-12-31">
                                 <div id="c7"></div>
                                <br>  Final &nbsp;<input type="date" id="periodo_dictaminacion_fin" name="periodo_dictaminacion_fin" value="" min="2020-01-01" max="2020-12-31"> 
                                 <div id="c8"></div>
                            </div>
                        </div>

                        <br>
                        <div class="registro">    
                            <div class="caja">
                                <p>Publicación de resultados
                                    <input type="date" id="publicacion_resultados" name="publicacion_resultados" value="" min="2020-01-01" max="2020-12-31">
                                </p>
                                 <div id="c9"></div>
                            </div>
                        </div>

                        <%                            }//fin if elegir    
                            else {
                                response.sendRedirect("login.jsp");
                            }
                        %>

                        <div class="registro">  
                            <div class="caja">
                                <input type="hidden" name="nombre" id="nombre" value="<%=request.getAttribute("nom")%>">
                                <input type="hidden" name="dato_ent" id="dato_ent" value="<%=request.getAttribute("dato_ent")%>">
                                <input type="hidden" name="dato_pla" id="dato_pla" value="<%=request.getAttribute("dato_pla")%>">
                                <input type="hidden" name="dato_rfc" id="dato_rfc" value="<%=request.getAttribute("dato_rfc")%>">
                                <input  class="btn btn-primary pull-right" type="submit" value="Guardar" name="guardar" form="regconv">

                                <input  class="btn btn-primary pull-right" type="submit" value="Regresar" name="regresa3" id="check" form="data2">
                            </div>
                        </div>
                    </form>  

                </div>
                <asideart class="asideart">

                </asideart>

                <form id="data2" class="form-horizontal" role="form" method="POST" action="Servlet_regresar3">
                    <input type="hidden" name="nombre" id="nombre" value="<%=request.getAttribute("nom")%>">
                    <input type="hidden" name="dato_ent" id="dato_ent" value="<%=request.getAttribute("dato_ent")%>">
                    <input type="hidden" name="dato_pla" id="dato_pla" value="<%=request.getAttribute("dato_pla")%>">
                    <input type="hidden" name="dato_rfc" id="dato_rfc" value="<%=request.getAttribute("dato_rfc")%>">
                </form>

                <form id="data4" class="form-horizontal" role="form" method="POST" action="Servlet_cerrarsesion">

                </form>


            </section>	


            <!-- JS  para el framework del gobierno-->
            <script src="https://framework-gb.cdn.gob.mx/gobmx.js"></script>        
            <script src='https://code.jquery.com/jquery-1.12.4.min.js'></script>
            <script src="js/notificaciones4.js"></script>
        </div>


    </body>  
</html>