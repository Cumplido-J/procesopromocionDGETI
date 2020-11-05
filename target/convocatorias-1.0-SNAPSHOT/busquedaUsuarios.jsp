<%-- 
    Document   : busquedaUsuarios
    Created on : 4 nov 2020, 14:45:33
    Author     : David Reyna
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    session = (HttpSession) request.getSession(true);    
    if (session.getAttribute("idUsuario") == null) {
        response.sendRedirect("login.jsp");
    }        
%>
<!DOCTYPE html>
<html>
    <head>
        <jsp:include page="seccionesPlantilla/head.jsp"/>
        <jsp:useBean id="catalogo" class="herramientas.Catalogos" />
        <jsp:useBean id="dato" class="herramientas.Datos" />
        <!--Agregar estilos aquí-->
    </head>
    <body>
        <main class="page">
            <jsp:include page="seccionesPlantilla/barraSuperior.jsp"/>
            <div class="container">
                <!--Agregar contenido de página aquí-->
                <div class="text-center">
                    <h4>Búsqueda de administradores</h4>                    
                </div>
                <form id="formBusqueda" role="form" method="POST" action="BuscarUsuario">
                <div class="row">
                    <div class="form-group col-xs-12">                               
                        <label class="control-label" for="programa">Programa:</label>
                        <select class="form-control input-sm" id="programa" name="programa" >                                  
                            ${catalogo.desplegarOpcionesProgramas()}
                        </select>
                    </div>
                </div>
                <div class="row">
                    <div class="form-group col-md-3">                               
                        <label class="control-label" for="subsistema">Subsistema:</label>
                        <select class="form-control input-sm" id="subsistema" name="subsistema" onchange="actualizarPlanteles()" >                                  
                            ${catalogo.desplegarOpcionesSubsistema()}
                        </select>
                    </div>
                    <div class="form-group col-md-3">                                               
                      <label class="control-label" for="entidad">Entidad</label>
                      <select class="form-control input-sm" id="entidad" name="entidad" onchange="actualizarPlanteles()" >                                  
                          ${catalogo.desplegarOpcionesEstado()}
                      </select>
                    </div>
                      
                    <div class="form-group col-md-3">                               
                        <label class="control-label" for="plantel">Plantel:</label>
                        <select class="form-control input-sm" id="plantel" name="plantel" >                                  
                            <option value=''>-Seleccione-</option>
                        </select>
                    </div>
                    <div class="form-group col-md-3">                               
                        <label class="control-label" for="usuario">Usuario:</label>
                        <input type="text" class="form-control input-sm" name="usuario" />
                    </div>
                </div>
                <div class="row">
                    <div class="form-group col-xs-12 text-center">                         
                        <input class="btn btn-sm btn-primary" id="btnBuscar" type="submit" value='Buscar'/> 
                        <a href="altaUsuario.jsp" class="btn btn-sm btn-primary">Agregar</a>                        
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
                                <th>Usuario</th>
                                <th>Nombre</th>
                                <th>Opciones</th>
                            </tr>
                        </thead>
                        <tbody id="seccionEditable">${dato.desplegarUsuarios('','','','','')}</tbody>
                    </table>
                </div>
            </div>
        </main>
        <!--Agregar modals aquí-->
        <div class="modal fade" id="modalMensaje" role="dialog">
            <div class="modal-dialog">

              <!-- Modal content-->
              <div class="modal-content panel">
                <div class="modal-header">
                  <button type="button" class="close" data-dismiss="modal">&times;</button>
                  <h4 class="modal-title">Aviso</h4>
                </div>
                <div class="modal-body">
                  <p id="mensaje"></p>
                </div>
                <div class="modal-footer">
                  <button type="button" class="btn btn-sm btn-default" data-dismiss="modal">Cerrar</button>
                </div>
              </div>

            </div>
        </div>
        <jsp:include page="seccionesPlantilla/scripts.jsp"/>
        <!--Agregar scripts aquí-->
        <script src="js/funcionesBusquedaUsuarios.js"></script>
    </body>
</html>