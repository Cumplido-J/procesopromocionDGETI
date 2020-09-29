/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
$(document).ready(function () {
    $('#formBusqueda').submit(function(e) {
        e.preventDefault();
    }).validate({                
        messages: {            
            'programa':{
                required: "Seleccione una opción"
            },
            'subsistema':{
                required: "Seleccione una opción"
            },
            'entidad':{
                required: "Seleccione una opción"
            },            
            'plantel': {
                required: "Seleccione una opción"
            },
            'tipo':{
                required: "Seleccione una opción"
            }
        },
        submitHandler:function(){
            $.ajax({
                type:$('#formBusqueda').attr("method"),
                url:$('#formBusqueda').attr("action"),
                data:$('#formBusqueda').serialize(),
                beforeSend:function(){
                    $("#btnBuscar").val("Buscando...");
                    $("#btnBuscar").attr("disabled","disabled");
                },
                complete:function(){
                   $("#btnBuscar").val("Buscar"); 
                   $("#btnBuscar").removeAttr("disabled");
                },success:function(data){
                    if(data.includes("<tr>")){ 
                        $("#seccionEditable").html(data);
                        if(data.includes("colspan")){
                            $("#idPrograma").val($("#programa").val());
                            $("#idSubsistema").val($("#subsistema").val());
                            $("#idEntidad").val($("#entidad").val());
                            $("#idPlantel").val($("#plantel").val());
                            $("#idTipo").val($("#tipo").val());
                            $("#modalConfirmacion").modal("show");
                        }
                    }else{                        
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

