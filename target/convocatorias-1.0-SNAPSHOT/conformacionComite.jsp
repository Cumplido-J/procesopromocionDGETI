<%-- 
    Document   : conformacionComite
    Created on : 23 sep 2020, 13:15:42
    Author     : David Reyna
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <jsp:include page="seccionesPlantilla/head.jsp"/>  
        <jsp:useBean id="catalogo" class="herramientas.Catalogos" />
        <jsp:useBean id="archivo" class="herramientas.Archivo" />
        <jsp:useBean id="comite" class="herramientas.Comite" />
        <%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
        <%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
    </head>
    <body>
        <main class="page">
            <jsp:include page="seccionesPlantilla/barraSuperior.jsp"/>
            <div class="container">                
                <div class="text-center">
                    <h4>Conformación de comité</h4>                    
                </div>
                <div class="row">
                    <div class="form-group col-xs-12">                               
                        <label class="control-label" for="programa">Programa:</label>
                        <select class="form-control input-sm disabled" id="programa" name="programa">                                  
                            ${catalogo.desplegarOpcionesProgramas()}
                        </select>
                    </div>
                </div>
                <div class="row">
                    <div class="form-group col-md-3">                               
                        <label class="control-label" for="tipo">Tipo:</label>
                        <select class="form-control input-sm disabled" id="tipo" name="tipo" required>                                  
                            <option value=''>-Seleccione-</option>
                            <option value='R'>Comité revisor</option>
                            <option value='D'>Consejo dictaminador</option>
                        </select>
                    </div>
                    <div class="form-group col-md-3">                               
                        <label class="control-label" for="subsistema">Subsistema:</label>
                        <select class="form-control input-sm disabled" id="subsistema" name="subsistema" onchange="actualizarPlanteles()" required>                                  
                            <option value=''>-Seleccione-</option>
                            <option value='1'>DGETI</option>
                            <option value='2'>CECyTE</option>
                        </select>
                    </div>
                    <div class="form-group col-md-3">                                               
                      <label class="control-label" for="entidad">Entidad</label>
                      <select class="form-control input-sm disabled" id="entidad" name="entidad" onchange="actualizarPlanteles()" required>                                  
                          ${catalogo.desplegarOpcionesEstado()}
                      </select>
                    </div>
                    <div class="form-group col-md-3">                               
                        <label class="control-label" for="plantel">Plantel:</label>
                        <select class="form-control input-sm disabled" id="plantel" name="plantel" required>                                  
                            ${catalogo.desplegarOpcionesPlanteles2(datos[2],datos[3])};
                        </select>
                    </div>   
                    
                </div>
                <div class="row text-center">                    
                    <!--<input  class="btn btn-sm btn-link" id="btnEditar" type="button" value='Modificar información comité'/>-->
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
                        <tbody id="seccionEditable">${comite.desplegarIntegrantesComite(datos[0])}</tbody>
                    </table>
                </div>
                <div class="form-group col-md-4">
                    <label class="control-label" for="btnEvidencia19">Acta constitutiva:</label><br/>                    
                    <c:if test = "${archivo.documentoCargado(aux)==true}">
                        <input id="btnEvidencia19" type="button" class="btn btn-sm btn-link" value="Ver archivo" onclick="abrirModalArchivo(19)"/>                                    
                        
                    </c:if>
                    <c:if test = "${archivo.documentoCargado(aux)==false}">
                        <input id="btnEvidencia19" type="button" class="btn btn-sm btn-link incompleto" value="Subir archivo" onclick="abrirModalArchivo(19)"/>
                        
                    </c:if>
                    
                                                       
                </div>
                <div class="form-group col-md-4">                               
                    <label class="control-label">Rol al que se le asignará usuario:</label>
                    <select class="form-control input-sm" id="rolUsuario">                                  
                        ${catalogo.desplegarOpcionesRolComite(datos[7])}
                    </select>
                    
                </div>
                <c:if test = "${datos[6]=='F'}">
                <div class="col-md-4 text-center">
                    <br/>
                    <input type="button" class="btn btn-sm btn-primary" value='Finalizar registro de comité' onclick="finalizaRegistro()"/>                          
                </div>
                </c:if>
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
                      <button type="button" id="btnCerrar" class="btn btn-sm btn-default" data-dismiss="modal">Cerrar</button>
                      <a href="busquedaComite.jsp" class="btn btn-sm btn-default hidden" id="btnContinuar">Continuar</a>
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
                            <input type="hidden" value="${datos[0]}" name="idComite" id="idComite">
                            <div class="row">
                                <div class="form-group col-md-6">                               
                                    <label class="control-label">RFC:</label>
                                    <input type="text" id="rfc" name="rfc" class="form-control input-sm text-uppercase" required>
                                    <label class="error" id="alertaRFC" hidden >Ingrese un RFC válido</label>
                                </div>
                                <div class="form-group col-md-6">                               
                                    <label class="control-label">Nombre:</label>
                                    <input type="text" id="nombre" name="nombre" class="form-control input-sm text-uppercase" required>
                                </div>
                            </div>
                            <div class="row">
                                <div class="form-group col-md-6">                               
                                    <label class="control-label">Primer Apellido:</label>
                                    <input type="text" id="apPaterno" name="apPaterno" class="form-control input-sm text-uppercase" required>
                                </div>
                                <div class="form-group col-md-6">                               
                                    <label class="control-label">Segundo Apellido:</label>
                                    <input type="text" id="apMaterno" name="apMaterno" class="form-control input-sm text-uppercase">
                                </div>
                            </div>
                            <div class="row">
                                <div class="form-group col-md-6">                               
                                    <label class="control-label">Correo:</label>
                                    <input type="text" id="correo" name="correo" class="form-control input-sm text-lowercase" required>
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
            
            <div class="modal fade" id="modalConfirmacion" role="dialog">
                <div class="modal-dialog">

                  <!-- Modal content-->
                  <div class="modal-content panel">
                    <form id="formBorrar" role="form" method="POST" action="BorrarIntegrante">
                        <div class="modal-header">
                          <button type="button" class="close" data-dismiss="modal">&times;</button>
                          <h4 class="modal-title">Confirmación</h4>
                        </div>
                        <div class="modal-body">
                            <label>Se eliminará la información del integrante seleccionado ¿Desea continuar?</label>
                            <input type="hidden" name="idIntegrante" id="idIntegrante">
                        </div>
                        <div class="modal-footer">
                            <input class="btn btn-sm btn-primary" type="submit" value='Sí'/>
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
                    <form id="formFinalizar" role="form" method="POST" action="FinalizarConformacion">
                        <div class="modal-header">
                          <button type="button" class="close" data-dismiss="modal">&times;</button>
                          <h4 class="modal-title">Confirmación</h4>
                        </div>
                        <div class="modal-body">
                            <label>La información registrada no podrá ser modificada ¿Desea continuar?</label>
                            <input type="hidden" name="idRol" id="idRol">
                        </div>
                        <div class="modal-footer">
                            <input class="btn btn-sm btn-primary" id="btnEnviar" type="submit" value='Sí'/>
                            <input type="button" class="btn btn-primary btn-sm" value="No" data-dismiss="modal"/>
                        </div>
                    </form>
                  </div>

                </div>
            </div>                        
        </main>
        <script src="https://framework-gb.cdn.gob.mx/gobmx.js"></script>
        <script src="https://code.jquery.com/jquery-1.12.4.js"></script>
        <script src="https://ajax.aspnetcdn.com/ajax/jquery.validate/1.13.1/jquery.validate.min.js"></script>
        <script src="js/funcionesConformacionComite.js"></script>
        
        <c:if test="${datos[0]!=null}">
            <script>
                $("#programa").val(${datos[1]});
                $("#subsistema").val(${datos[2]});
                $("#entidad").val(${datos[3]});
                $("#plantel").val(${datos[4]});
                $("#tipo").val('${datos[5]}');
            </script>
        </c:if>
        <c:if test = "${datos[6]=='V'}">
            <script>
                function confirmacion(){
                    $("#mensaje").html("Acción no permitida");                    
                    $("#modalMensaje").modal("show");
                }
            </script>
        </c:if>
        
    </body>
</html>
