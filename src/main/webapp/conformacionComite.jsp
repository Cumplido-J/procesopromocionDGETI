<%-- 
    Document   : conformacionComite
    Created on : 23 sep 2020, 13:15:42
    Author     : David Reyna
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Conformación de comité</title>
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
                    <a class="navbar-brand" href="/">UEMSTIS</a>
                  </div>
                  <div class="collapse navbar-collapse" id="subenlaces">
                    <ul class="nav navbar-nav navbar-right">      
                      <li><a href="SesionDocente">Regresar</a></li>
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
                    <h4>Conformación de comité</h4>                    
                </div>
                <div class="row">
                    <div class="form-group col-md-3">                               
                        <label class="control-label" for="programa">Programa:</label>
                        <select class="form-control input-sm" id="programa" name="programa" required>                                  
                            ${catalogo.desplegarOpcionesProgramas()}
                        </select>
                    </div>
                    <div class="form-group col-md-3">                               
                        <label class="control-label" for="programa">Subsistema:</label>
                        <select class="form-control input-sm" id="subsistema" name="subsistema" onchange="actualizarPlanteles()" required>                                  
                            <option value=''>-Seleccione-</option>
                            <option value='1'>UEMSTIS</option>
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
                </div>
                <div class="row text-center">
                    <input  class="btn btn-sm btn-link" id="btnAgregar" type="button" value='(+) Agregar miembro' onclick="mostrarModalRegistro()"/>
                </div>
                <div class="table-responsive">
                    <table class="table table-condensed table-striped">
                        <thead>
                            <th>RFC</th>
                            <th>Nombre</th>
                            <th>Primer apellido</th>
                            <th>Segundo apellido</th>
                            <th>Correo</th>
                            <th>Rol</th>
                            <th>Opciones</th>
                        </thead>
                        <tbody id="seccionEditable">
                            ${comite.desplegarIntegrantesComite(3)}
                        </tbody>
                    </table>
                </div>
                <div class="form-group col-xs-6">
                    <label class="control-label" for="btnEvidencia19">Acta constitutiva:</label>                    
                    <input id="btnEvidencia19" type="button" class="btn btn-sm btn-link" value="Subir archivo" onclick="abrirModalArchivo(19)"/>                                    
                </div>
                <div class="col-xs-6 text-center">
                    <input class="btn btn-sm btn-primary" value='Finalizar registro de comité'/>                          
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
            <div class="modal fade" id="modalRegistro" role="dialog">
                <div class="modal-dialog">

                  <!-- Modal content-->
                  <div class="modal-content panel">
                    <form id="formComite" role="form" method="POST" action="RegistroIntegranteComite">
                        <div class="modal-header">
                          <button type="button" class="close" data-dismiss="modal">&times;</button>
                          <h4 class="modal-title">Registro de integrante</h4>
                        </div>
                        <div class="modal-body">
                            <p id="respuesta" class="text-danger"></p>
                            <input type="hidden" value="3" name="idComite" id="idComite">
                            <div class="row">
                                <div class="form-group col-md-6">                               
                                    <label class="control-label">RFC:</label>
                                    <input type="text" id="rfc" name="rfc" class="form-control input-sm" required>
                                    <label class="error" id="alertaRFC" hidden >Ingrese un RFC válido</label>
                                </div>
                                <div class="form-group col-md-6">                               
                                    <label class="control-label">Nombre:</label>
                                    <input type="text" id="nombre" name="nombre" class="form-control input-sm" required>
                                </div>
                            </div>
                            <div class="row">
                                <div class="form-group col-md-6">                               
                                    <label class="control-label">Primer Apellido:</label>
                                    <input type="text" id="apPaterno" name="apPaterno" class="form-control input-sm" required>
                                </div>
                                <div class="form-group col-md-6">                               
                                    <label class="control-label">Segundo Apellido:</label>
                                    <input type="text" id="apMaterno" name="apMaterno" class="form-control input-sm">
                                </div>
                            </div>
                            <div class="row">
                                <div class="form-group col-md-6">                               
                                    <label class="control-label">Correo:</label>
                                    <input type="text" id="correo" name="correo" class="form-control input-sm" required>
                                    <label class="error" id="alertaCorreo" hidden >Ingrese una dirección de correo válida</label>
                                </div>
                                <div class="form-group col-md-6">                               
                                    <label class="control-label">Rol:</label>
                                    <select class="form-control input-sm" id="rol" name="rol" required>                                  
                                        ${catalogo.desplegarOpcionesRolComite()}
                                    </select>
                                </div>
                            </div>

                        </div>
                        <div class="modal-footer">                      
                            <input type="button" class="btn btn-primary btn-sm" value="Cancelar" data-dismiss="modal"/>
                            <input class="btn btn-sm btn-primary" id="btnRegistrar" type="submit" value='Registrar'/>
                        </div>
                    </form>
                  </div>

                </div>
            </div>
            <div id="modalArchivo" class="modal fade" role="dialog">
                <div class="modal-dialog">
                  <div class="modal-content">
                    <div class="modal-header">
                      <button type="button" class="close" data-dismiss="modal">&times;</button>
                      <h4 class="modal-title" id="tituloModal">Carga de Acta Constitutiva del Comité</h4>
                    </div>
                    <div class="modal-body">
                        <iframe name="ifRespuesta" hidden></iframe>
                        <iframe style="width:100%;" id="ifArchivo" name="ifArchivo" src="" hidden></iframe>
                        <div id="seccionCarga">
                            <form id="formArchivo" name="formArchivo" method="POST" enctype="multipart/form-data" >
                                    <!--<label class="text-warning" id="alertaCarga"><span class="glyphicon glyphicon-warning-sign"></span>&nbsp;Cárgue todas las evidencias documentales del criterio en un solo archivo PDF</label>-->
                                    <label class="control-label" for="archivo">Seleccione el archivo a cargar:</label>
                                    <input type="hidden" id="idArchivo" name="idArchivo" value="" />
                                    <input type="file" class="form-control input-sm" id="archivo" name="archivo" onchange="subirArchivo()" accept=".pdf" />

                            </form>  
                        </div>
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
        <script src="js/funcionesConformacionComite.js"></script>
    </body>
</html>
