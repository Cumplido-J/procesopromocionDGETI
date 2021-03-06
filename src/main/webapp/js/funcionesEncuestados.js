/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
$(document).ready(function () {
  //var $regexCorreo=/^([a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?)$/;                     
    var $regexCorreo=/^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
    $('#correo').keypress(function(){
        if (!$(this).val().match($regexCorreo)) {         
            $('#alertaCorreo').removeAttr('hidden');    
            $("#cbAviso").attr("disabled",true);
            $("#cbAviso").removeAttr("checked");
            $("#btnEnviar").attr("disabled",true);
            $('#correo').addClass('error'); 
        }
        else{
           $('#alertaCorreo').attr('hidden',true);
           $("#cbAviso").removeAttr("disabled");
           $('#correo').removeClass('error');
           $("#btnEnviar").removeAttr("disabled");
        }
    });
    $('#correo').keydown(function(){
        if (!$(this).val().match($regexCorreo)) {         
            $('#alertaCorreo').removeAttr('hidden');    
            $("#cbAviso").attr("disabled",true);
            $("#cbAviso").removeAttr("checked");
            $("#btnEnviar").attr("disabled",true);
            $('#correo').addClass('error'); 
        }
        else{
           $('#alertaCorreo').attr('hidden',true);
           $("#cbAviso").removeAttr("disabled");
           $('#correo').removeClass('error');
           $("#btnEnviar").removeAttr("disabled");
        }
    });
    $('#correo').keyup(function(){
        if (!$(this).val().match($regexCorreo)) {         
            $('#alertaCorreo').removeAttr('hidden');    
            $("#cbAviso").attr("disabled",true);
            $("#cbAviso").removeAttr("checked");
            $("#btnEnviar").attr("disabled",true);
            $('#correo').addClass('error'); 
        }
        else{
           $('#alertaCorreo').attr('hidden',true);
           $("#cbAviso").removeAttr("disabled");
           $('#correo').removeClass('error');
           $("#btnEnviar").removeAttr("disabled");
        }
    });
    $('#correo').change(function(){
        if (!$(this).val().match($regexCorreo)) {         
            $('#alertaCorreo').removeAttr('hidden');    
            $("#cbAviso").attr("disabled",true);
            $("#cbAviso").removeAttr("checked");
            $("#btnEnviar").attr("disabled",true);
            $('#correo').addClass('error'); 
        }
        else{
           $('#alertaCorreo').attr('hidden',true);
           $("#cbAviso").removeAttr("disabled");
           $('#correo').removeClass('error');
           $("#btnEnviar").removeAttr("disabled");
        }
    });
    var $regexCURP=/^([A-Z][AEIOUX][A-Z]{2}[0-9]{2}(0[1-9]|1[012])(0[1-9]|[12][0-9]|3[01])[MH]([ABCMTZ]S|[BCJMOT]C|[CNPST]L|[GNQ]T|[GQS]R|C[MH]|[MY]N|[DH]G|NE|VZ|DF|SP)[BCDFGHJ-NP-TV-Z]{3}[0-9A-Z][0-9])$/;
    $('#curp').on('keypress keydown keyup change',function(){
        if (!$(this).val().toUpperCase().match($regexCURP)) {         
            $('#alertaCURP').removeAttr('hidden');    
            $("#btnEnviar").attr("disabled",true);
            $('#curp').addClass('error'); 
        }
        else{
           $('#alertaCURP').attr('hidden',true);
           $("#btnEnviar").removeAttr("disabled");
           $('#curp').removeClass('error'); 
        }
    });
    $('#formRegistro').validate({ 
        messages: {            
            'curp':{
                required: "Campo requerido"                
            },
            'correo':{
                required: "Campo requerido"
            },
            'tipoEncuesta':{
                required: "Seleccione una opci??n"
            }
        },
        submitHandler:function(){
            var id=$("#tipoEncuesta").val();
            var c=$("#c"+id).html();
            if(c!="10"){
                $("#seccionBotones").attr("hidden",true);
                $("#seccionConfirmacion").removeAttr("hidden");
                $("#seccionBotonesConfirmacion").removeAttr("hidden");
                $("#respuesta").html("");
            }else{
                $("#respuesta").html("No se aceptan m??s registros para este tipo de encuesta");
            }
        }});
});

