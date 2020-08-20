/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
$(document).ready(function () {
    $( "#inicioCurso" ).datepicker({changeMonth:true, changeYear: true});
    $( "#finCurso" ).datepicker({changeMonth:true, changeYear: true});
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
                        $("#tablaCursos").html(data);   
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
    }else{
        $("#seccionCarga").removeClass("disabled");
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

function puntaje(id){
    var puntaje=$("#sp"+id+" option:selected").attr("puntaje");
    $("#p"+id).html("Puntaje:"+puntaje);
}

function pmultiple(){
    var p=0;
    if($("#cb10a").is(':checked')){
        p+=25;
    }
    if($("#cb10b").is(':checked')){
        p+=25;
    }
    p+=parseInt($("#sp102 option:selected").attr("puntaje"));
    p+=parseInt($("#sp103 option:selected").attr("puntaje"));
    p+=parseInt($("#sp104 option:selected").attr("puntaje"));
    p+=parseInt($("#sp105 option:selected").attr("puntaje"));
    $("#p10").html("Puntaje:"+p);
}

function abrirModalCursos(){
    $("#formCursos")[0].reset();
    $("#modalCursos").modal("show");
}

function abrirModalAportaciones(){
    $("#formAportacion")[0].reset();
    $("#modalAportaciones").modal("show");
}