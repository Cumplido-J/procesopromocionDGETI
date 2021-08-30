/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
var consultarWS=true;
var banderaContinuar=false;
$(document).ready(function () {
    var $regex=/^([a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?)$/;
    $('#correo').on('keypress keydown keyup change',function(){    
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
            if(banderaContinuar){
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
            }else{
                $("#mensaje").html("El usuario no puede ser registrado");            
                $("#modalMensaje").modal("show");
            }
            return false;
        }
    });
    
    $('#formPreregistroRFC').submit(function(e) {
        e.preventDefault();
    }).validate({
        messages: {
            'rfc':{
                required: "Campo requerido"
            }
        },
        submitHandler:function(){
                $.ajax({
                    type:$('#formPreregistro').attr("method"),
                    url:$('#formPreregistro').attr("action"),
                    data:$('#formPreregistroRFC').serialize(),
                    beforeSend:function(){
                        $("#btnEnviarRFC").val("Guardando...");
                        $("#btnEnviarRFC").attr("disabled","disabled");
                    },
                    complete:function(){
                       $("#btnEnviarRFC").val("Guardar"); 
                       $("#btnEnviarRFC").removeAttr("disabled");
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
            $("#cbAviso").attr("disabled",true);
            $("#cbAviso").removeAttr("checked");
            $("#btnEnviar").attr("disabled",true);
        }
        else{
            
             $('#alertaRFC').attr('hidden',true);
             $('#rfc').removeClass('error'); 
             $("#cbAviso").removeAttr("disabled");
             if($('#subsistema').val()=='1' && consultarWS){
                $.post("ConsultaWSPersonal", {rfc: rfc}, function(respuesta){
                   var aux=respuesta.split("|");
                   if(aux.length==3){
                       if(aux[0]!=""){
                           $("#nombre").val(aux[0]);
                           
                       }else{
                          $("#nombre").val("");
                          
                       }                       
                       if(aux[1]!=""){
                           $("#entidad").val(aux[1]);
                           
                           actualizarPlanteles(aux[2]);
                           
                           banderaContinuar=true;
                       }else{
                           $("#entidad").val("");
                           $("#plantel").val("");
                           $("#mensaje").html("El RFC ingresado no se encuentra asignado a plantel, contacte al personal de recursos humanos");            
                           $("#modalMensaje").modal("show");
                           $("#cbAviso").attr("disabled",true);
                           $("#cbAviso").removeAttr("checked");
                           $("#btnEnviar").attr("disabled",true);
                           $("#btnContinuar").attr("style","display:none;");
                           banderaContinuar=false;
                       }

                   }else{
                       $("#entidad").val("");
                       $("#plantel").val("");
                       $("#mensaje").html("El RFC ingresado no se encuentra registrado en la institución, contacte al personal de recursos humanos de su plantel");            
                       $("#modalMensaje").modal("show");
                       $("#cbAviso").attr("disabled",true);
                       $("#cbAviso").removeAttr("checked");
                       $("#btnEnviar").attr("disabled",true);
                       $("#btnContinuar").attr("style","display:none;");
                       banderaContinuar=false;
                   }
                   $("#nombre").attr("readOnly","readOnly");
                   $("#entidad").attr("style", "pointer-events: none;");
                   $("#entidad").attr("readOnly","readOnly");
                   $("#plantel").attr("style", "pointer-events: none;");
                   $("#plantel").attr("readOnly","readOnly");
               });
            }else{
                banderaContinuar=true;
                $("#nombre").removeAttr("readOnly"); 
                $("#apellido1").removeAttr("readOnly"); 
                $("#apellido2").removeAttr("readOnly"); 
                $("#entidad").removeAttr("readOnly"); 
                $("#plantel").removeAttr("readOnly");
                $("#entidad").removeAttr("style"); 
                $("#plantel").removeAttr("style");
            }
        }
    }else{
        $('#alertaRFC').attr('hidden',true);
    }
           
}
function actualizarPlanteles(idPlantel) {
    var idSubsistema=$('#subsistema').val();    
    var idEntidad=$("#entidad").val();
    if(idSubsistema!="" &&  idEntidad!="")
    $.get("ConsultaCatalogos", {k: "16",e:idEntidad,s:idSubsistema}, function(respuesta){
        $("#plantel").html(respuesta);
        if(idPlantel!=null){
            $("#plantel").val(idPlantel);
        }
    });
}
function cambioAviso(){
    if($("#cbAviso").is(':checked')){
        $("#btnEnviar").removeAttr("disabled");        
    }else{
        $("#btnEnviar").attr("disabled","true");
    }
}
function cambioSubsistema(objeto){
    $('#rfc').val('');
    if(consultarWS){
        if(objeto.value=="1"){
            $("#lblNombre").html("Nombre completo:");
            $("#seccionPaterno").addClass("hidden");
            $("#seccionMaterno").addClass("hidden");
            $("#apellido1").removeAttr("required");
        }else{
            $("#lblNombre").html("Nombre(s):");
            $("#seccionPaterno").removeClass("hidden");
            $("#seccionMaterno").removeClass("hidden");
            $("#apellido1").attr("required",true);
    }
}
}


function validacionRegistro(objeto){
    if(objeto.value==="1"){
        $("#validRegistro").removeClass("hidden");
        $("#validRegistro").attr("required",true);
        addHiddenDelForm();

    }else{
        $("#validRegistro").addClass("hidden"); 
        $("#validRegistro").removeAttr("required");
        removeHiddenDelForm();   
    }
}

function validacionRegistroFormulario(objeto){
    if(objeto.value === "opcion-01"){
        removeHiddenDelForm();
        $("#valid-form-07").addClass("hidden");
    }else if(objeto.value === "opcion-02"){
        addHiddenDelForm();
        $("#valid-form-07").removeClass("hidden");
    }
}

function removeHiddenDelForm(){
    $("#valid-form-01").removeClass("hidden");
    $("#valid-form-02").removeClass("hidden");
    $("#valid-form-03").removeClass("hidden");
    $("#valid-form-04").removeClass("hidden");
    $("#valid-form-05").removeClass("hidden");
    $("#valid-form-06").removeClass("hidden");
    $("#valid-form-07").addClass("hidden");
    $("#valid-form-09").addClass("hidden"); 
        $("#valid-form-10").removeAttr("hidden");
                        $("#valid-form-11").attr("hidden",true);
}
function addHiddenDelForm(){
    $("#valid-form-01").addClass("hidden");
    $("#valid-form-02").addClass("hidden");
    $("#valid-form-03").addClass("hidden");
    $("#valid-form-04").addClass("hidden");
    $("#valid-form-05").addClass("hidden");
    $("#valid-form-06").addClass("hidden");
                $("#valid-form-10").attr("hidden",true);

}

function noConservaCambio(){
    removeHiddenDelForm();
    $("#validRegistro").addClass("hidden"); 
    $("#validRegistro").removeAttr("required");
}

function siConservaCambio(){
    $("#valid-form-08").addClass("hidden"); 
    $("#valid-form-09").removeClass("hidden");
    $("#validRegistro").addClass("hidden"); 
    $("#validRegistro").removeAttr("required");
            $("#valid-form-11").removeAttr("hidden");
}

function comprobacionRFC2(){
    var accion=$("#accion").val();
    
    var rfc=$("#rfc-02").val().toUpperCase();
    var $regexRFC=/^([A-Z&Ñ]{3,4}[0-9]{2}(0[1-9]|1[012])(0[1-9]|[12][0-9]|3[01])[A-Z0-9]{2}[0-9A])$/;  
    if(rfc.length>0){
        if (!rfc.match($regexRFC)) {
            $('#alertaRFC-02').removeAttr('hidden'); 
            $('#rfc-02').addClass('error'); 
        }else{
             $('#alertaRFC-02').attr('hidden',true);
             $('#rfc-02').removeClass('error'); 
             
             $.post("ConsultaWSPersonal", {rfc: rfc,accion:accion}, function(respuesta){
                 var aux=respuesta.split("|");
                 if(aux.length===2){
                     if(aux[1]==='ok'){
                        $("#btnEnviarRFC").removeAttr("disabled");
                        //$("#valid-form-12").removeClass("hidden");
                        //$("#valid-form-13").removeClass("hidden");
                     }
                     else{
                        $("#btnEnviarRFC").attr("disabled",true);
                        //$("#valid-form-12").addClass("hidden");
                        //$("#valid-form-13").addClass("hidden");
                        $("#mensaje").html(aux[1]);            
                        $("#modalMensaje").modal("show");
                        $("#btnContinuar").attr("style","display:none;");
                    }
                 }else{
                     $("#mensaje").html("El RFC ingresado no se encuentra registrado en la institución, contacte al personal de recursos humanos de su plantel");            
                     $("#modalMensaje").modal("show");
                     $("#btnContinuar").attr("style","display:none;");
                 }
                 console.log(aux);
             });
        }
    }else{
        $('#alertaRFC-02').attr('hidden',true);
    }
}

/*function comprobacionPassword2(){
    var pass1=$("#pass01-p").val();
    var pass2=$("#pass02-p").val();
    
    if(pass1 !== "" && pass2 !== ""){
        if(pass1 === pass2 ){
            $("#btnEnviarRFC").removeAttr("disabled");
        }else{
            $("#btnEnviarRFC").attr("disabled",true);
            $("#mensaje").html("Contraseñas incorrectas");            
            $("#modalMensaje").modal("show");
            $("#btnContinuar").attr("style","display:none;");
        }
    }
}*/
