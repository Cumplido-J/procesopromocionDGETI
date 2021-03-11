
/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
$(document).ready(function () {
    $( "#inicioCurso" ).datepicker({changeMonth:true, changeYear: true,endDate: new Date(),firstDay: 0});
    $( "#finCurso" ).datepicker({changeMonth:true, changeYear: true,endDate: new Date(),firstDay: 0});
    $( "#inicioAportacion" ).datepicker({changeMonth:true, changeYear: true,endDate: new Date(),firstDay: 0});
    $( "#finAportacion" ).datepicker({changeMonth:true, changeYear: true,endDate: new Date(),firstDay: 0});
    $( "#inicioParticipacion" ).datepicker({changeMonth:true, changeYear: true,endDate: new Date(),firstDay: 0});
    $( "#finParticipacion" ).datepicker({changeMonth:true, changeYear: true,endDate: new Date(),firstDay: 0});
    $( "#inicioTutoria" ).datepicker({changeMonth:true, changeYear: true,endDate: new Date(),firstDay: 0});
    $( "#finTutoria" ).datepicker({changeMonth:true, changeYear: true,endDate: new Date(),firstDay: 0});
    $( "#fechaPublicacion" ).datepicker({changeMonth:true, changeYear: true,endDate: new Date(),firstDay: 0});
    $( "#inicioResultado" ).datepicker({changeMonth:true, changeYear: true,endDate: new Date(),firstDay: 0});
    $( "#finResultado" ).datepicker({changeMonth:true, changeYear: true,endDate: new Date(),firstDay: 0});
    
    $('#form1').submit(function(e) {
        e.preventDefault();
    }).validate({
        messages: {
            'puntaje': {
                required: "Seleccione una opción"
            }
        },
        submitHandler:function(){
            var idPermiso=$("#idPermisoD1").val();
            var aux=$("#btnEnviar1").val();
            var total=0;
            //var total=parseFloat($("#total").html());
            var p1=parseFloat($("#p1").html());
            var p1D=parseFloat($("#p1D").html());
            $.ajax({
                type:$('#form1').attr("method"),
                url:$('#form1').attr("action"),
                data:$('#form1').serialize(),
                beforeSend:function(){                    
                    $("#btnEnviar1").val("Guardando...");
                    $("#btnEnviar1").attr("disabled","disabled");
                },
                complete:function(){
                   $("#btnEnviar1").val(aux); 
                   $("#btnEnviar1").removeAttr("disabled");
                },success:function(data){
                    if(isNaN(data)){
                        $("#mensaje").html(data);            
                        $("#modalMensaje").modal("show");
                    }
                    else{   
                        //total=total-parseFloat($("#p1").html());
                        if (idPermiso === "6")
                        {$("#p1D").html(data);}
                        else
                        {$("#p1").html(data);}                                                
                        //total=total+parseFloat($("#p1").html());
                        //$("#total").html(total); 
                        calculaTotal();
                        $("#mensaje").html("Información guardada correctamente");            
                        $("#modalMensaje").modal("show");
                        
                        if (idPermiso === "6")
                        {   
                            if($("#btnEvidencia2").val().includes("Ver")){                                
                                $("#estatus1D").attr("class","glyphicon glyphicon-ok-sign completo");
                                $("#estatus1D").attr("title","Sección completa");
                                $("#estatus1D").attr("completo",true);
                            }else{                                
                                $("#estatus1D").attr("class","glyphicon glyphicon-exclamation-sign incompleto");
                                $("#estatus1D").attr("title","Sección incompleta");
                                $("#estatus1D").attr("completo",false);                            
                            }
                        }
                        else
                        {
                            if($("#btnEvidencia2").val().includes("Ver")){
                                $("#estatus1").attr("class","glyphicon glyphicon-ok-sign completo");
                                $("#estatus1").attr("title","Sección completa");
                                $("#estatus1").attr("completo",true);
                            }else{
                                $("#estatus1").attr("class","glyphicon glyphicon-exclamation-sign incompleto");
                                $("#estatus1").attr("title","Sección incompleta");
                                $("#estatus1").attr("completo",false);                            
                            }
                        }
                    }
                }
            });
            return false;
        }
    });
    $('#form2').submit(function(e) {
        e.preventDefault();
    }).validate({
        messages: {
            'puntaje': {
                required: "Seleccione una opción"
            }
        },
        submitHandler:function(){
            var idPermiso=$("#idPermisoD2").val();
            var aux=$("#btnEnviar2").val();
            $.ajax({
                type:$('#form2').attr("method"),
                url:$('#form2').attr("action"),
                data:$('#form2').serialize(),
                beforeSend:function(){
                    $("#btnEnviar2").val("Guardando...");
                    $("#btnEnviar2").attr("disabled","disabled");
                },
                complete:function(){
                   $("#btnEnviar2").val(aux); 
                   $("#btnEnviar2").removeAttr("disabled");
                },success:function(data){
                    if(isNaN(data)){
                        $("#mensaje").html(data);            
                        $("#modalMensaje").modal("show");
                    }
                    else{
                        if (idPermiso === "6")
                        {$("#p2D").html(data);}
                        else
                        {$("#p2").html(data);}
                        calculaTotal();
                        $("#mensaje").html("Información guardada correctamente");            
                        $("#modalMensaje").modal("show");
                        if (idPermiso === "6")
                        {
                            if($("#btnEvidencia10").val().includes("Ver")){
                                $("#estatus2D").attr("class","glyphicon glyphicon-ok-sign completo");
                                $("#estatus2D").attr("title","Sección completa");
                                $("#estatus2D").attr("completo",true);
                            }else{
                                $("#estatus2D").attr("class","glyphicon glyphicon-exclamation-sign incompleto");
                                $("#estatus2D").attr("title","Sección incompleta");
                                $("#estatus2D").attr("completo",false);                            
                            }
                        }
                        else
                        {
                            if($("#btnEvidencia10").val().includes("Ver")){
                                $("#estatus2").attr("class","glyphicon glyphicon-ok-sign completo");
                                $("#estatus2").attr("title","Sección completa");
                                $("#estatus2").attr("completo",true);
                            }else{
                                $("#estatus2").attr("class","glyphicon glyphicon-exclamation-sign incompleto");
                                $("#estatus2").attr("title","Sección incompleta");
                                $("#estatus2").attr("completo",false);                            
                            }
                        }
                    }
                }
            });
            return false;
        }
    });
    $('#form4').submit(function(e) {
        e.preventDefault();
    }).validate({
        messages: {
            'puntaje': {
                required: "Seleccione una opción"
            }
        },
        submitHandler:function(){
            var idPermiso=$("#idPermisoD4").val();
            var aux=$("#btnEnviar4").val();
            $.ajax({
                type:$('#form4').attr("method"),
                url:$('#form4').attr("action"),
                data:$('#form4').serialize(),
                beforeSend:function(){
                    $("#btnEnviar4").val("Guardando...");
                    $("#btnEnviar4").attr("disabled","disabled");
                },
                complete:function(){
                   $("#btnEnviar4").val(aux); 
                   $("#btnEnviar4").removeAttr("disabled");
                },success:function(data){
                    if(isNaN(data)){
                        $("#mensaje").html(data);            
                        $("#modalMensaje").modal("show");
                    }
                    else{                        
                        if (idPermiso === "6")
                        {$("#p4D").html(data);}
                        else
                        {$("#p4").html(data);}                        
                        calculaTotal();
                        $("#mensaje").html("Información guardada correctamente");            
                        $("#modalMensaje").modal("show");
                        if (idPermiso === "6")
                        {
                            if($("#btnEvidencia1").val().includes("Ver")){
                                $("#estatus4D").attr("class","glyphicon glyphicon-ok-sign completo");
                                $("#estatus4D").attr("title","Sección completa");
                                $("#estatus4D").attr("completo",true);
                            }else{
                                $("#estatus4D").attr("class","glyphicon glyphicon-exclamation-sign incompleto");
                                $("#estatus4D").attr("title","Sección incompleta");
                                $("#estatus4D").attr("completo",false);                            
                            }
                        }
                        else
                        {
                            if($("#btnEvidencia1").val().includes("Ver")){
                                $("#estatus4").attr("class","glyphicon glyphicon-ok-sign completo");
                                $("#estatus4").attr("title","Sección completa");
                                $("#estatus4").attr("completo",true);
                            }else{
                                $("#estatus4").attr("class","glyphicon glyphicon-exclamation-sign incompleto");
                                $("#estatus4").attr("title","Sección incompleta");
                                $("#estatus4").attr("completo",false);                            
                            }
                        }
                    }
                }
            });
            return false;
        }
    });
    $('#form5').submit(function(e) {
        e.preventDefault();
    }).validate({        
        submitHandler:function(){
            var idPermiso=$("#idPermisoD5").val();
            var aux=$("#btnEnviar5").val();
            if($("#cb5").is(':checked')||!$("#tablaCursos").html().includes("colspan")){
                $.ajax({
                    type:$('#form5').attr("method"),
                    url:$('#form5').attr("action"),
                    data:$('#form5').serialize(),
                    beforeSend:function(){
                        $("#btnEnviar5").val("Guardando...");
                        $("#btnEnviar5").attr("disabled","disabled");
                    },
                    complete:function(){
                       $("#btnEnviar5").val(aux); 
                       $("#btnEnviar5").removeAttr("disabled");
                    },success:function(data){
                            if(isNaN(data)) {
                                $("#mensaje").html(data); 
                            }else{
                                //if (idPermiso === "6")
                                //{$("#p5D").html(data);}
                                //else
                                //{$("#p5").html(data);}  
                                calculaTotal();
                                $("#mensaje").html("Información almacenada correctamente"); 
                            }                                        
                            $("#modalMensaje").modal("show");
                            if(!$("#cb5").is(':checked')){
                                if (idPermiso === "6")
                                {
                                    if($("#btnEvidencia13").val().includes("Ver")&&!$("#tablaCursos").html().includes("glyphicon-exclamation-sign")){
                                        $("#estatus5D").attr("class","glyphicon glyphicon-ok-sign completo");
                                        $("#estatus5D").attr("title","Sección completa");
                                        $("#estatus5D").attr("completo",true);
                                    }else{
                                        $("#estatus5D").attr("class","glyphicon glyphicon-exclamation-sign incompleto");
                                        $("#estatus5D").attr("title","Sección incompleta");
                                        $("#estatus5D").attr("completo",false);                            
                                    }
                                }
                                else
                                {
                                    if($("#btnEvidencia13").val().includes("Ver")&&!$("#tablaCursos").html().includes("glyphicon-exclamation-sign")){
                                        $("#estatus5").attr("class","glyphicon glyphicon-ok-sign completo");
                                        $("#estatus5").attr("title","Sección completa");
                                        $("#estatus5").attr("completo",true);
                                    }else{
                                        $("#estatus5").attr("class","glyphicon glyphicon-exclamation-sign incompleto");
                                        $("#estatus5").attr("title","Sección incompleta");
                                        $("#estatus5").attr("completo",false);                            
                                    }
                                }                                
                            }else{
                                if (idPermiso === "6")
                                {
                                    $("#estatus5D").attr("class","glyphicon glyphicon-ok-sign completo");
                                    $("#estatus5D").attr("title","Sección completa");
                                    $("#estatus5D").attr("completo",true);
                                }
                                else
                                {
                                    $("#estatus5").attr("class","glyphicon glyphicon-ok-sign completo");
                                    $("#estatus5").attr("title","Sección completa");
                                    $("#estatus5").attr("completo",true);
                                }
                            }                        
                    }
                });
            }else{
                $("#mensaje").html("Debe registrar la información de al menos un curso o marcar la casilla para indicar que no cuenta con evidencias de este criterio.");            
                $("#modalMensaje").modal("show");
            }
            return false;
        }
    });
    $('#form6').submit(function(e) {
        e.preventDefault();
    }).validate({        
        submitHandler:function(){
            var idPermiso=$("#idPermisoD6").val();
            var aux=$("#btnEnviar6").val();
            if($("#cb6").is(':checked')||!$("#tablaAportaciones").html().includes("colspan")){
            $.ajax({
                type:$('#form6').attr("method"),
                url:$('#form6').attr("action"),
                data:$('#form6').serialize(),
                beforeSend:function(){
                    $("#btnEnviar6").val("Guardando...");
                    $("#btnEnviar6").attr("disabled","disabled");
                },
                complete:function(){
                   $("#btnEnviar6").val(aux); 
                   $("#btnEnviar6").removeAttr("disabled");
                },success:function(data){
                    if(isNaN(data)) {
                        $("#mensaje").html(data); 
                    }else{    
                        //if (idPermiso === "6")
                        //{$("#p6D").html(data);}
                        //else
                        //{$("#p6").html(data);}                         
                        calculaTotal();
                        $("#mensaje").html("Información almacenada correctamente"); 
                    }  
                                           
                                  
                        $("#modalMensaje").modal("show");
                        if(!$("#cb6").is(':checked')){
                            if (idPermiso === "6")
                            {
                                if($("#btnEvidencia14").val().includes("Ver")&&!$("#tablaAportaciones").html().includes("glyphicon-exclamation-sign")){
                                    $("#estatus6D").attr("class","glyphicon glyphicon-ok-sign completo");
                                    $("#estatus6D").attr("title","Sección completa");
                                    $("#estatus6D").attr("completo",true);
                                }else{
                                    $("#estatus6D").attr("class","glyphicon glyphicon-exclamation-sign incompleto");
                                    $("#estatus6D").attr("title","Sección incompleta");
                                    $("#estatus6D").attr("completo",false);
                                }
                            }   
                            else
                            {
                                if($("#btnEvidencia14").val().includes("Ver")&&!$("#tablaAportaciones").html().includes("glyphicon-exclamation-sign")){
                                    $("#estatus6").attr("class","glyphicon glyphicon-ok-sign completo");
                                    $("#estatus6").attr("title","Sección completa");
                                    $("#estatus6").attr("completo",true);
                                }else{
                                    $("#estatus6").attr("class","glyphicon glyphicon-exclamation-sign incompleto");
                                    $("#estatus6").attr("title","Sección incompleta");
                                    $("#estatus6").attr("completo",false);
                                }
                            }
                        }else{
                            if (idPermiso === "6")
                            {
                                $("#estatus6D").attr("class","glyphicon glyphicon-ok-sign completo");
                                $("#estatus6D").attr("title","Sección completa");
                                $("#estatus6D").attr("completo",true);
                            }
                            else
                            {
                                $("#estatus6").attr("class","glyphicon glyphicon-ok-sign completo");
                                $("#estatus6").attr("title","Sección completa");
                                $("#estatus6").attr("completo",true);
                            }
                        }
                    }                
            });
            }
            else{
                $("#mensaje").html("Debe registrar la información de al menos una aportación o marcar la casilla para indicar que no cuenta con evidencias de este criterio.");            
                $("#modalMensaje").modal("show");
            }
        
            return false;
        }
    });
    $('#form7').submit(function(e) {
        e.preventDefault();
    }).validate({        
        submitHandler:function(){
            var idPermiso=$("#idPermisoD7").val();
            var aux=$("#btnEnviar7").val();
            if($("#cb7").is(':checked')||!$("#tablaParticipaciones").html().includes("colspan")){
            $.ajax({
                type:$('#form7').attr("method"),
                url:$('#form7').attr("action"),
                data:$('#form7').serialize(),
                beforeSend:function(){
                    $("#btnEnviar7").val("Guardando...");
                    $("#btnEnviar7").attr("disabled","disabled");
                },
                complete:function(){
                   $("#btnEnviar7").val(aux); 
                   $("#btnEnviar7").removeAttr("disabled");
                },success:function(data){
                    if(isNaN(data)) {
                        $("#mensaje").html(data); 
                    }else{
                        //if (idPermiso === "6")
                        //{$("#p7D").html(data);}
                        //else
                        //{$("#p7").html(data);}
                        calculaTotal();
                        $("#mensaje").html("Información almacenada correctamente"); 
                    }                       
                                  
                        $("#modalMensaje").modal("show");
                        if(!$("#cb7").is(':checked')){
                            if (idPermiso === "6")
                            {
                                if($("#btnEvidencia15").val().includes("Ver")&&!$("#tablaParticipaciones").html().includes("glyphicon-exclamation-sign")){
                                    $("#estatus7D").attr("class","glyphicon glyphicon-ok-sign completo");
                                    $("#estatus7D").attr("title","Sección completa");
                                    $("#estatus7D").attr("completo",true);
                                }else{
                                    $("#estatus7D").attr("class","glyphicon glyphicon-exclamation-sign incompleto");
                                    $("#estatus7D").attr("title","Sección incompleta");
                                    $("#estatus7D").attr("completo",false);                            
                                }
                            }
                            else
                            {
                                if($("#btnEvidencia15").val().includes("Ver")&&!$("#tablaParticipaciones").html().includes("glyphicon-exclamation-sign")){
                                    $("#estatus7").attr("class","glyphicon glyphicon-ok-sign completo");
                                    $("#estatus7").attr("title","Sección completa");
                                    $("#estatus7").attr("completo",true);
                                }else{
                                    $("#estatus7").attr("class","glyphicon glyphicon-exclamation-sign incompleto");
                                    $("#estatus7").attr("title","Sección incompleta");
                                    $("#estatus7").attr("completo",false);                            
                                }
                            }
                        }else{
                            if (idPermiso === "6")
                            {
                                $("#estatus7D").attr("class","glyphicon glyphicon-ok-sign completo");
                                $("#estatus7D").attr("title","Sección completa");
                                $("#estatus7D").attr("completo",true);
                            }
                            else
                            {
                                $("#estatus7").attr("class","glyphicon glyphicon-ok-sign completo");
                                $("#estatus7").attr("title","Sección completa");
                                $("#estatus7").attr("completo",true);
                            }
                        }
                    }                   
            });
        }else{
                $("#mensaje").html("Debe registrar la información de al menos una participación o marcar la casilla para indicar que no cuenta con evidencias de este criterio.");            
                $("#modalMensaje").modal("show");
            }
            return false;
        }
    });
    $('#form8').submit(function(e) {
        e.preventDefault();
    }).validate({        
        submitHandler:function(){
            var idPermiso=$("#idPermisoD8").val();
            var aux=$("#btnEnviar8").val();
            if($("#cb8").is(':checked')||!$("#tablaTutorias").html().includes("colspan")){
            $.ajax({
                type:$('#form8').attr("method"),
                url:$('#form8').attr("action"),
                data:$('#form8').serialize(),
                beforeSend:function(){
                    $("#btnEnviar8").val("Guardando...");
                    $("#btnEnviar8").attr("disabled","disabled");
                },
                complete:function(){
                   $("#btnEnviar8").val(aux); 
                   $("#btnEnviar8").removeAttr("disabled");
                },success:function(data){
                    if(isNaN(data)) {
                        $("#mensaje").html(data); 
                    }else{
                        //if (idPermiso === "6")
                        //{$("#p8D").html(data);}
                        //else
                        //{$("#p8").html(data);}
                        calculaTotal();
                        $("#mensaje").html("Información almacenada correctamente"); 
                    }         
                        $("#modalMensaje").modal("show");
                        if(!$("#cb8").is(':checked')){
                            if (idPermiso === "6")
                            {
                                if($("#btnEvidencia16").val().includes("Ver")&&!$("#tablaTutorias").html().includes("glyphicon-exclamation-sign")){
                                    $("#estatus8D").attr("class","glyphicon glyphicon-ok-sign completo");
                                    $("#estatus8D").attr("title","Sección completa");
                                    $("#estatus8D").attr("completo",true);
                                }else{
                                    $("#estatus8D").attr("class","glyphicon glyphicon-exclamation-sign incompleto");
                                    $("#estatus8D").attr("title","Sección incompleta");
                                    $("#estatus8D").attr("completo",false);                            
                                }
                            }
                            else
                            {
                                if($("#btnEvidencia16").val().includes("Ver")&&!$("#tablaTutorias").html().includes("glyphicon-exclamation-sign")){
                                    $("#estatus8").attr("class","glyphicon glyphicon-ok-sign completo");
                                    $("#estatus8").attr("title","Sección completa");
                                    $("#estatus8").attr("completo",true);
                                }else{
                                    $("#estatus8").attr("class","glyphicon glyphicon-exclamation-sign incompleto");
                                    $("#estatus8").attr("title","Sección incompleta");
                                    $("#estatus8").attr("completo",false);                            
                                }
                            }
                        }else{
                            if (idPermiso === "6")
                            {
                                $("#estatus8D").attr("class","glyphicon glyphicon-ok-sign completo");
                                $("#estatus8D").attr("title","Sección completa");
                                $("#estatus8D").attr("completo",true);
                            }
                            else
                            {
                                $("#estatus8").attr("class","glyphicon glyphicon-ok-sign completo");
                                $("#estatus8").attr("title","Sección completa");
                                $("#estatus8").attr("completo",true);
                            }
                        }
                    }
                
            });
        }else{
                $("#mensaje").html("Debe registrar la información de al menos una tutoría o marcar la casilla para indicar que no cuenta con evidencias de este criterio.");            
                $("#modalMensaje").modal("show");
            }
            return false;
        }
    });
    $('#form9').submit(function(e) {
        e.preventDefault();
    }).validate({        
        submitHandler:function(){
            var idPermiso=$("#idPermisoD9").val();
            var aux=$("#btnEnviar9").val();
            if($("#cb9").is(':checked')||!$("#tablaPublicaciones").html().includes("colspan")){
            $.ajax({
                type:$('#form9').attr("method"),
                url:$('#form9').attr("action"),
                data:$('#form9').serialize(),
                beforeSend:function(){
                    $("#btnEnviar9").val("Guardando...");
                    $("#btnEnviar9").attr("disabled","disabled");
                },
                complete:function(){
                   $("#btnEnviar9").val(aux); 
                   $("#btnEnviar9").removeAttr("disabled");
                },success:function(data){
                    if(isNaN(data)) {
                        $("#mensaje").html(data); 
                    }else{
                        //if (idPermiso === "6")
                        //{$("#p9D").html(data);}
                        //else
                        //{$("#p9").html(data);}
                        calculaTotal();
                        $("#mensaje").html("Información almacenada correctamente"); 
                    }             
                        $("#modalMensaje").modal("show");
                        if(!$("#cb9").is(':checked')){
                            if (idPermiso === "6")
                            {
                                if($("#btnEvidencia17").val().includes("Ver")&&!$("#tablaPublicaciones").html().includes("glyphicon-exclamation-sign")){
                                    $("#estatus9D").attr("class","glyphicon glyphicon-ok-sign completo");
                                    $("#estatus9D").attr("title","Sección completa");
                                    $("#estatus9D").attr("completo",true);
                                }else{
                                    $("#estatus9D").attr("class","glyphicon glyphicon-exclamation-sign incompleto");
                                    $("#estatus9D").attr("title","Sección incompleta");
                                    $("#estatus9D").attr("completo",false);                            
                                }
                            }
                            else
                            {
                                if($("#btnEvidencia17").val().includes("Ver")&&!$("#tablaPublicaciones").html().includes("glyphicon-exclamation-sign")){
                                    $("#estatus9").attr("class","glyphicon glyphicon-ok-sign completo");
                                    $("#estatus9").attr("title","Sección completa");
                                    $("#estatus9").attr("completo",true);
                                }else{
                                    $("#estatus9").attr("class","glyphicon glyphicon-exclamation-sign incompleto");
                                    $("#estatus9").attr("title","Sección incompleta");
                                    $("#estatus9").attr("completo",false);                            
                                }   
                            }                         
                        }else{
                            if (idPermiso === "6")
                            {
                                $("#estatus9D").attr("class","glyphicon glyphicon-ok-sign completo");
                                $("#estatus9D").attr("title","Sección completa");
                                $("#estatus9D").attr("completo",true);
                            }
                            else
                            {
                                $("#estatus9").attr("class","glyphicon glyphicon-ok-sign completo");
                                $("#estatus9").attr("title","Sección completa");
                                $("#estatus9").attr("completo",true);
                            }
                        }
                    }                
            });
            }else{
                $("#mensaje").html("Debe registrar la información de al menos una publicación o marcar la casilla para indicar que no cuenta con evidencias de este criterio");            
                $("#modalMensaje").modal("show");
            }
            return false;
        }
    });
    $('#form10').submit(function(e) {
        e.preventDefault();
    }).validate({
        messages: {
            'puntaje10': {
                required: "Seleccione una opción"
            },
            'puntaje11': {
                required: "Seleccione una opción"
            },
            'puntaje12': {
                required: "Seleccione una opción"
            },
            'puntaje13': {
                required: "Seleccione una opción"
            },
            'puntaje14': {
                required: "Seleccione una opción"
            }
        },
        submitHandler:function(){
            var idPermiso=$("#idPermisoD10").val();            
            var aux=$("#btnEnviar10").val();
            if(!$("#tablaResultados").html().includes("colspan")){
            $.ajax({
                type:$('#form10').attr("method"),
                url:$('#form10').attr("action"),
                data:$('#form10').serialize(),
                beforeSend:function(){
                    $("#btnEnviar10").val("Guardando...");
                    $("#btnEnviar10").attr("disabled","disabled");
                },
                complete:function(){
                   $("#btnEnviar10").val(aux); 
                   $("#btnEnviar10").removeAttr("disabled");
                },success:function(data){
                    if(isNaN(data)){
                        $("#mensaje").html(data);            
                        $("#modalMensaje").modal("show");
                    }
                    else{
                        if (idPermiso === "6")
                        {$("#pEvidenciasD").val(data);}
                        else
                        {$("#pEvidencias").val(data);}
                        
                        var puntaje=parseFloat($("#pResultado").val())+parseFloat($("#pEvidencias").val());                        
                        $("#p10").html(puntaje);
                        
                        var puntajeD=parseFloat($("#pResultadoD").val())+parseFloat($("#pEvidenciasD").val());                        
                        $("#p10D").html(puntajeD);
                        calculaTotal();
                        
                        $("#mensaje").html("Información guardada correctamente");            
                        $("#modalMensaje").modal("show");
                        if (idPermiso === "6")
                        {
                            if($("#btnEvidencia18").val().includes("Ver")&&!$("#tablaResultados").html().includes("glyphicon-exclamation-sign")){
                                $("#estatus10D").attr("class","glyphicon glyphicon-ok-sign completo");
                                $("#estatus10D").attr("title","Sección completa");
                                $("#estatus10D").attr("completo",true);
                            }else{
                                $("#estatus10D").attr("class","glyphicon glyphicon-exclamation-sign incompleto");
                                $("#estatus10D").attr("title","Sección incompleta");
                                $("#estatus10D").attr("completo",false);                            
                            }
                        }
                        else
                        {
                            if($("#btnEvidencia18").val().includes("Ver")&&!$("#tablaResultados").html().includes("glyphicon-exclamation-sign")){
                                $("#estatus10").attr("class","glyphicon glyphicon-ok-sign completo");
                                $("#estatus10").attr("title","Sección completa");
                                $("#estatus10").attr("completo",true);
                            }else{
                                $("#estatus10").attr("class","glyphicon glyphicon-exclamation-sign incompleto");
                                $("#estatus10").attr("title","Sección incompleta");
                                $("#estatus10").attr("completo",false);                            
                            }
                        }
                    }
                }
            });
        }else{
                $("#mensaje").html("Debe registrar la información de al menos un resultado educativo");            
                $("#modalMensaje").modal("show");
            }
            return false;
        }
    });
    $('#formCursos').submit(function(e) {
        e.preventDefault();
    }).validate({
        rules:{            
            'horasCurso': {
                number: true
            }
        },
        messages: {
            'tipo': {
                required: "Seleccione una opción"
            },
            'nombreCurso': {
                required: "Campo requerido"
            },
            'inicioCurso': {
                required: "Campo requerido"
            },
            'finCurso': {
                required: "Campo requerido"
            },
            'institucionCurso': {
                required: "Campo requerido"
            },
            'horasCurso': {
                required: "Campo requerido",
                number:"Ingrese sólo números"
            },
            'documento': {
                required: "Campo requerido"
            }
        },
        submitHandler:function(){
            $.ajax({
                type:$('#formCursos').attr("method"),
                url:$('#formCursos').attr("action"),
                data:$('#formCursos').serialize(),
                beforeSend:function(){
                    $("#btnEnviarCurso").val("Guardando...");
                    $("#btnEnviarCurso").attr("disabled","disabled");
                },
                complete:function(){
                   $("#btnEnviarCurso").val("Guardar"); 
                   $("#btnEnviarCurso").removeAttr("disabled");
                   $("#modalCursos").modal("hide");
                },success:function(data){
                    if(data.includes("<tr>")){
                        var aux=data.split("||");
                        $("#tablaCursos").html(aux[0]);
                        $("#p5").html(aux[1]);
                        $("#p5D").html(aux[2]);
                        calculaTotal();
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
    $('#formAportacion').submit(function(e) {
        e.preventDefault();
    }).validate({
        messages: {
            'idAportacion': {
                required: "Seleccione una opción"
            },
            'aportacion': {
                required: "Campo requerido"
            },
            'inicioAportacion': {
                required: "Campo requerido"
            },
            'finAportacion': {
                required: "Campo requerido"
            },
            'institucionAportacion': {
                required: "Campo requerido"
            },
            'documento': {
                required: "Campo requerido"
            }
        },
        submitHandler:function(){
            $.ajax({
                type:$('#formAportacion').attr("method"),
                url:$('#formAportacion').attr("action"),
                data:$('#formAportacion').serialize(),
                beforeSend:function(){
                    $("#btnEnviarAportacion").val("Guardando...");
                    $("#btnEnviarAportacion").attr("disabled","disabled");
                },
                complete:function(){
                   $("#btnEnviarAportacion").val("Guardar"); 
                   $("#btnEnviarAportacion").removeAttr("disabled");
                   $("#modalAportaciones").modal("hide");
                },success:function(data){
                    if(data.includes("<tr>")){
                        var aux=data.split("||");
                        $("#tablaAportaciones").html(aux[0]);
                        $("#p6").html(aux[1]);                        
                        $("#p6D").html(aux[2]);
                        calculaTotal();
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
    $('#formParticipacion').submit(function(e) {
        e.preventDefault();
    }).validate({
        messages: {
            'idParticipacion': {
                required: "Seleccione una opción"
            },
            'participacion': {
                required: "Campo requerido"
            },
            'inicioParticipacion': {
                required: "Campo requerido"
            },
            'finParticipacion': {
                required: "Campo requerido"
            },
            'institucionParticipacion': {
                required: "Campo requerido"
            },
            'documento': {
                required: "Campo requerido"
            }
        },
        submitHandler:function(){
            $.ajax({
                type:$('#formParticipacion').attr("method"),
                url:$('#formParticipacion').attr("action"),
                data:$('#formParticipacion').serialize(),
                beforeSend:function(){
                    $("#btnEnviarParticipacion").val("Guardando...");
                    $("#btnEnviarParticipacion").attr("disabled","disabled");
                },
                complete:function(){
                   $("#btnEnviarParticipacion").val("Guardar"); 
                   $("#btnEnviarParticipacion").removeAttr("disabled");
                   $("#modalParticipacion").modal("hide");
                },success:function(data){
                    if(data.includes("<tr>")){
                        var aux=data.split("||");
                        $("#tablaParticipaciones").html(aux[0]);
                        $("#p7").html(aux[1]);  
                        $("#p7D").html(aux[2]);
                        calculaTotal();
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
    $('#formTutoria').submit(function(e) {
        e.preventDefault();
    }).validate({
        messages: {            
            'inicioTutoria': {
                required: "Campo requerido"
            },
            'finTutoria': {
                required: "Campo requerido"
            },
            'documento': {
                required: "Campo requerido"
            }
        },
        submitHandler:function(){
            $.ajax({
                type:$('#formTutoria').attr("method"),
                url:$('#formTutoria').attr("action"),
                data:$('#formTutoria').serialize(),
                beforeSend:function(){
                    $("#btnEnviarTutoria").val("Guardando...");
                    $("#btnEnviarTutoria").attr("disabled","disabled");
                },
                complete:function(){
                   $("#btnEnviarTutoria").val("Guardar"); 
                   $("#btnEnviarTutoria").removeAttr("disabled");
                   $("#modalTutoria").modal("hide");
                },success:function(data){
                    if(data.includes("<tr>")){
                        var aux=data.split("||");
                        $("#tablaTutorias").html(aux[0]);
                        $("#p8").html(aux[1]); 
                        $("#p8D").html(aux[2]);
                        calculaTotal();
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
    $('#formPublicacion').submit(function(e) {
        e.preventDefault();
    }).validate({
        messages: {            
            'nombre': {
                required: "Campo requerido"
            },
            'tipo': {
                required: "Seleccione una opción"
            },
            'fecha': {
                required: "Campo requerido"
            },
            'ISSN': {
                required: "Campo requerido"
            }
        },
        submitHandler:function(){
            $.ajax({
                type:$('#formPublicacion').attr("method"),
                url:$('#formPublicacion').attr("action"),
                data:$('#formPublicacion').serialize(),
                beforeSend:function(){
                    $("#btnEnviarPublicacion").val("Guardando...");
                    $("#btnEnviarPublicacion").attr("disabled","disabled");
                },
                complete:function(){
                   $("#btnEnviarPublicacion").val("Guardar"); 
                   $("#btnEnviarPublicacion").removeAttr("disabled");
                   $("#modalPublicacion").modal("hide");
                },success:function(data){
                    if(data.includes("<tr>")){
                        var aux=data.split("||");
                        $("#tablaPublicaciones").html(aux[0]);
                        $("#p9").html(aux[1]);
                        $("#p9D").html(aux[2]);
                        calculaTotal();
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
    $('#formResultado').submit(function(e) {
        e.preventDefault();
    }).validate({
        messages: {  
            'idResultado': {
                required: "Seleccione una opción"
            },
            'resultado': {
                required: "Campo requerido"
            },
            'documento': {
                required: "Campo requerido"
            },
            'inicioResultado': {
                required: "Campo requerido"
            },
            'finResultado': {
                required: "Campo requerido"
            }
        },
        submitHandler:function(){
            $.ajax({
                type:$('#formResultado').attr("method"),
                url:$('#formResultado').attr("action"),
                data:$('#formResultado').serialize(),
                beforeSend:function(){
                    $("#btnEnviarResultado").val("Guardando...");
                    $("#btnEnviarResultado").attr("disabled","disabled");
                },
                complete:function(){
                   $("#btnEnviarResultado").val("Guardar"); 
                   $("#btnEnviarResultado").removeAttr("disabled");
                   $("#modalResultado").modal("hide");
                },success:function(data){
                    if(data.includes("<tr>")){
                        var aux=data.split("||");
                        $("#tablaResultados").html(aux[0]);
                        $("#pResultado").html(aux[1]);
                        $("#pResultadoD").html(aux[2]);
                        var puntaje=parseFloat(aux[1])+parseFloat($("#pEvidencias").val());                        
                        $("#p10").html(puntaje);
                        var puntajeD=parseFloat(aux[2])+parseFloat($("#pEvidenciasD").val());                        
                        $("#p10D").html(puntajeD);                      
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
});

function abrirModalArchivo(id){  
    /*if(id<9){
        $("#seccionCarga").addClass("disabled");
        $("#alertaCarga").addClass("hidden");
    }else{
        $("#seccionCarga").removeClass("disabled");
        $("#alertaCarga").removeClass("hidden");
    }*/
    $("#archivo").val("");
    if($("#btnEvidencia"+id).attr("value")=="Subir archivo"){        
        $("#ifArchivo").attr("hidden","true");
    }else if($("#btnEvidencia"+id).attr("value")=="Ver documento"){
        $("#ifArchivo").attr("src","Archivo?i="+id); 
        $("#ifArchivo").removeAttr("hidden");
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

function abrirModalCursos(){
    $("#formCursos")[0].reset();
    $("#modalCursos").modal("show");
}

function abrirModalAportaciones(){
    $("#formAportacion")[0].reset();
    $("#aportacion").addClass("hidden");
    $("#modalAportaciones").modal("show");
}
function abrirModalParticipaciones(){
    $("#formParticipacion")[0].reset();
    $("#participacion").addClass("hidden");
    $("#modalParticipacion").modal("show");
}
function abrirModalTutorias(){
    $("#formTutoria")[0].reset();    
    $("#modalTutoria").modal("show");
}
function abrirModalPublicacion(){
    $("#formPublicacion")[0].reset();    
    $("#modalPublicacion").modal("show");
}
function abrirModalResultado(){
    $("#formResultado")[0].reset(); 
    $("#resultado").addClass("hidden");
    $("#modalResultado").modal("show");
}

function confirmarCurso(id){
    $("#btnConfirmar").attr("onClick","borrarCurso("+id+")");
    $("#modalConfirmacion").modal("show");
}
function borrarCurso(id){
    $("#modalConfirmacion").modal("hide");
    $.post("RegistrarCurso", {id: id,k:"B"}, function(data){
        if(data.includes("<tr>")){
            var aux=data.split("||");
            $("#tablaCursos").html(aux[0]);
            $("#p5").html(aux[1]);
            $("#p5D").html(aux[2]);
            calculaTotal();
        }
        else{
            $("#mensaje").html(data);            
            $("#modalMensaje").modal("show");
        } 
    });
}

function aprobarCurso(id){
    $("#modalConfirmacion").modal("hide");
    $.post("RegistrarCurso", {id: id,k:"A"}, function(data){
        if(data.includes("<tr>")){
            var aux=data.split("||");
            $("#tablaCursos").html(aux[0]);
            $("#p5").html(aux[1]);
            $("#p5D").html(aux[2]);
            calculaTotal();
        }
        else{
            $("#mensaje").html(data);            
            $("#modalMensaje").modal("show");
        } 
    });
}

function rechazarCurso(id){
    $("#modalConfirmacion").modal("hide");
    $.post("RegistrarCurso", {id: id,k:"R"}, function(data){
        if(data.includes("<tr>")){
            var aux=data.split("||");
            $("#tablaCursos").html(aux[0]);
            $("#p5").html(aux[1]);
            $("#p5D").html(aux[2]);
            calculaTotal();
        }
        else{
            $("#mensaje").html(data);            
            $("#modalMensaje").modal("show");
        } 
    });
}

function cambioAportacion(){
    var id=$("#idAportacion").val();
    if(id=='-1'){
        $("#aportacion").removeClass("hidden");
        $("#aportacion").attr("required",true);
    }else{
        $("#aportacion").removeAttr("required");
        $("#aportacion").addClass("hidden");
        $("#aportacion").val("");
    }
}

function confirmarAportacion(id){
    $("#btnConfirmar").attr("onClick","borrarAportacion("+id+")");
    $("#modalConfirmacion").modal("show");
}
function borrarAportacion(id){
    $("#modalConfirmacion").modal("hide");
    $.post("RegistrarAportacion", {id: id,k:"B"}, function(data){
        if(data.includes("<tr>")){
            var aux=data.split("||");
            $("#tablaAportaciones").html(aux[0]);            
            $("#p6").html(aux[1]);  
            $("#p6D").html(aux[2]);
            calculaTotal();
        }
        else{
            $("#mensaje").html(data);            
            $("#modalMensaje").modal("show");
        } 
    });
}
function aprobarAportacion(id){
    $("#modalConfirmacion").modal("hide");
    $.post("RegistrarAportacion", {id: id,k:"A"}, function(data){
        if(data.includes("<tr>")){
            var aux=data.split("||");
            $("#tablaAportaciones").html(aux[0]);
            $("#p6").html(aux[1]);
            $("#p6D").html(aux[2]);
            calculaTotal();
        }
        else{
            $("#mensaje").html(data);            
            $("#modalMensaje").modal("show");
        } 
    });
}
function rechazarAportacion(id){
    $("#modalConfirmacion").modal("hide");
    $.post("RegistrarAportacion", {id: id,k:"R"}, function(data){
        if(data.includes("<tr>")){
            var aux=data.split("||");
            $("#tablaAportaciones").html(aux[0]);
            $("#p6").html(aux[1]);
            $("#p6D").html(aux[2]);
            calculaTotal();
        }
        else{
            $("#mensaje").html(data);            
            $("#modalMensaje").modal("show");
        } 
    });
}
function cambioParticipacion(){
    var id=$("#idParticipacion").val();
    if(id=='-1'){
        $("#participacion").removeClass("hidden");
        $("#participacion").attr("required",true);
    }else{
        $("#participacion").removeAttr("required");
        $("#participacion").addClass("hidden");
        $("#participacion").val("");
    }
}

function confirmarParticipacion(id){
    $("#btnConfirmar").attr("onClick","borrarParticipacion("+id+")");
    $("#modalConfirmacion").modal("show");
}
function borrarParticipacion(id){
    $("#modalConfirmacion").modal("hide");
    $.post("RegistrarParticipacion", {id: id,k:"B"}, function(data){
        if(data.includes("<tr>")){
            var aux=data.split("||");
            $("#tablaParticipaciones").html(aux[0]);
            $("#p7").html(aux[1]);            
            $("#p7D").html(aux[2]);
            calculaTotal();
        }
        else{
            $("#mensaje").html(data);            
            $("#modalMensaje").modal("show");
        } 
    });
}
function aprobarParticipacion(id){
    $("#modalConfirmacion").modal("hide");
    $.post("RegistrarParticipacion", {id: id,k:"A"}, function(data){
        if(data.includes("<tr>")){
            var aux=data.split("||");
            $("#tablaParticipaciones").html(aux[0]);
            $("#p7").html(aux[1]); 
            $("#p7D").html(aux[2]);
            calculaTotal();
        }
        else{
            $("#mensaje").html(data);            
            $("#modalMensaje").modal("show");
        } 
    });
}
function rechazarParticipacion(id){
    $("#modalConfirmacion").modal("hide");
    $.post("RegistrarParticipacion", {id: id,k:"R"}, function(data){
        if(data.includes("<tr>")){
            var aux=data.split("||");
            $("#tablaParticipaciones").html(aux[0]);
            $("#p7").html(aux[1]);
            $("#p7D").html(aux[2]);
            calculaTotal();
        }
        else{
            $("#mensaje").html(data);            
            $("#modalMensaje").modal("show");
        } 
    });
}
function confirmarTutoria(id){
    $("#btnConfirmar").attr("onClick","borrarTutoria("+id+")");
    $("#modalConfirmacion").modal("show");
}
function borrarTutoria(id){
    $("#modalConfirmacion").modal("hide");
    $.post("RegistrarTutoria", {id: id,k:"B"}, function(data){
        if(data.includes("<tr>")){
            var aux=data.split("||");
            $("#tablaTutorias").html(aux[0]);
            $("#p8").html(aux[1]);
            $("#p8D").html(aux[2]);
            calculaTotal();
        }
        else{
            $("#mensaje").html(data);            
            $("#modalMensaje").modal("show");
        } 
    });
}
function aprobarTutoria(id){
    $("#modalConfirmacion").modal("hide");
    $.post("RegistrarTutoria", {id: id,k:"A"}, function(data){
        if(data.includes("<tr>")){
            var aux=data.split("||");
            $("#tablaTutorias").html(aux[0]);
            $("#p8").html(aux[1]);
            $("#p8D").html(aux[2]);
            calculaTotal();
        }
        else{
            $("#mensaje").html(data);            
            $("#modalMensaje").modal("show");
        } 
    });
}
function rechazarTutoria(id){
    $("#modalConfirmacion").modal("hide");
    $.post("RegistrarTutoria", {id: id,k:"R"}, function(data){
        if(data.includes("<tr>")){
            var aux=data.split("||");
            $("#tablaTutorias").html(aux[0]);
            $("#p8").html(aux[1]);  
            $("#p8D").html(aux[2]);
            calculaTotal();
        }
        else{
            $("#mensaje").html(data);            
            $("#modalMensaje").modal("show");
        } 
    });
}
function confirmarPublicacion(id){
    $("#btnConfirmar").attr("onClick","borrarPublicacion("+id+")");
    $("#modalConfirmacion").modal("show");
}
function borrarPublicacion(id){
    $("#modalConfirmacion").modal("hide");
    $.post("RegistrarPublicacion", {id: id,k:"B"}, function(data){
        if(data.includes("<tr>")){
            var aux=data.split("||");
            $("#tablaPublicaciones").html(aux[0]);
            $("#p9").html(aux[1]);
            $("#p9D").html(aux[2]);
            calculaTotal();
        }
        else{
            $("#mensaje").html(data);            
            $("#modalMensaje").modal("show");
        } 
    });
}
function aprobarPublicacion(id){
    $("#modalConfirmacion").modal("hide");
    $.post("RegistrarPublicacion", {id: id,k:"A"}, function(data){
        if(data.includes("<tr>")){
            var aux=data.split("||");
            $("#tablaPublicaciones").html(aux[0]);
            $("#p9").html(aux[1]);              
            $("#p9D").html(aux[2]);
            calculaTotal();
        }
        else{
            $("#mensaje").html(data);            
            $("#modalMensaje").modal("show");
        } 
    });
}
function rechazarPublicacion(id){
    $("#modalConfirmacion").modal("hide");
    $.post("RegistrarPublicacion", {id: id,k:"R"}, function(data){
        if(data.includes("<tr>")){
            var aux=data.split("||");
            $("#tablaPublicaciones").html(aux[0]);
            $("#p9").html(aux[1]); 
            $("#p9D").html(aux[2]);
            calculaTotal();
        }
        else{
            $("#mensaje").html(data);            
            $("#modalMensaje").modal("show");
        } 
    });
}
function confirmarResultado(id){
    $("#btnConfirmar").attr("onClick","borrarResultado("+id+")");
    $("#modalConfirmacion").modal("show");
}
function borrarResultado(id){
    $("#modalConfirmacion").modal("hide");
    $.post("RegistrarResultado", {id: id,k:"B"}, function(data){
        if(data.includes("<tr>")){
            var aux=data.split("||");
            $("#tablaResultados").html(aux[0]);
            $("#pResultado").val(aux[1]);
            $("#pResultadoD").val(aux[2]);
            var puntaje=parseFloat(aux[1])+parseFloat($("#pEvidencias").val());                        
            $("#p10").html(puntaje);
            var puntajeD=parseFloat(aux[2])+parseFloat($("#pEvidenciasD").val());                        
            $("#p10D").html(puntajeD);
            calculaTotal();
        }
        else{
            $("#mensaje").html(data);            
            $("#modalMensaje").modal("show");
        } 
    });
}
function aprobarResultado(id){
    $("#modalConfirmacion").modal("hide");
    $.post("RegistrarResultado", {id: id,k:"A"}, function(data){
        if(data.includes("<tr>")){
            var aux=data.split("||");
            $("#tablaResultados").html(aux[0]);
            $("#pResultado").val(aux[1]);
            $("#pResultadoD").val(aux[2]);
            var puntaje=parseFloat(aux[1])+parseFloat($("#pEvidencias").val());                        
            $("#p10").html(puntaje);
            var puntajeD=parseFloat(aux[2])+parseFloat($("#pEvidenciasD").val());                        
            $("#p10D").html(puntajeD);
            calculaTotal();
        }
        else{
            $("#mensaje").html(data);            
            $("#modalMensaje").modal("show");
        } 
    });
}
function rechazarResultado(id){
    $("#modalConfirmacion").modal("hide");
    $.post("RegistrarResultado", {id: id,k:"R"}, function(data){
        if(data.includes("<tr>")){
            var aux=data.split("||");
            $("#tablaResultados").html(aux[0]);
            $("#pResultado").val(aux[1]);
            $("#pResultadoD").val(aux[2]);
            var puntaje=parseFloat(aux[1])+parseFloat($("#pEvidencias").val());                        
            $("#p10").html(puntaje);
            var puntajeD=parseFloat(aux[2])+parseFloat($("#pEvidenciasD").val());                        
            $("#p10D").html(puntajeD);
            calculaTotal();
        }
        else{
            $("#mensaje").html(data);            
            $("#modalMensaje").modal("show");
        } 
    });
}
function cambioResultado(){
    var id=$("#idResultado").val();
    if(id=='-1'){
        $("#resultado").removeClass("hidden");
        $("#resultado").attr("required",true);
    }else{
        $("#resultado").removeAttr("required");
        $("#resultado").addClass("hidden");
        $("#resultado").val("");
    }
}
function finalizar(){
    if($("#estatus1").attr("completo").includes("true")&&$("#estatus2").attr("completo").includes("true")&&$("#estatus3").attr("completo").includes("true")&&$("#estatus4").attr("completo").includes("true")&&$("#estatus5").attr("completo").includes("true")&&$("#estatus6").attr("completo").includes("true")&&$("#estatus7").attr("completo").includes("true")&&$("#estatus8").attr("completo").includes("true")&&$("#estatus9").attr("completo").includes("true")&&$("#estatus10").attr("completo").includes("true")){
        $("#modalConfirmacion2").modal("show");
    }else{
        $("#mensaje").html("Hay información pendiente de registrar");            
        $("#modalMensaje").modal("show");
    }
}
function finalizarRevision(){
    var idPermiso=$("#idPermisoD5").val();
    var nota = "";
    if (idPermiso==="6")
    {nota = $("#aux2").val();}
    else
    {nota = $("#aux").val();}
    
    if(nota!==""){
            if (idPermiso==="6")
            {
                if($("#estatus1D").attr("completo").includes("true")&&$("#estatus2D").attr("completo").includes("true")&&$("#estatus3D").attr("completo").includes("true")&&$("#estatus4D").attr("completo").includes("true")&&$("#estatus5D").attr("completo").includes("true")&&$("#estatus6D").attr("completo").includes("true")&&$("#estatus7D").attr("completo").includes("true")&&$("#estatus8D").attr("completo").includes("true")&&$("#estatus9D").attr("completo").includes("true")&&$("#estatus10D").attr("completo").includes("true")){
                    $("#observaciones").val($("#aux2").val());
                    $("#evaluacion").val($("#totalD").html());                    
                    $("#modalConfirmacion2").modal("show");
                }else{
                    $("#mensaje").html("Hay información pendiente de revisar");            
                    $("#modalMensaje").modal("show");
                }
            }
            else
            {
                if($("#estatus1").attr("completo").includes("true")&&$("#estatus2").attr("completo").includes("true")&&$("#estatus3").attr("completo").includes("true")&&$("#estatus4").attr("completo").includes("true")&&$("#estatus5").attr("completo").includes("true")&&$("#estatus6").attr("completo").includes("true")&&$("#estatus7").attr("completo").includes("true")&&$("#estatus8").attr("completo").includes("true")&&$("#estatus9").attr("completo").includes("true")&&$("#estatus10").attr("completo").includes("true")){
                    $("#observaciones").val($("#aux").val());
                    $("#evaluacion").val($("#total").html());
                    $("#modalConfirmacion2").modal("show");
                }else{
                    $("#mensaje").html("Hay información pendiente de revisar");            
                    $("#modalMensaje").modal("show");
                }
            }
        
    }else{
        $("#mensaje").html("Es necesario registrar observaciones");            
        $("#modalMensaje").modal("show");
    }
}
function calculaTotal(){
    var idPermiso=$("#idPermisoD5").val();
    if (idPermiso==="6")
    {
        var totalDIC=parseFloat($("#p1D").html())+parseFloat($("#p2D").html())+parseFloat($("#p3D").html())+parseFloat($("#p4D").html())+parseFloat($("#p5D").html())+parseFloat($("#p6D").html())+parseFloat($("#p7D").html())+parseFloat($("#p8D").html())+parseFloat($("#p9D").html())+parseFloat($("#p10D").html());
        $("#totalD").html(totalDIC);
    }
    else
    {
        var totalCR=parseFloat($("#p1").html())+parseFloat($("#p2").html())+parseFloat($("#p3").html())+parseFloat($("#p4").html())+parseFloat($("#p5").html())+parseFloat($("#p6").html())+parseFloat($("#p7").html())+parseFloat($("#p8").html())+parseFloat($("#p9").html())+parseFloat($("#p10").html());
        $("#totalCR").html(totalCR);
    }
}