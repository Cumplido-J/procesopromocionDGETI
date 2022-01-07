/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
$(document).ready(function () {   
    $('#formRegistro').submit(function(e) {
        e.preventDefault();
    }).validate({  
        rules: {
            'horas':{
                number:true,
                min:1,
                max:19
            },
            'vacancia':{
                number:true,
                min:1,
                max:1
            }
        },
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
            'categoria':{
                required: "Seleccione una opción"
            },
            'jornada':{
                required: "Seleccione una opción"
            },
            'vacancia':{
                required: "Campo requerido",
                min:"Ingrese un valor mayor a 0",
                max:"Ingrese un valor menor a 2"
            },            
            'tipoVacancia':{
                required: "Seleccione una opción"
            },
            'horas':{
                required: "Campo requerido",
                min:"Ingrese un valor mayor a 0",
                max:"Ingrese un valor menor a 20"
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

function cambioCategoria() {
    var idPrograma=$("#programa").val();
    var tipoCategoria=$("#categoria option:selected").attr("tipo");
    var id=$("#categoria").val();
    if(id!=""){
        $("#tipoCategoria").val(tipoCategoria);
        $.get("ConsultaCatalogos", {k: "9",i:id}, function(respuesta){
            $("#jornada").html(respuesta);
        });
        
    }
}

function cambioJornada(objeto){
    var programa=$("#programa").val();
    var jornada=objeto.value;
    
    if(jornada=="1"){
        if(programa=="1"){
            $("#mensaje").html("Opción no permitida para este programa");
            $("#modalMensaje").modal("show");
            $("#btnEnviar").addClass("disabled");
        }else{
            $("#seccionHoras").removeClass("hidden");
            $("#horas").attr("required",true);
            $("#btnEnviar").removeClass("disabled");
        }
    }else{
        $("#seccionHoras").addClass("hidden");
        $("#horas").removeAttr("required");
        $("#btnEnviar").removeClass("disabled");
    }
}
