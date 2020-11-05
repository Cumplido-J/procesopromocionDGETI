/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
$(document).ready(function () { 
    var $regex=/^([a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?)$/;
    var $regexRFC=/^([A-Z&Ñ]{3,4}[0-9]{2}(0[1-9]|1[012])(0[1-9]|[12][0-9]|3[01])[A-Z0-9]{2}[0-9A])$/;      
            
    $('#nivel').on('change',function(){
        switch($('#nivel').val()) {
            case 'N':
              $("#entidad").val("");
              $("#alertaEntidad").html("");
              $("#entidad").removeAttr("required");
              $("#entidad").addClass("disabled");
              $("#plantel").val("");
              $("#alertaPlantel").html("");
              $("#plantel").removeAttr("required");
              $("#plantel").addClass("disabled");
              break;
            case 'E':
              $("#entidad").val("");
              $("#alertaEntidad").html("*");
              $("#entidad").attr("required","true");
              $("#entidad").removeClass("disabled");
              $("#plantel").val("");
              $("#alertaPlantel").html("");
              $("#plantel").removeAttr("required");
              $("#plantel").addClass("disabled");
              break;
            default:
              $("#entidad").val("");
              $("#alertaEntidad").html("*");
              $("#entidad").attr("required","true");
              $("#entidad").removeClass("disabled");
              $("#plantel").val("");
              $("#alertaPlantel").html("*");
              $("#plantel").attr("required","true");
              $("#plantel").removeClass("disabled");
        } 
    });
    $('#correo').on('change',function(){
        if (!$("#correo").val().toLowerCase().match($regex)) {         
            $('#alertaCorreo').removeAttr('hidden'); 
            $('#correo').addClass('error'); 
        }
        else{
           $('#alertaCorreo').attr('hidden',true);
           $('#correo').removeClass('error'); 
        }
    });
    $('#usuario').on('change',function(){        
        if (!$('#usuario').val().toUpperCase().match($regexRFC)) {         
            $('#alertaUsuario').removeAttr('hidden');
            $('#usuario').addClass('error'); 
        }
        else{
           $('#alertaUsuario').attr('hidden',true);
           $('#usuario').removeClass('error'); 
        }
    });
    $('#formRegistro').submit(function(e) {
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
            'subsistema':{
                required: "Seleccione una opción"
            },
            'nivel':{
                required: "Seleccione una opción"
            },
            'usuario':{
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
            var aux=$("#btnEnviar").val();
            var permisos="";
            $('#formRegistro input[type=checkbox]').each(function(){
                if (this.checked) {
                    permisos += $(this).val()+';';
                }
            }); 
            $("#permisos").val(permisos);
            if (permisos!="") { 
                if ($("#correo").val().toLowerCase().match($regex) && $("#usuario").val().toUpperCase().match($regexRFC)) {                            
                    $.ajax({
                        type:$('#formRegistro').attr("method"),
                        url:$('#formRegistro').attr("action"),
                        data:$('#formRegistro').serialize(),
                        beforeSend:function(){
                            $("#btnEnviar").val("Guardando...");
                            $("#btnEnviar").attr("disabled","disabled");
                        },
                        complete:function(){
                           $("#btnEnviar").val(aux); 
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
                }
            }else{
                $('#alertaPermiso').removeAttr('hidden');
                $("#btnCerrar").removeAttr("style");
                $("#btnContinuar").attr("style","display:none;");
                $("#mensaje").html("Debe seleccionar al menos un permiso para asignar");            
                $("#modalMensaje").modal("show");
            }
            return false;
        }
    });
});



