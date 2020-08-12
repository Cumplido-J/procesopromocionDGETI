<%-- 
    Document   : FichaRegistro
    Created on : 6 jul 2020, 16:15:49
    Author     : David Reyna
--%>

<%@page import="java.util.List"%>
<%@page import="metodos_sql.Metodos_sql"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import='herramientas.Imagen'%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix ="fmt"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
    <head>        
        <title>Ficha de registro</title>
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
                <td valign="top"><img width="200" src="<%=Imagen.muestraImagen("C:/ArchivosPromocion/logos/logoSepSems.jpg")%>"></td>
                <td style="text-align:center;">
                    Convocatoria para el proceso de promoción en el servicio docente por cambio de categoría en Educación Media Superior 
                    <br/>(Promoción horizontal)
                    <br/>Ciclo Escolar 2020-2021
                        
                </td>
                <td valign="top"><img width="200" src="<%=Imagen.muestraImagen("C:/ArchivosPromocion/logos/logoUemstis.jpg")%>"></td>
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
                    <td>:${Docente.infoRegistro[41]}-${Docente.infoRegistro[43]}-${Docente.infoRegistro[45]}</td>
                </tr>
                <tr>
                    <td>GRADO ACADÉMICO REQUERIDO</td>
                    <td>:${Docente.infoRegistro[47]}</td>
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
                    <td>:${fecha.formatoImprimir(Docente.infoRegistro[26])}</td>
                </tr>
                <tr>
                    <td>FECHA DE INGRESO AL PLANTEL</td>
                    <td>:${fecha.formatoImprimir(Docente.infoRegistro[27])}</td>
                </tr>
                <tr>
                    <td>CATEGORÍA/NIVEL QUE OSTENTA</td>
                    <td>:${Docente.infoRegistro[29]}-${Docente.infoRegistro[31]}-${Docente.infoRegistro[33]}</td>
                </tr>
                <tr>
                    <td>FECHA DE INGRESO A LA PLAZA QUE OSTENTA</td>
                    <td>:${fecha.formatoImprimir(Docente.infoRegistro[34])}</td>
                </tr>
                <tr>
                    <td>TIPO DE NOMBRAMIENTO QUE OSTENTA </td>
                    <td>:${Docente.infoRegistro[36]}-${Docente.infoRegistro[37]}</td>
                </tr>                
                <tr>
                    <td>FECHA DE SU ÚLTIMA_PROMOCIÓN</td>
                    <td>:${fecha.formatoImprimir(Docente.infoRegistro[39])}</td>
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
            </table>
            <p style="text-align:justify">De acuerdo a la documentación comprobatoria que ha proporcionado como evidencia de cumplimiento de los requisitos requeridos para su registro y de las evidencias para los criterios de valoración, usted ha sido aceptado para participar en el proceso de promoción en el servicio docente por cambio de categoría en Educación Media Superior, Ciclo Escolar 2020-2021.</p>
            <p style="text-align:justify">Declara bajo protesta de decir verdad que cumple con los requisitos establecidos en la Convocatoria para el proceso de promoción en el servicio docente por cambio de categoría en Educación Media Superior, Ciclo Escolar 2020-2021. Para confirmar su dicho, las UEMSTIS podrá verificar la autenticidad de la documentación que proporciono, por lo que, en caso de alteración o falsificación de la misma, acepta la descalificación inmediata del proceso o, en su caso, la invalidación del nombramiento respectivo, sin perjuicio de las sanciones de tipo administrativo o penal en las que pudiera incurrir.</p>
            <c:set var="acepta" value="${Docente.infoRegistro[63] eq 'S' ? 'Acepta': 'No acepta'}"/>
            <p style="text-align:justify">${acepta} hacer públicos los resultados y recomendaciones individuales que se deriven de su valoración para el proceso de promoción en el servicio docente por cambio de categoría en Educación Media Superior ingreso a la Educación Media Superior, Ciclo Escolar 2020-2021.</p>
            
            <br/><br/><br/><center>${Docente.infoRegistro[1]} ${Docente.infoRegistro[2]} ${Docente.infoRegistro[3]}</center>
        </div>
        <br/><br/>
        <center><input type="button" value="Imprimir" onclick="window.print()"></center>
    </body>
</html>
