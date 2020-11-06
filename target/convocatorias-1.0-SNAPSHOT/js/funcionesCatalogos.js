/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
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



