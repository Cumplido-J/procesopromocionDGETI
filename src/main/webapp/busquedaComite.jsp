<%-- 
    Document   : busquedaComite
    Created on : 28 sep 2020, 11:11:40
    Author     : David Reyna
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>DGETI | sep.gob.mx</title>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">        
        <link href="https://framework-gb.cdn.gob.mx/assets/styles/main.css" rel="stylesheet">
        <link href="css/estilosRegistro.css" rel="stylesheet"/>   
        <jsp:useBean id="catalogo" class="herramientas.Catalogos" />
        <jsp:useBean id="comite" class="herramientas.Comite" />
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
                    <a class="navbar-brand" href="/">DGETI</a>
                  </div>
                  <div class="collapse navbar-collapse" id="subenlaces">
                    <ul class="nav navbar-nav navbar-right">      
                      <li><a href="SesionAdministrador">Regresar</a></li>
                      <li><a href="Servlet_cerrarsesion">Cerrar sesión</a></li> 
                    </ul>
                  </div>
                </div>
            </nav>
            <!--FIN Barra navegación UEMSTIS-->
            <!--Barra encabezado-->
            <div class="encabezado row text-center">
                <p>Dirección General de Educación Tecnológica Industrial y de Servicios</p>
            </div>
            <!--FIN Barra encabezado-->
            <div class="container">
                <div class="text-center">
                    <h4>Búsqueda de comité</h4>                    
                </div>
                <form id="formBusqueda" role="form" method="POST" action="BuscarComite">
                <div class="row">
                    <div class="form-group col-xs-12">                               
                        <label class="control-label" for="programa">Programa:</label>
                        <select class="form-control input-sm" id="programa" name="programa" required>                                  
                            ${catalogo.desplegarOpcionesProgramas()}
                        </select>
                    </div>
                </div>
                <div class="row">
                    <div class="form-group col-md-3">                               
                        <label class="control-label" for="subsistema">Subsistema:</label>
                        <select class="form-control input-sm" id="subsistema" name="subsistema" onchange="actualizarPlanteles()" required>                                  
                            <option value=''>-Seleccione-</option>
                            <option value='1'>DGETI</option>
                            <option value='2'>CECyTE</option>
                        </select>
                    </div>
                    <div class="form-group col-md-3">                                               
                      <label class="control-label" for="entidad">Entidad</label>
                      <select class="form-control input-sm" id="entidad" name="entidad" onchange="actualizarPlanteles()" required>                                  
                          ${catalogo.desplegarOpcionesEstado()}
                      </select>
                    </div>
                      
                    <div class="form-group col-md-3">                               
                        <label class="control-label" for="plantel">Plantel:</label>
                        <select class="form-control input-sm" id="plantel" name="plantel" required>                                  
                            <option value=''>-Seleccione-</option>
                        </select>
                    </div>
                    <div class="form-group col-md-3">                               
                        <label class="control-label" for="tipo">Tipo:</label>
                        <select class="form-control input-sm" id="tipo" name="tipo" required>                                  
                            <option value=''>-Seleccione-</option>
                            <option value='R'>Comité revisor</option>
                            <option value='D'>Consejo dictaminador</option>
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
                                <th>Tipo</th>
                                <th>Presidente</th>
                                <th>Estatus</th>
                                <th>Opciones</th>
                            </tr>
                        </thead>
                        <tbody id="seccionEditable">${comite.desplegarComite()}</tbody>
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
            <div class="modal fade" id="modalConfirmacion" role="dialog">
                <div class="modal-dialog">

                  <!-- Modal content-->
                  <div class="modal-content panel">
                    <form id="formComite" role="form" method="POST" action="RegistroComite">
                        <div class="modal-header">
                          <button type="button" class="close" data-dismiss="modal">&times;</button>
                          <h4 class="modal-title">Confirmación</h4>
                        </div>
                        <div class="modal-body">
                            <label>No se encontró el comité ¿desea registrarlo?</label>
                            <input type="hidden" name="idPrograma" id="idPrograma">
                            <input type="hidden" name="idSubsistema" id="idSubsistema">
                            <input type="hidden" name="idEntidad" id="idEntidad">
                            <input type="hidden" name="idPlantel" id="idPlantel">
                            <input type="hidden" name="idTipo" id="idTipo">
                        </div>
                        <div class="modal-footer">
                            <input class="btn btn-sm btn-primary" id="btnRegistrar" type="submit" value='Sí'/>
                            <input type="button" class="btn btn-primary btn-sm" value="No" data-dismiss="modal"/>
                        </div>
                    </form>
                  </div>

                </div>
            </div>
            <div class="modal fade" id="modalConfirmacion2" role="dialog">
                <div class="modal-dialog">

                  <!-- Modal content-->
                  <div class="modal-content panel">
                    <form id="formBorrarComite" role="form" method="POST" action="BorrarComite">
                        <div class="modal-header">
                          <button type="button" class="close" data-dismiss="modal">&times;</button>
                          <h4 class="modal-title">Confirmación</h4>
                        </div>
                        <div class="modal-body">
                            <label>Esta acción eliminará la información del comité, así como la de los integrantes del mismo ¿desea continuar?</label>
                            <input type="hidden" name="idComite" id="idComiteBorrar">
                        </div>
                        <div class="modal-footer">
                            <input class="btn btn-sm btn-primary" type="submit" value='Sí'/>
                            <input type="button" class="btn btn-primary btn-sm" value="No" data-dismiss="modal"/>
                        </div>
                    </form>
                  </div>

                </div>
            </div>
            
        </main>
        <script src="https://framework-gb.cdn.gob.mx/gobmx.js"></script>
        <script src="https://code.jquery.com/jquery-1.12.4.js"></script>
        <script src="http://ajax.aspnetcdn.com/ajax/jquery.validate/1.13.1/jquery.validate.min.js"></script>
        <script src="js/funcionesBusquedaComite.js"></script>
    </body>
</html>

