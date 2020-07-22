<%-- 
    Document   : FichaRegistroIncompleto
    Created on : 6 jul 2020, 16:15:49
    Author     : David Reyna
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import='herramientas.Imagen'%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
    <head>        
        <title>Ficha de registro incompleto</title>
        <meta charset="UTF-8">
        <jsp:useBean id="docente" scope="session" class="com.aplicacion.beans.Docente" />
    </head>
    <body style="width:800px; font-family:Verdana;">
        <table >
            <tr>
                <td><img width="200" src="<%=Imagen.muestraImagen("C:/ArchivosPromocion/logos/logoSepSems.jpg")%>"></td>
                <td>
                    <center>
                        <p>
                        Convocatoria para el proceso de promoción en el servicio docente por cambio de categoría en Educación Media Superior 
                        <br/>(Promoción horizontal)
                        <br/>Ciclo Escolar 2020-2021
                        </p>
                    </center>
                </td>
                <td><img width="200" src="<%=Imagen.muestraImagen("C:/ArchivosPromocion/logos/logoUemstis.jpg")%>"></td>
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
                    <td>:</td>
                </tr>
                <!--<tr>
                    <td>CURP</td>
                    <td>:</td>
                </tr>-->
                <tr>
                    <td>RFC</td>
                    <td>:${Docente.rfc}</td>
                </tr>
                <tr>
                    <td>NOMBRE</td>
                    <td>:${Docente.nombre}</td>
                </tr>
                <tr>
                    <td>PRIMER APELLIDO</td>
                    <td>:${Docente.primerApellido}</td>
                </tr>
                <tr>
                    <td>SEGUNDO APELLIDO</td>
                    <td>:${Docente.segundoApellido}</td>
                </tr>
                <tr>
                    <td>CORREO ELECTRÓNICO</td>
                    <td>:${Docente.correo}</td>
                </tr>
                <tr>
                    <td>ENTIDAD</td>
                    <td>:</td>
                </tr>
                <tr>
                    <td>CENTRO DE TRABAJO</td>
                    <td>:</td>
                </tr>
                <tr>
                    <td>CATEGORÍA A LA QUE ASPIRA</td>
                    <td>:</td>
                </tr>
                <tr>
                    <td>GRADO ACADÉMICO REQUERIDO</td>
                    <td>:</td>
                </tr>
                <tr>
                    <td>GRADO ACADÉMICO QUE OSTENTA</td>
                    <td>:</td>
                </tr>
                <tr>
                    <td>PERFIL PROFESIONAL (CARRERA)</td>
                    <td>:</td>
                </tr>
                <tr>
                    <td>ASIGNATURA/COMPONENTE PROFESIONAL/LABORATORIO O TALLER</td>
                    <td>:</td>
                </tr>
                <tr>
                    <td>DOCENTE ACTIVO EN SERVICIO</td>
                    <td>:</td>
                </tr>
                <tr>
                    <td>FECHA DE INGRESO AL SUBSISTEMA</td>
                    <td>:</td>
                </tr>
                <tr>
                    <td>FECHA DE INGRESO AL PLANTEL</td>
                    <td>:</td>
                </tr>
                <tr>
                    <td>CATEGORÍA/NIVEL QUE OSTENTA</td>
                    <td>:</td>
                </tr>
                <tr>
                    <td>FECHA DE INGRESO A LA PLAZA QUE OSTENTA</td>
                    <td>:</td>
                </tr>
                <tr>
                    <td>TIPO DE NOMBRAMIENTO QUE OSTENTA </td>
                    <td>:</td>
                </tr>
                <tr>
                    <td>HORAS FRENTE A GRUPO</td>
                    <td>:</td>
                </tr>
                <tr>
                    <td>FECHA DE SU ÚLTIMA_PROMOCIÓN</td>
                    <td>:</td>
                </tr>
                <tr>
                    <td>NOTA DESF. o SANCIÓN_ADMINISTRATIVA</td>
                    <td>:</td>
                </tr>
                <tr>
                    <td>REGLAS DE COMPATIBILIDAD</td>
                    <td>:</td>
                </tr>
                <tr>
                    <td>NIV_CENNI</td>
                    <td>:</td>
                </tr>
                <tr>
                    <td>FOLIO_CENNI </td>
                    <td>:</td>
                </tr>                
                <tr>
                    <td>FECHA Y HORA DE REGISTRO</td>
                    <td>:</td>
                </tr>
                <tr>
                    <td>CONSIDERACIONES PARTICULARES</td>
                    <td>:</td>
                </tr>
            </table>
            <p>De acuerdo a la documentación comprobatoria que ha proporcionado como evidencia de los requisitos requeridos para su registro</p>
            <p>
                a. <b>Nivel académico:</b> documento acreditado por una instancia oficial que confirma el grado de estudios requerido para participar en el Programa, de acuerdo con el perfil profesional.
                <br/>b. <b>Antigüedad:</b> constancia expedida por el área administrativa o de personal, definida por la DGETI.
                <br/>c. <b>Nombramiento definitivo:</b> documento expedido por la UEMSTIS.
                <br/>d. <b>Asistencia a las horas frente al grupo:</b> constancia expedida por el área administrativa o de personal, definida por la UEMSTIS. 
                <br/>e. <b>Nivel 14 de CENNI:</b> certificado vigente o constancia que acredite el trámite de expedición en proceso, emitido por la Secretaría de Educación Pública, para los participantes de inglés que tengan una licenciatura distinta a la de enseñanza del inglés.
                <br/>f. <b>No contar con nota desfavorable:</b> constancia emitida por el Director del plantel, de que el participante no cuenta con nota desfavorable en los dos últimos ciclos escolares inmediatos a la publicación de la convocatoria, y carta del participante, bajo protesta de decir verdad, de que no cuenta con sanción administrativa que pueda limitar su desempeño en la función.
                <br/>g. <b>Compatibilidad de empleos:</b> constancia vigente emitida por la autoridad competente en apego a las reglas de compatibilidad.
            </p>
            <p>Usted tiene su registro incompleto por lo que no es posible su participación en el proceso de promoción en el servicio docente por cambio de categoría en Educación Media Superior, Ciclo Escolar 2020-2021.</p>
            
            <br/><br/><br/><center>Nombre del participante</center>
        </div>
        <input type="button" value="Imprimir" onclick="window.print()">
    </body>
</html>
