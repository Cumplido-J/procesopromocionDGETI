$(document).ready(function () {
    $( "#ingresoSubsistema" ).datepicker({changeMonth:true, changeYear: true});  
    $( "#ingresoPlantel" ).datepicker({changeMonth:true, changeYear: true});     
    $( "#fechaPlaza" ).datepicker({changeMonth:true, changeYear: true});         
    $( "#fechaPromocion" ).datepicker({changeMonth:true, changeYear: true});  
    
    $('#formInfoAcademica').submit(function(e) {
        e.preventDefault();
    }).validate({        
        rules: {
            'egreso':{
                min:1920,
                max:2020
            },
            'titulacion':{
                min:1920,
                max:2020
            }
        },
        messages: {
            'entidad': {
                required: "Seleccione una opción"
            },
            'tipoInstitucion':{
                required: "Seleccione una opción"
            },
            'institucion':{
                required: "Seleccione una opción"
            },
            'cct':{
                required: "Seleccione una opción"
            },
            'escuela':{
                required: "Seleccione una opción"
            },
            'grado':{
                required: "Seleccione una opción"
            },
            'carrera':{
                required: "Campo requerido"
            },
            'egreso':{
                required: "Campo requerido",
                min:"Ingrese un valor válido",
                max:"Ingrese un valor válido"
            },
            'modalidad':{
                required: "Seleccione una opción"
            },
            'titulacion':{
                required: "Campo requerido",
                min:"Ingrese un valor válido",
                max:"Ingrese un valor válido"
            },
            'documento':{
                required: "Seleccione una opción"
            },
            'cedula':{
                required: "Campo requerido"
            }
        },
        submitHandler:function(){
            $.ajax({
                type:$('#formInfoAcademica').attr("method"),
                url:$('#formInfoAcademica').attr("action"),
                data:$('#formInfoAcademica').serialize(),
                beforeSend:function(){
                    $("#btnEnviar1").val("Guardando...");
                    $("#btnEnviar1").attr("disabled","disabled");
                },
                complete:function(){
                   $("#btnEnviar1").val("Guardar y continuar"); 
                   $("#btnEnviar1").removeAttr("disabled");
                },success:function(data){
                    //if(data==="ok"){
                        mostrarSiguiente(1);
                    /*}else{
                        $("#mensaje").html("Error de conexión, intente nuevamente."+data);            
                        $("#modalMensaje").modal("show");
                    }*/
                },error:function(){
                    
                }
            });
            return false;
        }
    });    
});

