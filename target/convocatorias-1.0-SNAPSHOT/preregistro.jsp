<%-- 
    Document   : preregistro
    Created on : 5 ago 2020, 20:35:38
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
        <jsp:useBean id="mensaje" class="com.aplicacion.beans.Mensaje" />
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
                    <a class="navbar-brand" href="/">DGETI - CECyTEs</a>
                  </div>
                  <div class="collapse navbar-collapse" id="subenlaces">
                    <ul class="nav navbar-nav navbar-right">      
                      <li><a href="login.jsp">Regresar</a></li> 
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
                  <h4>Programa de Promoción en el Servicio Docente en Educación Media Superior</h4>
              </div>
              <!--Breadcrumbs-->
              <ol class="breadcrumb">
                <li><a href="login.jsp">Inicio</a></li>
                <li class="active">Pre-registro de aspirante</li>
              </ol>
              <!--FIN Breadcrumbs-->
            </div>
            <div class="text-center">
                <h4>Pre-registro de aspirante</h4>                
            </div>
            <div class="container" style="margin-bottom: 20px;">
                <form id="formPreregistro" method="POST" action="Preregistro">
                    <div class="row">
                        <div class="form-group col-md-12">                               
                            <label class="control-label" for="programa">Programa por el que participa:</label>
                            <select class="form-control input-sm" id="programa" name="programa" required onChange="validacionRegistro(this)">                                  
                                ${catalogo.desplegarOpcionesProgramas()}
                            </select>
                        </div>
                    </div>
                    
                    <div class="row">
                        <div class="form-group col-md-6 hidden" id="validRegistro" name="validRegistro">                               
                            <div class="radio">
                                <label>
                                    <input type="radio" name="radio-01" value="opcion-01" onChange="validacionRegistroFormulario(this)"> <Strong>Deseas registrarte como un participante nuevo.</strong>
                                </label>
                                <label>
                                  <input type="radio" name="radio-01" value="opcion-02" onChange="validacionRegistroFormulario(this)"> <Strong>Deseas participar con tu resultado anterior.</Strong>
                                </label>
                            </div>
                        </div>        
                        <div class="form-group col-md-6 hidden" id="valid-form-01">                               
                            <label class="control-label" for="programa">Subsistema:</label>
                            <select class="form-control input-sm" id="subsistema" name="subsistema" onChange="cambioSubsistema(this)" required>                                  
                                <option value=''>-Seleccione-</option>
                                <option value='1'>DGETI</option>
                                <option value='2'>CECyTE</option>
                            </select>
                        </div>
     
                    </div>         
                          
                    <div class="row">
                        <div class="form-group col-md-12 hidden" id="valid-form-07" style="text-align: justify;">
                            <p>
                                "En caso de que hayas participado en el Proceso de Promoción en el Servicio Docente por Cambio de Categoría Ciclo Escolar 2020-2021, tienes la posibilidad de conservar tus resultados. Si decides hacerlo, registra tu RFC y 
                                elige la opción <strong>SI DESEO CONSERVAR LOS RESULTADOS</strong> y el puntaje que obtuviste te permitirá formar parte de la lista ordenada de resultados del Proceso de Promoción en el Servicio 
                                Docente por Cambio de Categoría Ciclo Escolar 2021-2022.
                                También puede elegir la opción <strong>NO DESEO CONSERVAR LOS RESULTADOS</strong> y deberas realizar el procedimiento completo de registro, como participante nuevo."
                            </p>
                            <div align="center" id="valid-form-08">
                                <button type="button" class="btn btn-sm  btn-primary" onclick="noConservaCambio()">NO DESEO CONSERVAR LOS RESULTADOS</button>
                                <button type="button" class="btn btn-sm btn-primary" onclick="siConservaCambio()">SI DESEO CONSERVAR LOS RESULTADOS</button>
                            </div>
                        </div> 
                        
                    </div>          
                            
                    <div class="row hidden" id="valid-form-02">
                        <div class="form-group col-md-4">                               
                            <label class="control-label" for="rfc">RFC:</label>
                            <input required class="form-control input-sm" type="text" id="rfc" name="rfc" onchange="consultaWS()" maxlength="13" />
                            <label class="error" id="alertaRFC" hidden >Ingrese un RFC válido</label>
                        </div>
                        <div class="form-group col-md-4">                               
                            <label class="control-label" for="nombre" id="lblNombre">Nombre(s):</label>
                            <input required class="form-control input-sm text-uppercase" type="text" id="nombre" name="nombre" maxlength="200"/>
                        </div>
                        <div class="form-group col-md-4" id="seccionPaterno">                               
                            <label class="control-label" for="apellido1">Primer apellido:</label>
                            <input required class="form-control input-sm text-uppercase" type="text" id="apellido1" name="apellido1" maxlength="50"/>
                        </div>
                    </div>
                    <div class="row hidden" id="valid-form-03">
                        <div class="form-group col-md-4" id="seccionMaterno">                               
                            <label class="control-label" for="apellido2">Segundo apellido:</label>
                            <input required class="form-control input-sm text-uppercase" type="text" id="apellido2" name="apellido2" maxlength="50"/>
                        </div>
                        <div class="form-group col-md-4">                               
                            <label class="control-label" for="entidad">Entidad:</label>
                            <select class="form-control input-sm" id="entidad" name="entidad" onchange="actualizarPlanteles()" required>                                  
                                ${catalogo.desplegarOpcionesEstado()}
                            </select>
                        </div>
                        <div class="form-group col-md-4">                               
                            <label class="control-label" for="plantel">Plantel:</label>
                            <select class="form-control input-sm" id="plantel" name="plantel" required>                                  
                                <option value=''>-Seleccione-</option>
                            </select>
                        </div>
                    </div>
                    <div class="row hidden" id="valid-form-04">
                        <div class="form-group col-md-4">                               
                            <label class="control-label" for="fijo">Teléfono fijo:</label>
                            <input required class="form-control input-sm" type="text" id="fijo" name="fijo" maxlength="10" />
                        </div>
                        <div class="form-group col-md-4">                               
                            <label class="control-label" for="movil">Teléfono celular:</label>
                            <input required class="form-control input-sm" type="text" id="movil" name="movil" maxlength="10" />
                        </div>
                        <div class="form-group col-md-4">                               
                            <label class="control-label" for="correo">Correo electrónico:</label>
                            <input required class="form-control input-sm text-lowercase" type="mail" id="correo" name="correo" maxlength="50"/>
                            <label class="error" id="alertaCorreo" hidden >Ingrese una dirección de correo válida</label>
                        </div>
                    </div>
                    <div class="row hidden" id="valid-form-05">
                        <div class="form-group col-md-12">    
                            <span class="d-inline-block" tabindex="0" data-toggle="tooltip" title="p.e. Debilidad visual, debilidad auditiva, silla de ruedas, etc">
                            <label class="control-label" for="consideraciones">Consideraciones particulares:</label>
                            </span>
                            <label class="text-warning">    
                            <span class="glyphicon glyphicon-alert" aria-hidden="true" class="d-inline-block" tabindex="0" data-toggle="tooltip" title="p.e. Debilidad visual, debilidad auditiva, silla de ruedas, etc"></span>
                            </label>
                            <textarea class="form-control text-uppercase" id="consideraciones" name="consideraciones" maxlength="200"></textarea>
                        </div>
                    </div>
                    <div class="row hidden" id="valid-form-06">
                        <div class="form-group col-md-4">                               
                            <label class="control-label" for="pass1">Crear contraseña:</label>
                            <input required class="form-control input-sm" type="password" id="pass1" name="pass1" />
                        </div>
                        <div class="form-group col-md-4">                               
                            <label class="control-label" for="pass2">Confirme contraseña:</label>
                            <input required class="form-control input-sm" type="password" id="pass2" name="pass2" />
                        </div>
                        <div style="padding-top:30px;">
                            <table>
                              <tr>
                                <td valign="top"><input type="checkbox" name="cbAviso" id="cbAviso" onClick="cambioAviso()"><td>
                                <td>He leído y acepto el aviso de privacidad disponible <a target="_blank" href="Convocatoria?k=avisoPrivacidad.pdf">aquí</a></td>    
                              </tr>                              
                            </table>
                        </div>
                    </div>
                    <div class="row">                        
                        <div class="col-xs-12 text-right" id="valid-form-10" hidden>
                            <input   class="btn btn-sm btn-primary" type="reset" value="Limpiar"/>
                            <input  class="btn btn-sm btn-primary" id="btnEnviar" type="submit" value='Guardar' disabled/>
                            <!--<input required type="button" class="btn btn-sm btn-primary" value="Guardar y continuar" onclick="mostrarSiguiente(1)"/>-->
                        </div>
                        
                    </div>
                </form>
                <form id="formPreregistroRFC" method="POST" action="Preregistro">
                    <div class="row">
                            <div class="form-group col-md-4  hidden" id="valid-form-09"> 
                                <input type="hidden" id="accion" name="accion" value="preregistroRFC">
                                <label class="control-label" for="rfc">Registrar RFC:</label>
                                <input  class="form-control input-sm" type="text" id="rfc-02" onchange="comprobacionRFC2()" name="rfc-02"  maxlength="13" />
                                <label class="error" id="alertaRFC-02" hidden >Ingrese un RFC válido</label>
                            </div>
                           <!-- <div class="form-group col-md-4 hidden" id="valid-form-12">                               
                                <label class="control-label" for="pass1">Crear contraseña:</label>
                                <input  class="form-control input-sm" type="password" id="pass01-p" name="pass01-p" onChange="comprobacionPassword2()"/>
                            </div>
                            <div class="form-group col-md-4 hidden" id="valid-form-13">                               
                                <label class="control-label" for="pass2">Confirmar contraseña:</label>
                                <input  class="form-control input-sm" type="password" id="pass02-p" name="pass02-p" onChange="comprobacionPassword2()"/>
                            </div>-->
                        <br>
                        <div class="col-xs-6 " id="valid-form-11" hidden>
                            <input  class="btn btn-sm btn-primary" id="btnEnviarRFC" type="submit" value='Guardar' disabled/>
                            <!--<input required type="button" class="btn btn-sm btn-primary" value="Guardar y continuar" onclick="mostrarSiguiente(1)"/>-->
                        </div>
                    </div>
                </form>            
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
                  <a id="btnContinuar" href="login.jsp" class="btn btn-sm btn-default">Continuar</a>
                  <button id="btnCerrar" type="button" class="btn btn-sm btn-default" data-dismiss="modal">Cerrar</button>
                </div>
              </div>

            </div>
          </div>            
        </main>
        <script src="https://framework-gb.cdn.gob.mx/gobmx.js"></script>
        <script src="https://code.jquery.com/jquery-1.12.4.js"></script>
        <script src="https://ajax.aspnetcdn.com/ajax/jquery.validate/1.13.1/jquery.validate.min.js"></script>
        <script src="js/funcionesPreregistro.js?v=1"></script>
    </body>
</html>
