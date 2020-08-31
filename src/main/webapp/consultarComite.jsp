<%@page import="java.sql.ResultSet"%>
<%@page import='herramientas.Catalogos'%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <title>Unidad de Educación Media Superior Tecnológica Industrial y de Servicios | gob.mx</title>
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
            <jsp:useBean id="catalogo" class="herramientas.Catalogos" scope="page" />
            
            <!-- Modal -->
                    <div class="modal fade" id="exampleModalCenter" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
                      <div class="modal-dialog modal-dialog-centered" role="document">
                        <div class="modal-content">
                          <div class="modal-header">
                            <h5 class="modal-title" id="exampleModalLongTitle">Actualizar datos comite</h5>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                              <span aria-hidden="true">&times;</span>
                            </button>
                          </div>
                          <div class="modal-body">
                            <form role="form">
                        <div>
                          <div class="form-group col-md-4">
                            <div>
                            <p>Entidad</p>
                            </div>
                            <div>
                                <select name="cboentidad1" id="cboentidad1" onchange="listarPlantelesModal(this.value);" class="form-control">
                                    ${catalogo.desplegarOpcionesEstado()}
                                </select>
                            </div>
                        </div>
                                
                        <div class="form-group col-md-4">
                            <div>
                            <p>Plantel</p>
                        </div>
                            <div>
                                <select name="cboplantel1" id="cboplantel1" onchange="listarProgramasPlanteles1(this.value);" class="form-control">
                                    <option value='-1'>Seleccione un plantel</option>
                                </select>
                            </div>
                        </div>
                        <div class="form-group col-md-4">
                            <div>
                            <p>Programa</p>
                            </div>
                            <div>
                                <select name="cboconvocatoria1" id="cboconvocatoria1" class="form-control">
                                    <option value='-1'>Seleccione un programa</option>
                                </select>
                            </div>
                        </div>
                        </div>
                      </form>
                                <%!
                                    String _idEntidad1 = "";
                                    String _idPlantel1 = "";
                                    String _idPrograma1 = "";
                                %>
                                <%
                                    _idEntidad1 = request.getParameter("cboentidad1");
                                    _idPlantel1 = request.getParameter("cboplantel1");
                                    _idPrograma1 = request.getParameter("cboconvocatoria1");
                                %>
                          </div>
                          <div class="modal-footer" class="form-group col-md-6">
                            <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                            <button type="button" class="btn btn-primary" onclick="actualizarComite()">Agregar</button>
                          </div>
                        </div>
                      </div>
                    </div>
            
            <form id="data" class="form-horizontal" role="form" method="POST">
                    <section class="sectionreg">
                    <div class="row">
                        
                        <div class="form-group col-md-4">
                            <div>
                            <p>Entidad</p>
                            </div>
                            <div>
                                <select name="cboentidad" id="cboentidad" onchange="listarPlanteles(this.value);" class="form-control" required>
                                    ${catalogo.desplegarOpcionesEstado()}
                                </select>
                            </div>
                        </div>
                                
                        <div class="form-group col-md-4">
                            <div>
                            <p>Plantel</p>
                        </div>
                            <div>
                                <select name="cboplantel" id="cboplantel" class="form-control" required>
                                    <option value='-1'>Seleccione un plantel</option>
                                </select>
                            </div>
                        </div>
                        <div class="form-group col-md-4">
                            <div>
                            <p>Programa</p>
                            </div>
                            <div>
                                <select name="cboconvocatoria" id="cboconvocatoria" onchange="listartiposComite(this.value);" class="form-control" required>
                                    ${catalogo.desplegarProgramasPlanteles()}
                                </select>
                            </div>
                        </div>
                        
                        <div class="form-group col-md-4">
                            <div>
                            <p>Tipo de comite</p>
                            </div>
                            <div>
                                <select name="cbocomite" id="cbocomite" class="form-control" required>
                                    <option value='-1'>Seleccione un comite</option>
                                </select>
                            </div>
                        </div>
                                
                        <div class="form-group col-md-12">
                            <div>
                                 <button class="btn btn-sm btn-primary" type="submit" id="consultarConvocatoria"name="consultarConvocatoria" style="width: 20%;">Buscar/Agregar</button>
                            </div>
                        </div>
                    </div>
                    </section>   
                    </form>
                                    
                    <jsp:useBean id="cn" class="metodos_sql.Metodos_sql" scope="page"></jsp:useBean>
                    <div>
                        <h4><span id="nombrePlantel"></span></h4>
                        <form id="data1" class="form-horizontal" role="form" method="POST">
                        <table class="table table-responsive table-bordered table-striped">
                            <thead>
                                <%!
                                    String _idEntidad = "";
                                    String _idPlantel = "";
                                    String _idPrograma = "";
                                    String _tipoComite = "";
                                %>
                                <%
                                    _idEntidad = request.getParameter("cboentidad");
                                    _idPlantel = request.getParameter("cboplantel");
                                    _idPrograma = request.getParameter("cboconvocatoria");
                                    _tipoComite = request.getParameter("cbocomite");
                                %>
                                <tr>
                              <th>Estado</th>
                              <th>Plantel</th>
                              <th>Programa</th>
                              <th>Nombre del presidente</th>
                              <th>Tipo de comite</th>
                              <th>Estatus</th>
                                </tr>
                                <%=
                                    new Catalogos().desplegarComite(_idEntidad, _idPlantel, _idPrograma, _tipoComite)
                                %>
                            </thead>
                            <tbody id="vacanciaData">

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
                  function borrarComite(_idEntidad,_idPlantel,_idPrograma,_tipo,_idComite){
                    console.log("delete");
                    
                     var retVal = confirm("Esta seguro de eliminar el registro ?");
                        if (retVal == true)
                        {
                            $.post("Servlet_borrarComites", {i: _idEntidad,j: _idPlantel,k: _idPrograma,l: _tipo,m: _idComite}, function(result){
                        var datos=result;
                        window.location.href="http://localhost:8080/consultarComite.jsp"
                        return true;
                        if(datos.length=="ok"){
                        }
                    });
                        }else{
                            return false;
                        }
                }
            </script>
            <script>
                  function actualizarComite(_idEntidad,_idPlantel,_idPrograma,_tipo,_idComite){
                    console.log("actualizar");
                    
                        $.post("Servlet_borrarComites", {i: _idEntidad,j: _idPlantel,k: _idPrograma,l: _tipo,m: _idComite}, function(result){
                        var datos=result;
                        window.location.href="http://localhost:8080/consultarComite.jsp"
                        return true;
                        if(datos.length=="ok"){
                        }
                    });
                }
            </script>
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
                opt.value="-1";
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
        opt.value="-1";
        opt.text="Seleccione un plantel";
        cboconvocatoria.appendChild(opt);
        alert("Seleccione una Entidad");
    }

}

