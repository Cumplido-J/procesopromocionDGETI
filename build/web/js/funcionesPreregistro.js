/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
$(document).ready(function () {
    var $regex=/^([a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?)$/;
    $('#correo').on('keypress keydown keyup',function(){
        if (!$(this).val().match($regex)) {         
            $('#alertaCorreo').removeAttr('hidden');    
            $("#btnEnviar").attr("disabled",true);
            $('#correo').addClass('error'); 
        }
        else{
           $('#alertaCorreo').attr('hidden',true);
           $("#btnEnviar").removeAttr("disabled");
           $('#correo').removeClass('error'); 
        }
    });
    $('#formPreregistro').submit(function(e) {
        e.preventDefault();
    }).validate({        
        rules: {
            'movil':{
                number:true,
                minlength:10,
                maxlength:10
            },
            'fijo':{
                number:true,
                minlength:10,
                maxlength:10
            },
            'pass1':{
                minlength:4
            },
            'pass2':{
                minlength:4,
                equalTo:"#pass1"
            }
        },
        messages: {
            'programa':{
                required: "Seleccione una opción"
            },
            'rfc':{
                required: "Campo requerido"
            },
            'nombre':{
                required: "Campo requerido"
            },
            'apellido1':{
                required: "Campo requerido"
            },
            'apellido2':{
                required: "Campo requerido"
            },            
            'entidad': {
                required: "Seleccione una opción"
            },
            'plantel':{
                required: "Seleccione una opción"
            },
            'fijo':{
                required: "Campo requerido",
                number:"Ingrese solo números",
                minlength:"Ingrese el número a diez dígitos",
                maxlength:"Ingrese el número a diez dígitos"
            },            
            'movil':{
                required: "Campo requerido",
                number:"Ingrese solo números",
                minlength:"Ingrese el número a diez dígitos",
                maxlength:"Ingrese el número a diez dígitos"
            },
            'correo':{
                required: "Campo requerido"
            },
            'consideraciones':{
                required: "Campo requerido"
            },
            'pass1':{
                required: "Campo requerido",
                minlength:"Ingrese al menos cuatro caracteres"
            },
            'pass2':{
                required: "Campo requerido",
                equalTo:"Las contraseñas no coinciden",
                minlength:"Ingrese al menos cuatro caracteres"
            }
        },
        submitHandler:function(){
            $.ajax({
                type:$('#formPreregistro').attr("method"),
                url:$('#formPreregistro').attr("action"),
                data:$('#formPreregistro').serialize(),
                beforeSend:function(){
                    $("#btnEnviar").val("Guardando...");
                    $("#btnEnviar").attr("disabled","disabled");
                },
                complete:function(){
                   $("#btnEnviar").val("Guardar"); 
                   $("#btnEnviar").removeAttr("disabled");
                },success:function(data){
                    if(data=="ok"){           
                        $("#btnContinuar").removeAttr("style");
                        $("#btnCerrar").attr("style","display:none;");
                        $("#mensaje").html("Los datos fueron almacenados correctamente");            
                        $("#modalMensaje").modal("show");
                        
                    }else{
                        $("#btnCerrar").removeAttr("style");
                        $("#btnContinuar").attr("style","display:none;");
                        $("#mensaje").html(data);            
                        $("#modalMensaje").modal("show");                        
                    }
                },error:function(){
                    
                }
            });
            return false;
        }
    });
});
function consultaWS(){
    var rfc=$("#rfc").val().toUpperCase();
    var $regexRFC=/^([A-Z&Ñ]{3,4}[0-9]{2}(0[1-9]|1[012])(0[1-9]|[12][0-9]|3[01])[A-Z0-9]{2}[0-9A])$/;  
    if(rfc.length>0){
        if (!rfc.match($regexRFC)) {
            $('#alertaRFC').removeAttr('hidden'); 
            $('#rfc').addClass('error'); 
            $("#btnEnviar").attr("disabled",true);
        }
        else{
             $('#alertaRFC').attr('hidden',true);
             $('#rfc').removeClass('error'); 
             $("#btnEnviar").removeAttr("disabled");
             $.post("ConsultaWSPersonal", {rfc: rfc}, function(respuesta){
                var aux=respuesta.split("|");
                if(aux.length==5){
                    if(aux[0]!=""){
                        $("#nombre").val(aux[0]);
                        $("#nombre").attr("readOnly","readOnly");
                    }else{
                       $("#nombre").val("");
                       $("#nombre").removeAttr("readOnly"); 
                    }
                    if(aux[1]!=""){
                        $("#apellido1").val(aux[1]);
                        $("#apellido1").attr("readOnly","readOnly");
                    }else{
                        $("#apellido1").val("");
                        $("#apellido1").removeAttr("readOnly");
                    }
                    if(aux[2]!=""){
                        $("#apellido2").val(aux[2]);
                        $("#apellido2").attr("readOnly","readOnly");
                    }else{
                        $("#apellido2").val("");
                        $("#apellido2").removeAttr("readOnly");
                    }
                    if(aux[3]!=""){
                        $("#entidad").val(aux[3]);
                        $("#entidad").attr("style", "pointer-events: none;");
                        $("#entidad").attr("readOnly","readOnly");
                        actualizarPlanteles(aux[4]);
                        $("#plantel").attr("style", "pointer-events: none;");
                        $("#plantel").attr("readOnly","readOnly");
                    }else{
                        $("#entidad").val("");
                        $("#entidad").removeAttr("style");
                        $("#entidad").removeAttr("readOnly");
                        $("#plantel").html("<option value=''>-Seleccione-</option>");
                        $("#plantel").removeAttr("style");
                        $("#plantel").removeAttr("readOnly");
                    }

                }
            });
        }
    }else{
        $('#alertaRFC').attr('hidden',true);
    }
           
}
function actualizarPlanteles(idPlantel) {
    idEntidad=$("#entidad").val();
    $.get("ConsultaCatalogos", {k: "13",i:idEntidad}, function(respuesta){
        $("#plantel").html(respuesta);
        if(idPlantel!=null){
            $("#plantel").val(idPlantel);
        }
    });  
}

