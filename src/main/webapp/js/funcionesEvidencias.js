/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

function abrirModalArchivo(id){    
    $("#archivo").val("");
    if($("#btnEvidencia"+id).attr("value")=="Subir archivo"){        
        $("#ifArchivo").attr("hidden","true");
    }else{
        $("#ifArchivo").attr("src","Archivo?k="+id); 
        $("#ifArchivo").removeAttr("hidden");
    }
               
    $("#idArchivo").val(id);
    /*switch(id){
        case 1: 
            $("#tituloModal").html("Título");            
            break;
        case 2: 
            $("#tituloModal").html("Constancia de antigüedad");
                      
            break;
        case 3: 
            $("#tituloModal").html("Nombramiento definitivo");     
            break;  
        case 4: 
            $("#tituloModal").html("Constancia de horas frente a grupo");        
            break;  
        case 5: 
            $("#tituloModal").html("Constancia CENNI");                         
            break;      
        case 6: 
            $("#tituloModal").html("Nota favorable y sin sanción administrativa");        
            break;
        case 7: 
            $("#tituloModal").html("Constancia de compatibilidad");            
            break;        
        case 8: 
            $("#tituloModal").html("Cédula profesional");            
            break;
        default:
            break;        
    }*/
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
        $("#alertaBtnEvidencia"+id).attr("style","display:none;");
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

function puntaje(id){
    var puntaje=$("#sp"+id+" option:selected").attr("puntaje");
    $("#p"+id).html("Puntaje:"+puntaje);
}

function pmultiple(){
    var p=0;
    if($("#cb10a").is(':checked')){
        p+=25;
    }
    if($("#cb10b").is(':checked')){
        p+=25;
    }
    p+=parseInt($("#sp102 option:selected").attr("puntaje"));
    p+=parseInt($("#sp103 option:selected").attr("puntaje"));
    p+=parseInt($("#sp104 option:selected").attr("puntaje"));
    p+=parseInt($("#sp105 option:selected").attr("puntaje"));
    $("#p10").html("Puntaje:"+p);
}