function listartiposComite(id){
     var cboconvocatoria = document.getElementById('cbocomite');
    if(id>0){
        
    ajax.open("GET",'ServletControladorConsultarComite?id='+id, true);
    ajax.responseType = "json";
        ajax.onreadystatechange=function(){
            if (ajax.readyState === 4){
                limpiarSelect(cboconvocatoria);
                var opt = document.createElement("option");
                opt.value="-1";
                opt.text="Seleccione un comite";
                cboconvocatoria.appendChild(opt);
                const planteles =  ajax.response;
                if(planteles.length==0){
                    $("#mensaje").html("No hay comites registrados");
                    $("#modalMensaje").modal();
                }
                for (var i = 0; i < planteles.length; i++) {
                var option = document.createElement("option");
                option.value = planteles[i].id;
                option.text = planteles[i].tipo;
                cboconvocatoria.appendChild(option);
                }
            }
        }
    ajax.send(null);        
    }else{
        limpiarSelect(cbocomite);
        var opt = document.createElement("option");
        opt.value="-1";
        opt.text="Seleccione un comite";
        cboconvocatoria.appendChild(opt);
        alert("Seleccione un comite");
    }

}

function listarPlantelesModal(id){
     var cboplanteles = document.getElementById('cboplantel1');
     var tbody = document.getElementById('vacanciaData');
    if(id>0){
        tbody.innerHTML = "";
        
    ajax.open("GET",'ServletControladorPlantel?id='+id, true);
    ajax.responseType = "json";
        ajax.onreadystatechange=function(){
            if (ajax.readyState === 4){
                limpiarSelect(cboplanteles);
                var opt = document.createElement("option");
                opt.value="-1";
                opt.text="Seleccione un plantel";
                cboplanteles.appendChild(opt);
                const planteles =  ajax.response;
                for (var i = 0; i < planteles.length; i++) {
                var option = document.createElement("option");
                option.value = planteles[i].id;
                option.text = planteles[i].planel;
                cboplanteles.appendChild(option);
                }
            }
        }
    ajax.send(null);        
    }else{
        limpiarSelect(cboplanteles);
        var opt = document.createElement("option");
        opt.value="-1";
        opt.text="Seleccione un plantel";
        cboplanteles.appendChild(opt);
        alert("Seleccione una Entidad");
    }
}

