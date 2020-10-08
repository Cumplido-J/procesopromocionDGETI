<%-- 
    Document   : busquedaDocente
    Created on : 7 oct 2020, 19:00:08
    Author     : David Reyna
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
    <head>
        <title>Búsqueda de docente</title>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">        
        <link href="https://framework-gb.cdn.gob.mx/assets/styles/main.css" rel="stylesheet">
        <link href="css/estilosRegistro.css" rel="stylesheet"/> 
        <jsp:useBean id="catalogo" class="herramientas.Catalogos" />
       
    </head>
    <body>
        <main class="page">
            <!--Barra navegación UEMSTIS-->
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
                        <li><a href="#"><%=session.getAttribute("nombre").toString()%></a></li>
                        <li><a href="SesionAdministrador">Regresar</a></li>
                        <li><a href="Servlet_cerrarsesion">Cerrar sesión</a></li> 
                    </ul>
                  </div>
                </div>
            </nav>
            <!--FIN Barra navegación UEMSTIS-->
            <!--Barra encabezado-->
            <div class="encabezado row text-center">
                <p>Unidad de Educación Media Superior Tecnológica Industrial y de Servicios</p>
            </div>
            <!--FIN Barra encabezado-->
            <div class="container">
                <div class="text-center">
                    <h4>Búsqueda de docente</h4>                    
                </div>
                <form id="formBusqueda" role="form" method="POST" action="BuscarDocente">
                    <div class="row">
                        <div class="form-group col-xs-12">                               
                            <label class="control-label" for="programa">Programa:</label>
                            <select class="form-control input-sm" id="programa" name="programa" >                                  
                                ${catalogo.desplegarOpcionesProgramas()}
                            </select>
                        </div>
                    </div>
                    <div class="row">
                        <div class="form-group col-md-4">                               
                            <label class="control-label" for="subsistema">Subsistema:</label>
                            <select class="form-control input-sm" id="subsistema" name="subsistema" onchange="actualizarPlanteles()" >                                  
                                <option value=''>-Seleccione-</option>
                                <option value='1'>UEMSTIS</option>
                                <option value='2'>CECyTE</option>
                            </select>
                        </div>
                        <div class="form-group col-md-4">                                               
                          <label class="control-label" for="entidad">Entidad</label>
                          <select class="form-control input-sm" id="entidad" name="entidad" onchange="actualizarPlanteles()" >                                  
                              ${catalogo.desplegarOpcionesEstado()}
                          </select>
                        </div>

                        <div class="form-group col-md-4">                               
                            <label class="control-label" for="plantel">Plantel:</label>
                            <select class="form-control input-sm" id="plantel" name="plantel" >                                  
                                <option value=''>-Seleccione-</option>
                            </select>
                        </div>
                    </div>
                    <div class="row">                        
                        <div class="form-group col-md-4">                               
                            <label class="control-label" for="rfcNombre"> RFC o nombre</label>
                            <input type="text" class="form-control input-sm" id="rfcNombre" name="rfcNombre" >
                        </div> 
                        <div class="form-group col-md-8">                               
                            <label class="control-label" for="estatus">Estatus:</label>
                            <select class="form-control input-sm" id="estatus" name="estatus" >                                  
                                ${catalogo.desplegarCatalogosEstatus()}
                            </select>
                        </div>
                    </div>
                    <div class="row">
                        <div class="form-group col-xs-12 text-center">                         
                            <input class="btn btn-sm btn-primary" id="btnBuscar" type="submit" value='Buscar'/>                          
                        </div>
                    </div>
                </form>
                <div class="table-responsive">
                    <table class="table table-condensed table-striped">
                        <thead>                                
                            <tr>
                                <th>Programa</th>
                                <th>Subsistema</th>
                                <th>Entidad</th>
                                <th>Plantel</th>
                                <th>RFC</th>
                                <th>Nombre</th>
                                <th>Estatus</th>
                                <th>Opciones</th>
                            </tr>
                        </thead>
                        <tbody id="seccionEditable">${catalogo.desplegarDocentes('','','','','','')}</tbody>
                    </table>
                </div>
            </div>
            <div class="modal fade" id="modalMensaje" role="dialog">
                <div class="modal-dialog">

                  <!-- Modal content-->
                  <div class="modal-content panel">
                    <div class="modal-header">
                      <button type="button" class="close" data-dismiss="modal">&times;</button>
                      <h4 class="modal-title">Aviso</h4>
                    </div>
                    <div class="modal-body">
                      <p id="mensaje">Registro exitoso.</p>
                    </div>
                    <div class="modal-footer">
                      <button type="button" class="btn btn-sm btn-default" data-dismiss="modal">Cerrar</button>
                    </div>
                  </div>

                </div>
            </div>
        </main>
        <script src="https://framework-gb.cdn.gob.mx/gobmx.js"></script>
        <script src="https://code.jquery.com/jquery-1.12.4.js"></script>
        <script src="http://ajax.aspnetcdn.com/ajax/jquery.validate/1.13.1/jquery.validate.min.js"></script>
        <script src="js/funcionesBusquedaDocente.js"></script>
    </body>
</html>