function actualizarTipoInstitucion() {
    id=$("#entidad").val();
    $.get("ConsultaCatalogos", {k: "11",i:id}, function(respuesta){
        $("#tipoInstitucion").html(respuesta);
    });   
    $("#institucion").val("");
    $("#cct").val("");
    $("#escuela").val("");
}
function actualizarInstitucion() {
    idEntidad=$("#entidad").val();
    idTipo=$("#tipoInstitucion").val();
    $.get("ConsultaCatalogos", {k: "1",i:idEntidad,t:idTipo}, function(respuesta){
        $("#institucion").html(respuesta);
    });
    $("#cct").val("");
    $("#escuela").val("");
}
function cambioInstitucion() {
    id=$("#institucion").val(); 
    $.get("ConsultaCatalogos", {k: "12",i:id}, function(respuesta){
        $("#cct").html(respuesta);
    });
    $.get("ConsultaCatalogos", {k: "2",i:id}, function(respuesta){
        $("#escuela").html(respuesta);
    });
}
function cambioPlantel() {
    id=$("#plantel").val();
    marginacion=$("#plantel option:selected").attr("marginacion");
    if(marginacion!="null"){
        $("#marginacion").html("Con grado de marginación"); 
    }else{
        $("#marginacion").html(""); 
    }
}
function mostrarElemento(elemento){
    $("#"+elemento).removeAttr("hidden");
}
function ocultarElemento(elemento){
    $("#"+elemento).attr("hidden","true");
}
function ocultarInfo(){
    ocultarElemento('seccionAgregar');
    $("#tipoInfo").val("");
    cambioTipoInfo();
}
function cambioTipoInfo(){
    id=$("#tipoInfo").val();
    switch(id){
        case "cbp":
            $.get("ConsultaCatalogos", {k: "3"}, function(respuesta){
                $("#version").html(respuesta);
            }); 
            $("#version").attr("onchange","cargaAsignaturas()");
            $("#version").val("");
            $("#semestre").attr("onchange","cargaAsignaturas()");
            $("#semestre").val("");
            $("#asignatura").val("");
            mostrarElemento("divVersion");
            mostrarElemento("divSemestre");
            mostrarElemento("divAsignatura");
            ocultarElemento("divCarrera");
            ocultarElemento("divModulo");
            ocultarElemento("divSubmodulo");
            ocultarElemento("divTaller");
            break;
        case "cp":
            $.get("ConsultaCatalogos", {k: "4"}, function(respuesta){
                $("#version").html(respuesta);
            }); 
            $("#version").attr("onchange","cargaCarreras()");
            $("#version").val("");
            $("#semestre").attr("onchange","cargaCarreras()");
            $("#semestre").val("");
            $("#carrera_cp").val("");
            $("#modulo").val("");
            $("#submodulo").val("");
            mostrarElemento("divVersion");
            mostrarElemento("divSemestre");
            ocultarElemento("divAsignatura");
            mostrarElemento("divCarrera");
            mostrarElemento("divModulo");
            mostrarElemento("divSubmodulo");
            ocultarElemento("divTaller");
            break;
        case "tl":
            $("#taller").val("");
            ocultarElemento("divVersion");
            ocultarElemento("divSemestre");
            ocultarElemento("divAsignatura");
            ocultarElemento("divCarrera");
            ocultarElemento("divModulo");
            ocultarElemento("divSubmodulo");
            mostrarElemento("divTaller");
            break;
        default:
            ocultarElemento("divVersion");
            ocultarElemento("divSemestre");
            ocultarElemento("divAsignatura");
            ocultarElemento("divCarrera");
            ocultarElemento("divModulo");
            ocultarElemento("divSubmodulo");
            ocultarElemento("divTaller");
    }
}
function cargaAsignaturas() {
    version=$("#version").val();
    semestre=$("#semestre").val();
    $.get("ConsultaCatalogos", {k: "5",v:version,s:semestre}, function(respuesta){
        $("#asignatura").html(respuesta);
    }); 
}
function cargaCarreras() {
    version=$("#version").val();
    semestre=$("#semestre").val();
    $.get("ConsultaCatalogos", {k: "6",v:version,s:semestre}, function(respuesta){
        $("#carrera_cp").html(respuesta);
        $("#modulo").val("");
        $("#submodulo").val("");
    }); 
}
function cambioCarreraCP() {
    version=$("#version").val();
    semestre=$("#semestre").val();
    carrera=$("#carrera_cp").val();
    $.get("ConsultaCatalogos", {k: "7",v:version,s:semestre,c:carrera}, function(respuesta){
        $("#modulo").html(respuesta);
        $("#submodulo").val("");
    }); 
}
function cambioModulo() {
    version=$("#version").val();
    semestre=$("#semestre").val();
    carrera=$("#carrera_cp").val();
    modulo=$("#modulo").val();
    $.get("ConsultaCatalogos", {k: "8",v:version,s:semestre,c:carrera,m:modulo}, function(respuesta){
        $("#submodulo").html(respuesta);
    }); 
}
var info=[];
function registrarInfo(){
    if(info.length==0){
        $("#tablaInfo").html("");
    }
    id=$("#tipoInfo").val();
    switch(id){
        case "cbp":
            cadena=$("#tipoInfo option:selected").text();
            cadena+="<br/>Versión:";
            cadena+=$("#version option:selected").text();
            cadena+="<br/>Semestre:";
            cadena+=$("#semestre option:selected").text();
            cadena+="<br/>Asignatura:";
            cadena+=$("#asignatura option:selected").attr("clave");
            cadena+="-";
            cadena+=$("#asignatura option:selected").text();
            info.push(cadena);
            break;
        case "cp":
            cadena=$("#tipoInfo option:selected").text();
            cadena+="<br/>Versión:";
            cadena+=$("#version option:selected").text();
            cadena+="<br/>Semestre:";
            cadena+=$("#semestre option:selected").text();
            cadena+="<br/>Carrera:";
            cadena+=$("#carrera_cp").val();
            cadena+="-";
            cadena+=$("#carrera_cp option:selected").text();
            cadena+="<br/>Módulo:";
            cadena+=$("#modulo").val();
            cadena+="-";
            cadena+=$("#modulo option:selected").text();
            cadena+="<br/>Submódulo:";
            cadena+=$("#submodulo option:selected").attr("clavesubmodulo");
            cadena+="-";
            cadena+=$("#submodulo option:selected").text();
            info.push(cadena);
            break;
        case "tl":
            cadena=$("#tipoInfo option:selected").text();
            cadena+=":";
            cadena+=$("#taller option:selected").text();
            cadena+=" - "+$("#horasTaller").val()+" horas";
            info.push(cadena);
            break;
        default:
            break;
    }
    fila="";
   for(c=0;c<info.length;c++){
        fila+="<tr>";
        fila+=   "<td>"+info[c]+"</td>";
        fila+="<td><input type='button' class='btn btn-link btn-sm' value='Borrar' onclick='borrarHoras("+c+")' /></td>";
        fila+="</tr>";
   }
   if(fila!=""){
        if(fila.includes("INGLES")||fila.includes("CENNI")||fila.includes("INGLÉS")){
             $("#seccionCENNI").removeAttr("hidden");
             $("#nivelCENNI").attr("required","true");
             $("#folio").attr("required","true");
         }else{
             $("#seccionCENNI").attr("hidden","true");
             $("#nivelCENNI").removeAttr("required");
             $("#folio").removeAttr("required");
         }
     }else{
         fila='<td colspan="2" class="text-center"><p class="text-danger">Sin información</p></td>';
     }
   
   $("#tablaInfo").html(fila);
   $("#modalInformacion").modal("hide");
   $("#tipoInfo").val("");
   cambioTipoInfo();
}
function borrarHoras(id){
    info.splice(id,1);
    fila="";
   for(c=0;c<info.length;c++){
        fila+="<tr>";
        fila+=   "<td>"+info[c]+"</td>";
        fila+="<td><input type='button' class='btn btn-link btn-sm' value='Borrar' onclick='borrarHoras("+c+")' /></td>";
        fila+="</tr>";
   }
   if(fila!=""){
        if(fila.includes("INGLES")||fila.includes("CENNI")||fila.includes("INGLÉS")){
             $("#seccionCENNI").removeAttr("hidden");
             $("#nivelCENNI").attr("required","true");
             $("#folio").attr("required","true");
         }else{
             $("#seccionCENNI").attr("hidden","true");
             $("#nivelCENNI").removeAttr("required");
             $("#folio").removeAttr("required");
         }
    }else{
         fila='<td colspan="2" class="text-center"><p class="text-danger">Sin información</p></td>';
     }
   
   $("#tablaInfo").html(fila);
}
function mostrarSiguiente(id){
    switch(id){
        case 1:
            $("#infoAcademica").collapse("hide");
            $("#panelInfoLaboral").removeAttr("hidden");
            $("#infoLaboral").collapse("show");
            break;
        case 2:  
            if($("#activoServicio").is(':checked')){
                if($("#notaDesfavorable").is(':checked')){
                    $("#mensaje").html("Su registro será rechazado debido a que cuenta con nota desfavorable y/o sanción administrativa.");
                    $("#modalMensaje").modal("show");
                }else{
                    $("#infoLaboral").collapse("hide");
                    $("#panelInfoHoras").removeAttr("hidden");
                    $("#infoHoras").collapse("show");
                }
            }else{
                $("#mensaje").html("Su registro será rechazado debido a que no se encuentra activo en el servicio.");
                $("#modalMensaje").modal("show");
            }
            break;
        case 3:
            if($("#frenteGrupo").is(':checked')){
                $("#infoHoras").collapse("hide");
                $("#panelInfoCompatibilidad").removeAttr("hidden");
                $("#infoCompatibilidad").collapse("show");
            }else{
                $("#mensaje").html("Su registro será rechazado debido a que no se encuentra frente a grupo.");
                $("#modalMensaje").modal("show");
            }
            break;
        case 4:
            if($("#compatibilidad").is(':checked')){
                $("#mensaje").html("Registro exitoso.");                
            }else{
                $("#mensaje").html("Su registro será rechazado debido a que no cuenta con la compatibilidad.");
            }
            $("#modalMensaje").modal("show");
            break;
        default:
            break;
    }
}