function mostrarModal(){
    $("#respuesta").html("");
    $("#formRegistro")[0].reset();
    $("#seccionBotones").removeAttr("hidden");
    $("#seccionConfirmacion").attr("hidden",true);
    $("#seccionBotonesConfirmacion").attr("hidden",true);
    $("#modalRegistro").modal("show");
}

function enviar(){
    //$("#modalConfirmacion").modal("hide");    
    $.ajax({
        type:$('#formRegistro').attr("method"),
        url:$('#formRegistro').attr("action"),
        data:$('#formRegistro').serialize(),
        beforeSend:function(){
            $("#btnSi").val("Guardando...");
            $("#btnSi").attr("disabled","disabled");
        },
        complete:function(){
           $("#btnSi").val("Si"); 
           $("#btnSi").removeAttr("disabled");
        },success:function(data){
            var aux=data.split("|");
            if(aux.length==2){  
                var id=$("#tipoEncuesta").val();
                //var fila="<tr><td>"+$("#curp").val()+"</td><td>"+$("#correo").val()+"</td></tr>";
                var fila=aux[0];
                var tabla="tabla"+id;
                var contenido=$("#"+tabla).html();
                $("#"+tabla).html(fila);
                /*if(contenido.includes("colspan")){
                    
                }else{
                    $("#"+tabla).html(contenido+fila);
                } */
                /*var contador=0;
                contador=parseInt($("#c"+id).html());
                contador++;*/
                var contador=aux[1];
                $("#c"+id).html(contador);
                if(contador=="10"){
                    $("#estatus"+id).attr("class","glyphicon glyphicon-ok-sign completo");
                    $("#estatus"+id).attr("title","Secci??n completa");
                    $("#estatus"+id).attr("completo",true);
                }   
                $("#modalRegistro").modal("hide");
                $('.nav-tabs a[href="#seccion'+id+'"]').tab('show');
                if($("#c1").html()=="10"&&$("#c2").html()=="10"&&$("#c3").html()=="10"){
                    $("#btnAgregar").attr("disabled",true);
                    $("#btnFinalizar").removeClass("disabled");
                }
            }else{                
                $("#respuesta").html(data);
                $("#seccionBotonesConfirmacion").attr("hidden",true);
                $("#seccionConfirmacion").attr("hidden",true);
                $("#seccionBotones").removeAttr("hidden");
            }
        },error:function(){

        }
    });
    return false;
}
function cancelar(){
    //$("#modalConfirmacion").modal("hide");
    $("#seccionBotonesConfirmacion").attr("hidden",true);
    $("#seccionConfirmacion").attr("hidden",true);
    $("#seccionBotones").removeAttr("hidden");
}
function cambioEncuesta(){
    $("#respuesta").html("");
}
function borrarEncuestado(idEncuestado,idTipo,idPeriodo){
    $("#btnCancelaPin").attr("onClick","cancelaPin("+idEncuestado+","+idTipo+","+idPeriodo+")");
    $("#modalConfirmacion").modal("show");
}
function cancelaPin(idEncuestado,idTipo,idPeriodo){
    $("#modalConfirmacion").modal("hide");
    $.post("CancelaPin", {i: idEncuestado,t:idTipo, p:idPeriodo}, function(data){
        var aux=data.split("|");
        if(aux.length==2){  
            var id=idTipo;
            var fila=aux[0];
            var contador=aux[1];
            var tabla="tabla"+id;
            var contenido=$("#"+tabla).html();
            $("#"+tabla).html(fila);
            $("#c"+id).html(contador);
            if(contador=="10"){
                $("#estatus"+id).attr("class","glyphicon glyphicon-ok-sign completo");
                $("#estatus"+id).attr("title","Secci??n completa");
                $("#estatus"+id).attr("completo",true);
            }
            $('.nav-tabs a[href="#seccion'+id+'"]').tab('show');
            if($("#c1").html()=="10"&&$("#c2").html()=="10"&&$("#c3").html()=="10"){
                $("#btnAgregar").attr("disabled",true);
                $("#btnFinalizar").removeClass("disabled");
            }
        }else{                
            $("#mensaje").html(data);
            $("#modalMensaje").modal();
            
        }
    });
}

function cambioObservaciones(objeto){
    if(objeto.value!=""){
        $("#btnFinalizar").removeAttr("disabled");    
    }else{
        $("#btnFinalizar").attr("disabled",true); 
    }
}