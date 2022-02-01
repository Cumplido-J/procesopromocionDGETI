/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
$(document).ready(function () { 
//    var $regex=/^([a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?)$/;
    var $regex=/^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
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
    $('#correo').on('keypress keydown keyup change',function(){
        if (!$("#correo").val().toLowerCase().match($regex)) {         
            $('#alertaCorreo').removeAttr('hidden'); 
            $('#correo').addClass('error'); 
        }
        else{
           $('#alertaCorreo').attr('hidden',true);
           $("#cbAviso").removeAttr("disabled");
           $('#correo').removeClass('error'); 
        }
    });
    $('#correo').keydown(function(){
        if (!$(this).val().match($regex)) {         
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
//           $("#btnEnviar").attr("disabled",false);
        }
    });
    $('#correo').keyup(function(){
        if (!$(this).val().match($regex)) {         
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
           $("#btnEnviar").attr("disabled",false);
        }
    });
    $('#correo').change(function(){
        if (!$(this).val().match($regex)) {         
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
           $("#btnEnviar").attr("disabled",false);
        }
    });    
    $('#usuario').on('keypress keydown keyup change',function(){        
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
            'correo':{
                number:false,
                maxlength:50
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
                required: "Campo requerido",
                 maxlength:"Longitud de correo de 50 caracteres"
            },
            'tusuario':{
                required: "Seleccione una opción"
            }
        },
        submitHandler:function(){            
            var aux=$("#btnEnviar").val();
            var perfilD=$("#perfilD").val();
            var perfilSel=$("#tusuario").val();
            var permisos="";
            var id=0;
            $('.permiso').each(function(){
                id=$(this).val();
                if (this.checked) {
                    permisos += id+",";                
                    permisos+=document.getElementById('cbEscritura'+id).checked+","+document.getElementById('cbEliminar'+id).checked;                
                    permisos+=";";
                }
            }); 
            //alert(permisos);
            $("#permisos").val(permisos);            
            if (permisos!="" || perfilSel=="D") { 
                //if ($("#correo").val().toLowerCase().match($regex) && $("#usuario").val().toUpperCase().match($regexRFC)) {
                if ($("#correo").val().toLowerCase().match($regex)) {    
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
                else{
                    $("#mensaje").html("Correo no cumple con las caracteristicas");            
                    $("#modalMensaje").modal("show");
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

function cambioPermiso(objeto){
    var id=objeto.value;
    id=id.replace("permiso","");
    if(objeto.checked){
        $("#escritura"+id).removeClass("hidden");
        $("#eliminar"+id).removeClass("hidden");
    }else{
        $("#escritura"+id).addClass("hidden");
        $("#cbEscritura"+id).removeAttr("checked");
        $("#eliminar"+id).addClass("hidden");
        $("#cbEliminar"+id).removeAttr("checked");
    }
}

function habilitaPermisos(){
    
    var rol = $("#tusuario").val();
    if(rol==="D"){
        $("#PermisosAsignados1").addClass("hidden");
    }else{
        $("#PermisosAsignados1").removeClass("hidden");
    }   
           
}