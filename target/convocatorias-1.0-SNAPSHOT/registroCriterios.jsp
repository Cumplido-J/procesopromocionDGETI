<%-- 
    Document   : registroCriterios
    Created on : 18 ago 2020, 14:39:07
    Author     : David Reyna
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
    <head>
        <title></title>
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
                  <h4>Programa de Promoción en el Servicio Docente en Educación Media Superior</h4>
              </div>
              <!--Breadcrumbs-->
              <ol class="breadcrumb">
                <li><a href="Servlet_cerrarsesion">Inicio</a></li>
                <li><a href="SesionDocente">Sesión Docente</a></li>
                <li class="active">Registro de evidencias de criterios de valoración</li>
              </ol>
              <!--FIN Breadcrumbs-->
              
                  <div class="panel-group ficha-collapse" id="accordion">
                    <div class="panel panel-default">
                      <div class="panel-heading">
                        <h4 class="panel-title">
                          <a data-parent="#accordion" data-toggle="collapse" href="#panel1" aria-expanded="true" aria-controls="panel1">
                              ${criterios[0][0]} - ${criterios[0][1]}
                          </a>
                        </h4>
                        <button type="button" class="collpase-button collapsed" data-parent="#accordion" data-toggle="collapse" href="#panel1"></button>
                      </div>
                      <div class="panel-collapse collapse in" id="panel1">
                        <div class="panel-body">
                            <form id="form1" role="form" action="RegistroCriterio" method="POST">
                                <input type='hidden' name='idCriterio' value='${criterios[0][0]}'>
                                <div class="form-group col-md-6">                                                             
                                  <label class="control-label">Antigüedad:</label>
                                  <select class="form-control input-sm" id="puntaje1" name="puntaje" required>                                  
                                      ${catalogo.desplegarOpcionesPuntaje(criterios[0][0])}
                                  </select>
                                </div>
                                <div class="form-group col-md-6">
                                    <label class="control-label">Carga de evidencia documental:</label>
                                    <br/><input id="btnEvidencia9" type="button" class="btn btn-sm btn-link" value="Subir archivo" onclick="abrirModalArchivo(9)"/>
                                </div>
                                <div class="col-xs-12 text-right">
                                    <input  class="btn btn-sm btn-primary" type="reset" value="Limpiar"/>
                                    <input class="btn btn-sm btn-primary" id="btnEnviar1" type="submit" value='Guardar y continuar'/>                                    
                                </div>
                            </form>
                        </div>
                      </div>
                    </div>
                    <div class="panel panel-default">
                      <div class="panel-heading">
                        <h4 class="panel-title">
                          <a data-parent="#accordion" data-toggle="collapse" href="#panel2" aria-expanded="false" aria-controls="panel2">
                          ${criterios[1][0]} - ${criterios[1][1]}
                          </a>
                        </h4>
                        <button type="button" class="collpase-button collapsed" data-parent="#accordion" data-toggle="collapse" href="#panel2"></button>
                      </div>
                      <div class="panel-collapse collapse" id="panel2">
                        <div class="panel-body">
                          <form id="form1" role="form" action="RegistroCriterio" method="POST">
                                <input type='hidden' name='idCriterio' value='${criterios[1][0]}'>
                                <div class="form-group col-md-6">                                                             
                                  <label class="control-label">Experiencia:</label>
                                  <select class="form-control input-sm" id="puntaje2" name="puntaje" required>                                  
                                      ${catalogo.desplegarOpcionesPuntaje(criterios[1][0])}
                                  </select>
                                </div>
                                <div class="form-group col-md-6">
                                    <label class="control-label">Carga de evidencia documental:</label>
                                    <br/><input id="btnEvidencia10" type="button" class="btn btn-sm btn-link" value="Subir archivo" onclick="abrirModalArchivo(10)"/>
                                </div>
                                <div class="col-xs-12 text-right">
                                    <input  class="btn btn-sm btn-primary" type="reset" value="Limpiar"/>
                                    <input class="btn btn-sm btn-primary" id="btnEnviar2" type="submit" value='Guardar y continuar'/>                                    
                                </div>
                            </form>
                        </div>
                      </div>
                    </div>
                    <div class="panel panel-default">
                      <div class="panel-heading">
                        <h4 class="panel-title">
                          <a data-parent="#accordion" data-toggle="collapse" href="#panel3" aria-expanded="false" aria-controls="panel3">
                          ${criterios[2][0]} - ${criterios[2][1]}
                          </a>
                        </h4>
                        <button type="button" class="collpase-button collapsed" data-parent="#accordion" data-toggle="collapse" href="#panel3"></button>
                      </div>
                      <div class="panel-collapse collapse" id="panel3">
                        <div class="panel-body">
                            <div class='table-responsive'>
                                <table class='table table-condensed table-bordered'>
                                    <tr><th>Encuesta</th><th>Estatus</th></tr>
                                    <tr><td>A madres y padres de familia o tutores</td><td>Pendiente</td></tr>
                                    <tr><td>A alumnos</td><td>Evaluado</td></tr>
                                    <tr><td>A compañeros de trabajo</td><td>Pendiente</td></tr>
                                </table>
                            </div>
                        </div>
                      </div>
                    </div>
                    <div class="panel panel-default">
                      <div class="panel-heading">
                        <h4 class="panel-title">
                          <a data-parent="#accordion" data-toggle="collapse" href="#panel4" aria-expanded="false" aria-controls="panel4">
                          ${criterios[3][0]} - ${criterios[3][1]}
                          </a>
                        </h4>
                        <button type="button" class="collpase-button collapsed" data-parent="#accordion" data-toggle="collapse" href="#panel4"></button>
                      </div>
                      <div class="panel-collapse collapse" id="panel4">
                        <div class="panel-body">
                          <form id="form1" role="form" action="RegistroCriterio" method="POST">
                                <input type='hidden' name='idCriterio' value='${criterios[3][0]}'>
                                <div class="form-group col-md-6">                                                             
                                  <label class="control-label">Máximo grado académico:</label>
                                  <select class="form-control input-sm" id="puntaje4" name="puntaje" required>                                  
                                      ${catalogo.desplegarOpcionesPuntaje(criterios[3][0])}
                                  </select>
                                </div>
                                <div class="form-group col-md-6">
                                    <label class="control-label">Carga de evidencia documental:</label>
                                    <br/><input id="btnEvidencia12" type="button" class="btn btn-sm btn-link" value="Subir archivo" onclick="abrirModalArchivo(12)"/>
                                </div>
                                <div class="col-xs-12 text-right">
                                    <input  class="btn btn-sm btn-primary" type="reset" value="Limpiar"/>
                                    <input class="btn btn-sm btn-primary" id="btnEnviar4" type="submit" value='Guardar y continuar'/>                                    
                                </div>
                            </form>
                        </div>
                      </div>
                    </div>
                    <div class="panel panel-default">
                      <div class="panel-heading">
                        <h4 class="panel-title">
                          <a data-parent="#accordion" data-toggle="collapse" href="#panel5" aria-expanded="false" aria-controls="panel5">
                          ${criterios[4][0]} - ${criterios[4][1]}
                          </a>
                        </h4>
                        <button type="button" class="collpase-button collapsed" data-parent="#accordion" data-toggle="collapse" href="#panel5"></button>
                      </div>
                      <div class="panel-collapse collapse" id="panel5">
                        <div class="panel-body">
                            <div class='text-center'>
                                <input type='button' class='btn btn-sm btn-link' value='(+) Agregar información' />
                            </div>
                            <div class='table-responsive'>
                                <table class='table table-bordered table-condensed'>
                                    <tr><th>Nombre del curso</th><th>Periodo o Fecha de realización</th><th>Institución educativa con reconocimiento oficial que emite constancia</th><th>Total de horas que acredita el curso</th><th>Borrar</th></tr>
                                    <tr><td colspan='5'>Sin información</td></tr>
                                </table>
                            </div>
                            <form id="form1" role="form" action="RegistroCriterio" method="POST">
                                <input type='hidden' name='idCriterio' value='${criterios[4][0]}'>                                
                                <div class="form-group col-xs-12">
                                    <label class="control-label">Carga de evidencia documental:</label>
                                    <br/><input id="btnEvidencia13" type="button" class="btn btn-sm btn-link" value="Subir archivo" onclick="abrirModalArchivo(13)"/>
                                </div>
                                <div class="col-xs-12 text-right">
                                    <input  class="btn btn-sm btn-primary" type="reset" value="Limpiar"/>
                                    <input class="btn btn-sm btn-primary" id="btnEnviar5" type="submit" value='Guardar y continuar'/>                                    
                                </div>
                            </form>
                        </div>
                      </div>
                    </div>
                    <div class="panel panel-default">
                      <div class="panel-heading">
                        <h4 class="panel-title">
                          <a data-parent="#accordion" data-toggle="collapse" href="#panel6" aria-expanded="false" aria-controls="panel6">
                          ${criterios[5][0]} - ${criterios[5][1]}
                          </a>
                        </h4>
                        <button type="button" class="collpase-button collapsed" data-parent="#accordion" data-toggle="collapse" href="#panel6"></button>
                      </div>
                      <div class="panel-collapse collapse" id="panel6">
                        <div class="panel-body">
                            <div class='text-center'>
                                <input type='button' class='btn btn-sm btn-link' value='(+) Agregar información' />
                            </div>
                            <div class='table-responsive'>
                                <table class='table table-bordered table-condensed'>
                                    <tr><th>Nombre de la aportación en materia de mejora continua</th><th>Periodo o Fecha de realización</th><th>Institución educativa con reconocimiento oficial que emite constancia</th><th>Borrar</th></tr>
                                    <tr><td colspan='4'>Sin información</td></tr>
                                </table>
                            </div>
                            <form id="form1" role="form" action="RegistroCriterio" method="POST">
                                <input type='hidden' name='idCriterio' value='${criterios[5][0]}'>                                
                                <div class="form-group col-xs-12">
                                    <label class="control-label">Carga de evidencia documental:</label>
                                    <br/><input id="btnEvidencia14" type="button" class="btn btn-sm btn-link" value="Subir archivo" onclick="abrirModalArchivo(14)"/>
                                </div>
                                <div class="col-xs-12 text-right">
                                    <input  class="btn btn-sm btn-primary" type="reset" value="Limpiar"/>
                                    <input class="btn btn-sm btn-primary" id="btnEnviar6" type="submit" value='Guardar y continuar'/>                                    
                                </div>
                            </form>
                        </div>
                      </div>
                    </div>
                    <div class="panel panel-default">
                      <div class="panel-heading">
                        <h4 class="panel-title">
                          <a data-parent="#accordion" data-toggle="collapse" href="#panel7" aria-expanded="false" aria-controls="panel7">
                          ${criterios[6][0]} - ${criterios[6][1]}
                          </a>
                        </h4>
                        <button type="button" class="collpase-button collapsed" data-parent="#accordion" data-toggle="collapse" href="#panel7"></button>
                      </div>
                      <div class="panel-collapse collapse" id="panel7">
                        <div class="panel-body">
                            <div class='text-center'>
                                <input type='button' class='btn btn-sm btn-link' value='(+) Agregar información' />
                            </div>
                            <div class='table-responsive'>
                                <table class='table table-bordered table-condensed'>
                                    <tr><th>Nombre de la participación en eventos y actividades de fortalecimiento académico y formación integral del educando</th><th>Periodo o Fecha de realización</th><th>Institución educativa con reconocimiento oficial que emite constancia</th><th>Borrar</th></tr>
                                    <tr><td colspan='4'>Sin información</td></tr>
                                </table>
                            </div>
                            <form id="form1" role="form" action="RegistroCriterio" method="POST">
                                <input type='hidden' name='idCriterio' value='${criterios[6][0]}'>                                
                                <div class="form-group col-xs-12">
                                    <label class="control-label">Carga de evidencia documental:</label>
                                    <br/><input id="btnEvidencia15" type="button" class="btn btn-sm btn-link" value="Subir archivo" onclick="abrirModalArchivo(15)"/>
                                </div>
                                <div class="col-xs-12 text-right">
                                    <input  class="btn btn-sm btn-primary" type="reset" value="Limpiar"/>
                                    <input class="btn btn-sm btn-primary" id="btnEnviar7" type="submit" value='Guardar y continuar'/>                                    
                                </div>
                            </form>
                        </div>
                      </div>
                    </div>
                    <div class="panel panel-default">
                      <div class="panel-heading">
                        <h4 class="panel-title">
                          <a data-parent="#accordion" data-toggle="collapse" href="#panel8" aria-expanded="false" aria-controls="panel8">
                          ${criterios[7][0]} - ${criterios[7][1]}
                          </a>
                        </h4>
                        <button type="button" class="collpase-button collapsed" data-parent="#accordion" data-toggle="collapse" href="#panel8"></button>
                      </div>
                      <div class="panel-collapse collapse" id="panel8">
                        <div class="panel-body">
                            <div class='text-center'>
                                <input type='button' class='btn btn-sm btn-link' value='(+) Agregar información' />
                            </div>
                            <div class='table-responsive'>
                                <table class='table table-bordered table-condensed'>
                                    <tr><th>Periodo o Fecha de realización</th><th>Borrar</th></tr>
                                    <tr><td colspan='2'>Sin información</td></tr>
                                </table>
                            </div>
                            <form id="form1" role="form" action="RegistroCriterio" method="POST">
                                <input type='hidden' name='idCriterio' value='${criterios[7][0]}'>                                
                                <div class="form-group col-xs-12">
                                    <label class="control-label">Carga de evidencia documental:</label>
                                    <br/><input id="btnEvidencia16" type="button" class="btn btn-sm btn-link" value="Subir archivo" onclick="abrirModalArchivo(16)"/>
                                </div>
                                <div class="col-xs-12 text-right">
                                    <input  class="btn btn-sm btn-primary" type="reset" value="Limpiar"/>
                                    <input class="btn btn-sm btn-primary" id="btnEnviar8" type="submit" value='Guardar y continuar'/>                                    
                                </div>
                            </form>
                        </div>
                      </div>
                    </div>
                    <div class="panel panel-default">
                      <div class="panel-heading">
                        <h4 class="panel-title">
                          <a data-parent="#accordion" data-toggle="collapse" href="#panel9" aria-expanded="false" aria-controls="panel9">
                          ${criterios[8][0]} - ${criterios[8][1]}
                          </a>
                        </h4>
                        <button type="button" class="collpase-button collapsed" data-parent="#accordion" data-toggle="collapse" href="#panel9"></button>
                      </div>
                      <div class="panel-collapse collapse" id="panel9">
                        <div class="panel-body">
                            <div class='text-center'>
                                <input type='button' class='btn btn-sm btn-link' value='(+) Agregar información' />
                            </div>
                            <div class='table-responsive'>
                                <table class='table table-bordered table-condensed'>
                                    <tr><th>Nombre de  la publicación</th><th>Medio en el que se publicó</th><th>Fecha de publicación</th><th>Borrar</th></tr>
                                    <tr><td colspan='4'>Sin información</td></tr>
                                </table>
                            </div>
                            <form id="form1" role="form" action="RegistroCriterio" method="POST">
                                <input type='hidden' name='idCriterio' value='${criterios[8][0]}'>                                
                                <div class="form-group col-xs-12">
                                    <label class="control-label">Carga de evidencia documental:</label>
                                    <br/><input id="btnEvidencia17" type="button" class="btn btn-sm btn-link" value="Subir archivo" onclick="abrirModalArchivo(17)"/>
                                </div>
                                <div class="col-xs-12 text-right">
                                    <input  class="btn btn-sm btn-primary" type="reset" value="Limpiar"/>
                                    <input class="btn btn-sm btn-primary" id="btnEnviar9" type="submit" value='Guardar y continuar'/>                                    
                                </div>
                            </form>
                        </div>
                      </div>
                    </div>
                    <div class="panel panel-default">
                      <div class="panel-heading">
                        <h4 class="panel-title">
                          <a data-parent="#accordion" data-toggle="collapse" href="#panel10" aria-expanded="false" aria-controls="panel10">
                          ${criterios[9][0]} - ${criterios[9][1]}
                          </a>
                        </h4>
                        <button type="button" class="collpase-button collapsed" data-parent="#accordion" data-toggle="collapse" href="#panel10"></button>
                      </div>
                      <div class="panel-collapse collapse" id="panel10">
                        <div class="panel-body">
                            <form id="form1" role="form" action="RegistroCriterio" method="POST">
                                <input type='hidden' name='idCriterio' value='${criterios[9][0]}'> 
                                <div class="row">
                                    <div class="form-group col-md-6">
                                        <label class="control-label">10.1A Planeación didáctica: Docente</label>
                                        <select class="form-control input-sm" id="puntaje10" name="puntaje10" required>                                  
                                          ${catalogo.desplegarOpcionesPuntaje(10)}
                                      </select>
                                    </div>
                                    <div class="form-group col-md-6">
                                        <label class="control-label">10.1AB Portafolio de evidencias de Evaluación del aprendizaje</label>
                                        <select class="form-control input-sm" id="puntaje11" name="puntaje11" required>                                  
                                          ${catalogo.desplegarOpcionesPuntaje(11)}
                                        </select>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="form-group col-md-6">                                                             
                                      <label class="control-label">10.2A Observación en el aula (práctica docente)
                                          <br/>Nivel de desempeño en la observación de clase en aula (práctica docente)
                                      </label>
                                      <select class="form-control input-sm" id="puntaje12" name="puntaje12" required>                                  
                                          ${catalogo.desplegarOpcionesPuntaje(12)}
                                      </select>
                                    </div>
                                    <div class="form-group col-md-6">                                                             
                                      <label class="control-label">10.3A Porcentaje de aprobación escolar (Resultados educativos) por asignatura, actividad paraescolar o módulo profesional:<br/><br/></label>
                                      <select class="form-control input-sm" id="puntaje13" name="puntaje13" required>                                  
                                          ${catalogo.desplegarOpcionesPuntaje(13)}
                                      </select>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="form-group col-md-6">                                                             
                                      <label class="control-label">10.4A Dictamen del área académica
                                      <br/>Nivel de Desempeño(resultados educativos): 
                                      </label>
                                      <select class="form-control input-sm" id="puntaje13" name="puntaje14" required>                                  
                                          ${catalogo.desplegarOpcionesPuntaje(14)}
                                      </select>
                                    </div>
                                </div>
                                <div class="col-xs-12">
                                    <label class="control-label">Evidencias de resultados educativos</label>
                                    <div class='text-center'>
                                        <input type='button' class='btn btn-sm btn-link' value='(+) Agregar información' />
                                    </div>
                                    <div class='table-responsive'>
                                        <table class='table table-bordered table-condensed'>
                                            <tr><th>Periodo o Fecha de realización</th><th>Borrar</th></tr>
                                            <tr><td colspan='2'>Sin información</td></tr>
                                        </table>
                                    </div>
                                </div>
                                <div class="form-group col-md-12">
                                    <label class="control-label">Carga de evidencia documental:</label>
                                    <br/><input id="btnEvidencia18" type="button" class="btn btn-sm btn-link" value="Subir archivo" onclick="abrirModalArchivo(18)"/>
                                </div>
                                <div class="col-xs-12 text-right">
                                    <input  class="btn btn-sm btn-primary" type="reset" value="Limpiar"/>
                                    <input class="btn btn-sm btn-primary" id="btnEnviar10" type="submit" value='Guardar y continuar'/>                                    
                                </div>
                            </form>
                        </div>
                      </div>
                    </div>
                      
                  </div>
              <div class="container text-center" style="margin-bottom:15px;">
                  <form action="#" method="POST">
                      <input type="hidden" id="banderaCompleto" name="k" value="${banderaCompleto}">                      
                      <br/>
                      <input type="submit" disabled="true" class="btn btn-primary" value="Finalizar registro" id="btnFinalizar">
                  </form>
              </div>
              
        </main>
        <div id="modalArchivo" class="modal fade" role="dialog">
            <div class="modal-dialog">
              <div class="modal-content">
                <div class="modal-header">
                  <button type="button" class="close" data-dismiss="modal">&times;</button>
                  <h4 class="modal-title" id="tituloModal">Carga de evidencia documental</h4>
                </div>
                <div class="modal-body">
                    <iframe name="ifRespuesta" hidden></iframe>
                    <iframe style="width:100%;" id="ifArchivo" name="ifArchivo" src="" hidden></iframe>
                    <form id="formArchivo" name="formArchivo" method="POST" enctype="multipart/form-data" >
                        <div class="form-group">
                            <label class="control-label" for="archivo">Seleccione el archivo a cargar:</label>
                            <input type="hidden" id="idArchivo" name="idArchivo" value="" />
                            <input type="file" class="form-control input-sm" id="archivo" name="archivo" onchange="subirArchivo()" accept=".pdf" />
                        </div>
                    </form>                    
                </div>
                <div class="modal-footer">
                  <button type="button" class="btn btn-sm btn-default" data-dismiss="modal">Cerrar</button>
                </div>
              </div>
            </div>
          </div>
        <script src="https://framework-gb.cdn.gob.mx/gobmx.js"></script>
        <script src="https://code.jquery.com/jquery-1.12.4.js"></script>   
        <script src="http://ajax.aspnetcdn.com/ajax/jquery.validate/1.13.1/jquery.validate.min.js"></script>
        <script src="js/funcionesEvidencias.js"></script> 
    </body>
</html>
