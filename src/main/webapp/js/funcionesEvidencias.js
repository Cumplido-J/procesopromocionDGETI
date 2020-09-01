/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
$(document).ready(function () {
    $( "#inicioCurso" ).datepicker({changeMonth:true, changeYear: true,endDate: new Date()});
    $( "#finCurso" ).datepicker({changeMonth:true, changeYear: true,endDate: new Date()});
    $( "#inicioAportacion" ).datepicker({changeMonth:true, changeYear: true,endDate: new Date()});
    $( "#finAportacion" ).datepicker({changeMonth:true, changeYear: true,endDate: new Date()});
    $( "#inicioParticipacion" ).datepicker({changeMonth:true, changeYear: true,endDate: new Date()});
    $( "#finParticipacion" ).datepicker({changeMonth:true, changeYear: true,endDate: new Date()});
    $( "#inicioTutoria" ).datepicker({changeMonth:true, changeYear: true,endDate: new Date()});
    $( "#finTutoria" ).datepicker({changeMonth:true, changeYear: true,endDate: new Date()});
    $( "#fechaPublicacion" ).datepicker({changeMonth:true, changeYear: true,endDate: new Date()});
    $( "#inicioResultado" ).datepicker({changeMonth:true, changeYear: true,endDate: new Date()});
    $( "#finResultado" ).datepicker({changeMonth:true, changeYear: true,endDate: new Date()});
    
    $('#form1').submit(function(e) {
        e.preventDefault();
    }).validate({
        messages: {
            'puntaje': {
                required: "Seleccione una opción"
            }
        },
        submitHandler:function(){
            $.ajax({
                type:$('#form1').attr("method"),
                url:$('#form1').attr("action"),
                data:$('#form1').serialize(),
                beforeSend:function(){
                    $("#btnEnviar1").val("Guardando...");
                    $("#btnEnviar1").attr("disabled","disabled");
                },
                complete:function(){
                   $("#btnEnviar1").val("Guardar y continuar"); 
                   $("#btnEnviar1").removeAttr("disabled");
                },success:function(data){
                    if(isNaN(data)){
                        $("#mensaje").html(data);            
                        $("#modalMensaje").modal("show");
                    }
                    else{                        
                        $("#p1").html(data); 
                        $("#mensaje").html("Información guardada correctamente");            
                        $("#modalMensaje").modal("show");
                    }
                }
            });
            return false;
        }
    });
    $('#form2').submit(function(e) {
        e.preventDefault();
    }).validate({
        messages: {
            'puntaje': {
                required: "Seleccione una opción"
            }
        },
        submitHandler:function(){
            $.ajax({
                type:$('#form2').attr("method"),
                url:$('#form2').attr("action"),
                data:$('#form2').serialize(),
                beforeSend:function(){
                    $("#btnEnviar2").val("Guardando...");
                    $("#btnEnviar2").attr("disabled","disabled");
                },
                complete:function(){
                   $("#btnEnviar2").val("Guardar y continuar"); 
                   $("#btnEnviar2").removeAttr("disabled");
                },success:function(data){
                    if(isNaN(data)){
                        $("#mensaje").html(data);            
                        $("#modalMensaje").modal("show");
                    }
                    else{                        
                        $("#p2").html(data); 
                        $("#mensaje").html("Información guardada correctamente");            
                        $("#modalMensaje").modal("show");
                    }
                }
            });
            return false;
        }
    });
    $('#form4').submit(function(e) {
        e.preventDefault();
    }).validate({
        messages: {
            'puntaje': {
                required: "Seleccione una opción"
            }
        },
        submitHandler:function(){
            $.ajax({
                type:$('#form4').attr("method"),
                url:$('#form4').attr("action"),
                data:$('#form4').serialize(),
                beforeSend:function(){
                    $("#btnEnviar4").val("Guardando...");
                    $("#btnEnviar4").attr("disabled","disabled");
                },
                complete:function(){
                   $("#btnEnviar4").val("Guardar y continuar"); 
                   $("#btnEnviar4").removeAttr("disabled");
                },success:function(data){
                    if(isNaN(data)){
                        $("#mensaje").html(data);            
                        $("#modalMensaje").modal("show");
                    }
                    else{                        
                        $("#p4").html(data); 
                        $("#mensaje").html("Información guardada correctamente");            
                        $("#modalMensaje").modal("show");
                    }
                }
            });
            return false;
        }
    });
    $('#form5').submit(function(e) {
        e.preventDefault();
    }).validate({        
        submitHandler:function(){
            $.ajax({
                type:$('#form5').attr("method"),
                url:$('#form5').attr("action"),
                data:$('#form5').serialize(),
                beforeSend:function(){
                    $("#btnEnviar5").val("Guardando...");
                    $("#btnEnviar5").attr("disabled","disabled");
                },
                complete:function(){
                   $("#btnEnviar5").val("Guardar y continuar"); 
                   $("#btnEnviar5").removeAttr("disabled");
                },success:function(data){
                    if(isNaN(data)){
                        $("#mensaje").html(data);            
                        $("#modalMensaje").modal("show");
                    }
                    else{                        
                        $("#p5").html(data); 
                        $("#mensaje").html("Información guardada correctamente");            
                        $("#modalMensaje").modal("show");
                    }
                }
            });
            return false;
        }
    });
    $('#form6').submit(function(e) {
        e.preventDefault();
    }).validate({        
        submitHandler:function(){
            $.ajax({
                type:$('#form6').attr("method"),
                url:$('#form6').attr("action"),
                data:$('#form6').serialize(),
                beforeSend:function(){
                    $("#btnEnviar6").val("Guardando...");
                    $("#btnEnviar6").attr("disabled","disabled");
                },
                complete:function(){
                   $("#btnEnviar6").val("Guardar y continuar"); 
                   $("#btnEnviar6").removeAttr("disabled");
                },success:function(data){
                    if(isNaN(data)){
                        $("#mensaje").html(data);            
                        $("#modalMensaje").modal("show");
                    }
                    else{                        
                        $("#p6").html(data); 
                        $("#mensaje").html("Información guardada correctamente");            
                        $("#modalMensaje").modal("show");
                    }
                }
            });
            return false;
        }
    });
    $('#form7').submit(function(e) {
        e.preventDefault();
    }).validate({        
        submitHandler:function(){
            $.ajax({
                type:$('#form7').attr("method"),
                url:$('#form7').attr("action"),
                data:$('#form7').serialize(),
                beforeSend:function(){
                    $("#btnEnviar7").val("Guardando...");
                    $("#btnEnviar7").attr("disabled","disabled");
                },
                complete:function(){
                   $("#btnEnviar7").val("Guardar y continuar"); 
                   $("#btnEnviar7").removeAttr("disabled");
                },success:function(data){
                    if(isNaN(data)){
                        $("#mensaje").html(data);            
                        $("#modalMensaje").modal("show");
                    }
                    else{                        
                        $("#p7").html(data); 
                        $("#mensaje").html("Información guardada correctamente");            
                        $("#modalMensaje").modal("show");
                    }
                }
            });
            return false;
        }
    });
    $('#form8').submit(function(e) {
        e.preventDefault();
    }).validate({        
        submitHandler:function(){
            $.ajax({
                type:$('#form8').attr("method"),
                url:$('#form8').attr("action"),
                data:$('#form8').serialize(),
                beforeSend:function(){
                    $("#btnEnviar8").val("Guardando...");
                    $("#btnEnviar8").attr("disabled","disabled");
                },
                complete:function(){
                   $("#btnEnviar8").val("Guardar y continuar"); 
                   $("#btnEnviar8").removeAttr("disabled");
                },success:function(data){
                    if(isNaN(data)){
                        $("#mensaje").html(data);            
                        $("#modalMensaje").modal("show");
                    }
                    else{                        
                        $("#p8").html(data); 
                        $("#mensaje").html("Información guardada correctamente");            
                        $("#modalMensaje").modal("show");
                    }
                }
            });
            return false;
        }
    });
    $('#form9').submit(function(e) {
        e.preventDefault();
    }).validate({        
        submitHandler:function(){
            $.ajax({
                type:$('#form9').attr("method"),
                url:$('#form9').attr("action"),
                data:$('#form9').serialize(),
                beforeSend:function(){
                    $("#btnEnviar9").val("Guardando...");
                    $("#btnEnviar9").attr("disabled","disabled");
                },
                complete:function(){
                   $("#btnEnviar9").val("Guardar y continuar"); 
                   $("#btnEnviar9").removeAttr("disabled");
                },success:function(data){
                    if(isNaN(data)){
                        $("#mensaje").html(data);            
                        $("#modalMensaje").modal("show");
                    }
                    else{                        
                        $("#p9").html(data); 
                        $("#mensaje").html("Información guardada correctamente");            
                        $("#modalMensaje").modal("show");
                    }
                }
            });
            return false;
        }
    });
    $('#form10').submit(function(e) {
        e.preventDefault();
    }).validate({
        messages: {
            'puntaje10': {
                required: "Seleccione una opción"
            },
            'puntaje11': {
                required: "Seleccione una opción"
            },
            'puntaje12': {
                required: "Seleccione una opción"
            },
            'puntaje13': {
                required: "Seleccione una opción"
            },
            'puntaje14': {
                required: "Seleccione una opción"
            }
        },
        submitHandler:function(){
            $.ajax({
                type:$('#form10').attr("method"),
                url:$('#form10').attr("action"),
                data:$('#form10').serialize(),
                beforeSend:function(){
                    $("#btnEnviar10").val("Guardando...");
                    $("#btnEnviar10").attr("disabled","disabled");
                },
                complete:function(){
                   $("#btnEnviar10").val("Guardar y continuar"); 
                   $("#btnEnviar10").removeAttr("disabled");
                },success:function(data){
                    if(isNaN(data)){
                        $("#mensaje").html(data);            
                        $("#modalMensaje").modal("show");
                    }
                    else{
                        var puntaje=parseInt(data)+parseInt($("#pEvidencias").val());                        
                        $("#p10").html(puntaje); 
                        $("#mensaje").html("Información guardada correctamente");            
                        $("#modalMensaje").modal("show");
                    }
                }
            });
            return false;
        }
    });
    $('#formCursos').submit(function(e) {
        e.preventDefault();
    }).validate({
        rules:{            
            'horasCurso': {
                number: true
            }
        },
        messages: {
            'tipo': {
                required: "Seleccione una opción"
            },
            'nombreCurso': {
                required: "Campo requerido"
            },
            'inicioCurso': {
                required: "Campo requerido"
            },
            'finCurso': {
                required: "Campo requerido"
            },
            'institucionCurso': {
                required: "Campo requerido"
            },
            'horasCurso': {
                required: "Campo requerido",
                number:"Ingrese sólo números"
            },
            'documento': {
                required: "Campo requerido"
            }
        },
        submitHandler:function(){
            $.ajax({
                type:$('#formCursos').attr("method"),
                url:$('#formCursos').attr("action"),
                data:$('#formCursos').serialize(),
                beforeSend:function(){
                    $("#btnEnviarCurso").val("Guardando...");
                    $("#btnEnviarCurso").attr("disabled","disabled");
                },
                complete:function(){
                   $("#btnEnviarCurso").val("Guardar"); 
                   $("#btnEnviarCurso").removeAttr("disabled");
                   $("#modalCursos").modal("hide");
                },success:function(data){
                    if(data.includes("<tr>")){
                        var aux=data.split("||");
                        $("#tablaCursos").html(aux[0]);
                        $("#p5").html(aux[1]);
                    }
                    else{
                        $("#mensaje").html(data);            
                        $("#modalMensaje").modal("show");
                    }                    
                }
            });
            return false;
        }
    });
    $('#formAportacion').submit(function(e) {
        e.preventDefault();
    }).validate({
        messages: {
            'idAportacion': {
                required: "Seleccione una opción"
            },
            'aportacion': {
                required: "Campo requerido"
            },
            'inicioAportacion': {
                required: "Campo requerido"
            },
            'finAportacion': {
                required: "Campo requerido"
            },
            'institucionAportacion': {
                required: "Campo requerido"
            },
            'documento': {
                required: "Campo requerido"
            }
        },
        submitHandler:function(){
            $.ajax({
                type:$('#formAportacion').attr("method"),
                url:$('#formAportacion').attr("action"),
                data:$('#formAportacion').serialize(),
                beforeSend:function(){
                    $("#btnEnviarAportacion").val("Guardando...");
                    $("#btnEnviarAportacion").attr("disabled","disabled");
                },
                complete:function(){
                   $("#btnEnviarAportacion").val("Guardar"); 
                   $("#btnEnviarAportacion").removeAttr("disabled");
                   $("#modalAportaciones").modal("hide");
                },success:function(data){
                    if(data.includes("<tr>")){
                        var aux=data.split("||");
                        $("#tablaAportaciones").html(aux[0]);
                        $("#p6").html(aux[1]);
                    }
                    else{
                        $("#mensaje").html(data);            
                        $("#modalMensaje").modal("show");
                    }                    
                }
            });
            return false;
        }
    });
    $('#formParticipacion').submit(function(e) {
        e.preventDefault();
    }).validate({
        messages: {
            'idParticipacion': {
                required: "Seleccione una opción"
            },
            'participacion': {
                required: "Campo requerido"
            },
            'inicioParticipacion': {
                required: "Campo requerido"
            },
            'finParticipacion': {
                required: "Campo requerido"
            },
            'institucionParticipacion': {
                required: "Campo requerido"
            },
            'documento': {
                required: "Campo requerido"
            }
        },
        submitHandler:function(){
            $.ajax({
                type:$('#formParticipacion').attr("method"),
                url:$('#formParticipacion').attr("action"),
                data:$('#formParticipacion').serialize(),
                beforeSend:function(){
                    $("#btnEnviarParticipacion").val("Guardando...");
                    $("#btnEnviarParticipacion").attr("disabled","disabled");
                },
                complete:function(){
                   $("#btnEnviarParticipacion").val("Guardar"); 
                   $("#btnEnviarParticipacion").removeAttr("disabled");
                   $("#modalParticipacion").modal("hide");
                },success:function(data){
                    if(data.includes("<tr>")){
                        var aux=data.split("||");
                        $("#tablaParticipaciones").html(aux[0]);
                        $("#p7").html(aux[1]);
                    }
                    else{
                        $("#mensaje").html(data);            
                        $("#modalMensaje").modal("show");
                    }                    
                }
            });
            return false;
        }
    });
    $('#formTutoria').submit(function(e) {
        e.preventDefault();
    }).validate({
        messages: {            
            'inicioTutoria': {
                required: "Campo requerido"
            },
            'finTutoria': {
                required: "Campo requerido"
            },
            'documento': {
                required: "Campo requerido"
            }
        },
        submitHandler:function(){
            $.ajax({
                type:$('#formTutoria').attr("method"),
                url:$('#formTutoria').attr("action"),
                data:$('#formTutoria').serialize(),
                beforeSend:function(){
                    $("#btnEnviarTutoria").val("Guardando...");
                    $("#btnEnviarTutoria").attr("disabled","disabled");
                },
                complete:function(){
                   $("#btnEnviarTutoria").val("Guardar"); 
                   $("#btnEnviarTutoria").removeAttr("disabled");
                   $("#modalTutoria").modal("hide");
                },success:function(data){
                    if(data.includes("<tr>")){
                        var aux=data.split("||");
                        $("#tablaTutorias").html(aux[0]);
                        $("#p8").html(aux[1]);   
                    }
                    else{
                        $("#mensaje").html(data);            
                        $("#modalMensaje").modal("show");
                    }                    
                }
            });
            return false;
        }
    });
    $('#formPublicacion').submit(function(e) {
        e.preventDefault();
    }).validate({
        messages: {            
            'nombre': {
                required: "Campo requerido"
            },
            'tipo': {
                required: "Seleccione una opción"
            },
            'fecha': {
                required: "Campo requerido"
            },
            'ISSN': {
                required: "Campo requerido"
            }
        },
        submitHandler:function(){
            $.ajax({
                type:$('#formPublicacion').attr("method"),
                url:$('#formPublicacion').attr("action"),
                data:$('#formPublicacion').serialize(),
                beforeSend:function(){
                    $("#btnEnviarPublicacion").val("Guardando...");
                    $("#btnEnviarPublicacion").attr("disabled","disabled");
                },
                complete:function(){
                   $("#btnEnviarPublicacion").val("Guardar"); 
                   $("#btnEnviarPublicacion").removeAttr("disabled");
                   $("#modalPublicacion").modal("hide");
                },success:function(data){
                    if(data.includes("<tr>")){
                        var aux=data.split("||");
                        $("#tablaPublicaciones").html(aux[0]);
                        $("#p9").html(aux[1]);
                    }
                    else{
                        $("#mensaje").html(data);            
                        $("#modalMensaje").modal("show");
                    }                    
                }
            });
            return false;
        }
    });
    $('#formResultado').submit(function(e) {
        e.preventDefault();
    }).validate({
        messages: {  
            'idResultado': {
                required: "Seleccione una opción"
            },
            'resultado': {
                required: "Campo requerido"
            },
            'documento': {
                required: "Campo requerido"
            },
            'inicioResultado': {
                required: "Campo requerido"
            },
            'finResultado': {
                required: "Campo requerido"
            }
        },
        submitHandler:function(){
            $.ajax({
                type:$('#formResultado').attr("method"),
                url:$('#formResultado').attr("action"),
                data:$('#formResultado').serialize(),
                beforeSend:function(){
                    $("#btnEnviarResultado").val("Guardando...");
                    $("#btnEnviarResultado").attr("disabled","disabled");
                },
                complete:function(){
                   $("#btnEnviarResultado").val("Guardar"); 
                   $("#btnEnviarResultado").removeAttr("disabled");
                   $("#modalResultado").modal("hide");
                },success:function(data){
                    if(data.includes("<tr>")){
                        var aux=data.split("||");
                        $("#tablaResultados").html(aux[0]);
                        $("#pEvidencias").val(aux[1]);  
                    }
                    else{
                        $("#mensaje").html(data);            
                        $("#modalMensaje").modal("show");
                    }                    
                }
            });
            return false;
        }
    });
});

