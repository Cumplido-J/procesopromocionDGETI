<%-- 
    Document   : FichaDictamen
    Created on : 23/04/2021, 15:31:53
    Author     : jtrinidadl
--%>

<%@page import="java.util.List"%>
<%@page import="metodos_sql.Metodos_sql"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import='herramientas.Imagen'%>
<%@page import='herramientas.RutaConfig'%>
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
                <%
                    String rutaLogo = (String) request.getAttribute("rutaImagenInc");
                %>
                <td valign="top"><img width="200" src="<%=Imagen.muestraImagen(RutaConfig.getRutaCarpeta()+rutaLogo)%>"></td>
            </tr>
        </table> 
        <center><p>DICTAMEN</p></center>
        <div style="font-size: 12px">
            <p>Imprimir y conservar esta ficha.</p>
            <p style="text-align: end;">Ciudad de México, a ${Docente.infoRegistro[80]}</p>
            <hr/>            
            <h3>DATOS DEL PARTICIPANTE</h3>
            <table >
                <tr>
                    <td>FOLIO</td>                    
                    <td>:${Docente.infoRegistro[76]}</td>
                </tr>
                <tr>
                    <td>RFC</td>
                    <td>:${Docente.infoRegistro[5]}</td>
                </tr>
                <tr>
                    <td>NOMBRE</td>
                    <td>:${Docente.infoRegistro[1]}</td>
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
                    <td>PLANTEL</td>
                    <td>:${Docente.infoRegistro[10]}</td>
                </tr>
                <tr>
                    <td COLSPAN="2">
                        <p>PLAZAS QUE OSTENTA:</p>
                        <table>
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
                <tr>
                    <td>PLAZA A LA QUE ASPIRA</td>
                    <td>:${Docente.infoRegistro[41]}-${Docente.infoRegistro[43]} ${Docente.infoRegistro[77]}-${Docente.infoRegistro[45]}</td>
                </tr>
                <tr>
                    <td>NÚMERO EN LAS LISTA DE RESULTADOS:</td>
                        <c:if test="${Docente.infoRegistro[81]==null}">
                            <td>:No aplica</td>
                        </c:if>
                        <c:if test="${Docente.infoRegistro[81]!=null}">
                            <td>:${Docente.infoRegistro[81]}</td>
                        </c:if>
                </tr>
                <tr>
                    <td COLSPAN="2">
                        <h3>REQUISITOS:</h3>
                        <table>
                            <tr><th class="borde">CUMPLE:</th><th class="borde">NO CUMPLE:</th></tr>
                            <c:if test="${Docente.infoRegistro[78]=='14'}">
                                <tr><td class="borde">${Docente.infoRegistro[79]}</td><td class="borde">----------</td></tr>
                            </c:if>
                            <c:if test="${Docente.infoRegistro[78]=='3'}">
                                <tr><td class="borde">----------</td><td class="borde">${Docente.infoRegistro[79]}</td></tr>
                            </c:if>
                            <c:if test="${Docente.infoRegistro[78]=='15'}">
                                <tr><td class="borde">----------</td><td class="borde">${Docente.infoRegistro[79]}</td></tr>
                            </c:if>
                            <c:if test="${Docente.infoRegistro[78]=='16'}">
                                <tr><td class="borde">Aceptado</td><td class="borde">----------</td></tr>
                            </c:if>
                            <tr><td class="borde" COLSPAN="2">${Docente.infoRegistro[67].toUpperCase()}</td></tr>
                        </table>
                    </td>                    
                </tr>
                <tr>
                    <td COLSPAN="2">
                        <h3>PUNTAJE CRITERIOS DE VALORACIÓN:</h3>
                        <table>
                            <tr><th class="borde">No.</th><th class="borde">Criterio de valoración</th><th class="borde">Puntaje</th></tr>
                            <tr><td class="borde">1</td><td class="borde">Antigüedad en el servicio.</td><td class="borde">${puntajesDictaminador[0][4]}</td></tr>
                            <c:set var="totalDictaminador" value="${totalDictaminador+puntajesDictaminador[0][4]}"></c:set>
                            <tr><td class="borde">2</td><td class="borde">Experiencia y tiempo de trabajo en zonas de marginación, pobreza y descomposición social.</td><td class="borde">${puntajesDictaminador[1][4]}</td></tr>
                            <c:set var="totalDictaminador" value="${totalDictaminador+puntajesDictaminador[1][4]}"></c:set>
                            <tr><td class="borde">3</td><td class="borde">El reconocimiento al buen desempeño por la comunidad educativa, con la participación de madres y padres de familia o tutores, alumnos y compañeros de trabajo.</td><td class="borde">${puntajeEncuestas[5]}</td></tr>
                            <c:set var="totalDictaminador" value="${totalDictaminador+puntajeEncuestas[5]}"></c:set>
                            <tr><td class="borde">4</td><td class="borde">La formación académica y de posgrado.</td><td class="borde">${puntajesDictaminador[3][4]}</td></tr>
                            <c:set var="totalDictaminador" value="${totalDictaminador+puntajesDictaminador[3][4]}"></c:set>
                            <c:if test="${puntajesDictaminador[4][3]=='0'}">
                                <tr><td class="borde">5</td><td class="borde">La capacitación y actualización. </td><td class="borde">${puntajesDictaminador[4][4]}</td></tr>
                                <c:set var="totalDictaminador" value="${totalDictaminador+puntajesDictaminador[4][4]}"></c:set>
                            </c:if>
                            <c:if test="${puntajesDictaminador[4][3]!='0'}">
                                <tr><td class="borde">5</td><td class="borde">La capacitación y actualización. </td><td class="borde">${cursos[2]}</td></tr>
                                <c:set var="totalDictaminador" value="${totalDictaminador+cursos[2]}"></c:set>
                            </c:if>
                            <c:if test="${puntajesDictaminador[5][3]=='0'}">
                                <tr><td class="borde">6</td><td class="borde">Las aportaciones en materia de mejora continua en la educación, la docencia o la investigación.</td><td class="borde">${puntajesDictaminador[5][4]}</td></tr>
                                <c:set var="totalDictaminador" value="${totalDictaminador+puntajesDictaminador[5][4]}"></c:set>
                            </c:if>
                            <c:if test="${puntajesDictaminador[5][3]!='0'}">
                                <tr><td class="borde">6</td><td class="borde">Las aportaciones en materia de mejora continua en la educación, la docencia o la investigación.</td><td class="borde">${aportaciones[2]}</td></tr>
                                <c:set var="totalDictaminador" value="${totalDictaminador+aportaciones[2]}"></c:set>
                            </c:if>
                            <c:if test="${puntajesDictaminador[6][3]=='0'}">
                                <tr><td class="borde">7</td><td class="borde">Participación en eventos y actividades de fortalecimiento académico y formación integral del educando.</td><td class="borde">${puntajesDictaminador[6][4]}</td></tr>
                                <c:set var="totalDictaminador" value="${totalDictaminador+puntajesDictaminador[6][4]}"></c:set>
                            </c:if>
                            <c:if test="${puntajesDictaminador[6][3]!='0'}">
                                <tr><td class="borde">7</td><td class="borde">Participación en eventos y actividades de fortalecimiento académico y formación integral del educando.</td><td class="borde">${participaciones[2]}</td></tr>
                                <c:set var="totalDictaminador" value="${totalDictaminador+participaciones[2]}"></c:set>
                            </c:if>
                            <c:if test="${puntajesDictaminador[7][3]=='0'}">
                                <tr><td class="borde">8</td><td class="borde">Actividades de tutoría o acompañamiento docente.</td><td class="borde">${puntajesDictaminador[7][4]}</td></tr>
                                <c:set var="totalDictaminador" value="${totalDictaminador+puntajesDictaminador[7][4]}"></c:set>
                            </c:if>
                            <c:if test="${puntajesDictaminador[7][3]!='0'}">
                                <tr><td class="borde">8</td><td class="borde">Actividades de tutoría o acompañamiento docente.</td><td class="borde">${tutorias[2]}</td></tr>
                                <c:set var="totalDictaminador" value="${totalDictaminador+tutorias[2]}"></c:set>
                            </c:if>
                            <c:if test="${puntajesDictaminador[8][3]=='0'}">
                                <tr><td class="borde">9</td><td class="borde">Las publicaciones académicas o de investigación.</td><td class="borde">${puntajesDictaminador[8][4]}</td></tr>
                                <c:set var="totalDictaminador" value="${totalDictaminador+puntajesDictaminador[8][4]}"></c:set>
                            </c:if>
                            <c:if test="${puntajesDictaminador[8][3]!='0'}">
                                <tr><td class="borde">9</td><td class="borde">Las publicaciones académicas o de investigación.</td><td class="borde">${publicaciones[2]}</td></tr>
                                <c:set var="totalDictaminador" value="${totalDictaminador+publicaciones[2]}"></c:set>
                            </c:if>
                            <tr><td class="borde">10</td><td class="borde">El desempeño en el plantel o subsistema en el que realice su labor.</td><td class="borde">${puntajesDictaminador[9][4]+puntajesDictaminador[10][4]+puntajesDictaminador[11][4]+puntajesDictaminador[12][4]+puntajesDictaminador[13][4]+resultados[2]}</td></tr>
                            <tr><td class="borde" COLSPAN="2"><p class="text-center">Total</p></td><td class="borde">${totalDictaminador+puntajesDictaminador[9][4]+puntajesDictaminador[10][4]+puntajesDictaminador[11][4]+puntajesDictaminador[12][4]+puntajesDictaminador[13][4]+resultados[2]}</td></tr>
                        </table>
                    </td>                    
                </tr>
                <tr>
                    <td COLSPAN="2">
                        <h3>CRITERIOS DE VALORACIÒN</h3>
                        <table>
                            <tr><th class="borde">CUMPLE:</th><th class="borde">NO CUMPLE:</th></tr>
                            <c:if test="${Docente.infoRegistro[78]=='14'}">
                                <tr><td class="borde">${Docente.infoRegistro[79]}</td><td class="borde">----------</td></tr>
                            </c:if>
                            <c:if test="${Docente.infoRegistro[78]=='16'}">
                                <tr><td class="borde">----------</td><td class="borde">${Docente.infoRegistro[79]}</td></tr>
                            </c:if>
                            <c:if test="${Docente.infoRegistro[78]=='15'}">
                                <tr><td class="borde">No aplica</td><td class="borde">No aplica</td></tr>
                            </c:if>    
                            <c:if test="${Docente.infoRegistro[78]!='14' && Docente.infoRegistro[78]!='15' && Docente.infoRegistro[78]!='16'}">
                                <tr><td class="borde">No Cumple</td><td class="borde">No cumple</td></tr>
                            </c:if>
                            <tr><td class="borde" COLSPAN="2">${Docente.infoRegistro[69].toUpperCase()}</td></tr>
                            <tr><td class="borde" COLSPAN="2">${Docente.infoRegistro[74].toUpperCase()}</td></tr>
                        </table>
                    </td>                    
                </tr>
            </table>
            <hr/>
            
        </div>
        <br/><br/>
        <center><input type="button" value="Imprimir" onclick="window.print()"></center>
    </body>
</html>
