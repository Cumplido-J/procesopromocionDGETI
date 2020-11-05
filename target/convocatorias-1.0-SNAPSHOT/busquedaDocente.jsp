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
        <jsp:include page="seccionesPlantilla/head.jsp"/>  
        <jsp:useBean id="catalogo" class="herramientas.Catalogos" />
       
    </head>
    <body>
        <main class="page">
           <jsp:include page="seccionesPlantilla/barraSuperior.jsp"/>
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
                                ${catalogo.desplegarOpcionesSubsistema()}
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
                                <th>Puntaje</th>
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