function listarProgramasPlanteles1(id){
     var cboconvocatoria = document.getElementById('cboconvocatoria1');
    if(id>0){
        
    ajax.open("GET",'ServletControladorProgramasPlantel?id='+id, true);
    ajax.responseType = "json";
        ajax.onreadystatechange=function(){
            if (ajax.readyState === 4){
                limpiarSelect(cboconvocatoria);
                var opt = document.createElement("option");
                opt.value="-1";
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
        opt.value="-1";
        opt.text="Seleccione un plantel";
        cboconvocatoria.appendChild(opt);
        alert("Seleccione una Entidad");
    }

}

function Agrega(){
 
//obtenemos los valores de nuestra caja de texto
var codigo=document.getElementById("cboentidad1");
var nombre=document.getElementById("cboplantel1");
var precio=document.getElementById("cboconvocatoria1");

var text1 = codigo.options[codigo.selectedIndex].innerText; //El texto de la opción seleccionada
var text2 = nombre.options[nombre.selectedIndex].innerText; //El texto de la opción seleccionada
var text3 = precio.options[precio.selectedIndex].innerText; //El texto de la opción seleccionada

//creamos un objeto tr que anexaremos a nuestra tabla llamada tableProductos
var TR= document.createElement("tr");
 
//creamos 4 elementos td en donde iran los datos y uno cuarto donde ira un boton para eliminar
var TD1=document.createElement("td");
var TD2=document.createElement("td");
var TD3=document.createElement("td");
var TD4=document.createElement("td");
var TD5=document.createElement("td");
var TD6=document.createElement("td");

//asignamos los valores a nuestros td por medio del atributo innerHTML, el cual tiene el contenido HTML de un Nodo
TD1.innerHTML=text1;
TD2.innerHTML=text2;
TD3.innerHTML=text3;
TD4.innerHTML="";
TD5.innerHTML="";
TD6.innerHTML="";
 
//A continuación asignamos contenido html a nuestro cuarto td
//esta es una forma de crear elementos tambien, dando el codigo html a un Nodo
//TD4.innerHTML="&lt;input type='button' value='Eliminar' onclick='Elimina(this)'&gt;"
 
//Ahora proseguimos a agregar los hijos TD al Padre TR
//Esta es otra manera de crear elementos HTML, por medio de el metodo appendChild
TR.appendChild(TD1);
TR.appendChild(TD2);
TR.appendChild(TD3);
TR.appendChild(TD4);
TR.appendChild(TD5);
TR.appendChild(TD6);
 
//Por ultimo asignamos nuestro TR a la tabla con id tablaProductos
document.getElementById("tablaProductos1").appendChild(TR);
 
//limpiamos nuestros inputs para agregar ma datos, y ponemos el foco nuevamente en el input de codigo
document.getElementById("cboentidad1").value="";
document.getElementById("cboplantel1").value="";
document.getElementById("cboconvocatoria1").value="";
document.getElementById("cboentidad1").focus();
}
            </script>
    </body>
</html>
