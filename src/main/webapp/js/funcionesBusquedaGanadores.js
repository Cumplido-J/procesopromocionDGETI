$(document).ready(function () {    
    $("#formBusqueda").submit(function(event){
	event.preventDefault(); //prevent default action 
	var post_url = $(this).attr("action"); //get form action url
	var request_method = $(this).attr("method"); //get form GET/POST method
	var form_data = $(this).serialize(); //Encode form elements for submission
	console.log(form_data);
	$.ajax({
		url : post_url,
		type: request_method,
		data : form_data
	}).done(function(response){ //
            //console.log(response);
            if(response == "noprograma"){
               $("#mensaje").html("Debe selecciona un programa");
               $("#modalMensaje").modal("show"); 
            }
            if(response.includes("<tr>")){ 
                $("#seccionEditable").html(response);     
                console.log("draw");
            }
                /*
		if(response.includes("<tr>")){ 
                    $("#seccionEditable").html(response);                    
                }
                else{
                    $("#mensaje").html(response);
                    $("#modalMensaje").modal("show");
                }*/
	});
    });
});

function mostrarDatePicker(){
    console.log("show date picker");
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
