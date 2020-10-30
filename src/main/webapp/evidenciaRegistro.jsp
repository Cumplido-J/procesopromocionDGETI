<%-- 
    Document   : evidenciaRegistro
    Created on : 04/08/2020, 11:50:39
    Author     : jtrinidadl
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import='herramientas.Catalogos'%>
<!DOCTYPE html>
<!--
To change this license header, choose License Headers in Project Properties.
To change this template file, choose Tools | Templates
and open the template in the editor.
-->
<html lang="es">
    <head>
        <title>DGETI | sep.gob.mx</title>
        <meta charset="UTF-8"/>
        <meta http-equiv="X-UA-Compatible" content="IE=edge"/>
        <meta name="viewport" content="width=device-width, initial-scale=1.0"/>        
        <link href="https://framework-gb.cdn.gob.mx/assets/styles/main.css" rel="stylesheet"/>
        <!--<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
        <link rel="stylesheet" href="/resources/demos/style.css">-->
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
                    <a class="navbar-brand" href="/">DGETI</a>
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
                <p>Dirección General de Educación Tecnológica Industrial y de Servicios</p>
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
                <li class="active">Criterios de valoración</li>
              </ol>
              <!--FIN Breadcrumbs-->
              <div class="text-center">
                <h4>Registro de requisitos para participar en el:</h4>
                <h4>Programa de Promoción en el Servicio Docente por Cambio de Categoría en Educación Media Superior</h4>
              </div>
              <!--Paneles colapsables-->
              <div class="panel-group ficha-collapse" id="accordion">
                <div class="panel panel-default">
                  <div class="panel-heading">
                    <h4 class="panel-title">
                      <a data-parent="#accordion" data-toggle="collapse" href="#infoAntiguedad" aria-expanded="true" aria-controls="infoAntiguedad">
                      1. Antiguedad <p id="p1"></p>
                      </a>
                    </h4>
                    <button type="button" class="collpase-button collapsed" data-parent="#accordion" data-toggle="collapse" href="#infoAntiguedad"></button>
                  </div>
                  <div class="panel-collapse collapse in" id="infoAntiguedad">
                    <div class="panel-body">
                      <form id="formInfoAntiguedad" role="form" method="POST" action="#">
                          <div class="form-group col-md-6">                               
                              <label class="control-label" for="antiguedad">Antiguedad</label>
                              <select class="form-control input-sm" id="sp1" onchange="puntaje(1)"name="antiguedad" required>                                  
                                  ${catalogo.desplegarOpcionesPuntaje("1")}
                              </select>
                            </div>
                        <div class="form-group col-md-6">
                          <label class="control-label" for="btnEvidencia9">Cargar de constancia de antiguedad:</label>
                          <br/><input id="btnEvidencia9" type="button" class="btn btn-sm btn-link" value="Subir archivo" onclick="abrirModalArchivo(9)"/>
                        </div>
                          <br>
                        <div class="col-xs-12 text-right">
                          <button class="btn btn-sm btn-primary" type="reset">Limpiar</button>
                          <button class="btn btn-sm btn-primary" type="submit">Guardar y continuar</button>
                        </div>
                      </form>
                    </div>
                  </div>
                </div>
                
                <div class="panel panel-default">
                  <div class="panel-heading">
                    <h4 class="panel-title">
                      <a data-parent="#accordion" data-toggle="collapse" href="#infoExperiencia" aria-expanded="true" aria-controls="infoExperiencia">
                      2. Experiencia y tiempo de trabajo en zonas de marginación, pobreza y descomposición social
                      <p id="p2"></p>
                      </a>
                    </h4>
                    <button type="button" class="collpase-button collapsed" data-parent="#accordion" data-toggle="collapse" href="#infoExperiencia"></button>
                  </div>
                  <div class="panel-collapse collapse" id="infoExperiencia">
                    <div class="panel-body">
                      <form role="form" method="POST" action="#">
                          <div class="form-group col-md-6">                               
                              <label class="control-label" for="experiencia">Seleccionar tiempo de experiencia:</label>
                              <select class="form-control input-sm" id="sp2" onchange="puntaje(2)" required>                                  
                                  ${catalogo.desplegarOpcionesPuntaje("2")}
                              </select>
                            </div>
                        <div class="form-group col-md-6">
                          <label class="control-label" for="evidencia7">Cargar de constancia de experiecia</label>
                          <br/><input id="btnEvidencia10" type="button" class="btn btn-sm btn-link" value="Subir archivo" onclick="abrirModalArchivo(10)"/>
                        </div>
                          <br>
                        <div class="col-xs-12 text-right">
                          <button class="btn btn-sm btn-primary" type="reset">Limpiar</button>
                          <button class="btn btn-sm btn-primary" type="submit">Guardar y continuar</button>
                        </div>
                      </form>
                    </div>
                  </div>
                </div>
                  
                <div class="panel panel-default">
                  <div class="panel-heading">
                    <h4 class="panel-title">
                      <a data-parent="#accordion" data-toggle="collapse" href="#infoReconocimiento" aria-expanded="true" aria-controls="infoReconocimiento">
                      3. Reconocimiento al buen desempeño por la comunidad educativa
                      </a>
                    </h4>
                    <button type="button" class="collpase-button collapsed" data-parent="#accordion" data-toggle="collapse" href="#infoReconocimiento"></button>
                  </div>
                  <div class="panel-collapse collapse" id="infoReconocimiento">
                    <div class="panel-body">
                      <form role="form">
                         <div class="table-responsive">
                          <table class="table table-striped table-bordered">
                            <tr>
                              <th>A madres y padres de familia o tutores</th>
                              <td>Completo</td>                   
                            </tr>
                            <tr>
                              <th>A alumnos</th>
                              <td>Incompleto</td>                    
                            </tr>
                            <tr>
                              <th>A compañeros de trabajo</th> 
                              <td>Completo</td>               
                            </tr>
                          </table>
                        </div>
                          <br>
                        <div class="col-xs-12 text-right">
                          <button class="btn btn-sm btn-primary" type="reset">Limpiar</button>
                          <button class="btn btn-sm btn-primary" type="submit">Guardar y continuar</button>
                        </div>
                      </form>
                    </div>
                  </div>
                </div>
                
                <div class="panel panel-default">
                  <div class="panel-heading">
                    <h4 class="panel-title">
                      <a data-parent="#accordion" data-toggle="collapse" href="#infoGradoAcademico" aria-expanded="true" aria-controls="infoGradoAcademico">
                      4. Formacion Ácademica y/o Posgrado
                      <p id="p4"></p>
                      </a>
                    </h4>
                    <button type="button" class="collpase-button collapsed" data-parent="#accordion" data-toggle="collapse" href="#infoGradoAcademico"></button>
                  </div>
                  <div class="panel-collapse collapse" id="infoGradoAcademico">
                    <div class="panel-body">
                      <form role="form" method="POST" action="#">
                         <div class="form-group col-md-6">
                          <label class="control-label" for="gradoAcademico">Grado académico:</label>
                          <select class="form-control input-sm" name="gradoAcademico" id="sp4" onchange="puntaje(4)">
                            ${catalogo.desplegarOpcionesPuntaje("4")}
                          </select>
                        </div>
                        <div class="form-group col-md-6">
                          <label class="control-label" for="evidencia7">Cargar de constancia de grado académico</label>
                          <br/><input id="btnEvidencia11" type="button" class="btn btn-sm btn-link" value="Subir archivo" onclick="abrirModalArchivo(11)"/>
                        </div>
                          <br>
                        <div class="col-xs-12 text-right">
                          <button class="btn btn-sm btn-primary" type="reset">Limpiar</button>
                          <button class="btn btn-sm btn-primary" type="submit">Guardar y continuar</button>
                        </div>
                      </form>
                    </div>
                  </div>
                </div>
                
                <div class="panel panel-default">
                  <div class="panel-heading">
                    <h4 class="panel-title">
                      <a data-parent="#accordion" data-toggle="collapse" href="#infoCapacitacion" aria-expanded="true" aria-controls="infoCapacitacion">
                      5. Capacitación y actualización
                      <p id="p5"></p>
                      </a>
                    </h4>
                    <button type="button" class="collpase-button collapsed" data-parent="#accordion" data-toggle="collapse" href="#infoCapacitacion"></button>
                  </div>
                  <div class="panel-collapse collapse" id="infoCapacitacion">
                    <div class="panel-body">
                        <!-- Modal -->
                    <div class="modal fade" id="exampleModalCenter" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
                      <div class="modal-dialog modal-dialog-centered" role="document">
                        <div class="modal-content">
                          <div class="modal-header">
                            <h5 class="modal-title" id="exampleModalLongTitle">Agregar Cursos</h5>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                              <span aria-hidden="true">&times;</span>
                            </button>
                          </div>
                          <div class="modal-body">
                            <form role="form">
                        <div>
                          <div class="form-group col-md-12">
                          <label class="control-label" for="folio"> Nombre del curso:</label>
                          <input type="text" class="form-control input-sm" id="txt1" name="1">
                          </div>
                          <div class="form-group col-md-12">
                          <label class="control-label" for="folio"> Fecha de realización:</label>
                          <input type="text" class="form-control input-sm" id="txt2" name="2">
                          </div>
                          <div class="form-group col-md-12">
                          <label class="control-label" for="folio"> Institución educativa:</label>
                          <input type="text" class="form-control input-sm" id="txt3" name="3">
                          </div>
                          <div id="content" class="form-group col-md-12">
                          <label class="control-label" for="modalidad">Tipo de curso:</label>
                          <select class="form-control input-sm" id="txt4" name="4" id="tipoCurso" onchange="mySeccion6()">
                            <option>-Seleccione Numero de participaciones-</option>
                            <option value='1'>1</option>
                            <option value='2'>2</option>
                            <option value='3'>3</option>
                          </select>
                          </div>
                        </div>
                      </form>
                          </div>
                          <div class="modal-footer" class="form-group col-md-6">
                            <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                            <button type="button" class="btn btn-primary" onclick="Agrega1()">Agregar</button>
                          </div>
                        </div>
                      </div>
                    </div>
                    
                      <form role="form">
                        <div class="form-group col-md-7">
                          <!--<input type="button" class="btn btn-link btn-sm" data-target="#exampleModalCenter" value="(+) Agregar información" />-->
                          <input type="button" class="btn btn-link" data-toggle="modal" data-target="#exampleModalCenter" value="(+) Agregar información">
                        </div>
                        <div class="form-group col-md-12">
                            <table table class="table table-bordered" id="tablaProductos1" onchange="mySeccion6()">
                            <tr>
                              <th>Nombre del curso</th>
                              <th>Fecha de realización</th>
                              <th>Institución educativa</th>
                              <th>Tipo de curso</th>                        
                            </tr>
                          </table>
                        </div>
                      <form role="form">
                         <div class="checkbox col-md-6">
                          <label><input type="checkbox" checked="false" name="check" id="check" onchange="mySeccion5()">Tienen certificaciones laborales o de idiomas vigentes</label>
                        </div>
                        <div>
                          <div id="content" class="form-group col-md-6">
                          <label class="control-label" for="modalidad">Cursos de actualización:</label>
                          <select class="form-control input-sm" id="sp5" name="horasCurso" onchange="puntaje(5)">
                            ${catalogo.desplegarOpcionesPuntaje("5")}
                          </select>
                        </div>
                        <div class="form-group col-md-6" id="content" >
                          <label class="control-label" for="evidencia7" id="content">Cargar constancia de cursos:</label>
                          <br/><input id="btnEvidencia12" type="button" class="btn btn-sm btn-link" value="Subir archivo" onclick="abrirModalArchivo(12)"/>
                        </div>
                        </div>
                            
                        <div class="col-xs-12 text-right">
                          <button class="btn btn-sm btn-primary" type="reset">Limpiar</button>
                          <button class="btn btn-sm btn-primary" type="submit">Guardar y continuar</button>
                        </div>
                      </form>
                    </div>
                  </div>
                </div>
                  
                <div class="panel panel-default">
                  <div class="panel-heading">
                    <h4 class="panel-title">
                      <a data-parent="#accordion" data-toggle="collapse" href="#infoMejoraContinua" aria-expanded="true" aria-controls="infoMejoraContinua">
                          </a>6. Las aportaciones en materia de mejora continua en la educación, la docencia o la investigación
                          <p id="p6"></p>
                    </h4>
                    <button type="button" class="collpase-button collapsed" data-parent="#accordion" data-toggle="collapse" href="#infoMejoraContinua"></button>
                  </div>
                  <div class="panel-body" id="infoMejoraContinua">
                        <div id="content" class="form-group col-md-6">
                          <label class="control-label" for="modalidad">Aportaciones:</label>
                          <select class="form-control input-sm" id="sp6" name="horasCurso" onchange="puntaje(6)">
                            ${catalogo.desplegarOpcionesPuntaje("6")}
                          </select>
                        </div>
                    
                        <div class="form-group col-md-12">
                          <label class="control-label" for="evidencia6">Carga de constancias:</label>
                          <br/><input id="btnEvidencia13" type="button" class="btn btn-sm btn-link" value="Subir archivo" onclick="abrirModalArchivo(13)"/>
                        </div> 
                        <div class="col-xs-12 text-right">
                          <button class="btn btn-sm btn-primary" type="reset">Limpiar</button>
                          <button class="btn btn-sm btn-primary" type="submit">Guardar y continuar</button>
                        </div>
                      </form>
                    </div>
                </div>
                  
                  <div class="panel panel-default">
                  <div class="panel-heading">
                    <h4 class="panel-title">
                      <a data-parent="#accordion" data-toggle="collapse" href="#infoParticipacion" aria-expanded="true" aria-controls="infoParticipacion">
                          7. Participación en eventos y actividades</a>
                        <p id="p7"></p>
                    </h4>
                    <button type="button" class="collpase-button collapsed" data-parent="#accordion" data-toggle="collapse" href="#infoParticipacion"></button>
                  </div>
                  <div class="panel-collapse collapse" id="infoParticipacion">
                    <div class="panel-body">
                      <form role="form">
                        <div id="content" class="form-group col-md-6">
                          <label class="control-label" for="modalidad">Participación en eventos y actividades academicás:</label>
                          <select class="form-control input-sm" id="sp7" name="horasCurso" onchange="puntaje(7)">
                            ${catalogo.desplegarOpcionesPuntaje("7")}
                          </select>
                        </div>                
                        <div class="form-group col-md-6">
                            <div id="content" >
                          <label class="control-label" for="evidencia7" id="content">Cargar constancia :</label>
                          <br/><input id="btnEvidencia14" type="button" class="btn btn-sm btn-link" value="Subir archivo" onclick="abrirModalArchivo(14)"/>
                        </div>
                        </div>
                            
                          <div class="col-xs-12 text-right"><br>
                          <button class="btn btn-sm btn-primary" type="reset">Limpiar</button>
                          <button class="btn btn-sm btn-primary" type="submit">Guardar y continuar</button>
                        </div>
                      </form>
                    </div>
                  </div>
                </div>
                  
                  <div class="panel panel-default">
                  <div class="panel-heading">
                    <h4 class="panel-title">
                      <a data-parent="#accordion" data-toggle="collapse" href="#infoTutorriaDocente" aria-expanded="true" aria-controls="infoTutorriaDocente">
                          </a>8. Actividades de tutoría o acompañamiento docente
                          <p id="p8"></p>
                    </h4>
                    <button type="button" class="collpase-button collapsed" data-parent="#accordion" data-toggle="collapse" href="#infoTutorriaDocente"></button>
                  </div>
                  <div class="panel-collapse collapse" id="infoTutorriaDocente">
                    <div class="panel-body">
                      <form role="form">
                        <div id="content" class="form-group col-md-6">
                          <label class="control-label" for="modalidad">Seleccione una opción:</label>
                          <select class="form-control input-sm" id="sp8" name="opc8" onchange="puntaje(8)">
                            ${catalogo.desplegarOpcionesPuntaje("8")}
                          </select>
                        </div>
                          <div class="form-group col-md-6">
                          <label class="control-label" for="8"> Periodo o Fecha de realización:</label>
                          <input type="text" class="form-control input-sm" id="periodoTutoria" name="8" placeholder="dd/mm/yyy del-al" onchange="mySeccion8()">
                          </div>
                        <div>
                            <div id="content" class="form-group col-md-12">
                          <label class="control-label" for="evidencia7" id="content">Cargar constancia:</label>
                          <br/><input id="btnEvidencia15" type="button" class="btn btn-sm btn-link" value="Subir archivo" onclick="abrirModalArchivo(15)"/>
                        </div>
                        </div>
                            
                          <div class="col-xs-12 text-right"><br>
                          <button class="btn btn-sm btn-primary" type="reset">Limpiar</button>
                          <button class="btn btn-sm btn-primary" type="submit">Guardar y continuar</button>
                        </div>
                      </form>
                    </div>
                  </div>
                </div>
                 
                  <div class="panel panel-default">
                  <div class="panel-heading">
                    <h4 class="panel-title">
                      <a data-parent="#accordion" data-toggle="collapse" href="#infoPublicaciones" aria-expanded="true" aria-controls="infoPublicaciones">
                          </a>9. Las publicaciones académicas o de investigación
                          <p id="demo9"></p>
                    </h4>
                    <button type="button" class="collpase-button collapsed" data-parent="#accordion" data-toggle="collapse" href="#infoPublicaciones"></button>
                  </div>
                  <div class="panel-body" id="infoPublicaciones">

                    <!-- Modal -->
                    <div class="modal fade" id="exampleModalCenter1" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
                      <div class="modal-dialog modal-dialog-centered" role="document">
                        <div class="modal-content">
                          <div class="modal-header">
                            <h5 class="modal-title" id="exampleModalLongTitle">Agregar </h5>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                              <span aria-hidden="true">&times;</span>
                            </button>
                          </div>
                          <div class="modal-body">
                            <form role="form">
                        <div>
                          <div class="form-group col-md-12">
                          <label class="control-label" for="1"> Nombre de  la publicación:</label>
                          <input type="text" class="form-control input-sm" id="txt5" name="1">
                          </div>
                          <div class="form-group col-md-12">
                          <label class="control-label" for="2"> Medio en el que se publicó:</label>
                          <input type="text" class="form-control input-sm" id="txt6" name="2">
                          </div>
                          <div class="form-group col-md-12">
                          <label class="control-label" for="3"> Fecha de publicación:</label>
                          <input type="text" class="form-control input-sm" id="txt7" name="3">
                          </div>
                            <div class="form-group col-md-12">
                          <label class="control-label" for="4"> ISNN:</label>
                          <input type="text" class="form-control input-sm" id="txt8" name="4">
                          </div>
                        </div>
                      </form>
                          </div>
                          <div class="modal-footer" class="form-group col-md-6">
                            <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                            <button type="button" class="btn btn-primary" onclick="Agrega2()" onchange="mySeccion9()">Agregar</button>
                          </div>
                        </div>
                      </div>
                    </div>
                    
                      <form role="form">
                        <div class="form-group col-md-7">
                          <!--<input type="button" class="btn btn-link btn-sm" data-target="#exampleModalCenter" value="(+) Agregar información" />-->
                          <input type="button" class="btn btn-link" data-toggle="modal" data-target="#exampleModalCenter1" value="(+) Agregar información">
                        </div>
                        <div class="form-group col-md-12">
                            <table table class="table table-bordered" id="tablaProductos2" onchange="mySeccion9()">
                            <tr>
                              <th>Nombre de  la publicación</th>
                              <th>Medio en el que se publicó</th>
                              <th>Fecha de publicación</th>
                              <th>ISNN:</th>                        
                            </tr>
                          </table>
                        </div>
                        <div class="form-group col-md-12">
                          <label class="control-label" for="evidencia6">Carga de constancia :</label>
                          <br/><input id="btnEvidencia16" type="button" class="btn btn-sm btn-link" value="Subir archivo" onclick="abrirModalArchivo(16)"/>
                        </div> 
                        <div class="col-xs-12 text-right">
                          <button class="btn btn-sm btn-primary" type="reset">Limpiar</button>
                          <button class="btn btn-sm btn-primary" type="submit">Guardar y continuar</button>
                        </div>
                      </form>
                    </div>
                </div>
                  
                  <div class="panel panel-default">
                  <div class="panel-heading">
                    <h4 class="panel-title">
                      <a data-parent="#accordion" data-toggle="collapse" href="#desempenoPlantel" aria-expanded="true" aria-controls="infoTutorriaDocente">
                          </a>10. Actividades de tutoría o acompañamiento docente
                          <p id="p10"></p>
                    </h4>
                    <button type="button" class="collpase-button collapsed" data-parent="#accordion" data-toggle="collapse" href="#desempenoPlantel"></button>
                  </div>
                  <div class="panel-collapse collapse" id="desempenoPlantel">
                    <div class="panel-body">
                      <form role="form" method="POST" action="evidenciaRegistro.jsp">                        
                        <div class="checkbox col-xs-6">
                          <label><input type="checkbox" name="funcionesOtro" id="cb10a" onchange="pmultiple()">10.A Planeación didáctica entregada</label>
                        </div>
                        <div class="checkbox col-xs-6" style="margin-top: 10px;">
                          <label><input type="checkbox" name="activoServicio" id="cb10b" onchange="pmultiple()">10.AB Portafolio de evidencias</label>
                        </div>
                          <div class="form-group col-md-6">
                          <label class="control-label" for="modalidad">10.2A Observacion en el aula:</label>
                          <select class="form-control input-sm" name="modalidad" id="sp102" onchange="pmultiple()">
                            ${catalogo.desplegarOpcionesPuntaje("12")}
                          </select>
                        </div>
                         <div class="form-group col-md-6">
                          <label class="control-label" for="a">10.3A Porcentaje de aprobación escolar:</label>
                          <select class="form-control input-sm" name="a" id="sp103" onchange="pmultiple()">
                            ${catalogo.desplegarOpcionesPuntaje("13")}
                          </select>
                         </div>
                          <div class="form-group col-md-6">
                          <label class="control-label" for="b">10.4A Nivel de desempeño área académica:</label>
                          <select class="form-control input-sm" name="b" id="sp104" onchange="pmultiple()">
                            ${catalogo.desplegarOpcionesPuntaje("12")}
                          </select>
                         </div>
                          <div class="form-group col-md-6">
                          <label class="control-label">10.4A Evidencia de resultados educativos:</label>
                          <select class="form-control input-sm" id="sp105" onchange="pmultiple()">
                            ${catalogo.desplegarOpcionesPuntaje("15")}
                          </select>
                         </div>
                        <div class="form-group col-md-12">
                          <label class="control-label" for="evidencia7">Carga de constancia</label>
                          <br/><input id="btnEvidencia17" type="button" class="btn btn-sm btn-link" value="Subir archivo" onclick="abrirModalArchivo(17)"/>
                        </div> 
                        <div class="col-xs-12 text-right">
                          <button class="btn btn-sm btn-primary" type="reset">Limpiar</button>
                          <button class="btn btn-sm btn-primary" type="submit">Guardar y continuar</button>
                        </div>
                      </form>
                    </div>
                  </div>
                </div>
              </div>
              <!--FIN Paneles colapsables-->
              <div class="col-xs-12 text-center" style="margin-top: -40px;"><br>
                          <button class="btn btn-sm btn-primary" type="submit" style="height: 70;
    height: 60px !important;
    width: 190px !important;
    th: 120px !important;
    font-size: 20px !important;
    font-weight: 600;