function abrirModalArchivo(id){  
    if(id<9){
        $("#seccionCarga").addClass("disabled");
        $("#alertaCarga").addClass("hidden");
    }else{
        $("#seccionCarga").removeClass("disabled");
        $("#alertaCarga").removeClass("hidden");
    }
    $("#archivo").val("");
    if($("#btnEvidencia"+id).attr("value")=="Subir archivo"){        
        $("#ifArchivo").attr("hidden","true");
    }else{
        $("#ifArchivo").attr("src","Archivo?k="+id); 
        $("#ifArchivo").removeAttr("hidden");
    }
               
    $("#idArchivo").val(id);    
    $("#modalArchivo").modal("show");
}
function subirArchivo(){
    $("#modalArchivo").modal("hide");
    
    if(validaArchivo()){
        document.formArchivo.target="ifRespuesta";
        document.formArchivo.action="GuardarArchivo";
        document.formArchivo.submit();
        var id=$("#idArchivo").val(); 
        $("#btnEvidencia"+id).attr("value","Ver archivo");
        $("#alertaBtnEvidencia"+id).attr("style","display:none;");
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

function abrirModalCursos(){
    $("#formCursos")[0].reset();
    $("#modalCursos").modal("show");
}

function abrirModalAportaciones(){
    $("#formAportacion")[0].reset();
    $("#aportacion").addClass("hidden");
    $("#modalAportaciones").modal("show");
}
function abrirModalParticipaciones(){
    $("#formParticipacion")[0].reset();
    $("#participacion").addClass("hidden");
    $("#modalParticipacion").modal("show");
}
function abrirModalTutorias(){
    $("#formTutoria")[0].reset();    
    $("#modalTutoria").modal("show");
}
function abrirModalPublicacion(){
    $("#formPublicacion")[0].reset();    
    $("#modalPublicacion").modal("show");
}
function abrirModalResultado(){
    $("#formResultado")[0].reset(); 
    $("#resultado").addClass("hidden");
    $("#modalResultado").modal("show");
}

function confirmarCurso(id){
    $("#btnConfirmar").attr("onClick","borrarCurso("+id+")");
    $("#modalConfirmacion").modal("show");
}
function borrarCurso(id){
    $("#modalConfirmacion").modal("hide");
    $.post("RegistrarCurso", {id: id}, function(data){
        if(data.includes("<tr>")){
            var aux=data.split("||");
            $("#tablaCursos").html(aux[0]);
            $("#p5").html(aux[1]);  
        }
        else{
            $("#mensaje").html(data);            
            $("#modalMensaje").modal("show");
        } 
    });
}

function cambioAportacion(){
    var id=$("#idAportacion").val();
    if(id=='-1'){
        $("#aportacion").removeClass("hidden");
        $("#aportacion").attr("required",true);
    }else{
        $("#aportacion").removeAttr("required");
        $("#aportacion").addClass("hidden");
        $("#aportacion").val("");
    }
}

function confirmarAportacion(id){
    $("#btnConfirmar").attr("onClick","borrarAportacion("+id+")");
    $("#modalConfirmacion").modal("show");
}
function borrarAportacion(id){
    $("#modalConfirmacion").modal("hide");
    $.post("RegistrarAportacion", {id: id}, function(data){
        if(data.includes("<tr>")){
            var aux=data.split("||");
            $("#tablaAportaciones").html(aux[0]);
            $("#p6").html(aux[1]);
        }
        else{
            $("#mensaje").html(data);            
            $("#modalMensaje").modal("show");
        } 
    });
}
function cambioParticipacion(){
    var id=$("#idParticipacion").val();
    if(id=='-1'){
        $("#participacion").removeClass("hidden");
        $("#participacion").attr("required",true);
    }else{
        $("#participacion").removeAttr("required");
        $("#participacion").addClass("hidden");
        $("#participacion").val("");
    }
}

function confirmarParticipacion(id){
    $("#btnConfirmar").attr("onClick","borrarParticipacion("+id+")");
    $("#modalConfirmacion").modal("show");
}
function borrarParticipacion(id){
    $("#modalConfirmacion").modal("hide");
    $.post("RegistrarParticipacion", {id: id}, function(data){
        if(data.includes("<tr>")){
            var aux=data.split("||");
            $("#tablaParticipaciones").html(aux[0]);
            $("#p7").html(aux[1]);
        }
        else{
            $("#mensaje").html(data);            
            $("#modalMensaje").modal("show");
        } 
    });
}
function confirmarTutoria(id){
    $("#btnConfirmar").attr("onClick","borrarTutoria("+id+")");
    $("#modalConfirmacion").modal("show");
}
function borrarTutoria(id){
    $("#modalConfirmacion").modal("hide");
    $.post("RegistrarTutoria", {id: id}, function(data){
        if(data.includes("<tr>")){
            var aux=data.split("||");
            $("#tablaTutorias").html(aux[0]);
            $("#p8").html(aux[1]);
        }
        else{
            $("#mensaje").html(data);            
            $("#modalMensaje").modal("show");
        } 
    });
}
function confirmarPublicacion(id){
    $("#btnConfirmar").attr("onClick","borrarPublicacion("+id+")");
    $("#modalConfirmacion").modal("show");
}
function borrarPublicacion(id){
    $("#modalConfirmacion").modal("hide");
    $.post("RegistrarPublicacion", {id: id}, function(data){
        if(data.includes("<tr>")){
            var aux=data.split("||");
            $("#tablaPublicaciones").html(aux[0]);
            $("#p9").html(aux[1]);   
        }
        else{
            $("#mensaje").html(data);            
            $("#modalMensaje").modal("show");
        } 
    });
}
function confirmarResultado(id){
    $("#btnConfirmar").attr("onClick","borrarResultado("+id+")");
    $("#modalConfirmacion").modal("show");
}
function borrarResultado(id){
    $("#modalConfirmacion").modal("hide");
    $.post("RegistrarResultado", {id: id}, function(data){
        if(data.includes("<tr>")){
            var aux=data.split("||");
            $("#tablaResultados").html(aux[0]);
            $("#pEvidencias").val(aux[1]);
        }
        else{
            $("#mensaje").html(data);            
            $("#modalMensaje").modal("show");
        } 
    });
}
function cambioResultado(){
    var id=$("#idResultado").val();
    if(id=='-1'){
        $("#resultado").removeClass("hidden");
        $("#resultado").attr("required",true);
    }else{
        $("#resultado").removeAttr("required");
        $("#resultado").addClass("hidden");
        $("#resultado").val("");
    }
}