<%-- 
    Document   : registro
    Created on : 8 jun 2020, 14:51:58
    Author     : David Reyna
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import='herramientas.Catalogos'%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="es">
    <head>
        <title>Evidencias Registro JSP</title>
        <meta charset="UTF-8"/>
        <meta http-equiv="X-UA-Compatible" content="IE=edge"/>
        <meta name="viewport" content="width=device-width, initial-scale=1.0"/>        
        <link href="https://framework-gb.cdn.gob.mx/assets/styles/main.css" rel="stylesheet"/>        
        <link href="css/estilos.css" rel="stylesheet"/>
        <jsp:useBean id="docente" scope="session" class="com.aplicacion.beans.Docente" />
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
                      <li><a href="#">Inicio</a></li>                          
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
                <li><a href="#">UEMSTIS</a></li>
                <li><a href="#">Promoción Docente</a></li>
                <li class="active">Registro de aspirante</li>
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
                      <a data-parent="#accordion" data-toggle="collapse" href="#infoAcademica" aria-expanded="true" aria-controls="infoAcademica">
                      Información Académica
                      </a>
                    </h4>
                    <button type="button" class="collpase-button collapsed" data-parent="#accordion" data-toggle="collapse" href="#infoAcademica"></button>
                  </div>
                  <div class="panel-collapse collapse in" id="infoAcademica">
                    <div class="panel-body">
                      <form id="formInfoAcademica" role="form" action="RegistroInfoAcademica" method="POST">
                        <div class="row">
                            <div class="form-group col-md-3">
                              <!--<input type="text" value="${Docente.rfc}" />-->                                
                              <label class="control-label" for="entidad">Entidad de estudio:</label>
                              <select class="form-control input-sm" id="entidad" name="entidad" onchange="actualizarTipoInstitucion()" required>
                                  <%=new Catalogos().desplegarOpcionesEstado()%>
                              </select>
                            </div>
                            <div class="form-group col-md-3">
                              <label class="control-label" for="tipoInstitucion">Tipo de institución:</label>
                              <select class="form-control input-sm" id="tipoInstitucion" name="tipoInstitucion" onchange="actualizarInstitucion()" required>
                                <option value="">-Seleccione-</option>                                
                              </select>
                            </div>                            
                            <div class="form-group col-md-3">
                              <label class="control-label" for="institucion">Institución:</label>
                              <select class="form-control input-sm" id="institucion" name="institucion" onchange="cambioInstitucion()" required>
                                <option value=''>-Seleccione-</option>
                              </select>
                            </div>
                            <div class="form-group col-md-3">
                              <label class="control-label" for="cct">CCT:</label>
                              <select class="form-control input-sm" id="cct" name="cct">
                                <option value=''>-Seleccione-</option>
                              </select>
                            </div>
                        </div>
                        <div class="row">
                            <div class="form-group col-md-3">
                              <label class="control-label" for="escuela">Escuela o Facultad:</label>
                              <select class="form-control input-sm" id="escuela" name="escuela" required
                                      >
                                <option value=''>-Seleccione-</option>
                              </select>
                            </div>
                            <div class="form-group col-md-3">
                              <label class="control-label" for="grado">Grado Académico:</label>
                              <select class="form-control input-sm" id="grado" name="grado" required>
                                <%=new Catalogos().desplegarOpcionesGrado()%>
                              </select>
                            </div>
                            <div class="form-group col-md-3">
                              <label class="control-label" for="carrera">Carrera:</label>                              
                              <input type="text" class="form-control input-sm" id="carrera" name="carrera" required>
                              <!--<select class="form-control input-sm" id="carrera" name="carrera">
                                <option>-Seleccione-</option>
                              </select>-->
                            </div>
                            <div class="form-group col-md-3">
                              <label class="control-label" for="egreso">Año de egreso:</label>
                              <input type="text" class="form-control input-sm" id="egreso" name="egreso" pattern="[0-9]{4}" maxlength="4" required>
                            </div>
                        </div>
                        <div class="row">
                            <div class="form-group col-md-3">
                              <label class="control-label" for="modalidad">Modalidad de Titulación:</label>
                              <select class="form-control input-sm" id="modalidad" name="modalidad" required>
                                <%=new Catalogos().desplegarOpcionesModalidadTitulacion()%>
                              </select>
                            </div>
                            <div class="form-group col-md-3">
                              <label class="control-label" for="titulacion">Año de titulación:</label>
                              <input type="text" class="form-control input-sm" id="titulacion" name="titulacion" pattern="[0-9]{4}" maxlength="4" required>
                            </div>                            
                            <div class="form-group col-md-3">
                              <label class="control-label" for="btnEvidencia1">Título:</label>
                              <a title="Ver ejemplo" onclick="abrirModalEjemplo(1)">
                                <span class="glyphicon glyphicon-picture"></span>
                              </a><br/>                          
                              <input id="btnEvidencia1" type="button" class="btn btn-sm btn-link" value="Subir archivo" onclick="abrirModalArchivo(1)"/>
                            </div> 
                            <div class="form-group col-md-3">
                              <label class="control-label" for="documento">Documento comprobatorio:</label>
                              <select class="form-control input-sm" id="documento" name="documento" onchange="cambioDocumento(this)" required>
                                  <option value="">-Seleccionar-</option>
                                  <option value="acta">Acta de grado</option>
                                  <option value="cedula">Cédula profesional</option>
                              </select>
                            </div>
                        </div>
                        <div class="row">
                            <div id="seccionCedula" hidden="true">
                                <div class="form-group col-md-3">
                                  <label class="control-label" for="cedula">Número de Cédula:</label>
                                  <input type="text" class="form-control input-sm" id="cedula" name="cedula">
                                </div>
                                <div class="form-group col-md-3">
                                  <label class="control-label" for="btnEvidencia8">Cédula profesional:</label>
                                  <a title="Ver ejemplo" onclick="abrirModalEjemplo(8)"><span class="glyphicon glyphicon-picture"></span></a><br/>                          
                                  <input id="btnEvidencia8" type="button" class="btn btn-sm btn-link" value="Subir archivo" onclick="abrirModalArchivo(8)"/>
                                </div> 
                            </div>
                        </div>                        
                        <div class="col-xs-12 text-right">
                          <input  class="btn btn-sm btn-primary" type="reset" value="Limpiar"/>
                          <input class="btn btn-sm btn-primary" id="btnEnviar1" type="submit" value='Guardar y continuar'/>
                          <!--<input type="button" class="btn btn-sm btn-primary" value="Guardar y continuar" onclick="mostrarSiguiente(1)"/>-->
                        </div>
                      </form>
                    </div>
                  </div>
                </div>

                <div class="panel panel-default" id="panelInfoLaboral" >
                  <div class="panel-heading">
                    <h4 class="panel-title">
                      <a data-parent="#accordion" data-toggle="collapse" href="#infoLaboral" aria-expanded="true" aria-controls="infoLaboral">
                      Información Laboral
                      </a>
                    </h4>
                    <button type="button" class="collpase-button collapsed" data-parent="#accordion" data-toggle="collapse" href="#infoLaboral"></button>
                  </div>
                  <div class="panel-collapse collapse" id="infoLaboral">
                    <div class="panel-body">
                      <form id="formInfoLaboral" role="form" action="RegistroInfoLaboral" method="POST">                      
                        <div class="row">
                            <div class="checkbox col-xs-12">
                              <label><input type="checkbox" checked="true" id="activoServicio" name="activoServicio" data-toggle="collapse" data-target="#seccionActivoServicio">Activo en Servicio</label>
                            </div>
                        </div>
                        <div id="seccionActivoServicio" class="collapse in">
                            <div class="row">
                                <div class="form-group col-md-3 datepicker-group">
                                  <label class="control-label" for="ingresoSubsistema">Fecha de ingreso al subsistema:</label>
                                  <input type="text" class="form-control input-sm" id="ingresoSubsistema" name="ingresoSubsistema" required>

                                </div>
                                <div class="form-group col-md-3 datepicker-group">
                                  <label class="control-label" for="ingresoPlantel">Fecha de ingreso al plantel:</label>
                                  <input class="form-control input-sm" id="ingresoPlantel" name="ingresoPlantel" type="text" required>

                                </div>
                                <div class="form-group col-md-3">
                                  <label class="control-label" for="plantel">Plantel:</label>
                                  <select class="form-control input-sm" id="plantel" name="plantel" onchange="cambioPlantel()" required>
                                    <%=new Catalogos().desplegarOpcionesPlanteles()%>
                                  </select>
                                </div>
                                <div class="form-group col-md-3">
                                  <br/>
                                  <span class="text-danger" id="marginacion"></span>
                                </div>  
                            </div>
                            <div class="row">
                                <div class="form-group col-md-3">
                                  <label class="control-label" for="categoria">Categoría actual:</label>
                                  <select class="form-control input-sm" id="categoria" name="categoria" onchange="cambioCategoria()" required>
                                    <%=new Catalogos().desplegarOpcionesCategorias()%>
                                  </select>                          
                                </div>
                                <div class="form-group col-md-3">
                                  <label class="control-label" for="jornada">Tipo de jornada:</label>
                                  <select class="form-control input-sm" id="jornada" name="jornada" required>
                                      <option value=''>-Seleccione-</option>
                                  </select>                          
                                </div>
                                <div class="form-group col-md-3 datepicker-group">
                                  <label class="control-label" for="fechaPlaza" style="font-size: 12px;">Fecha desde que ostenta la plaza:</label>
                                  <input class="form-control input-sm" id="fechaPlaza" name="fechaPlaza" type="text" required>

                                </div>
                                <div class="form-group col-md-3">
                                  <label class="control-label" for="tipoNombramiento">Tipo de nombramiento:</label>
                                  <select class="form-control input-sm" id="tipoNombramiento" name="tipoNombramiento" required>
                                    <%=new Catalogos().desplegarOpcionesTipoNombramiento()%>
                                  </select>                          
                                </div>                                
                            </div>
                            <div class="row"> 
                                <div class="form-group col-md-3 datepicker-group">
                                  <label class="control-label" for="fechaPromocion">Fecha de su última promoción:</label>
                                  <input class="form-control input-sm" id="fechaPromocion" name="fechaPromocion" type="text" required>
                                </div>
                                <div class="form-group col-md-3">
                                    <label class="control-label" for="btnEvidencia2">Constancia de antiguedad:</label>
                                    <a title="Ver ejemplo" onclick="abrirModalEjemplo(2)"><span class="glyphicon glyphicon-picture"></span></a><br/>  
                                    <input id="btnEvidencia2" type="button" class="btn btn-sm btn-link" value="Subir archivo" onclick="abrirModalArchivo(2)"/>                          
                                </div> 
                                <div class="form-group col-md-6">
                                    <label class="control-label" for="btnEvidencia3">Constancia de nombramiento definitivo:</label>  
                                    <a title="Ver ejemplo" onclick="abrirModalEjemplo(3)"><span class="glyphicon glyphicon-picture"></span></a><br/>
                                    <input id="btnEvidencia3" type="button" class="btn btn-sm btn-link" value="Subir archivo" onclick="abrirModalArchivo(3)"/>
                                </div>                             
                            </div>
                            <div class="row">
                                <div class="form-group col-md-3">
                                  <label class="control-label" for="categoriaAspira">Categoría a la que aspira:</label>
                                  <select class="form-control input-sm" id="categoriaAspira" name="categoriaAspira" onchange="cambioCategoriaAspira()" required>
                                     <%=new Catalogos().desplegarOpcionesCategorias()%>
                                  </select>                          
                                </div>
                                <div class="form-group col-md-3">
                                  <label class="control-label" for="jornadaAspira">Tipo de jornada:</label>
                                  <select class="form-control input-sm" id="jornadaAspira" name="jornadaAspira" required>
                                      <option value=''>-Seleccione-</option>
                                  </select>                          
                                </div>
                                <div class="form-group col-md-6" id="rbRequisitos">
                                    
                                </div>
                            </div>
                            <div class="row">
                                <div class="checkbox col-md-6">
                                    <label><input type="checkbox" id="notaDesfavorable" name="notaDesfavorable" data-toggle="collapse" data-target="#seccionNota" >Marque la casilla si cuenta con nota desfavorable y/o sanción administrativa</label>
                                </div>
                                <div id="seccionNota" class="form-group col-md-6 collapse in">
                                    <label class="control-label" for="btnEvidencia6">Constancia de nota favorable:</label>
                                    <a title="Ver ejemplo" onclick="abrirModalEjemplo(6)"><span class="glyphicon glyphicon-picture"></span></a><br/> 
                                    <input id="btnEvidencia6" type="button" class="btn btn-sm btn-link" value="Subir archivo" onclick="abrirModalArchivo(6)"/>
                                </div> 
                            </div>
                        </div>
                        <div class="col-xs-12 text-right">
                          <button class="btn btn-sm btn-primary" type="reset">Limpiar</button>
                          <input class="btn btn-sm btn-primary" id="btnEnviar2" type="submit" value='Guardar y continuar'/>
                          
                        </div>
                      </form>
                    
                  </div>
                </div>
                </div>
                <div class="panel panel-default" id="panelInfoHoras">
                  <div class="panel-heading">
                    <h4 class="panel-title">
                      <a data-parent="#accordion" data-toggle="collapse" href="#infoHoras" aria-expanded="true" aria-controls="infoHoras">
                      Horas frente a grupo
                      </a>
                    </h4>
                    <button type="button" class="collpase-button collapsed" data-parent="#accordion" data-toggle="collapse" href="#infoHoras"></button>
                  </div>
                  <div class="panel-collapse collapse" id="infoHoras">
                    <div class="panel-body">
                      <form role="form" id="formInfoHorasGrupo" action="RegistroInfoCENNI" method="POST">
                        <div class="checkbox col-md-6">
                          <label><input type="checkbox" checked="true" name="frenteGrupo" id="frenteGrupo" data-toggle="collapse" data-target="#seccionHoras">Marque la casilla si actualmente se encuentra frente a grupo</label>
                        </div>  
                        <div id="seccionHoras" class="collapse in">
                            <div class="form-group col-md-3">
                              <label class="control-label" for="numHoras">Horas frente a grupo:</label>
                              <input type="text" class="form-control input-sm" id="numHoras" name="numHoras" value="${Docente.getTotalHoras()}"  required>
                            </div>
                            <div class="form-group col-md-3">
                              <label class="control-label" for="numGrupos">Número de grupos:</label>
                              <input type="text" class="form-control input-sm" id="numGrupos" name="numGrupos" value="${Docente.getNumGrupos()}"  required>
                            </div>
                            <div class="text-center">
                              <input type="button" class="btn btn-link btn-sm" value="(+) Agregar información" data-toggle="modal" data-target="#modalInformacion"/>
                            </div>
                            <div class="table-responsive">
                              <table class="table table-striped table-bordered">
                                <tr>
                                  <th>Información</th>                              
                                  <th>Opciones</th>                        
                                </tr>
                                <tbody id="tablaInfo">
                                    <!--<td colspan="2" class="text-center"><p class="text-danger">Sin información</p></td>-->
                                    <c:forEach items="${Docente.getListaHoras()}" var="hora">
                                        <tr>
                                            <td>
                                                Periodo: <c:out value="${hora[2]}"/><br/>
                                                <c:if test = "${hora[7] == 'A'}">
                                                    <c:out value="Componente básico y/o propedéutico: "/> 
                                                </c:if>
                                                <c:if test = "${hora[7] == 'S'}">
                                                    <c:out value="Componente profesional: "/> 
                                                </c:if>
                                                <c:if test = "${hora[7] == 'T'}">
                                                    <c:out value="Taller: "/> 
                                                </c:if> 
                                                <c:if test = "${hora[5] != null}">
                                                    <c:out value="${hora[5]}"/> - 
                                                </c:if>
                                                <c:out value="${hora[4]}"/><br/>
                                                Grupo: <c:out value="${hora[10]}"/><br/>                                                
                                                Semestre: <c:out value="${hora[6]}"/><br/>
                                                Horas: <c:out value="${hora[9]}"/><br/>
                                            </td>
                                            <td class="text-center">
                                                <button type="button" class="btn btn-sm" title="Borrar" onclick="borrarHoraGrupo(<c:out value="${hora[0]}"/>)">
                                                    <span class="glyphicon glyphicon-trash"></span>
                                                </button>                                                
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>                                
                              </table>
                            </div>
                            <div class="row" id="seccionCENNI" hidden>
                                <div class="form-group col-md-3">
                                  <label class="control-label" for="nivelCENNI">Nivel de Inglés CENNI:</label>
                                  <input type="text" class="form-control input-sm" id="nivelCENNI" name="nivelCENNI" pattern="[0-9]+">                          
                                </div>
                                <div class="form-group col-md-3">
                                  <label class="control-label" for="folio">Folio CENNI:</label>
                                  <input type="text" class="form-control input-sm" id="folio" name="folio">
                                </div>
                                <div class="form-group col-md-6">
                                    <label class="control-label" for="btnEvidencia5">Constancia CENNI:</label>
                                    <a title="Ver ejemplo" onclick="abrirModalEjemplo(5)"><span class="glyphicon glyphicon-picture"></span></a><br/> 
                                    <input id="btnEvidencia5" type="button" class="btn btn-sm btn-link" value="Subir archivo" onclick="abrirModalArchivo(5)"/>                                                    
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="control-label" for="btnEvidencia4">Constancia de horas frente a grupo:</label>  
                                <a title="Ver ejemplo" onclick="abrirModalEjemplo(4)"><span class="glyphicon glyphicon-picture"></span></a><br/>
                                <input id="btnEvidencia4" type="button" class="btn btn-sm btn-link" value="Subir archivo" onclick="abrirModalArchivo(4)"/>
                            </div>
                        </div>
                        <div class="col-xs-12 text-right">
                          <button class="btn btn-sm btn-primary" type="reset">Limpiar</button>                          
                          <input class="btn btn-sm btn-primary" id="btnEnviar3" type="submit" value='Guardar y continuar'/>
                        </div>
                      </form>
                    </div>
                  </div>
                </div>
                <div class="panel panel-default" id="panelInfoCompatibilidad" >
                  <div class="panel-heading">
                    <h4 class="panel-title">
                      <a data-parent="#accordion" data-toggle="collapse" href="#infoCompatibilidad" aria-expanded="true" aria-controls="infoCompatibilidad">
                      Compatibilidad
                      </a>
                    </h4>
                    <button type="button" class="collpase-button collapsed" data-parent="#accordion" data-toggle="collapse" href="#infoCompatibilidad"></button>
                  </div>
                  <div class="panel-collapse collapse" id="infoCompatibilidad">
                    <div class="panel-body">
                      <form role="form" id="formInfoCompatibilidad" method="POST" action="RegistroInfoCompatibilidad">                        
                        <div class="checkbox col-xs-12">
                          <label><input data-toggle="collapse" data-target="#seccionOtro" type="checkbox" name="funcionesOtro">Marque la casilla si desempeña funciones en otro subsistema</label>
                        </div>
                        <div id="seccionOtro" class="collapse" >
                            <div class="form-group col-md-3">
                              <label class="control-label" for="numHorasOtro">Número de horas:</label>
                              <input type="text" class="form-control input-sm" id="numHorasOtro" name="numHorasOtro" required>
                            </div>
                            <div class="checkbox col-md-4">
                              <label><input data-toggle="collapse" data-target="#seccionCompatibilidad" type="checkbox" checked="true" name="compatibilidad" id="compatibilidad">Marque la casilla si cuenta con la compatibilidad requerida</label>
                            </div>
                            <div id="seccionCompatibilidad" class="collapse in" >
                                <div class="form-group col-md-4">
                                    <label class="control-label" for="btnEvidencia7">Constancia de compatibilidad:</label>  
                                    <a title="Ver ejemplo" onclick="abrirModalEjemplo(7)"><span class="glyphicon glyphicon-picture"></span></a><br/>
                                    <input id="btnEvidencia7" type="button" class="btn btn-sm btn-link" value="Subir archivo" onclick="abrirModalArchivo(7)"/>                          
                                </div> 
                            </div>
                        </div>
                        <div class="col-xs-12 text-right">
                          <button class="btn btn-sm btn-primary" type="reset">Limpiar</button>
                          <input class="btn btn-sm btn-primary" id="btnEnviar4" type="submit" value='Guardar y continuar'/>                          
                        </div>
                      </form>
                    </div>
                  </div>
                </div>
                
              </div>
              <!--FIN Paneles colapsables-->
          </div>
                            
         <!--MODAL-->                 
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
         
         <div id="modalEjemplo" class="modal fade" role="dialog">
            <div class="modal-dialog">
              <div class="modal-content">
                <div class="modal-header">
                  <button type="button" class="close" data-dismiss="modal">&times;</button>
                  <h4 class="modal-title" id="tituloModalEjemplo">Carga de archivos</h4>
                </div>
                <div class="modal-body">
                    <iframe style="width:100%;" id="ifArchivoEjemplo" name="ifArchivoEjemplo" src=""></iframe>
                                       
                </div>
                <div class="modal-footer">
                  <button type="button" class="btn btn-sm btn-default" data-dismiss="modal">Cerrar</button>
                </div>
              </div>
            </div>
          </div>
         
         
         <div id="modalInformacion" class="modal fade" role="dialog">
            <div class="modal-dialog">
              <div class="modal-content">
                <div class="modal-header">
                  <button type="button" class="close" data-dismiss="modal">&times;</button>
                  <h4 class="modal-title">Registro información</h4>
                </div>
                <div class="modal-body">
                    <div class="container-fluid">
                        
                        <form id="formHorasGrupo" role="form" method="POST" action="RegistroHorasGrupo">
                            <div class="form-group col-md-6" >
                                <label class="control-label" for="periodo">Periodo:</label>
                                <select class="form-control input-sm" id="periodo" name="periodo" required>
                                    <%=new Catalogos().desplegarPeriodos()%>                                        
                                </select>                          
                            </div>
                            <div class="form-group col-md-6">
                                <label class="control-label" for="grupo">Grupo:</label>
                                <input type="text" class="form-control input-sm" id="grupo" name="grupo" required>                                                                 
                            </div>
                            <div class="form-group col-md-6" id="divSemestre">
                                <label class="control-label" for="semestre">Semestre:</label>
                                <select class="form-control input-sm" id="semestre" name="semestre" required>
                                    <option value="">-Seleccione-</option>
                                    <option value="1">1</option>
                                    <option value="2">2</option>
                                    <option value="3">3</option>
                                    <option value="4">4</option>
                                    <option value="5">5</option>
                                    <option value="6">6</option>
                                </select>                          
                            </div>
                            <div class="form-group col-md-6">
                                <label class="control-label" for="tipoInfo">Tipo de información:</label>
                                <select class="form-control input-sm" id="tipoInfo" name="tipoInfo" onchange="cambioTipoInfo()" required>
                                    <option value="">-Seleccione-</option>
                                    <option value="cbp">Componente básico y/o propedeútico</option>
                                    <option value="cp">Componente profesional</option>
                                    <option value="tl">Taller / laboratorio</option>
                                </select>                          
                            </div>
                            <div class="form-group col-md-6" id="divVersion" hidden>
                                <label class="control-label" for="version">Versión:</label>
                                <select class="form-control input-sm" id="version" name="version">
                                    <option value="">-Seleccione-</option>                                        
                                </select>                          
                            </div>                            
                            <div class="form-group col-md-6" id="divAsignatura" hidden>
                                <label class="control-label" for="asignatura" >Asignatura:</label>
                                <select class="form-control input-sm" id="asignatura" name="asignatura" onchange="cambioAsignatura()">
                                    <option value="">-Seleccione-</option>                                        
                                </select>                          
                            </div>
                            <div class="form-group col-md-6" id="divCarrera" hidden>
                                <label class="control-label" for="carrera_cp">Carrera:</label>
                                <select class="form-control input-sm" id="carrera_cp" name="carrera_cp" onchange="cambioCarreraCP()">
                                    <option value="">-Seleccione-</option>                                        
                                </select>                          
                            </div>
                            <div class="form-group col-md-6" id="divModulo" hidden>
                                <label class="control-label" for="modulo">Modulo:</label>
                                <select class="form-control input-sm" id="modulo" name="modulo" onchange="cambioModulo()">
                                    <option value="">-Seleccione-</option>                                        
                                </select>                          
                            </div>
                            <div class="form-group col-md-6" id="divSubmodulo" hidden>
                                <label class="control-label" for="submodulo">Submodulo:</label>
                                <select class="form-control input-sm" id="submodulo" name="submodulo" onchange="cambioSubmodulo()">
                                    <option value="">-Seleccione-</option>                                        
                                </select>                          
                            </div>
                            <div id="divTaller" hidden>
                                <div class="form-group col-md-6">
                                    <label class="control-label" for="taller">Taller / laboratorio:</label>
                                    <select class="form-control input-sm" id="taller" name="taller">
                                        <%=new Catalogos().desplegarTalleres()%>                                        
                                    </select>                          
                                </div>
                                
                            </div>
                            <div class="form-group col-md-6">
                                <label class="control-label" for="horas">Horas:</label>
                                <input type="text" class="form-control input-sm" id="horas" name="horas" required>                                                                 
                            </div>
                            <div class="col-xs-12 text-center">
                                <input type="button" class="btn btn-primary btn-sm" value="Cancelar" data-dismiss="modal"/>
                                <input class="btn btn-sm btn-primary" id="btnEnviarHG" type="submit" value='Registrar'/>
                                                                   
                            </div>
                        </form>
                    </div>                                       
                </div>
                <!--<div class="modal-footer">
                  <button type="button" class="btn btn-sm btn-default" data-dismiss="modal">Cerrar</button>
                </div>-->
              </div>
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
       
         
         <!--FIN MODAL-->                   
                
        </main>
        <script src="https://framework-gb.cdn.gob.mx/gobmx.js"></script>        
        <script src="https://code.jquery.com/jquery-1.12.4.js"></script>      
        <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>  
        <script src="https://framework-gb.cdn.gob.mx/assets/scripts/jquery-ui-datepicker.js"></script>
        <script src="http://ajax.aspnetcdn.com/ajax/jquery.validate/1.13.1/jquery.validate.min.js"></script>
        <script src="js/funciones.js"></script> 
        <script>
            $( function() {
            var availableTags = [
              <%=new Catalogos().consultarCarreras()%>
            ];
            $( "#carrera" ).autocomplete({
              source: availableTags
            });
            if(${Docente.getBanderaIngles()}){
                $("#seccionCENNI").removeAttr("hidden");
                $("#nivelCENNI").attr("required","true");
                $("#folio").attr("required","true");
            }else{
                $("#seccionCENNI").attr("hidden","true");
                $("#nivelCENNI").removeAttr("required");
                $("#nivelCENNI").val("");
                $("#folio").removeAttr("required");
                $("#folio").val("");
            } 
          } );
        </script>
    </body>
</html>