function abrirModalArchivo(id){    
    $("#archivo").val("");
    if($("#btnEvidencia"+id).attr("value")=="Subir archivo"){        
        $("#ifArchivo").attr("hidden","true");
    }else{
        $("#ifArchivo").attr("src","Archivo?k="+id); 
        $("#ifArchivo").removeAttr("hidden");
    }
               
    $("#idArchivo").val(id);
    switch(id){
        case 1: 
            $("#tituloModal").html("Título");            
            break;
        case 2: 
            $("#tituloModal").html("Constancia CENNI");            
            break;
        case 3: 
            $("#tituloModal").html("Constancia de antigüedad");            
            break;  
        case 4: 
            $("#tituloModal").html("Nombramiento definitivo");            
            break;  
        case 5: 
            $("#tituloModal").html("Nota favorable y sin sanción administrativa");            
            break;      
        case 6: 
            $("#tituloModal").html("Constancia de horas frente a grupo");            
            break;
        case 7: 
            $("#tituloModal").html("Constancia de compatibilidad");            
            break;        
        case 8: 
            $("#tituloModal").html("Cédula profesional");            
            break;
        default:
            break;        
    }
    $("#modalArchivo").modal("show");
}
function abrirModalEjemplo(id){  
    $("#ifArchivoEjemplo").attr("src","Archivo?e="+id);     
              
    switch(id){
        case 1: 
            $("#tituloModalEjemplo").html("Título");            
            break;
        case 2: 
            $("#tituloModalEjemplo").html("Constancia CENNI");            
            break;
        case 3: 
            $("#tituloModalEjemplo").html("Constancia de antigüedad");            
            break;  
        case 4: 
            $("#tituloModalEjemplo").html("Nombramiento definitivo");            
            break;  
        case 5: 
            $("#tituloModalEjemplo").html("Nota favorable y sin sanción administrativa");            
            break;      
        case 6: 
            $("#tituloModalEjemplo").html("Constancia de horas frente a grupo");            
            break;
        case 7: 
            $("#tituloModalEjemplo").html("Constancia de compatibilidad");            
            break;        
        case 8: 
            $("#tituloModalEjemplo").html("Cédula profesional");            
            break;
        default:
            break;        
    }
    $("#modalEjemplo").modal("show");
}

