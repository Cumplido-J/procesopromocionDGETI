<%-- 
    Document   : FichaRegistroClon
    Created on : 21-sep-2021, 17:12:18
    Author     : Jonathan Trinidad de Lazaro
--%>

<%@page import="java.util.List"%>
<%@page import="metodos_sql.Metodos_sql"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import='herramientas.Imagen'%>
<%@page import='herramientas.RutaConfig'%>
<%@page import='herramientas.Catalogos'%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix ="fmt"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
    <head>        
        <title>DGETI | gob.mx</title>
        <meta charset="UTF-8">        
        <jsp:useBean id="fecha" class="herramientas.Fecha" />      
        <jsp:useBean id="now" class="java.util.Date" />
        <jsp:useBean id="catalogoC" class="herramientas.Catalogos" />
        <fmt:formatDate var="fechaYear" value="${now}" type="both" dateStyle="long" pattern="yyyy" />
        <style>
            .borde{
                border: 1px solid black;                
            }
        </style>
        <c:if test='${sessionScope["rol"]=="D"}'>
            <c:if test = "${Docente.documentoCargado3('1')==false && !banderaIdUsuarioPadre }">
            <%
                response.sendRedirect("/procesopromocion/SesionDocente");
            %>
            </c:if>       
        </c:if> 
    </head>
    <body style="width:800px; font-family:Verdana;">
        <table >
            <tr>
                <td valign="top"><img width="200" src="<%=Imagen.muestraImagen(RutaConfig.getRutaCarpeta()+"logos/sems.png")%>"></td>
                <td style="text-align:center;">
                    Convocatoria para el proceso de promoción en el servicio docente por 
                      <c:if test='${sessionScope["programa"]=="1"}'>
                      cambio de categoría  
                      </c:if>
                      <c:if test='${sessionScope["programa"]=="2"}'>
                      horas adicionales 
                      </c:if>
                       <c:if test='${sessionScope["programa"]=="3"}'>
                      incentivos
                      </c:if>
                    en Educación Media Superior
                    <br/>(Promoción horizontal)
                    <br/><%--<jsp:include page="seccionesPlantilla/cicloEscolar.jsp" flush="true"/>--%>
                    Ciclo Escolar 
                    <c:if test='${idUsuarioPadrePeriodo == 1}'>
                    ${catalogoC.getCatalogoCicloEscolar(Docente.infoRegistro[82])}
                    </c:if>  
                    <c:if test='${idUsuarioPadrePeriodo == 0}'>
                    ${catalogoC.getCatalogoCicloEscolar(Docente1.infoRegistro[84])}
                    </c:if> 
                </td>
                <%
                    String rutaLogo = (String) request.getAttribute("rutaimagen");
                %>
                <td valign="top"><img width="200" src="<%=Imagen.muestraImagen(RutaConfig.getRutaCarpeta()+rutaLogo)%>"></td>
            </tr>
        </table> 
        <center><p>FICHA DE REGISTRO</p></center>
        <div style="font-size: 12px">
            <p>Imprimir y conservar esta ficha.</p>
            <hr/>            
            <p>DATOS DEL PARTICIPANTE</p>
            <table >
                <tr>
                    <td>FOLIO</td>                    
                    <td>:${Docente.infoRegistro[76]}</td>
                </tr>
                <!--<tr>
                    <td>CURP</td>
                    <td>:</td>
                </tr>-->
                <tr>
                    <td>RFC</td>
                    <td>:${Docente.infoRegistro[5]}</td>
                </tr>
                <tr>
                    <td>NOMBRE</td>
                    <td>:${Docente.infoRegistro[1]}</td>
                </tr>
                <tr>
                    <td>PRIMER APELLIDO</td>
                    <td>:
                        <c:if test='${Docente.infoRegistro[2]!=null}'>
                      ${Docente.infoRegistro[2]}
                      </c:if>
                      <c:if test='${Docente.infoRegistro[2] == null}'>
                      ----------------------------
                      </c:if>  
                    </td>
                </tr>
                <tr>
                    <td>SEGUNDO APELLIDO</td>
                    <td>:
                        <c:if test='${Docente.infoRegistro[3]!=null}'>
                      ${Docente.infoRegistro[3]}
                      </c:if>
                      <c:if test='${Docente.infoRegistro[3] == null}'>
                      ----------------------------
                      </c:if> 
                    </td>
                </tr>
                <tr>
                    <td>CORREO ELECTRÓNICO</td>
                    <td>:${Docente.infoRegistro[4]}</td>
                </tr>
                <tr>
                    <td>ENTIDAD</td>
                    <td>:${Docente.infoRegistro[8]}</td>
                </tr>
                <tr>
                    <td>CENTRO DE TRABAJO</td>
                    <td>:${Docente.infoRegistro[9]}-${Docente.infoRegistro[10]}</td>
                </tr>
              
                <tr>
                    <td>GRADO ACADÉMICO REQUERIDO</td>
                    <td>:${Docente.infoRegistro[47]}</td>
                </tr>
                <tr>
                    <td>GRADO ACADÉMICO QUE OSTENTA</td>
                    <fmt:parseNumber var = "anioTitulacion" type = "number" value = "${Docente.infoRegistro[23]}" />                    
                     <td>:${fechaYear-anioTitulacion} años de haber obtenido el título de ${Docente.infoRegistro[20]}</td>
                </tr>
                <tr>
                    <td>PERFIL PROFESIONAL (CARRERA)</td>
                    <td>:${Docente.infoRegistro[17]}</td>
                </tr>
                <!--<tr>
                    <td>ASIGNATURA/COMPONENTE PROFESIONAL/LABORATORIO O TALLER</td>
                    <td>:</td>
                </tr>-->
                                
                <tr>
                    <td>DOCENTE ACTIVO EN SERVICIO</td>
                    <td>:<c:out value="${Docente.infoRegistro[25] eq 'S' ? 'SI': 'NO'}"/></td>
                </tr>
                <tr>
                    <td>FECHA DE INGRESO AL SUBSISTEMA </td>
                    <td>:${fecha.formatoImprimir(Docente.infoRegistro[26])}</td>
                </tr>
                <tr>
                    <td>FECHA DE INGRESO AL PLANTEL</td>
                    <td>:${fecha.formatoImprimir(Docente.infoRegistro[27])}</td>
                </tr> 
                <c:if test='${Docente1.infoRegistro[85]!=null }'>
                    <tr>
                        <td>PLAZA QUE OSTENTA:</td>
                        <td>:${Docente.infoRegistro[29]}-${Docente.infoRegistro[31]}-${Docente.infoRegistro[33]}-${Docente1.infoRegistro[86]}</td>
                    </tr>
                    <c:if test='${infoCategoria == null }'>
                        <tr>
                        <td>CATEGORÍA A LA QUE ASPIRA</td>
                            <td>:${Docente.infoRegistro[41]}-${Docente.infoRegistro[43]}-${Docente.infoRegistro[45]}</td>
                        </tr>
                    </c:if>
                    <c:if test='${infoCategoria !=null }'>
                    <tr>
                    <td>CATEGORÍA A LA QUE ASPIRA</td>
                        <c:forEach items="${infoCategoria}" var="infoCategoria">
                            <td>:${infoCategoria[2]}-${infoCategoria[0]}-${infoCategoria[1]}</td>
                        </c:forEach>    
                    </tr>
                    </c:if>
                </c:if>
                <tr>
                    <td COLSPAN="2">

                        <table>
                             <c:if test='${Docente1.infoRegistro[85]==null && infoPlazasAspira != null && sessionScope["programa"]=="2"}'>
                            <tr><th class="borde" COLSPAN="6">PLAZAS QUE OSTENTA:</th> </tr>
                            </c:if>
                            <tr><th class="borde">CLAVE PRESUPUESTAL</th><th class="borde">FECHA DESDE QUE OSTENTA LA PLAZA</th><th class="borde">TIPO DE NOMBRAMIENTO</th><th class="borde">CATEGORIA</th><th class="borde">JORNADA</th><th class="borde">FUNCIÓN DIRECTIVA</th></tr>
                            
                                <c:forEach items="${infoPlazas}" var="plaza">
                                    <tr><td class="borde">${plaza[11]}</td><td class="borde">${plaza[7]}</td><td class="borde">${plaza[9]}:${plaza[10]}</td><td class="borde">${plaza[3]}</td>
                                        <td class="borde">
                                            ${plaza[5]}
                                            <c:if test="${plaza[4]=='1'}">
                                                (${plaza[6]})
                                            </c:if>
                                        </td>
                                        <td class="borde">
                                            <c:if test="${plaza[13]=='D'}">
                                                Director<br/>Fecha de renuncia:${plaza[14]}
                                            </c:if>
                                                <c:if test="${plaza[13]=='S'}">
                                                Subdirector<br/>Fecha de renuncia:${plaza[14]}
                                            </c:if>
                                            <c:if test="${plaza[13]=='J'}">
                                                Jefe de Departamento<br/>Fecha de renuncia:${plaza[14]}
                                            </c:if>                                                
                                            <c:if test="${plaza[13]=='-'}">
                                                No aplica
                                            </c:if>
                                        </td>
                                    </tr>
                                </c:forEach>
                            
                        </table>
                    </td>                    
                </tr>
                <c:if test='${Docente1.infoRegistro[85]==null && infoPlazasAspira != null && sessionScope["programa"]=="2"}'>
                <tr>
                    <td COLSPAN="2">
                        
                        <table>
                            
                            <tr><th class="borde" COLSPAN="6">CATEGORÍAS A LA QUE ASPIRA:</th> </tr>
                            
                            <tr><th class="borde">CATEGORÍA</th><th class="borde">Horas a las que aspira</th></tr>
                            
                                <c:forEach items="${infoPlazasAspira}" var="plaza">
                                    <tr><td class="borde">${plaza[3]}</td><td class="borde"><center>${plaza[6]}</center></td>
                                    </tr>
                                </c:forEach>
                            
                        </table>
                    </td>                    
                </tr>
                <tr>
                    <td>TOTAL DE HORAS A LA QUE ASPIRA</td>
                    <td>:${Docente1.infoRegistro[87]}</td>
                </tr>
                </c:if>
                <tr>
                    <td>FECHA DE SU ÚLTIMA_PROMOCIÓN</td>
                    <td>:
                      <c:if test='${Docente.infoRegistro[39]!=null}'>
                      ${fecha.formatoImprimir(Docente.infoRegistro[39])}
                      </c:if>
                      <c:if test='${Docente.infoRegistro[39] == null}'>
                      ----------------------------
                      </c:if> 
                    </td>
                </tr>
                <tr>
                    <td>NOTA DESF. o SANCIÓN_ADMINISTRATIVA</td>
                    <td>:<c:out value="${Docente.infoRegistro[48] eq 'S' ? 'SI': 'NO'}"/></td>
                </tr>
                <c:set var="horasOtro" value="${Docente.infoRegistro[60] eq 'S' ? 'SI': 'NO'}"></c:set>
                <tr>
                    <td>DESEMPEÑA FUNCIONES EN OTRO SUBSISTEMA</td>
                    <td>:<c:out value="${horasOtro}"/></td>
                </tr>
                <c:if test="${horasOtro=='SI'}">
                    <tr>
                        <td>REGLAS DE COMPATIBILIDAD</td>
                        <td>:<c:out value="${Docente.infoRegistro[49] eq 'S' ? 'SI': 'NO'}"/></td>
                    </tr>
                </c:if>
                <c:if test = "${fn:length(Docente.infoRegistro[51])>0}">
                    <tr>
                        <td>NIV_CENNI</td>
                        <td>:${Docente.infoRegistro[51]}</td>
                    </tr>
                    <tr>
                        <td>FOLIO_CENNI </td>
                        <td>:${Docente.infoRegistro[52]}</td>
                    </tr>
                </c:if>
                                
                <tr>
                    <td>FECHA Y HORA DE REGISTRO</td>
                    <td>:${fecha.formatoImprimirFH(Docente.infoRegistro[61])}</td>
                </tr>
                <tr>
                    <td>CONSIDERACIONES PARTICULARES</td>
                    <c:if test="${Docente.infoRegistro[62]!=null}">
                        <td>:${Docente.infoRegistro[62]}</td>
                    </c:if>
                    <c:if test="${Docente.infoRegistro[62]==null}">
                        <td>:Ninguna</td>
                    </c:if>
                </tr>                
                <tr>
                    <td colspan="2">
                        <table >
                            <tr>
                                <th class="borde">PERIODO</th>
                                <th class="borde">ASIGNATURA/COMPONENTE PROFESIONAL/LABORATORIO O TALLER</th>
                                <th class="borde">GRUPO</th>
                                <th class="borde">SEMESTRE</th>
                                <th class="borde">HORAS</th>
                            </tr>
                            <c:if test='${Docente.infoRegistro[75] != "2"}'>
                                 <c:forEach items="${Docente.getListaHoras()}" var="hora">
                                <tr>
                                    <td class="borde"><c:out value="${hora[2]}"/></td>
                                    <td class="borde">
                                        <c:if test = "${hora[3] != null}"> 
                                            <c:if test = "${hora[5] != null}">
                                                <c:out value="${hora[5]}"/> - 
                                            </c:if>
                                            <c:out value="${hora[4]}"/><br/>
                                        </c:if>
                                            
                                        <c:if test = "${hora[13] != null}">
                                            <c:if test = "${hora[3] != null}">  <hr class="red"></c:if>
                                            <c:if test = "${hora[15] != null}">
                                                <c:out value="${hora[15]}"/> - 
                                            </c:if>
                                            <c:out value="${hora[16]}"/><br/>
                                        </c:if>
                                    
                                        <c:if test = "${hora[17] != null}">
                                            <c:if test = "${hora[3] != null || hora[13] != null}">  <hr class="red"></c:if>
                                            <c:if test = "${hora[19] != null}">
                                                <c:out value="${hora[19]}"/> - 
                                            </c:if>
                                            <c:out value="${hora[20]}"/><br/>
                                            
                                        </c:if>     
                                        
                                    </td>  
                                    <td class="borde"><c:out value="${hora[10]}"/></td>
                                    <td class="borde"><c:out value="${hora[6]}"/></td>
                                    <td class="borde"><c:out value="${hora[9]}"/></td>
                                </tr>
                            </c:forEach>
                            <tr>
                                <td colspan="4" class="borde">HORAS FRENTE A GRUPO</td>
                                <td class="borde"><b>${Docente.getTotalHoras()}</b></td>
                            </tr>
                            </c:if>
                            
                            <c:if test='${Docente.infoRegistro[75] == "2"}'>
                                <c:forEach items="${Docente.getListaHorasCecyte()}" var="hora">
                                <tr>
                                    <td class="borde"><c:out value="${hora[2]}"/></td>
                                    <td class="borde">
                                        <c:if test = "${hora[11] != null}">
                                            <c:out value="${hora[11]}"/> - 
                                        </c:if>
                                        <c:out value="${hora[5]}"/><br/>
                                    </td>   
                                    <td class="borde"><c:out value="${hora[3]}"/></td>
                                    <td class="borde"><c:out value="${hora[4]}"/></td>
                                    <td class="borde"><c:out value="${hora[10]}"/></td>
                                </tr>
                            </c:forEach>
                            <tr>
                                <td colspan="4" class="borde">HORAS FRENTE A GRUPO</td>
                                <td class="borde"><b>${Docente.getTotalHorasCecyte()}</b></td>
                            </tr>
                            </c:if>
                        </table>
                    </td>
                </tr>
            </table>
            <hr/>            
            <p>CRITERIOS DE VALORACIÓN:</p>
            <c:forEach items="${puntajes}" var="info">
                <c:if test="${info[2]<=10}">
                    <c:out value="${info[2]}"/>&nbsp; 
                </c:if>
                <c:out value="${info[5]}"/> :
                <c:if test="${info[6]!=null}">
                    <c:out value="${info[6]}"/>
                </c:if>                
                <br/>
                <c:if test="${info[2]=='3'&&info[3]==null}">
                    <table>
                        <tr><th class='borde'>Encuesta</th><th class='borde'>Estatus</th></tr>
                        <tr><td class='borde'>A madres y padres de familia o tutores</td><td class='borde'>Evaluado</td></tr>
                        <tr><td class='borde'>A alumnos</td><td class='borde'>Evaluado</td></tr>
                        <tr><td class='borde'>A compañeros de trabajo</td><td class='borde'>Evaluado</td></tr>
                    </table>
                </c:if>
                <c:if test="${info[2]=='5'&&info[3]==null}">
                    <table>
                        <tr><th class='borde'>Tipo</th><th class='borde'>Nombre del curso</th><th class='borde'>Periodo o Fecha de realización</th><th class='borde'>Institución educativa con reconocimiento oficial que emite constancia</th><th class='borde'>Total de horas que acredita el curso</th><th class='borde'>Constancia o documento probatorio</th></tr>
                        ${cursos}
                    </table>
                </c:if>
                <c:if test="${info[2]=='6'&&info[3]==null}">
                    <table>
                        <tr><th class='borde'>Nombre de la aportación en materia de mejora continua</th><th class='borde'>Periodo o Fecha de realización</th><th class='borde'>Institución educativa con reconocimiento oficial que emite constancia</th><th class='borde'>Constancia o documento probatorio</th></tr>
                        ${aportaciones}
                    </table>
                </c:if>
                <c:if test="${info[2]=='7'&&info[3]==null}">
                    <table>
                        <tr><th class='borde'>Nombre de la participación en eventos y actividades de fortalecimiento académico y formación integral del educando</th><th class='borde'>Periodo o Fecha de realización</th><th class='borde'>Institución educativa con reconocimiento oficial que emite constancia</th><th class='borde'>Constancia o documento probatorio</th></tr>
                        ${participaciones}
                    </table>
                </c:if>
                <c:if test="${info[2]=='8'&&info[3]==null}">
                    <table>
                        <tr><th class='borde'>Periodo o Fecha de realización</th><th class='borde'>Constancia o documento probatorio</th></tr>
                        ${tutorias}
                    </table>
                </c:if>
                <c:if test="${info[2]=='9'&&info[3]==null}">
                    <table>
                        <tr><th class='borde'>Nombre de  la publicación</th><th class='borde'>Medio en el que se publicó</th><th class='borde'>Fecha de publicación</th><th class='borde'>ISSN / ISBN</th></tr>
                        ${publicaciones}
                    </table>
                </c:if>
                <c:if test="${info[2]=='15'&&info[3]==null}">
                    <table>
                        <tr><tr><th class='borde'>Tipo de evidencia</th><th class='borde'>Periodo o Fecha de realización</th><th class='borde'>Constancia o documento probatorio</th></tr>
                        ${resultados}
                    </table>
                </c:if>
            </c:forEach>
            <c:if test="${registroEvidencias != null}">       
            <p>EVIDENCIAS REGISTRO:</p>
            <table>
                <tr><tr><th class='borde'>Criterio</th><th class='borde'>Descripcion tipo documento</th><th class='borde'>Entrego documento</th></tr>
                ${registroEvidencias}
            </table>
            </c:if>
            <c:if test="${evidencias != null}">
            <p>EVIDENCIAS CRITERIOS DE VALORACIÓN:</p>
            <table>
                <tr><tr><th class='borde'>Criterio</th><th class='borde'>Descripcion tipo documento</th><th class='borde'>Entrego documento</th></tr>
                ${evidencias}
            </table>
            </c:if>
            <p style="text-align:justify">De acuerdo a la documentación comprobatoria que ha proporcionado como evidencia de cumplimiento de los requisitos requeridos para su registro y de las evidencias para los criterios de valoración, usted ha sido aceptado para participar en el proceso de promoción en el servicio docente por cambio de categoría en Educación Media Superior, 
                <%--<jsp:include page="seccionesPlantilla/cicloEscolar.jsp" flush="true"/>--%>
                    Ciclo Escolar 
                    <c:if test='${idUsuarioPadrePeriodo == 1}'>
                    ${catalogoC.getCatalogoCicloEscolar(Docente.infoRegistro[82])}
                    </c:if>  
                    <c:if test='${idUsuarioPadrePeriodo == 0}'>
                    ${catalogoC.getCatalogoCicloEscolar(Docente1.infoRegistro[84])}
                    </c:if>
                .</p>
            <p style="text-align:justify">Declara bajo protesta de decir verdad que cumple con los requisitos establecidos en la Convocatoria para el proceso de promoción en el servicio docente por cambio de categoría en Educación Media Superior, 
               <%-- <jsp:include page="seccionesPlantilla/cicloEscolar.jsp" flush="true"/>--%>
                Ciclo Escolar 
                    <c:if test='${idUsuarioPadrePeriodo == 1}'>
                    ${catalogoC.getCatalogoCicloEscolar(Docente.infoRegistro[82])}
                    </c:if>  
                    <c:if test='${idUsuarioPadrePeriodo == 0}'>
                    ${catalogoC.getCatalogoCicloEscolar(Docente1.infoRegistro[84])}
                    </c:if>
                . Para confirmar su dicho, la DGETI podrá verificar la autenticidad de la documentación que proporciono, por lo que, en caso de alteración o falsificación de la misma, acepta la descalificación inmediata del proceso o, en su caso, la invalidación del nombramiento respectivo, sin perjuicio de las sanciones de tipo administrativo o penal en las que pudiera incurrir.</p>
            <c:set var="acepta" value="${Docente.infoRegistro[63] eq 'S' ? 'Acepta': 'No acepta'}"/>
            <p style="text-align:justify">${acepta} hacer públicos los resultados y recomendaciones individuales que se deriven de su valoración para el proceso de promoción en el servicio docente por cambio de categoría en Educación Media Superior ingreso a la Educación Media Superior, 
               <%-- <jsp:include page="seccionesPlantilla/cicloEscolar.jsp" flush="true"/>--%>
                Ciclo Escolar 
                    <c:if test='${idUsuarioPadrePeriodo == 1}'>
                    ${catalogoC.getCatalogoCicloEscolar(Docente.infoRegistro[82])}
                    </c:if>  
                    <c:if test='${idUsuarioPadrePeriodo == 0}'>
                    ${catalogoC.getCatalogoCicloEscolar(Docente1.infoRegistro[84])}
                    </c:if>
                .</p>
            
            <br/><br/><br/><center>${Docente.infoRegistro[1]} ${Docente.infoRegistro[2]} ${Docente.infoRegistro[3]}</center>
        </div>
        <br/><br/>
        <center><input type="button" value="Imprimir" onclick="window.print()"></center>
    </body>
</html>