">Enviar</button>
              </div>
          </div>
        <div id="modalArchivo" class="modal fade" role="dialog">
            <div class="modal-dialog">
              <div class="modal-content">
                <div class="modal-header">
                  <button type="button" class="close" data-dismiss="modal">&times;</button>
                  <h4 class="modal-title" id="tituloModal">Carga de archivos</h4>
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
                
        </main>
        <script src="https://framework-gb.cdn.gob.mx/gobmx.js"></script>        
        <script src="https://code.jquery.com/jquery-1.12.4.js"></script>      
        <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>  
        <script src="https://framework-gb.cdn.gob.mx/assets/scripts/jquery-ui-datepicker.js"></script>
        <script src="js/funcionesEvidencias.js"></script> 
        <script>
        function Agrega(){
 
//obtenemos los valores de nuestra caja de texto
var codigo=document.getElementById("txt1").value;
var nombre=document.getElementById("txt2").value;
var precio=document.getElementById("txt3").value;
 
//creamos un objeto tr que anexaremos a nuestra tabla llamada tableProductos
var TR= document.createElement("tr");
 
//creamos 4 elementos td en donde iran los datos y uno cuarto donde ira un boton para eliminar
var TD1=document.createElement("td");
var TD2=document.createElement("td");
var TD3=document.createElement("td");
 
//asignamos los valores a nuestros td por medio del atributo innerHTML, el cual tiene el contenido HTML de un Nodo
TD1.innerHTML=codigo;
TD2.innerHTML=nombre;
TD3.innerHTML=precio;
TD4.innerHTML=isnn;
 
//A continuación asignamos contenido html a nuestro cuarto td
//esta es una forma de crear elementos tambien, dando el codigo html a un Nodo
//TD4.innerHTML="&lt;input type='button' value='Eliminar' onclick='Elimina(this)'&gt;"
 
//Ahora proseguimos a agregar los hijos TD al Padre TR
//Esta es otra manera de crear elementos HTML, por medio de el metodo appendChild
TR.appendChild(TD1);
TR.appendChild(TD2);
TR.appendChild(TD3);
 
//Por ultimo asignamos nuestro TR a la tabla con id tablaProductos
document.getElementById("tablaProductos2").appendChild(TR)
 
//limpiamos nuestros inputs para agregar ma datos, y ponemos el foco nuevamente en el input de codigo
document.getElementById("txt1").value=""
document.getElementById("txt2").value="";
document.getElementById("txt3").value="";
document.getElementById("txt1").focus();
}
            </script>
            <script>
                function Elimina(NodoBoton){
 
//recibimos el boton como parametro, obtendremos el tr que lo contiene de la siguiente manera
//Como nuestro boton es hijo de un td, y este td de el tr, debemos invocar dos veces parentNode
//Esto para llegar a tener el TR
var TR= NodoBoton.parentNode.parentNode;
 
//ahora que ya tenemos el padre TR, podemos eliminarlo de la siguiente manera
//junto a todos sus hijos
 
document.getElementById("tablaProductos").removeChild(TR);
}
            </script>
            <script>
