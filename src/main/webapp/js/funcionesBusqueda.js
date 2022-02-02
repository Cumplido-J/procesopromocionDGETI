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
	
        $("#programa").removeClass("completo");
        $("#programa").removeClass("error");       
        $("#subsistema").removeClass("completo");
        $("#subsistema").removeClass("error");
        $("#entidad").removeClass("completo");
        $("#entidad").removeClass("error");
        $("#plantel").removeClass("completo");
        $("#plantel").removeClass("error");
        $("#tipo").removeClass("completo");
        $("#tipo").removeClass("error");
        
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

