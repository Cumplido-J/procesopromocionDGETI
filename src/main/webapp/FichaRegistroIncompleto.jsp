<%-- 
    Document   : FichaRegistroIncompleto
    Created on : 6 jul 2020, 16:15:49
    Author     : David Reyna
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import='herramientas.Imagen'%>
<%@page import='herramientas.RutaConfig'%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix ="fmt"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
    <head>        
        <title>Ficha de registro incompleto</title>
        <meta charset="UTF-8">
        <jsp:useBean id="fecha" class="herramientas.Fecha" /> 
        <jsp:useBean id="now" class="java.util.Date" />
        <style>
            .borde{
                border: 1px solid black;                
            }
        </style>
    </head>
    <body style="width:800px; font-family:Verdana;">
        <table >
            <tr>
                <td valign="top"><img width="200" src="<%=Imagen.muestraImagen(RutaConfig.getRutaCarpeta()+"logos/sems.png")%>"></td>
                <td style="text-align:center;">                    
                        Convocatoria para el proceso de promoción en el servicio docente por cambio de categoría en Educación Media Superior 
                        <br/>(Promoción horizontal)
                        <br/>Ciclo Escolar 2020-2021                                            
                </td>
                <td valign="top"><img width="200" src="<%=Imagen.muestraImagen(RutaConfig.getRutaCarpeta()+"logos/logo_dgeti.jpg")%>"></td>
            </tr>
        </table> 
        <center><p>FICHA DE REGISTRO INCOMPLETO</p></center>
        <div style="font-size: 12px">
            <p>Imprimir y conservar esta ficha.</p>
            <hr/>
            <p>DATOS DEL PARTICIPANTE</p>
            <table >
                <tr>
                    <td>FOLIO</td>
                    <fmt:formatDate var="anio" value="${now}" pattern="yyyy" />
                    <td>:<fmt:formatNumber pattern="00" value="${Docente.infoRegistro[7]}" />PCC001<fmt:formatNumber pattern="00000" value="${Docente.infoRegistro[0]}"/>${anio}</td>
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
                    <td>:${Docente.infoRegistro[2]}</td>
                </tr>
                <tr>
                    <td>SEGUNDO APELLIDO</td>
                    <td>:${Docente.infoRegistro[3]}</td>
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
                    <td>CATEGORÍA A LA QUE ASPIRA</td>
                    <c:if test="${Docente.infoRegistro[41]!=null}">
                        <td>:${Docente.infoRegistro[41]}-${Docente.infoRegistro[43]}-${Docente.infoRegistro[45]}</td>
                    </c:if>
                    <c:if test="${Docente.infoRegistro[41]==null}">
                        <td>:-------------------------------------</td>
                    </c:if>
                </tr>
                <tr>
                    <td>GRADO ACADÉMICO REQUERIDO</td>
                    <c:if test="${Docente.infoRegistro[47]!=null}">
                        <td>:${Docente.infoRegistro[47]}</td>
                    </c:if>
                    <c:if test="${Docente.infoRegistro[47]==null}">
                        <td>:-------------------------------------</td>
                    </c:if>
                </tr>
                <tr>
                    <td>GRADO ACADÉMICO QUE OSTENTA</td>
                    <fmt:parseNumber var = "anioTitulacion" type = "number" value = "${Docente.infoRegistro[23]}" />                    
                    <td>:${anio-anioTitulacion} años de haber obtenido el título de ${Docente.infoRegistro[20]}</td>
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
                    <c:if test="${Docente.infoRegistro[26]!=null}">
                        <td>:${fecha.formatoImprimir(Docente.infoRegistro[26])}</td>
                    </c:if>
                    <c:if test="${Docente.infoRegistro[26]==null}">
                        <td>:-------------------------------------</td>
                    </c:if>
                </tr>
                <tr>
                    <td>FECHA DE INGRESO AL PLANTEL</td>
                    <c:if test="${Docente.infoRegistro[27]!=null}">
                        <td>:${fecha.formatoImprimir(Docente.infoRegistro[27])}</td>
                    </c:if>
                    <c:if test="${Docente.infoRegistro[27]==null}">
                        <td>:-------------------------------------</td>
                    </c:if>
                </tr>
                <tr>
                    <td COLSPAN="2">
                        PLAZAS QUE OSTENTA:
                        <table>
                            <tr><th class="borde">CLAVE PRESUPUESTAL</th><th class="borde">FECHA DESDE QUE OSTENTA LA PLAZA</th><th class="borde">TIPO DE NOMBRAMIENTO</th><th class="borde">CATEGORIA</th><th class="borde">JORNADA</th></tr>
                            
                                <c:forEach items="${infoPlazas}" var="plaza">
                                    <tr><td class="borde">${plaza[11]}</td><td class="borde">${fecha.formatoImprimir(plaza[7])}</td><td class="borde">${plaza[9]}:${plaza[10]}</td><td class="borde">${plaza[3]}</td>
                                        <td class="borde">
                                            ${plaza[5]}
                                            <c:if test="${plaza[4]=='1'}">
                                                (${plaza[6]})
                                            </c:if>
                                        </td>
                                    </tr>
                                </c:forEach>
                            
                        </table>
                    </td>                    
                </tr>                
                <tr>
                    <td>FECHA DE SU ÚLTIMA_PROMOCIÓN</td>
                    <c:if test="${Docente.infoRegistro[39]!=null}">
                        <td>:${fecha.formatoImprimir(Docente.infoRegistro[39])}</td>
                    </c:if>
                    <c:if test="${Docente.infoRegistro[39]==null}">
                        <td>:-------------------------------------</td>
                    </c:if>
                </tr>
                <tr>
                    <td>NOTA DESF. o SANCIÓN_ADMINISTRATIVA</td>
                    <c:if test="${Docente.infoRegistro[48]!=null}">
                        <td>:<c:out value="${Docente.infoRegistro[48] eq 'S' ? 'SI': 'NO'}"/></td>
                    </c:if>
                    <c:if test="${Docente.infoRegistro[48]==null}">
                        <td>:-------------------------------------</td>
                    </c:if>
                </tr>
                <c:set var="horasOtro" value="${Docente.infoRegistro[60] eq 'S' ? 'SI': 'NO'}"></c:set>
                <tr>
                    <td>DESEMPEÑA FUNCIONES EN OTRO SUBSISTEMA</td>
                    <c:if test="${Docente.infoRegistro[60]!=null}">
                        <td>:<c:out value="${horasOtro}"/></td>
                    </c:if>
                    <c:if test="${Docente.infoRegistro[60]==null}">
                        <td>:-------------------------------------</td>
                    </c:if>
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
                <c:if test="${Docente.infoRegistro[25]=='S'}"> 
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
                            <c:forEach items="${Docente.getListaHoras()}" var="hora">
                                <tr>
                                    <td class="borde"><c:out value="${hora[2]}"/></td>
                                    <td class="borde">
                                        <c:if test = "${hora[5] != null}">
                                            <c:out value="${hora[5]}"/> - 
                                        </c:if>
                                        <c:out value="${hora[4]}"/><br/>
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
                        </table>
                    </td>
                </tr>
                </c:if>
            </table>
            <p>De acuerdo a la documentación comprobatoria que ha proporcionado como evidencia de los requisitos requeridos para su registro</p>
            <c:if test="${Docente.infoRegistro[25]=='N'}">
                <p>c. <b>Nombramiento definitivo:</b> documento expedido por la DGETI.
                   <br/>d. <b>Asistencia a las horas frente al grupo:</b> constancia expedida por el área administrativa o de personal, definida por la DGETI.</p>
            </c:if>
            <c:if test = "${fn:length(Docente.infoRegistro[51])>0}">
                <fmt:parseNumber var = "nivelCENNI" type = "number" value = "${Docente.infoRegistro[51]}" />
                <c:if test = "${nivelCENNI<14}">
                    <p>e. <b>Nivel 14 de CENNI:</b> certificado vigente o constancia que acredite el trámite de expedición en proceso, emitido por la Secretaría de Educación Pública, para los participantes de inglés que tengan una licenciatura distinta a la de enseñanza del inglés.</p>
                </c:if>
            </c:if>
            <c:if test="${Docente.infoRegistro[48]=='S'}">
                <p>f. <b>No contar con nota desfavorable:</b> constancia emitida por el Director del plantel, de que el participante no cuenta con nota desfavorable en los dos últimos ciclos escolares inmediatos a la publicación de la convocatoria, y carta del participante, bajo protesta de decir verdad, de que no cuenta con sanción administrativa que pueda limitar su desempeño en la función.</p>
            </c:if>
            <c:if test="${Docente.infoRegistro[49]=='N'}">
                <p>g. <b>Compatibilidad de empleos:</b> constancia vigente emitida por la autoridad competente en apego a las reglas de compatibilidad.</p>
            </c:if>
            
            <!--<p>
                a. <b>Nivel académico:</b> documento acreditado por una instancia oficial que confirma el grado de estudios requerido para participar en el Programa, de acuerdo con el perfil profesional.
                <br/>b. <b>Antigüedad:</b> constancia expedida por el área administrativa o de personal, definida por la DGETI.
                <br/>c. <b>Nombramiento definitivo:</b> documento expedido por la UEMSTIS.
                <br/>d. <b>Asistencia a las horas frente al grupo:</b> constancia expedida por el área administrativa o de personal, definida por la UEMSTIS. 
                <br/>e. <b>Nivel 14 de CENNI:</b> certificado vigente o constancia que acredite el trámite de expedición en proceso, emitido por la Secretaría de Educación Pública, para los participantes de inglés que tengan una licenciatura distinta a la de enseñanza del inglés.
                <br/>f. <b>No contar con nota desfavorable:</b> constancia emitida por el Director del plantel, de que el participante no cuenta con nota desfavorable en los dos últimos ciclos escolares inmediatos a la publicación de la convocatoria, y carta del participante, bajo protesta de decir verdad, de que no cuenta con sanción administrativa que pueda limitar su desempeño en la función.
                <br/>g. <b>Compatibilidad de empleos:</b> constancia vigente emitida por la autoridad competente en apego a las reglas de compatibilidad.
            </p>-->
            <p>Usted tiene su registro incompleto por lo que no es posible su participación en el proceso de promoción en el servicio docente por cambio de categoría en Educación Media Superior, Ciclo Escolar 2020-2021.</p>
            
            <br/><br/><br/><center>${Docente.infoRegistro[1]} ${Docente.infoRegistro[2]} ${Docente.infoRegistro[3]}</center>
        </div>
        <br/><br/>
        <center><input type="button" value="Imprimir" onclick="window.print()"></center>
    </body>
</html>