function mySeccion1() {
  var x = document.getElementById("mySelect").value;
  var puntos = 0;
  if(x==="1"){
      puntos = 10;
  }else if(x==="2"){
      puntos = 20;
  }else if(x==="3"){
      puntos = 30;
  }else if(x==="4"){
      puntos = 40;
  }else if(x==="5"){
      puntos = 50;
  }
  document.getElementById("demo").innerHTML = "Puntos: " + puntos;
}
</script>
<script>
function mySeccion2() {
  var x = document.getElementById("mySelect2").value;
  var puntos = 0;
  if(x==="6"){
      puntos = 25;
  }else if(x==="7"){
      puntos = 50;
  }
  document.getElementById("demo2").innerHTML = "Puntos: " + puntos;
}
</script>
<script>
function mySeccion4() {
  var x = document.getElementById("mySelect4").value;
  var puntos = 0;
  if(x==="11"){
      puntos = 30;
  }else if(x==="12"){
      puntos = 50;
  }else if(x==="13"){
      puntos = 60;
  }else if(x==="14"){
      puntos = 70;
  }else if(x==="15"){
      puntos = 100;
  }
  document.getElementById("demo4").innerHTML = "Puntos: " + puntos;
}
</script>

<script>
function mySeccion9() {
    var codigo=document.getElementById("txt5").value;
var nombre=document.getElementById("txt6").value;
var precio=document.getElementById("txt7").value;
var isnn=document.getElementById("txt8").value;
  var puntos6 = 0;
 if(codigo!="" && nombre!="" && precio!="" && isnn!="" ){
      puntos6 = 25;
      var rows = document.getElementById('tablaProductos2').getElementsByTagName('tbody')[0].getElementsByTagName('tr').length;
  }
  document.getElementById("demo9").innerHTML = Filas"" + rows;
}
</script>
<script>
function mySeccion10() {
  var x = document.getElementById("mySelect10").value;
  var y = document.getElementById("mySelectDesem10").value;
  var z = document.getElementById("mySelectDictamen10").value;
  var z1 = document.getElementById("myCheckBox").checked;
  var z2 = document.getElementById("myCheckBox1").checked;
  var evidencias = document.getElementById("myEvidencias").value;
  
var codigo=document.getElementById("txtCodigo").value;
var nombre=document.getElementById("txtNombre").value;
var precio=document.getElementById("txtPrecio").value;
var isnn=document.getElementById("txtISNN").value;
  
  var puntos = 0;
  var puntos1 = 0;
  var puntos2 = 0;
  var puntos3 = 0;
  var puntos4 = 0;
  var puntos5 = 0;
  var puntos6 = 0;
  
  if(codigo!="" && nombre!="" && precio!="" && isnn!="" ){
      puntos6 = 25;
      var rows = document.getElementById('tablaProductos').getElementsByTagName('tbody')[0].getElementsByTagName('tr').length;
  }
  
  if(x==="41"){
      puntos = 5;
  }else if(x==="42"){
      puntos = 10;
  }else if(x==="43"){
      puntos = 15;
  }else if(x==="44"){
      puntos = 20;
  }else if(x==="45"){
      puntos = 25;
  }
  
  if(y==="46"){
      puntos1 = 25;
  }else if(y==="47"){
      puntos1 = 35;
  }else if(y==="48"){
      puntos1 = 50;
  }
  
  if(z==="46"){
      puntos2 = 10;
  }else if(z==="47"){
      puntos2 = 15;
  }else if(z==="48"){
      puntos2 = 25;
  }
  
  if(z1==true){
      puntos3 = 25;
  }
  
  if(z2==true){
      puntos4 = 25;
  }
  
  if(evidencias==="49"){
      puntos5 = 30;
  }else if(evidencias==="50"){
      puntos5 = 55;
  }else if(evidencias==="51"){
      puntos5 = 80;
  }else if(evidencias==="52"){
      puntos5 = 105;
  }else if(evidencias==="53"){
      puntos5 = 130;
  }else if(evidencias==="54"){
      puntos5 = 150;
  }
  
  document.getElementById("demo10").innerHTML = "Puntos: " + (puntos + puntos1 + puntos2 + puntos3 + puntos4 + puntos5);
}
</script>
<script>
        function Agrega1(){
 
//obtenemos los valores de nuestra caja de texto
var codigo=document.getElementById("txt1").value;
var nombre=document.getElementById("txt2").value;
var precio=document.getElementById("txt3").value;
var isnn=document.getElementById("txt4").value;
 
//creamos un objeto tr que anexaremos a nuestra tabla llamada tableProductos
var TR= document.createElement("tr");
 
//creamos 4 elementos td en donde iran los datos y uno cuarto donde ira un boton para eliminar
var TD1=document.createElement("td")
var TD2=document.createElement("td")
var TD3=document.createElement("td");
var TD4= document.createElement("td")
 
//asignamos los valores a nuestros td por medio del atributo innerHTML, el cual tiene el contenido HTML de un Nodo
TD1.innerHTML=codigo;
TD2.innerHTML=nombre;
TD3.innerHTML=precio;
TD4.innerHTML=isnn;
 
//A continuación asignamos contenido html a nuestro cuarto td
//esta es una forma de crear elementos tambien, dando el codigo html a un Nodo
//TD4.innerHTML="&lt;input type='button' value='Eliminar' onclick='Elimina(this)'&gt;"
 
//Ahora proseguimos a agregar los hijos TD al Padre TR
//Esta es otra manera de crear elementos HTML, por medio de el metodo appendChild
TR.appendChild(TD1);
TR.appendChild(TD2);
TR.appendChild(TD3);
TR.appendChild(TD4);
 
//Por ultimo asignamos nuestro TR a la tabla con id tablaProductos
document.getElementById("tablaProductos1").appendChild(TR)
 
//limpiamos nuestros inputs para agregar ma datos, y ponemos el foco nuevamente en el input de codigo
document.getElementById("txt1").value=""
document.getElementById("txt2").value="";
document.getElementById("txt3").value="";
document.getElementById("txt4").value="";
document.getElementById("txt1").focus();
}
</script>
<script>
function mySeccion6() {
    var codigo1=document.getElementById("txt1").value;
var nombre1=document.getElementById("txt2").value;
var precio12=document.getElementById("txt3").value;
var isnn1=document.getElementById("txt4").value;
  var puntosSeccion6 = 0;
 if(codigo1!="" && nombre1!="" && precio1!="" && isnn1!="" ){
      puntosSeccion6 = 25;
      var rows = document.getElementById('tablaProductos1').getElementsByTagName('tbody')[0].getElementsByTagName('tr').length;
  }
  document.getElementById("demo6").innerHTML = "Puntos: " + puntosSeccion6;
}
</script>
<script>
        function Agrega2(){
 
//obtenemos los valores de nuestra caja de texto
var codigo=document.getElementById("txt5").value;
var nombre=document.getElementById("txt6").value;
var precio=document.getElementById("txt7").value;
var isnn=document.getElementById("txt8").value;
 
//creamos un objeto tr que anexaremos a nuestra tabla llamada tableProductos
var TR= document.createElement("tr");
 
//creamos 4 elementos td en donde iran los datos y uno cuarto donde ira un boton para eliminar
var TD1=document.createElement("td")
var TD2=document.createElement("td")
var TD3=document.createElement("td");
var TD4= document.createElement("td")
 
//asignamos los valores a nuestros td por medio del atributo innerHTML, el cual tiene el contenido HTML de un Nodo
TD1.innerHTML=codigo;
TD2.innerHTML=nombre;
TD3.innerHTML=precio;
TD4.innerHTML=isnn;
 
//A continuación asignamos contenido html a nuestro cuarto td
//esta es una forma de crear elementos tambien, dando el codigo html a un Nodo
//TD4.innerHTML="&lt;input type='button' value='Eliminar' onclick='Elimina(this)'&gt;"
 
//Ahora proseguimos a agregar los hijos TD al Padre TR
//Esta es otra manera de crear elementos HTML, por medio de el metodo appendChild
TR.appendChild(TD1);
TR.appendChild(TD2);
TR.appendChild(TD3);
TR.appendChild(TD4);
 
//Por ultimo asignamos nuestro TR a la tabla con id tablaProductos
document.getElementById("tablaProductos2").appendChild(TR)
 
//limpiamos nuestros inputs para agregar ma datos, y ponemos el foco nuevamente en el input de codigo
document.getElementById("txt5").value=""
document.getElementById("txt6").value="";
document.getElementById("txt7").value="";
document.getElementById("txt8").value="";
document.getElementById("txt5").focus();
}
</script>
<script>
function mySeccion8() {
  var txtmySelect8 = document.getElementById("mySelect8").value;
  var txtperiodoTutoria = document.getElementById("periodoTutoria").value;
  var puntos8 = 0;
  if(txtmySelect8==="30" && txtperiodoTutoria!=""){
      puntos8 = 35;
  }else if(txtmySelect8==="31" && txtperiodoTutoria!=""){
      puntos8 = 70;
  }
  document.getElementById("demo8").innerHTML = "Puntos: " + puntos8;
}
</script>
<script>
function mySeccion5() {
  var txtMyCheck= document.getElementById("check").checked;
  var txtCapacitacion = document.getElementById("myCapacitacion").value;
  var puntosCapacitacion = 0;
  if(txtMyCheck == true && txtCapacitacion === "17"){
      puntosCapacitacion = 50;
  }else if(txtMyCheck == true && txtCapacitacion === "18"){
      puntosCapacitacion = 60;
  }else if(txtMyCheck == true && txtCapacitacion === "19"){
      puntosCapacitacion = 70;
  }else if(txtMyCheck == false && txtCapacitacion === "17"){
      puntosCapacitacion = 40;
  }else if(txtMyCheck == false && txtCapacitacion === "18"){
      puntosCapacitacion = 50;
  }else if(txtMyCheck == false && txtCapacitacion === "19"){
      puntosCapacitacion = 60;
  }else if(txtMyCheck == true && txtCapacitacion != ""){
      puntosCapacitacion = 10;
  }else if(txtMyCheck == false){
      puntosCapacitacion = 0;
  }else if(txtMyCheck == true){
      puntosCapacitacion = 10;
  }
  document.getElementById("demo5").innerHTML = "Puntos: " + puntosCapacitacion;
}
</script>
    </body>
</html>

