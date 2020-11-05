<%-- 
    Document   : altaUsuario
    Created on : 4 nov 2020, 15:57:31
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
        <!--Agregar estilos aquí-->
    </head>
    <body>
        <main class="page">
            <jsp:include page="seccionesPlantilla/barraSuperior.jsp"/>
            <div class="container">
                <!--Agregar contenido de página aquí-->
                <div class="text-center">
                    <h4>Alta de administrador</h4>                       
                </div>
                <div class="row col-xs-12">
                    <p>Los campos marcados con <span class="text-danger" title="Campo obligatorio">*</span> son requeridos.</p>
                </div>
                <form id="formRegistro" role="form" method="POST" action="RegistrarUsuario">
                <div class="row">
                    <div class="form-group col-md-8"> 
                        <label class="control-label" for="programa">Programa:<span class="text-danger" title="Campo obligatorio">*</span></label>
                        <select class="form-control input-sm" id="programa" name="programa" required>                                  
                            ${catalogo.desplegarOpcionesProgramas()}
                        </select>
                    </div>
                    <div class="form-group col-md-4">                               
                        <label class="control-label" for="subsistema">Subsistema:<span class="text-danger" title="Campo obligatorio">*</span></label>
                        <select class="form-control input-sm" id="subsistema" name="subsistema" onchange="actualizarPlanteles()" required>                                  
                            ${catalogo.desplegarOpcionesSubsistema()}
                        </select>
                    </div>
                </div>
                <div class="row">
                    <div class="form-group col-md-4">                                               
                      <label class="control-label" for="nivel">Nivel:<span class="text-danger" title="Campo obligatorio">*</span></label>
                      <select class="form-control input-sm" id="nivel" name="nivel" required>                                  
                          <option value="">-Seleccione-</option>
                          <option value="N">Nacional</option>
                          <option value="E">Estatal</option>
                          <option value="P">Plantel</option>
                      </select>
                    </div>
                    <div class="form-group col-md-4">                                               
                      <label class="control-label" for="entidad">Entidad:<span id="alertaEntidad" class="text-danger" title="Campo obligatorio"></span></label>
                      <select class="form-control input-sm" id="entidad" name="entidad" onchange="actualizarPlanteles()" >                                  
                          ${catalogo.desplegarOpcionesEstado()}
                      </select>
                    </div>                    
                    <div class="form-group col-md-4">                               
                        <label class="control-label" for="plantel">Plantel:<span id="alertaPlantel" class="text-danger" title="Campo obligatorio"></span></label>
                        <select class="form-control input-sm" id="plantel" name="plantel" >                                  
                            <option value=''>-Seleccione-</option>
                        </select>
                    </div>
                </div>
                <div class="row">
                    <div class="form-group col-md-4">                               
                        <label class="control-label" for="usuario">Usuario:<span class="text-danger" title="Campo obligatorio">*</span></label>
                        <input type="text" class="form-control input-sm" name="usuario" id="usuario" maxlength="13" required/>
                        <label class="error" id="alertaUsuario" hidden >Ingrese un RFC válido</label>
                    </div>
                    <div class="form-group col-md-4">                               
                        <label class="control-label" for="nombre">Nombre:<span class="text-danger" title="Campo obligatorio">*</span></label>
                        <input type="text" class="form-control input-sm" name="nombre" required/>
                    </div>
                    <div class="form-group col-md-4">                               
                        <label class="control-label" for="apellido1">Primer apellido:<span class="text-danger" title="Campo obligatorio">*</span></label>
                        <input type="text" class="form-control input-sm" name="apellido1" required/>
                    </div>
                </div>
                <div class="row">
                    <div class="form-group col-md-4">                               
                        <label class="control-label" for="apellido2">Segundo apellido:</label>
                        <input type="text" class="form-control input-sm" name="apellido2" />
                    </div>
                    <div class="form-group col-md-4">                               
                        <label class="control-label">Teléfono fijo:<span class="text-danger" title="Campo obligatorio">*</span></label>
                        <input type="text" class="form-control input-sm" name="fijo" maxlength="10" required/>
                    </div>
                    <div class="form-group col-md-4">                               
                        <label class="control-label">Teléfono celular:<span class="text-danger" title="Campo obligatorio">*</span></label>
                        <input type="text" class="form-control input-sm" name="movil" maxlength="10" required/>
                    </div>
                </div>
                <div class="row">
                    <div class="form-group col-md-4">                               
                        <label class="control-label">Correo electrónico:<span class="text-danger" title="Campo obligatorio">*</span></label>
                        <input type="text" class="form-control input-sm" name="correo" id="correo" required/>
                        <label class="error" id="alertaCorreo" hidden >Ingrese una dirección de correo válida</label>
                    </div>
                    <div class="form-group col-md-4">                               
                        <label class="control-label">Contraseña:<span class="text-danger" title="Campo obligatorio">*</span></label>
                        <input type="password" class="form-control input-sm" name="pass1" id="pass1" required/>
                    </div>
                    <div class="form-group col-md-4">                               
                        <label class="control-label">Confirmar contraseña:<span class="text-danger" title="Campo obligatorio">*</span></label>
                        <input type="password" class="form-control input-sm" name="pass2" required/>
                    </div>
                </div>
                <div class="row col-xs-12">
                    <label class="control-label">Permisos asignados:<span class="text-danger" title="Campo obligatorio">*</span></label><br/>  
                    ${catalogo.desplegarOpcionesPermisos()}    
                    <input type="hidden" id="permisos" name="permisos"/>
                </div>
                <div class="row" >
                    <div class="form-group col-xs-12 text-center" style="padding-top: 20px;">                         
                        <input class="btn btn-primary" id="btnEnviar" type="submit" value='Registrar'/>                                                
                    </div>
                </div>
                </form>
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
                  <a id="btnContinuar" href="busquedaUsuarios.jsp" class="btn btn-sm btn-default">Continuar</a>
                  <button type="button" class="btn btn-sm btn-default" data-dismiss="modal">Cerrar</button>
                </div>
              </div>

            </div>
        </div>
        <jsp:include page="seccionesPlantilla/scripts.jsp"/>
        <!--Agregar scripts aquí-->
        <script src="js/funcionesAltaUsuario.js"></script>
    </body>
</html>
