$(document).ready(function () {
    $( "#ingresoSubsistema" ).datepicker({changeMonth:true, changeYear: true,firstDay: 0});  
    $( "#ingresoPlantel" ).datepicker({changeMonth:true, changeYear: true,firstDay: 0});     
    $( "#fechaPlaza" ).datepicker({changeMonth:true, changeYear: true,firstDay: 0});         
    $( "#fechaPromocion" ).datepicker({changeMonth:true, changeYear: true,firstDay: 0});  
        
    $('#formInfoAcademica').submit(function(e) {
        e.preventDefault();
    }).validate({        
        rules: {
            'egreso':{
                min:1920,
                number: true
            },
            'titulacion':{
                min:1920,
                number: true
            }
        },
        messages: {
            'entidad': {
                required: "Seleccione una opción"
            },
            'tipoInstitucion':{
                required: "Seleccione una opción"
            },
            'institucion':{
                required: "Seleccione una opción"
            },
            'cct':{
                required: "Seleccione una opción"
            },
            'escuela':{
                required: "Seleccione una opción"
            },
            'grado':{
                required: "Seleccione una opción"
            },
            'carrera':{
                required: "Campo requerido"
            },
            'egreso':{
                required: "Campo requerido",
                min:"Ingrese un año válido",
                number:"Ingrese un año válido"
            },
            'modalidad':{
                required: "Seleccione una opción"
            },
            'titulacion':{
                required: "Campo requerido",
                min:"Ingrese un año válido",
                number:"Ingrese un año válido"
            },
            'documento':{
                required: "Seleccione una opción"
            },
            'cedula':{
                required: "Campo requerido"
            }
        },
        submitHandler:function(){
            $.ajax({
                type:$('#formInfoAcademica').attr("method"),
                url:$('#formInfoAcademica').attr("action"),
                data:$('#formInfoAcademica').serialize(),
                beforeSend:function(){
                    $("#btnEnviar1").val("Guardando...");
                    $("#btnEnviar1").attr("disabled","disabled");
                },
                complete:function(){
                   $("#btnEnviar1").val("Guardar y continuar"); 
                   $("#btnEnviar1").removeAttr("disabled");
                },success:function(data){
                    if(data=="ok"){                                               
                        mostrarSiguiente(1);
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
    
    $('#formInfoLaboral').submit(function(e) {
        e.preventDefault();
    }).validate({          
        messages: {            
            'ingresoSubsistema': {
                required: "Campo requerido"
            },
            'ingresoPlantel':{
                required: "Campo requerido"
            },
            'plantel':{
                required: "Seleccione una opción"
            },            
            'fechaPromocion':{
                required: "Campo requerido"
            },
            'categoriaAspira':{
                required: "Seleccione una opción"
            },
            'jornadaAspira':{
                required: "Seleccione una opción"
            }
        },
        submitHandler:function(){
           
            $.ajax({
                type:$('#formInfoLaboral').attr("method"),
                url:$('#formInfoLaboral').attr("action"),
                data:$('#formInfoLaboral').serialize(),
                beforeSend:function(){
                    $("#btnEnviar2").val("Guardando...");
                    $("#btnEnviar2").attr("disabled","disabled");
                },
                complete:function(){
                   $("#btnEnviar2").val("Guardar y continuar"); 
                   $("#btnEnviar2").removeAttr("disabled");
                },success:function(data){
                    if(data=="ok"){
                        mostrarSiguiente(2);
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
    $('#formPlaza').submit(function(e) {
        e.preventDefault();
    }).validate({
        rules:{            
            'horas': {
                number: true,
                min:1,
                max:19
            }
        },
        messages: {
            'categoria':{
                required: "Seleccione una opción"
            },
            'jornada':{
                required: "Seleccione una opción"
            },
            'fechaPlaza':{
                required: "Campo requerido"
            },
            'tipoNombramiento':{
                required: "Seleccione una opción"
            },
            'horas': {
                required: "Campo requerido",
                number:"Ingrese sólo números",
                min:"Ingrese un valor mayor a 0",
                max:"Ingrese un valor menor a 20"
            }
        },
        submitHandler:function(){
            $.ajax({
                type:$('#formPlaza').attr("method"),
                url:$('#formPlaza').attr("action"),
                data:$('#formPlaza').serialize(),
                beforeSend:function(){
                    $("#btnGuardarPlaza").val("Guardando...");
                    $("#btnGuardarPlaza").attr("disabled","disabled");
                },
                complete:function(){
                   $("#btnGuardarPlaza").val("Guardar"); 
                   $("#btnGuardarPlaza").removeAttr("disabled");
                   $("#modalPlazas").modal("hide");
                },success:function(data){
                    if(data.includes("<tr>")){                        
                        $("#tablaPlazas").html(data);
                    }
                    else{
                        $("#mensaje").html(data);            
                        $("#modalMensaje").modal("show");
                    }                    
                }
            });
            return false;
        }
    });
    $('#formInfoHorasGrupo').submit(function(e) {
        e.preventDefault();
    }).validate({    
        rules: {
            nivelCENNI: {
              number: true
            }
        },
        messages: {            
            'nivelCENNI': {
                required: "Campo requerido",
                number: "Ingrese sólo números"
            },
            'folio': {
                required: "Campo requerido"
            }
        },
        submitHandler:function(){
            $.ajax({
                type:$('#formInfoHorasGrupo').attr("method"),
                url:$('#formInfoHorasGrupo').attr("action"),
                data:$('#formInfoHorasGrupo').serialize(),
                beforeSend:function(){
                    $("#btnEnviar3").val("Guardando...");
                    $("#btnEnviar3").attr("disabled","disabled");
                },
                complete:function(){
                   $("#btnEnviar3").val("Guardar y continuar"); 
                   $("#btnEnviar3").removeAttr("disabled");
                },success:function(data){
                    if(data=="ok"){
                        mostrarSiguiente(3);
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
    $('#formInfoCompatibilidad').submit(function(e) {
        e.preventDefault();
    }).validate({  
        rules: {
            numHorasOtro: {
              number: true,
              min:1              
            }
        },
        messages: {
            'numHorasOtro': {
                required: "Campo requerido",
                number:"Ingrese un valor numérico",
                min:"Ingrese un valor mayor a cero"
            }
        },
        submitHandler:function(){
            $.ajax({
                type:$('#formInfoCompatibilidad').attr("method"),
                url:$('#formInfoCompatibilidad').attr("action"),
                data:$('#formInfoCompatibilidad').serialize(),
                beforeSend:function(){
                    $("#btnEnviar4").val("Guardando...");
                    $("#btnEnviar4").attr("disabled","disabled");
                },
                complete:function(){
                   $("#btnEnviar4").val("Guardar y continuar"); 
                   $("#btnEnviar4").removeAttr("disabled");
                },success:function(data){
                    if(data=="ok"){
                        mostrarSiguiente(4);
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
    $('#formHorasGrupo').submit(function(e) {
        e.preventDefault();
    }).validate({
        rules: {
            horas: {
              number: true
            }
        },
        messages: {
            'periodo': {
                required: "Seleccione una opción"
            },
            'grupo': {
                required: "Campo requerido"
            },
            'semestre': {
                required: "Seleccione una opción"
            },
            'tipoInfo': {
                required: "Seleccione una opción"
            },
            'version': {
                required: "Seleccione una opción"
            },
            'asignatura': {
                required: "Seleccione una opción"
            },
            'carrera_cp': {
                required: "Seleccione una opción"
            },
            'modulo': {
                required: "Seleccione una opción"
            },
            'submodulo': {
                required: "Seleccione una opción"
            },
            'taller': {
                required: "Seleccione una opción"
            },
            'horas': {
                required: "Campo requerido",
                number:"Ingrese un valor numérico"
            }
        },
        submitHandler:function(){
            $.ajax({
                type:$('#formHorasGrupo').attr("method"),
                url:$('#formHorasGrupo').attr("action"),
                data:$('#formHorasGrupo').serialize(),
                beforeSend:function(){
                    $("#btnEnviarHG").val("Guardando...");
                    $("#btnEnviarHG").attr("disabled","disabled");
                },
                complete:function(){
                   $("#btnEnviarHG").val("Registrar"); 
                   $("#btnEnviarHG").removeAttr("disabled");
                },success:function(data){
                    var datos=data.split("|");
                    if(datos.length==3){
                        $("#tablaInfo").html(datos[0]);                        
                        if(datos[0].includes("INGLES")||datos[0].includes("CENNI")||datos[0].includes("INGLÉS")){
                            $("#seccionCENNI").removeAttr("hidden");
                            $("#nivelCENNI").attr("required","true");
                            $("#folio").attr("required","true");
                        }else{
                            $("#seccionCENNI").attr("hidden","true");
                            $("#nivelCENNI").removeAttr("required");
                            $("#nivelCENNI").val("");
                            $("#folio").removeAttr("required");
                            $("#folio").val("");
                        }                        
                        $("#numHoras").val(datos[1]);
                        $("#numGrupos").val(datos[2]);
                        $("#modalInformacion").modal("hide");
                        $("#tipoInfo").val("");
                        $("#periodo").val("");
                        $("#semestre").val("");
                        $("#grupo").val("");
                        $("#horas").val("");
                        cambioTipoInfo();
                    }
                },error:function(){
                    
                }
            });
            return false;
        }
    });    
});

function actualizarTipoInstitucion() {
    id=$("#entidad").val();
    $.get("ConsultaCatalogos", {k: "11",i:id}, function(respuesta){
        $("#tipoInstitucion").html(respuesta);
    });   
    $("#institucion").val("");
    $("#cct").val("");
    $("#escuela").val("");
}
function actualizarInstitucion() {
    idEntidad=$("#entidad").val();
    idTipo=$("#tipoInstitucion").val();
    $.get("ConsultaCatalogos", {k: "1",i:idEntidad,t:idTipo}, function(respuesta){
        $("#institucion").html(respuesta);
    });
    $("#cct").val("");
    $("#escuela").val("");
}
function cambioInstitucion() {
    id=$("#institucion").val(); 
    $.get("ConsultaCatalogos", {k: "12",i:id}, function(){        
    }).done(function(respuesta){$("#cct").html(respuesta);});
    $.get("ConsultaCatalogos", {k: "2",i:id}, function(){        
    }).done(function(respuesta){$("#escuela").html(respuesta);});
}
function cambioPlantel() {
    id=$("#plantel").val();
    marginacion=$("#plantel option:selected").attr("marginacion");
    if(marginacion!="null"){
        $("#marginacion").html("Con grado de marginación"); 
    }else{
        $("#marginacion").html(""); 
    }
}
function mostrarElemento(elemento){
    $("#"+elemento).removeAttr("hidden");
}
function ocultarElemento(elemento){
    $("#"+elemento).attr("hidden","true");
}
function ocultarInfo(){
    ocultarElemento('seccionAgregar');
    $("#tipoInfo").val("");
    cambioTipoInfo();
}
function cambioTipoInfo(){
    id=$("#tipoInfo").val();
    switch(id){
        case "cbp":
            $.get("ConsultaCatalogos", {k: "3"}, function(respuesta){
                $("#version").html(respuesta);
            }); 
            $("#version").attr("onchange","cargaAsignaturas()");
            $("#version").attr("required","true");
            $("#version").val("");
            $("#semestre").attr("onchange","cargaAsignaturas()");
            //$("#semestre").val("");
            $("#asignatura").val("");
            mostrarElemento("divVersion");
            //mostrarElemento("divSemestre");
            $("#asignatura").attr("required","true");
            mostrarElemento("divAsignatura");
            $("#carrera_cp").removeAttr("required");
            ocultarElemento("divCarrera");
            $("#modulo").removeAttr("required");
            ocultarElemento("divModulo");
            $("#submodulo").removeAttr("required");
            ocultarElemento("divSubmodulo");
            $("#taller").removeAttr("required");
            ocultarElemento("divTaller");
            break;
        case "cp":
            $.get("ConsultaCatalogos", {k: "4"}, function(respuesta){
                $("#version").html(respuesta);
            }); 
            $("#version").attr("onchange","cargaCarreras()");
            $("#version").val("");
            $("#version").attr("required","true");
            $("#semestre").attr("onchange","cargaCarreras()");
            //$("#semestre").val("");
            $("#carrera_cp").val("");
            $("#carrera_cp").attr("required","true");
            $("#modulo").val("");
            $("#modulo").attr("required","true");
            $("#submodulo").val("");
            $("#submodulo").attr("required","true");
            mostrarElemento("divVersion");
            //mostrarElemento("divSemestre");
            $("#asignatura").removeAttr("required");
            ocultarElemento("divAsignatura");
            mostrarElemento("divCarrera");
            mostrarElemento("divModulo");
            mostrarElemento("divSubmodulo");
            $("#taller").removeAttr("required");
            ocultarElemento("divTaller");
            break;
        case "tl":
            $("#taller").val("");
            $("#version").removeAttr("required");
            ocultarElemento("divVersion");
            //ocultarElemento("divSemestre");
            $("#version").removeAttr("required");
            ocultarElemento("divAsignatura");
            $("#asignatura").removeAttr("required");
            $("#carrera_cp").removeAttr("required");
            ocultarElemento("divCarrera");
            $("#modulo").removeAttr("required");
            ocultarElemento("divModulo");
            $("#submodulo").removeAttr("required");            
            ocultarElemento("divSubmodulo");
            mostrarElemento("divTaller");
            $("#taller").attr("required","true"); 
            $("#horas").removeAttr("readOnly");
            break;
        default:
            ocultarElemento("divVersion");
            //ocultarElemento("divSemestre");
            ocultarElemento("divAsignatura");
            ocultarElemento("divCarrera");
            ocultarElemento("divModulo");
            ocultarElemento("divSubmodulo");
            ocultarElemento("divTaller");
    }
}
function cargaAsignaturas() {
    version=$("#version").val();
    semestre=$("#semestre").val();
    $.get("ConsultaCatalogos", {k: "5",v:version,s:semestre}, function(respuesta){
        $("#asignatura").html(respuesta);
    }); 
}
function cargaCarreras() {
    version=$("#version").val();
    semestre=$("#semestre").val();
    $.get("ConsultaCatalogos", {k: "6",v:version,s:semestre}, function(respuesta){
        $("#carrera_cp").html(respuesta);
        $("#modulo").val("");
        $("#submodulo").val("");
    }); 
}
function cambioCarreraCP() {
    version=$("#version").val();
    semestre=$("#semestre").val();
    carrera=$("#carrera_cp").val();
    $.get("ConsultaCatalogos", {k: "7",v:version,s:semestre,c:carrera}, function(respuesta){
        $("#modulo").html(respuesta);
        $("#submodulo").val("");
    }); 
}
function cambioModulo() {
    version=$("#version").val();
    semestre=$("#semestre").val();
    carrera=$("#carrera_cp").val();
    modulo=$("#modulo").val();
    $.get("ConsultaCatalogos", {k: "8",v:version,s:semestre,c:carrera,m:modulo}, function(respuesta){
        $("#submodulo").html(respuesta);
    }); 
}
/*var info=[];
function registrarInfo(){
    
    if(info.length==0){
        $("#tablaInfo").html("");
    }
    id=$("#tipoInfo").val();
    cadena=$("#periodo option:selected").text();
    cadena+="<br/>";
    cadena+=$("#tipoInfo option:selected").text();
    switch(id){
        case "cbp":            
            cadena+="<br/>Versión:";
            cadena+=$("#version option:selected").text();
            cadena+="<br/>Semestre:";
            cadena+=$("#semestre option:selected").text();
            cadena+="<br/>Asignatura:";
            cadena+=$("#asignatura option:selected").attr("clave");
            cadena+="-";
            cadena+=$("#asignatura option:selected").text();
            cadena+="<br/>Horas:";
            cadena+=$("#asignatura option:selected").attr("horas");
            horas=$("#asignatura option:selected").attr("horas");
            datos=[cadena,horas];
            info.push(datos);
            break;
        case "cp":
            cadena+="<br/>Versión:";
            cadena+=$("#version option:selected").text();
            cadena+="<br/>Semestre:";
            cadena+=$("#semestre option:selected").text();
            cadena+="<br/>Carrera:";
            cadena+=$("#carrera_cp").val();
            cadena+="-";
            cadena+=$("#carrera_cp option:selected").text();
            cadena+="<br/>Módulo:";
            cadena+=$("#modulo").val();
            cadena+="-";
            cadena+=$("#modulo option:selected").text();
            cadena+="<br/>Submódulo:";
            cadena+=$("#submodulo option:selected").attr("clave");
            cadena+="-";
            cadena+=$("#submodulo option:selected").text();
            cadena+="<br/>Horas:";
            cadena+=$("#submodulo option:selected").attr("horas");
            horas=$("#submodulo option:selected").attr("horas");
            datos=[cadena,horas];
            info.push(datos);
            break;
        case "tl":
            cadena+=":";
            cadena+=$("#taller option:selected").text();
            cadena+="<br/>Horas:";
            cadena+=$("#horasTaller").val();
            horas=$("#horasTaller").val();
            datos=[cadena,horas];
            info.push(datos);
            break;
        default:
            break;
    }
    fila="";
    horas=0;
   for(c=0;c<info.length;c++){
        fila+="<tr>";
        fila+=   "<td>"+info[c][0]+"</td>";
        fila+="<td><input type='button' class='btn btn-link btn-sm' value='Borrar' onclick='borrarHoras("+c+")' /></td>";
        fila+="</tr>";
        horas+=parseInt(info[c][1]);
   }
   if(fila!=""){
        if(fila.includes("INGLES")||fila.includes("CENNI")||fila.includes("INGLÉS")){
             $("#seccionCENNI").removeAttr("hidden");
             $("#nivelCENNI").attr("required","true");
             $("#folio").attr("required","true");
         }else{
             $("#seccionCENNI").attr("hidden","true");
             $("#nivelCENNI").removeAttr("required");
             $("#folio").removeAttr("required");
         }
     }else{
         fila='<td colspan="2" class="text-center"><p class="text-danger">Sin información</p></td>';
     }
   
   $("#tablaInfo").html(fila);
   $("#numHoras").val(horas);
   $("#modalInformacion").modal("hide");
   $("#tipoInfo").val("");
   $("#periodo").val("");
   cambioTipoInfo();
}
function borrarHoras(id){
    info.splice(id,1);
    fila="";
    horas=0;
   for(c=0;c<info.length;c++){
        fila+="<tr>";
        fila+=   "<td>"+info[c][0]+"</td>";
        fila+="<td><input type='button' class='btn btn-link btn-sm' value='Borrar' onclick='borrarHoras("+c+")' /></td>";
        fila+="</tr>";
        horas+=parseInt(info[c][1]);
   }
   if(fila!=""){
        if(fila.includes("INGLES")||fila.includes("CENNI")||fila.includes("INGLÉS")){
             $("#seccionCENNI").removeAttr("hidden");
             $("#nivelCENNI").attr("required","true");
             $("#folio").attr("required","true");
         }else{
             $("#seccionCENNI").attr("hidden","true");
             $("#nivelCENNI").removeAttr("required");
             $("#folio").removeAttr("required");
         }
    }else{
         fila='<td colspan="2" class="text-center"><p class="text-danger">Sin información</p></td>';
     }
   
   $("#tablaInfo").html(fila);
   $("#numHoras").val(horas);
}*/
function mostrarSiguiente(id){
    var completo=true;
    switch(id){
        case 1:     
            if($("#btnEvidencia1").val()=="Subir archivo"){
                completo=false;
            }
            if($("#documento").val()=="cedula"){
                if($("#btnEvidencia8").val()=="Subir archivo"){
                    completo=false;
                }
            }
            if(completo){
                $("#estatusInfoAcademica").attr("class","glyphicon glyphicon-ok-sign completo");
                $("#estatusInfoAcademica").attr("title","Sección completa");
                $("#estatusInfoAcademica").attr("completo",true);
            }else{
                $("#estatusInfoAcademica").attr("class","glyphicon glyphicon-exclamation-sign incompleto");
                $("#estatusInfoAcademica").attr("title","Sección incompleta");
                $("#estatusInfoAcademica").attr("completo",false);
            }           
            $("#infoAcademica").collapse("hide");
            $("#panelInfoLaboral").removeAttr("hidden");
            $("#infoLaboral").collapse("show");
            break;
        case 2:
            if($("#btnEvidencia2").val()=="Subir archivo"){
                completo=false;
            }
            if($("#btnEvidencia3").val()=="Subir archivo"){
                completo=false;
            }
            if(!$("#notaDesfavorable").is(':checked')){
                if($("#btnEvidencia6").val()=="Subir archivo"){
                    completo=false;
                }
            }            
            if(completo){
                $("#estatusInfoLaboral").attr("class","glyphicon glyphicon-ok-sign completo");
                $("#estatusInfoLaboral").attr("title","Sección completa");
                $("#estatusInfoLaboral").attr("completo",true);
            }else{
                $("#estatusInfoLaboral").attr("class","glyphicon glyphicon-exclamation-sign incompleto");
                $("#estatusInfoLaboral").attr("title","Sección incompleta");
                $("#estatusInfoLaboral").attr("completo",false);
            } 
            
            if($("#activoServicio").is(':checked')){                
                if (!$("input[name='opReqCat']:checked").val()) {
                    $("#btnConfirmacion").attr("onClick","enviarConfirmacion(7)");
                    $("#idHora").val("");
                    $("#descripcionBitacora").val("El usuario confirma que: no cumple ningun requisito de la plaza que aspira");
                    $("#mensajeConfirmacion").html("Confirma que no cumple ningun requisito de la plaza que aspira");
                    $("#tituloConfirmacion").html("Aviso");
                    $("#modalConfirmacion").modal("show");                    
                }
                else if($("#notaDesfavorable").is(':checked')){
                    $("#btnConfirmacion").attr("onClick","enviarConfirmacion(2)");
                    $("#idHora").val("");
                    $("#descripcionBitacora").val("El usuario confirma que:"+$("#mensajeNotaDesfavorable").val());
                    $("#mensajeConfirmacion").html($("#mensajeNotaDesfavorable").val());
                    $("#tituloConfirmacion").html("Aviso");
                    $("#modalConfirmacion").modal("show");
                    //$(location).attr('href',"FichaRegistroIncompleto");
                }else{
                    $("#infoLaboral").collapse("hide");
                    $("#panelInfoHoras").removeAttr("hidden");
                    $("#infoHoras").collapse("show");
                }
            }else{
                $("#btnConfirmacion").attr("onClick","enviarConfirmacion(1)");
                $("#idHora").val("");
                $("#descripcionBitacora").val("El usuario confirma que:"+$("#mensajeInactivoServicio").val());                
                $("#mensajeConfirmacion").html($("#mensajeInactivoServicio").val()); 
                $("#tituloConfirmacion").html("Aviso");
                $("#modalConfirmacion").modal("show");
                //$(location).attr('href',"FichaRegistroIncompleto");
            }
            break;
        case 3:  
            var aux=$("#tablaInfo").html();
            if(aux.includes("confirmar")){
                completo=false;
            }
            if($("#btnEvidencia4").val()=="Subir archivo"){
                completo=false;
            }            
            if($("#folio").val()!=""){
                if($("#btnEvidencia5").val()=="Subir archivo"){
                    completo=false;
                }
            }            
            if(completo){
                $("#estatusInfoHoras").attr("class","glyphicon glyphicon-ok-sign completo");
                $("#estatusInfoHoras").attr("title","Sección completa");
                $("#estatusInfoHoras").attr("completo",true);
            }else{
                $("#estatusInfoHoras").attr("class","glyphicon glyphicon-exclamation-sign incompleto");
                $("#estatusInfoHoras").attr("title","Sección incompleta");
                $("#estatusInfoHoras").attr("completo",false);
            } 
            
            if($("#frenteGrupo").is(':checked')){
                if($("#numHoras").val()>0){
                    $("#infoHoras").collapse("hide");
                    $("#panelInfoCompatibilidad").removeAttr("hidden");
                    $("#infoCompatibilidad").collapse("show");
                }else{
                    $("#mensajeConfirmacion").html("Debe registrar la información de horas frente a grupo.");                    
                    $("#modalMensaje").modal("show");
                }
            }else{
                $("#btnConfirmacion").attr("onClick","enviarConfirmacion(3)");
                $("#idHora").val("");
                $("#descripcionBitacora").val("El usuario confirma que:"+$("#mensajeNoFrenteGrupo").val());
                $("#mensajeConfirmacion").html($("#mensajeNoFrenteGrupo").val());
                $("#tituloConfirmacion").html("Aviso");
                $("#modalConfirmacion").modal("show");
                //$(location).attr('href',"FichaRegistroIncompleto");
                
            }
            break;
        case 4:  
            if($("#funcionesOtro").is(':checked')){
                if($("#compatibilidad").is(':checked')){
                    if($("#btnEvidencia7").val()=="Subir archivo"){
                        completo=false;
                    }
                } else{
                    completo=false;
                } 
            }
            if(completo){
                $("#estatusInfoCompatibilidad").attr("class","glyphicon glyphicon-ok-sign completo");
                $("#estatusInfoCompatibilidad").attr("title","Sección completa");
                $("#estatusInfoCompatibilidad").attr("completo",true);
            }else{
                $("#estatusInfoCompatibilidad").attr("class","glyphicon glyphicon-exclamation-sign incompleto");
                $("#estatusInfoCompatibilidad").attr("title","Sección incompleta");
                $("#estatusInfoCompatibilidad").attr("completo",false);
            } 
            if($("#funcionesOtro").is(':checked')){
                if(!$("#compatibilidad").is(':checked')){ 
                    $("#btnConfirmacion").attr("onClick","enviarConfirmacion(4)");
                    $("#idHora").val("");
                    $("#descripcionBitacora").val("El usuario confirma que:"+$("#mensajeNoCompatibilidad").val());
                    $("#mensajeConfirmacion").html($("#mensajeNoCompatibilidad").val());
                    //$(location).attr('href',"FichaRegistroIncompleto");
                    $("#tituloConfirmacion").html("Aviso");
                    $("#modalConfirmacion").modal("show");
                }
                /*else{
                    if(
                        $("#estatusInfoAcademica").attr("completo")=='true'
                        &&$("#estatusInfoLaboral").attr("completo")=='true'
                        &&$("#estatusInfoHoras").attr("completo")=='true'
                        &&$("#estatusInfoCompatibilidad").attr("completo")=='true'
                    ){
                        $("#banderaCompleto").val("true");
                        $("#btnFinalizar").removeAttr("disabled");                        
                    }else{
                        $("#mensaje").html('Formulario incompleto revise los campos marcados con el icono <span class="glyphicon glyphicon-exclamation-sign incompleto" ></span>');
                        $("#modalMensaje").modal("show");
                    }
                }*/
            }
            /*else{
             * if(
                    $("#estatusInfoAcademica").attr("completo")=='true'
                    &&$("#estatusInfoLaboral").attr("completo")=='true'
                    &&$("#estatusInfoHoras").attr("completo")=='true'
                    &&$("#estatusInfoCompatibilidad").attr("completo")=='true'
                ){
                    $("#banderaCompleto").val("true");
                    $("#btnFinalizar").removeAttr("disabled");                    
                }else{
                    $("#mensaje").html('Formulario incompleto revise los campos marcados con <span class="glyphicon glyphicon-exclamation-sign incompleto" ></span>');
                    $("#modalMensaje").modal("show");
                }
                
            }*/
            
                       
            break;
        default:
            break;
    }
    if(
        $("#estatusInfoAcademica").attr("completo")=='true'
        &&$("#estatusInfoLaboral").attr("completo")=='true'
        &&$("#estatusInfoHoras").attr("completo")=='true'
        &&$("#estatusInfoCompatibilidad").attr("completo")=='true'
    ){
        $("#banderaCompleto").val("true");
        $("#seccionNotas").removeAttr("hidden");
        /*$("#mensaje").html("Registro completo");
        $("#modalMensaje").modal("show");
        $(location).attr('href',"FichaRegistro");*/
    }else{
        $("#banderaCompleto").val("false");
        $("#btnFinalizar").attr("disabled","true");
    }
    /*else{
        $("#mensaje").html('Formulario incompleto revise los campos marcados con <span class="glyphicon glyphicon-exclamation-sign incompleto" ></span>');
        $("#modalMensaje").modal("show");
    }*/
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
    switch(id){
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
    }
    $("#modalArchivo").modal("show");
}
function abrirModalEjemplo(id){  
    $("#ifArchivoEjemplo").attr("src","Archivo?e="+id);     
              
    switch(id){
        case 1: 
            $("#tituloModalEjemplo").html("Título");            
            break;
        case 2: 
            $("#tituloModalEjemplo").html("Constancia de antigüedad");
                      
            break;
        case 3: 
            $("#tituloModalEjemplo").html("Nombramiento definitivo");     
            break;  
        case 4: 
            $("#tituloModalEjemplo").html("Constancia de horas frente a grupo");        
            break;  
        case 5: 
            $("#tituloModalEjemplo").html("Constancia CENNI");                         
            break;      
        case 6: 
            $("#tituloModalEjemplo").html("Nota favorable y sin sanción administrativa");        
            break;
        case 7: 
            $("#tituloModalEjemplo").html("Constancia de compatibilidad");            
            break;        
        case 8: 
            $("#tituloModalEjemplo").html("Cédula profesional");            
            break;
        default:
            break;        
    }
    $("#modalEjemplo").modal("show");
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
/*function cambioCarrera(elemento){
    var carrera=elemento.value.toString();
    if(carrera.includes("INGLES")||carrera.includes("CENNI")){
        $("#seccionCENNI").removeAttr("hidden");
        $("#nivelCENNI").attr("required","true");
        $("#folio").attr("required","true");
    }else{
        $("#seccionCENNI").attr("hidden","true");
        $("#nivelCENNI").removeAttr("required");
        $("#folio").removeAttr("required");
    }
}*/
function cambioDocumento(elemento){
    if(elemento.value=="cedula"){
        $("#seccionCedula").removeAttr("hidden");
        $("#cedula").attr("required","true");
    }else{
        $("#seccionCedula").attr("hidden","true");
        $("#cedula").removeAttr("required");
        $("#cedula").val("");
    }
}
function cambioCategoria() {
    id=$("#categoria").val(); 
    $.get("ConsultaCatalogos", {k: "9",i:id}, function(respuesta){
        $("#jornada").html(respuesta);
    });
    $("#categoriaAspira").val("");
    /*if($("#categoriaAspira").val()!=""){
        var categoria=parseInt($("#categoria").val());
        var categoriaAspira=parseInt($("#categoriaAspira").val());
        //var aux=categoria+1;

        if(categoriaAspira==categoria+1){
            $("#alertaCategoria").attr("hidden",true);
            $("#btnEnviar2").removeClass("disabled");
        }else{
            $("#alertaCategoria").removeAttr("hidden");
            $("#btnEnviar2").addClass("disabled");
        }
    }*/
}
function cambioCategoriaAspira() {
    var categoria=parseInt($("#categoria").val());
    var categoriaAspira=parseInt($("#categoriaAspira").val());
    var tipo=$("#categoriaAspira option:selected").attr("aux");
    if(!tipo.includes("Real")){
        $("#avisoCategoria").removeClass("hidden");
        $("#avisoCategoria").attr("title","Se dará siempre y cuando un aspirante cumpla todos los requisitos y resulte ganador de una plaza de vacancia real, dejando desocupada la plaza que ostenta y ésta podrá asignarse a otro participante.");
        $("#categoriaAspira").attr("title","Se dará siempre y cuando un aspirante cumpla todos los requisitos y resulte ganador de una plaza de vacancia real, dejando desocupada la plaza que ostenta y ésta podrá asignarse a otro participante.");
    }else{
        $("#avisoCategoria").removeAttr("title");
        $("#avisoCategoria").addClass("hidden");
        $("#categoriaAspira").removeAttr("title");
    }
    //var aux=categoria+1;
    
    if(categoriaAspira==categoria|| categoriaAspira==categoria+1){
        $("#alertaCategoria").attr("hidden",true);
        $("#btnEnviar2").removeClass("disabled");
        id=$("#categoriaAspira").val(); 
        idPrograma=$("#programa").val(); 
        idPlantel=$("#plantel").val(); 
        $.get("ConsultaCatalogos", {k: "17",i:id,pr:idPrograma,pl:idPlantel}, function(){        
        }).done(function(respuesta){
            var aux=respuesta.split("|");
            if(aux.length==2){
                $("#jornadaAspira").html(aux[0]);
                $("#rbRequisitos").html(aux[1]);
            }
        });
         
    }else{
        $("#alertaCategoria").removeAttr("hidden");
        $("#btnEnviar2").addClass("disabled");
    }
}
function cambioJornadaAspira() {
    var categoria=parseInt($("#categoria").val());
    var categoriaAspira=parseInt($("#categoriaAspira").val());
    var jornada=parseInt($("#jornada").val());
    var jornadaAspira=parseInt($("#jornadaAspira").val());
     
    if(categoria==categoriaAspira){
        if(jornadaAspira==jornada+1){
            $("#alertaJornada").attr("hidden",true);
            $("#btnEnviar2").removeClass("disabled");         
        }else{
            $("#alertaJornada").removeAttr("hidden");
            $("#btnEnviar2").addClass("disabled");
        }
    }else if(categoria==categoriaAspira-1){
        if(jornadaAspira==jornada){
            $("#alertaJornada").attr("hidden",true);
            $("#btnEnviar2").removeClass("disabled");         
        }else{
            $("#alertaJornada").removeAttr("hidden");
            $("#btnEnviar2").addClass("disabled");
        }        
    }
}

function borrarHoraGrupo(id){
    $.post("BorrarHoraGrupo", {i: id}, function(result){
        var datos=result.split("|");
        if(datos.length==3){
            $("#tablaInfo").html(datos[0]);
            if(datos[0].includes("INGLES")||datos[0].includes("CENNI")||datos[0].includes("INGLÉS")){
                $("#seccionCENNI").removeAttr("hidden");
                $("#nivelCENNI").attr("required","true");
                $("#folio").attr("required","true");
            }else{
                $("#seccionCENNI").attr("hidden","true");
                $("#nivelCENNI").removeAttr("required");
                $("#nivelCENNI").val("");
                $("#folio").removeAttr("required");
                $("#folio").val("");
            } 
            $("#numHoras").val(datos[1]);
            $("#numGrupos").val(datos[2]);
        }
    });
}



function cambioAsignatura(){
    var horas=$("#asignatura option:selected").attr("horas");
    $("#horas").val(horas);
    $("#horas").attr("readOnly","true");
}
function cambioSubmodulo(){
    var horas=$("#submodulo option:selected").attr("horas");
    $("#horas").val(horas);
    $("#horas").attr("readOnly","true");
}
function enviarConfirmacion(parametro){
    var btnEnviar = $("#btnConfirmacion");
    $.ajax({
        type: $("#formBitacora").attr("method"),
        url: $("#formBitacora").attr("action"),
        data:$("#formBitacora").serialize(),
        beforeSend: function(){            
            btnEnviar.val("Enviando");
            btnEnviar.attr("disabled","disabled");
        },
        complete:function(data){
            btnEnviar.val("Enviar formulario");
            btnEnviar.removeAttr("disabled");
        },
        success: function(data){
            var datos;
            switch(parametro){
                case 1:
                    $("#btnEnviar2").attr("disabled","disabled");
                    $("#activoServicio").attr("disabled",true);
                    $("#banderaCompleto").val("false");
                    $("#seccionNotas").attr("hidden",true);
                    $("#btnFinalizar").removeAttr("disabled");
                    break;
                case 2:
                    $("#btnEnviar2").attr("disabled","disabled");
                    $("#notaDesfavorable").attr("disabled",true);
                    $("#banderaCompleto").val("false");
                    $("#seccionNotas").attr("hidden",true);
                    $("#btnFinalizar").removeAttr("disabled");
                    break;
                case 3:
                    $("#btnEnviar3").attr("disabled","disabled");
                    $("#frenteGrupo").attr("disabled",true);
                    $("#banderaCompleto").val("false");
                    $("#seccionNotas").attr("hidden",true);
                    $("#btnFinalizar").removeAttr("disabled");
                    break;
                case 4:
                    $("#btnEnviar4").attr("disabled","disabled");
                    $("#compatibilidad").attr("disabled",true);
                    $("#banderaCompleto").val("false");
                    $("#seccionNotas").attr("hidden",true);
                    $("#btnFinalizar").removeAttr("disabled");
                    break;
                case 5:
                    datos=data.split("|");
                    if(datos.length==3){
                        $("#tablaInfo").html(datos[0]);
                        $("#numHoras").val(datos[1]);
                        $("#numGrupos").val(datos[2]);
                    }
                    break;
                case 6:
                    datos=data.split("|");
                    if(datos.length==3){
                        $("#tablaInfo").html(datos[0]);
                        $("#numHoras").val(datos[1]);
                        $("#numGrupos").val(datos[2]);
                    }
                    break;
                case 7:
                    $("#btnEnviar2").attr("disabled","disabled");
                    //$("#notaDesfavorable").attr("disabled",true);
                    $("#banderaCompleto").val("false");
                    //$("#seccionNotas").attr("hidden",true);
                    $("#btnFinalizar").removeAttr("disabled");
                    break;
                default:
                    break;
            }            
            
            $("#modalConfirmacion").modal("hide");
        },
        error: function(data){
        }
    });
}

function confirmarHoraGrupo(id){
    $("#btnConfirmacion").attr("onClick","enviarConfirmacion(5)");
    $("#idHora").val(id);
    $("#descripcionBitacora").val("El usuario confirma que:"+$("#mensajeConfirmacionHora").val());
    $("#mensajeConfirmacion").html($("#mensajeConfirmacionHora").val());
    $("#tituloConfirmacion").html("Confirmación");
    $("#modalConfirmacion").modal("show");
}
function rechazarHoraGrupo(id){
    $("#btnConfirmacion").attr("onClick","enviarConfirmacion(6)");
    $("#idHora").val("-"+id);
    $("#descripcionBitacora").val("El usuario confirma que:"+$("#mensajeRechazoHora").val());
    $("#mensajeConfirmacion").html($("#mensajeRechazoHora").val());
    $("#tituloConfirmacion").html("Confirmacion");
    $("#modalConfirmacion").modal("show");
}

function cambioProtesta(){
    if($("#cbProtestaVerdad").is(':checked')){
        $("#btnFinalizar").removeAttr("disabled");        
    }else{
        $("#btnFinalizar").attr("disabled","true");
    }
}
function cambioCarrera(){
    var carrera=$("#carrera").val();
    var catalogo=$("#catCarreras").html();
    if(!catalogo.includes(carrera)){
        $("#mensaje").html("Seleccione una carrera de la lista desplegable");
        $("#modalMensaje").modal("show");
        $("#carrera").val("");
    }
}
function abrirModalPlazas(){
    $("#formPlaza")[0].reset();
    $("#modalPlazas").modal("show");
}
function cambioJornada(objeto){
    var jornada=objeto.value;
    if(jornada=="1"){
        $("#seccionHoras2").removeClass("hidden");
        $("#horas2").attr("required",true);
    }else{
        $("#seccionHoras2").addClass("hidden");
        $("#horas2").removeAttr("required");
    }
}