function subirArchivo(){
    $("#modalArchivo").modal("hide");
    
    if(validaArchivo()){
        document.formArchivo.target="ifRespuesta";
        document.formArchivo.action="GuardarArchivo";
        document.formArchivo.submit();
        var id=$("#idArchivo").val(); 
        $("#btnEvidencia"+id).attr("value","Visualizar archivo");        
        $("#mensaje").html("El archivo fue cargado correctamente");
    }
    $("#modalMensaje").modal("show");
}

function validaArchivo(){
    var retorno=true;
    var elemento=document.getElementById("archivo");
    var fileName = elemento.files[0].name;
    var fileSize = elemento.files[0].size;

    if(fileSize > 1000000){
            $("#mensaje").html("El archivo no debe superar 1MB");    
            elemento.value = '';
            retorno=false;
    }else{
            var ext = fileName.split('.').pop();
            ext = ext.toLowerCase();            
            if(ext!="pdf"){
               $("#mensaje").html("Solo se aceptan archivos PDF"); 
               elemento.value = ''; // reset del valor               
               retorno=false;
            }            
    }
    return retorno;
}
/*function cambioCarrera(elemento){
    var carrera=elemento.value.toString();
    if(carrera.includes("INGLES")||carrera.includes("CENNI")){
        $("#seccionCENNI").removeAttr("hidden");
        $("#nivelCENNI").attr("required","true");
        $("#folio").attr("required","true");
    }else{
        $("#seccionCENNI").attr("hidden","true");
        $("#nivelCENNI").removeAttr("required");
        $("#folio").removeAttr("required");
    }
}*/
function cambioDocumento(elemento){
    if(elemento.value=="cedula"){
        $("#seccionCedula").removeAttr("hidden");
        $("#cedula").attr("required","true");
    }else{
        $("#seccionCedula").attr("hidden","true");
        $("#cedula").removeAttr("required");
    }
}
function cambioCategoria() {
    id=$("#categoriaAspirada").val(); 
    $.get("ConsultaCatalogos", {k: "9",i:id}, function(respuesta){
        $("#jornada").html(respuesta);
    });
    $.get("ConsultaCatalogos", {k: "10",i:id}, function(respuesta){
        $("#rbRequisitos").html("<label class='control-label'>Seleccione el requisito cumplido de acuerdo a su situación:</label>"+respuesta);
    }); 
}
function demoFromHTML() {
        var pdf = new jsPDF('p', 'pt', 'letter');
        // source can be HTML-formatted string, or a reference
        // to an actual DOM element from which the text will be scraped.
        source = $('#content')[0];

        // we support special element handlers. Register them with jQuery-style 
        // ID selector for either ID or node name. ("#iAmID", "div", "span" etc.)
        // There is no support for any other type of selectors 
        // (class, of compound) at this time.
        specialElementHandlers = {
            // element with id of "bypass" - jQuery style selector
            '#bypassme': function (element, renderer) {
                // true = "handled elsewhere, bypass text extraction"
                return true
            }
        };
        margins = {
            top: 80,
            bottom: 60,
            left: 40,
            width: 522
        };
        // all coords and widths are in jsPDF instance's declared units
        // 'inches' in this case
        pdf.fromHTML(
        source, // HTML string or DOM elem ref.
        margins.left, // x coord
        margins.top, { // y coord
            'width': margins.width, // max width of content on PDF
            'elementHandlers': specialElementHandlers
        },

        function (dispose) {
            // dispose: object with X, Y of the last line add to the PDF 
            //          this allow the insertion of new lines after html
            pdf.save('Test.pdf');
        }, margins);
    }


