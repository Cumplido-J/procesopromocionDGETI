<%@page import="java.sql.ResultSet"%>
<%@page import='herramientas.Catalogos'%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <title>DGETI | gob.mx</title>
        <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@500&display=swap" rel="stylesheet">
        <link href="/favicon.ico" rel="shortcut icon">
        <link href="https://framework-gb.cdn.gob.mx/assets/styles/main.css" rel="stylesheet">
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
                                <select name="cboentidad" id="cboentidad" onchange="listarPlanteles(this.value);" class="form-control">
                                    ${catalogo.desplegarOpcionesEstado()}
                                </select>
                            </div>
                        </div>
                                
                        <div class="form-group col-md-4">
                            <div>
                            <p>Plantel</p>
                        </div>
                            <div>
                                <select name="cboplantel" id="cboplantel" onchange="listarProgramasPlanteles(this.value);" class="form-control">
                                    <option value=''>Seleccione un plantel</option>
                                </select>
                            </div>
                        </div>
                        <div class="form-group col-md-4">
                            <div>
                            <p>Convocatoria</p>
                            </div>
                            <div>
                                <select name="cboconvocatoria" id="cboconvocatoria" class="form-control">
                                    <option value=''>Seleccione un programa</option>
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
                        <%
                            String nombre = "";
                            String _idEntidad = "";
                            String _idPlantel = "";
                            String _idEstatus = "";
                            nombre = request.getParameter("rfcNombre");
                            _idEntidad = request.getParameter("cboentidad");
                            _idPlantel = request.getParameter("cboplantel");
                            _idEstatus = request.getParameter("cboestatus");
                        %>
                        <h4><span id="nombrePlantel"></span></h4>
                        <form id="data1" class="form-horizontal" role="form" method="POST" action="VistaDocente">
                        <table class="table table-responsive table-bordered table-striped">
                            <thead>                                
                                <tr>
                                    <th>Estado</th>
                                    <th>Plantel</th>
                                    <th>RFC</th>
                                    <th>Nombre</th>
                                    <th>Primer apellido</th>
                                    <th>Segundo apellido</th>
                                    <th>Estatus</th>
                                    <th>Opciones</th>
                                </tr>
                            </thead>
                            <tbody id="vacanciaData">
                                <%=
                                    new Catalogos().desplegarConvocatorio(nombre, session.getAttribute("estado").toString(), session.getAttribute("plantel").toString(), _idEstatus)
                                %>
                            </tbody>
                        </table>
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
            <script>
                function AJAX(){
    var xhr = false;
    if(window.ActiveXObject){
        xhr = new ActiveXObject("Microsoft.XMLHttp");
    }
    else if(window.XMLHttpRequest || typeof XMLHttpRequest != undefined){
        xhr = new XMLHttpRequest();    
    }
    else{
        console.log("Su navegador no tiene soporte para AJAX");
        xhr =false;
    }
    return xhr;
}
var ajax = AJAX();
function listarProgramasPlanteles(id){
     var cboconvocatoria = document.getElementById('cboconvocatoria');
    if(id>0){
        
    ajax.open("GET",'ServletControladorProgramasPlantel?id='+id, true);
    ajax.responseType = "json";
        ajax.onreadystatechange=function(){
            if (ajax.readyState === 4){
                limpiarSelect(cboconvocatoria);
                var opt = document.createElement("option");
                opt.value="";
                opt.text="Seleccione un programa";
                cboconvocatoria.appendChild(opt);
                const planteles =  ajax.response;
                for (var i = 0; i < planteles.length; i++) {
                var option = document.createElement("option");
                option.value = planteles[i].id;
                option.text = planteles[i].programa;
                cboconvocatoria.appendChild(option);
                }
            }
        }
    ajax.send(null);        
    }else{
        limpiarSelect(cboconvocatoria);
        var opt = document.createElement("option");
        opt.value="";
        opt.text="Seleccione un plantel";
        cboconvocatoria.appendChild(opt);
        alert("Seleccione una Entidad");
    }
}
            </script>
    </body>
</html>