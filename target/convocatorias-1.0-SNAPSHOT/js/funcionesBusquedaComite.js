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
                    if(data.includes("<tr")){ 
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
    $("#formBorrarComite").submit(function(event){
	event.preventDefault(); //prevent default action 
	var post_url = $(this).attr("action"); //get form action url
	var request_method = $(this).attr("method"); //get form GET/POST method
	var form_data = $(this).serialize(); //Encode form elements for submission
	
	$.ajax({
		url : post_url,
		type: request_method,
		data : form_data
	}).done(function(response){ //
                $("#modalConfirmacion2").modal("hide");
		if(response=="ok"){
                    var id=$("#idComiteBorrar").val();
                    $("#comite"+id).remove();
                    if($('#seccionEditable').is(':empty')){
                        $("#seccionEditable").html("<tr><td colspan='8' class='text-center'>Sin información</td></tr>");
                    }
                }else{
                    $("#mensaje").html(response);
                    $("#modalMensaje").modal("show");
                }
	});
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
function confirmacion(idComite) {
    $("#idComiteBorrar").val(idComite);
    $("#modalConfirmacion2").modal("show");
}

