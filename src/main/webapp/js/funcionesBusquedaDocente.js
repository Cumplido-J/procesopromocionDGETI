/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
$(document).ready(function () {    
    $("#formBusqueda").submit(function(event){
	event.preventDefault(); //prevent default action 
	var post_url = $(this).attr("action"); //get form action url
	var request_method = $(this).attr("method"); //get form GET/POST method
	var form_data = $(this).serialize(); //Encode form elements for submission
	
	$.ajax({
		url : post_url,
		type: request_method,
		data : form_data
	}).done(function(response){ //
                
		if(response.includes("<tr>")){ 
                    $("#seccionEditable").html(response);                    
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
function actualizarVacancias() {
    var idPrograma=$('#programa').val();
    var idSubsistema=$('#subsistema').val();    
    var idEntidad=$("#entidad").val();
    var idPlantel=$("#plantel").val();
    var id="18";
    if(idSubsistema!="" &&  idEntidad!="")
    $.get("ConsultaCatalogos", {k:id,e:idPrograma,s:idSubsistema,i:idEntidad,m:idPlantel}, function(respuesta){
        $("#categoria").html(respuesta);
    });
}
function actualizarJornada() {
    var idPrograma=$('#programa').val();
    var idSubsistema=$('#subsistema').val();    
    var idEntidad=$("#entidad").val();
    var idPlantel=$("#plantel").val();
    var idCategoria=$("#categoria").val();
    var id="19";
    if(idSubsistema!="" &&  idEntidad!="")
    $.get("ConsultaCatalogos", {k:id,e:idPrograma,s:idSubsistema,i:idEntidad,m:idPlantel,n:idCategoria}, function(respuesta){
        $("#jornada").html(respuesta);
    });
}
function numeroPlazas() {
    var idPrograma=$('#programa').val();
    var idSubsistema=$('#subsistema').val();    
    var idEntidad=$("#entidad").val();
    var idPlantel=$("#plantel").val();
    var idCategoria=$("#categoria").val();
    var idJornada=$("#jornada").val();
    var id="20";
    if(idSubsistema!="" &&  idEntidad!="")
    $.get("ConsultaCatalogos", {k:id,e:idPrograma,s:idSubsistema,i:idEntidad,m:idPlantel,n:idCategoria,p:idJornada}, function(respuesta){
        $("#plazas").html(respuesta);
    });
}
function confirmacion(idComite) {
    $("#idComiteBorrar").val(idComite);
    $("#modalConfirmacion2").modal("show");
}

