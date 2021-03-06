<%-- 
    Document   : Bienvenida_administrador
    Created on : 04-jun-2020, 14:52:22
    Author     : charl
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
        <link rel="stylesheet" href="estilos.css">

        <!-- para el framework del gobierno-->
        <!-- CSS -->
        <link href="/favicon.ico" rel="shortcut icon">
        <link href="https://framework-gb.cdn.gob.mx/assets/styles/main.css" rel="stylesheet">
        <style type="text/css">
            li {
                /* no relevante */
                list-style: none;
               
            }


            #menu {
                padding: 10px 130px; 
            }

           

            #li2{
                text-align:center;
                width: 100%;
                display: inline-block;
                text-decoration: activecaption;               
                background-color: #6e6e6e;
                padding:4px 30px;
                color: #ffffff;
            }
            #menu li a{
                text-align:center;
                width: 100%;
                display: inline-block;
                text-decoration: activecaption;               
                background-color: #393C3E;
                padding:4px 10px;
                color: #ffffff;
            }

            #menu li a:hover{
                background-color: #000000;
                padding-bottom: 4px;
            }	



        </style>
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
                            <li><a href="login.jsp">Inicio</a></li>
                        </ul>
                    </div>
                </div>
            </nav>
        </div>

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
                <p> UEMSTIS > Promoción Docente > Administrador</p>
            </div>
            <section class="sectionart">
                <div class="articulosart">
                    <h3>Inicia sesión como Administrador</h3>	

                    <form class="form-horizontal" role="form">

                        <div class="form-group">

                            <div class="col-sm-offset-3 col-sm-9">

                                <ul id="menu">
                                    <li id="li2">Configuraciones</li>
                                    <li><a href="administradores.jsp">Agregar Administradores</a></li>
                                    <li><a href="vacancia.jsp">Agregar Vacancia</a></li>

                                </ul>

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
