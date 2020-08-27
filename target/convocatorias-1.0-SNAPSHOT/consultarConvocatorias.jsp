<%@page import="java.sql.ResultSet"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <title>Unidad de Educación Media Superior Tecnológica Industrial y de Servicios | gob.mx</title>
        <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@500&display=swap" rel="stylesheet">
        <link href="/favicon.ico" rel="shortcut icon">
        <link href="https://framework-gb.cdn.gob.mx/assets/styles/main.css" rel="stylesheet">

        <!-- Respond.js soporte de media queries para Internet Explorer 8 -->
        <!-- ie8.js EventTarget para cada nodo en Internet Explorer 8 -->
        <!--[if lt IE 9]>
          <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
          <script src="https://cdnjs.cloudflare.com/ajax/libs/ie8/0.2.2/ie8.js"></script>
        <![endif]-->
        <!--Termina  para el framework del gobierno-->
        <link rel="stylesheet" href="convocatoria/recursos/font-awesome-4.7.0/css/font-awesome.min.css">
        <link rel="stylesheet" href="convocatoria/recursos/css/estilos.css">
        <script type="text/javascript" src="convocatoria/recursos/js/convocatorias.js"></script>
        <script src="https://code.jquery.com/jquery-1.12.4.js"></script> 
    </head>
    <body>
        <jsp:include page="layout/navbar.jsp"/>
        <div class="padre">
            <jsp:include page="layout/header.jsp"/>
            
            <jsp:useBean id="catalogo" class="herramientas.Catalogos" />
            <form id="data" class="form-horizontal" role="form" method="POST">
                    <section class="sectionreg">
                    <div class="row">
                        
                        <div class="form-group col-md-4">
                            <div>
                            <p>Entidad</p>
                            </div>
                            <div>
                                <select name="cboentidad" id="cboentidad" class="form-control">
                                    ${catalogo.desplegarOpcionesEstado()}
                                </select>
                            </div>
                        </div>
                        
                        <div class="form-group col-md-4">
                            <div>
                            <p>Plantel</p>
                        </div>
                            <div>
                                <select name="cboplantel" id="cboplantel" onchange="myConvocatoria()" class="form-control">
                                    ${catalogo.desplegarPlanteles(1)}
                                </select>
                            </div>
                        </div>
                        
                        <div class="form-group col-md-4">
                            <div>
                            <p>Convocatoria</p>
                            </div>
                            <div>
                                <select name="cboplantel" id="cboconvocatoria" onchange="myConvocatoria()" class="form-control">
                                    ${catalogo.desplegarOpcionesConvocatoria(1)}
                                </select>
                            </div>
                        </div>
                                
                        <div class="form-group col-md-4">
                            <div>
                            <p>Estatus</p>
                            </div>
                            <div>
                                <select name="cboestatus" id="cboestatus" class="form-control">
                                    ${catalogo.desplegarCatalogosEstatus()}

                                </select>
                            </div>
                        </div>
                                <div class="form-group col-md-8">
                            <div>
                            <p>RFC/Nombre</p>
                            </div>
                            <div>
                                <input type="text" class="form-control input-sm" id="rfcNombre" name="rfcNombre" >
                            </div>
                        </div>
                                
                        <div class="form-group col-md-12">
                            <div>
                                 <button class="btn btn-sm btn-primary" type="submit" id="consultarConvocatoria"name="consultarConvocatoria" style="width: 20%;">Buscar</button>
                            </div>
                        </div>
                    </div>
                    </section>   
                    </form>
                                    
                    <jsp:useBean id="cn" class="metodos_sql.Metodos_sql" scope="page"></jsp:useBean>
                    <div>
                        <h4><span id="nombrePlantel"></span></h4>
                        <form id="data1" class="form-horizontal" role="form" method="POST" action="editarConsultarConvocatoria.jsp">
                        <section>
                        <table class="table table-responsive table-bordered table-striped">
                            <%
                                    String buscar = request.getParameter("rfcNombre");
                                        ResultSet rs = cn.mostrar("Select * from usuario where nombre like '%"+buscar+"%' or curp like '%"+buscar+"%'");
                                %>
                            <thead>
                                <tr>
                                    <th>Estado</th>
                                    <th>Plantel</th>
                                    <th>RFC</th>
                                    <th>Nombre</th>
                                    <th>Tipo de Convocatoria</th>
                                    <th>Estatus</th>
                                    <th>Opciones</th>
                                </tr>
                                <%
                                    while(rs.next()){
                                %>
                                <tr>
                                    <td><%= rs.getString("entidad")%></td>
                                    <td><%= rs.getString("plantel")%></td>
                                    <td><%= rs.getString("curp")%></td>
                                    <td><%= rs.getString("nombre")%></td>
                                    <td><%= rs.getString("idConvocatoria")%></td>
                                    <td><%= rs.getInt("id")%></td>
                                    <td><button class="btn btn-sm btn-primary" type="submit" id="enviarDatos"name="enviarDatos">Enviar</button></td>
                                    <%
            session = (HttpSession) request.getSession(true);
            String entidad = "";
            String plantel = "";
                session.setAttribute("entidad", request.getParameter(entidad));
                session.setAttribute("plantel", request.getParameter(plantel));
        %>
                                </tr>
                                <%}%>
                            </thead>
                            <tbody id="vacanciaData">

                            </tbody>
                        </table>
                        </section>
                        </form>
                    </div>

            <jsp:include page="layout/footer.jsp"/>

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
                  <p id="mensaje">Generando documento.</p>
                  <iframe src="" id="ifArchivo" width="100%" height="300px" hidden ></iframe>
                </div>
                <div class="modal-footer">
                  <button type="button" class="btn btn-sm btn-default" data-dismiss="modal">Cerrar</button>
                </div>
              </div>
            </div>
          </div>
    </body>
</html>
