/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
$(document).ready(function () {
    var $regex=/^([a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?)$/;
    $('#correo').on('keypress keydown keyup change',function(){
        if (!$(this).val().match($regex)) {         
            $('#alertaCorreo').removeAttr('hidden');
            $("#btnRegistrar").attr("disabled",true);
            $('#correo').addClass('error'); 
        }
        else{
           $('#alertaCorreo').attr('hidden',true);           
           $('#correo').removeClass('error'); 
           $("#btnRegistrar").removeAttr("disabled");
        }
    });
    var $regexRFC=/^([A-Z&Ñ]{3,4}[0-9]{2}(0[1-9]|1[012])(0[1-9]|[12][0-9]|3[01])[A-Z0-9]{2}[0-9A])$/;  
    $('#rfc').on('keypress keydown keyup change',function(){
        if (!$(this).val().toUpperCase().match($regexRFC)) {
            $('#alertaRFC').removeAttr('hidden'); 
            $('#rfc').addClass('error');             
            $("#btnRegistrar").attr("disabled",true);
        }else{
            $('#alertaRFC').attr('hidden',true);           
            $('#rfc').removeClass('error');
            $("#btnRegistrar").removeAttr("disabled");
        }
    });
    $('#formComite').submit(function(e) {
        e.preventDefault();
    }).validate({                
        messages: {            
            'rfc':{
                required: "Campo requerido"
            },
            'nombre':{
                required: "Campo requerido"
            },
            'apPaterno':{
                required: "Campo requerido"
            },            
            'correo': {
                required: "Campo requerido"
            },
            'rol':{
                required: "Seleccione una opción"
            }
        },
        submitHandler:function(){
            $.ajax({
                type:$('#formComite').attr("method"),
                url:$('#formComite').attr("action"),
                data:$('#formComite').serialize(),
                beforeSend:function(){
                    $("#btnRegistrar").val("Registrando...");
                    $("#btnRegistrar").attr("disabled","disabled");
                },
                complete:function(){
                   $("#btnRegistrar").val("Registrar"); 
                   $("#btnRegistrar").removeAttr("disabled");
                },success:function(data){
                    if(data.includes("<tr>")){ 
                        $("#seccionEditable").html(data);            
                        $("#modalRegistro").modal("hide");
                        $("#respuesta").html("");
                    }else{                        
                        $("#respuesta").html(data);                             
                    }
                },error:function(){
                    
                }
            });
            return false;
        }
    });
});
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
function mostrarModalRegistro(){    
    $("#formComite")[0].reset();  
    $("#respuesta").html("");
    $("#modalRegistro").modal("show");
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
        //$("#alertaBtnEvidencia"+id).attr("style","display:none;");
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

