/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
$(document).ready(function () { 
    $(".calendario").datepicker({changeMonth:true, changeYear: true,firstDay: 0});     
    $('#formRegistro').submit(function(e) {
        e.preventDefault();
    }).validate({  
        messages: {
            'programa':{
                required: "Seleccione una opción"
            },
            'subsistema':{
                required: "Seleccione una opción"
            },           
            'entidad': {
                required: "Seleccione una opción"
            },
            'plantel':{
                required: "Seleccione una opción"
            },
            'publicacion':{
                required: "Campo requerido"
            },
            'inicioRegistro':{
                required: "Campo requerido"
            },
            'finRegistro':{
                required: "Campo requerido"
            },
            'inicioValoracion':{
                required: "Campo requerido"
            },
            'finValoracion':{
                required: "Campo requerido"
            },
            'inicioDictaminacion':{
                required: "Campo requerido"
            },
            'finDictaminacion':{
                required: "Campo requerido"
            },
            'resultados':{
                required: "Campo requerido"
            }
        },
        submitHandler:function(){
            var aux=$("#btnEnviar").val();
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
            return false;
        }
    });
});
function validaFecha(objeto,alerta){
    var retorno;
    var fecha=$("#"+objeto).val();
    var $regex=/^[0-9]{2}\/[0-9]{2}\/[0-9]{4}$/;
    if (fecha.match($regex)){
        $("#"+objeto).removeClass("error");
        $("#"+alerta).html("");
        $("#"+alerta).addClass("hidden");
        retorno=true;
    }else{
        $("#"+objeto).addClass("error");
        $("#"+alerta).html("Ingrese una fecha válida");
        $("#"+alerta).removeClass("hidden");
        retorno=false;
    }
    return retorno;
}
function validarFechas(){
    var retorno=true;
    
    return retorno;
}



