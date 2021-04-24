/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
function establecerPermisoActual(idPermiso, permisoEdicion){
    
    var respuestaIdPermiso = null;
    
    $.get("EstableceSesionPermiso", {e:idPermiso, p:permisoEdicion}, function(respuesta){
        respuestaIdPermiso = respuesta;
    });

}

function consultarPermisoActual(){
    
    var idPermiso = null;
    
    $.get("ConsultaSesionPermiso", function(respuesta){
        idPermiso = respuesta;
    });
    return idPermiso;
}