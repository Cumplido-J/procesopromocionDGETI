<%-- 
    Document   : login2.jsp
    Created on : 7 oct 2020, 15:50:00
    Author     : David Reyna
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
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

        <!-- Respond.js soporte de media queries para Internet Explorer 8 -->
        <!-- ie8.js EventTarget para cada nodo en Internet Explorer 8 -->
        <!--[if lt IE 9]>
          <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
          <script src="https://cdnjs.cloudflare.com/ajax/libs/ie8/0.2.2/ie8.js"></script>
        <![endif]-->
        <!--Termina  para el framework del gobierno-->
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
                            <li><a href="convocatorias.jsp">Consulta convocatorias</a></li>
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
            <section class="sectionart">
                <div class="articulosart">
                    <h3>Iniciar sesión</h3>	
                    <form class="form-horizontal" role="form" method="POST" action="Servlet_iniciosesion_administrador">
                    <!-- <form class="form-horizontal" role="form" method="POST" action="Servlet_iniciosesion_administrador">-->    
                        <div class="form-group">
                            <label class="col-sm-3 control-label" for="curp">RFC:</label>
                            <div class="col-sm-9">
                                <input class="form-control" id="rfc" name="rfc" placeholder="RFC" type="text">
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-3 control-label" for="password-03">Contraseña:</label>
                            <div class="col-sm-9">
                                <input class="form-control" id="password-03" placeholder="Contraseña" type="password" name="clave">
                            </div>

                        </div>
                        <div class="error"> 
                            <%
                                if (request.getAttribute("error") == null) {
                                    out.print("");
                                } else {
                                    out.print(request.getAttribute("error"));
                                }
                            %>
                        </div>
                        <div class="form-group">
                            <div class="col-sm-offset-3 col-sm-9">
                                <divlog class="divlog">
                                   
                                    <divOlvide class="divOlvide">
                                        <a href="recuperar_contraseña.jsp">Olvidé mi contraseña</a>
                                    </divOlvide>
                                <%--     <divOlvide class="divOlvide">
                                        <a href="administradores.jsp">Inicia sesión como Administrador</a>
                                    </divOlvide> --%>
                                </divlog>
                            </div>
                        </div>

                        <div class="form-group">
                            <div class="col-sm-offset-3 col-sm-9">
                                <button class="btn btn-primary" type="submit" name="iniciarsesionadmin">Enviar</button>                            
                                <a href="preregistro.jsp"><button class="btn btn-primary" type="button">Regístrate aquí</button></a>
                            </div>
                        </div>
                    </form>
                        
                        
                        
                        
                </div>
                <asideart class="asideart">

                </asideart>
            </section>		
            <!-- JS  para el framework del gobierno-->
            <script src="https://framework-gb.cdn.gob.mx/gobmx.js"></script>
        </div>

    </body>
</html>
