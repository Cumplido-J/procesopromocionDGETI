function AJAX(){
    var xhr = false;
    if(window.ActiveXObject){
        xhr = new ActiveXObject("Microsoft.XMLHttp");
    }
    else if(window.XMLHttpRequest || typeof XMLHttpRequest != undefined){
        xhr = new XMLHttpRequest();    
    }
    else{
        console.log("Su navegador no tiene soporte para AJAX");
        xhr =false;
    }
    return xhr;
}
var ajax = AJAX();
function listarPlanteles(id){
    var ids=document.getElementById('cbosubsistema').value;
     var cboplanteles = document.getElementById('cboplantel');
     var tbody = document.getElementById('vacanciaData');
    if(id>0){
        tbody.innerHTML = "";
        
    ajax.open("GET",'ServletControladorPlantel?id='+id+'&ids='+ids, true);
    ajax.responseType = "json";
        ajax.onreadystatechange=function(){
            if (ajax.readyState === 4){
                limpiarSelect(cboplanteles);
                var opt = document.createElement("option");
                opt.value="-1";
                opt.text="Seleccione un plantel";
                cboplanteles.appendChild(opt);
                const planteles =  ajax.response;
                for (var i = 0; i < planteles.length; i++) {
                var option = document.createElement("option");
                option.value = planteles[i].id;
                option.text = planteles[i].planel;
                cboplanteles.appendChild(option);
                }
            }
        }
    ajax.send(null);        
    }else{
        limpiarSelect(cboplanteles);
        var opt = document.createElement("option");
        opt.value="-1";
        opt.text="Seleccione un plantel";
        cboplanteles.appendChild(opt);
        alert("Seleccione una Entidad");
    }

}

function limpiarSelect(select){
    for(var i=select.options.length; i>=0; i--){
        select.remove(i);
    }
}

function crearVacancias(idplantel){
    if(idplantel>0){
    ajax.open("GET",'ServletControladorVacancia?id='+idplantel, true);
    ajax.responseType = "json";
    var tbody = document.getElementById('vacanciaData')
        ajax.onreadystatechange=function(){
            if (ajax.readyState === 4){
                console.log(ajax.response);
                const convocatorias =  ajax.response;
                tbody.innerHTML = "";
                var trs = [];                
                if(convocatorias.length==0){
                    $("#mensaje").html("No hay convocatorias disponibles");
                    $("#ifArchivo").attr("hidden",true);
                    $("#modalMensaje").modal();
                }
                for(i=1;i<=convocatorias.length; i++){
                    console.log(convocatorias[i-1]);
                    var td1='<td>'+convocatorias[i-1].nombre+'</td>';
                    var td2='<td><a onClick="crearReporte(this.id);" id="'+convocatorias[i-1].id+'"><i class="fa fa-download" arie-hidden="true"></i></a></td>';
                    var trs="<tr>"+td1+td2+"</tr>";
                    tbody.innerHTML += trs;
                }
                
                     //var td2='<td><a onClick="crearReporte();" id="'+convocatorias[i-1].id+'" href="'+convocatorias[i-1].url+'" target="_blank"><i class="fa fa-download" arie-hidden="true"></i></a></td>';

                }
            }
        }
    ajax.send(null);        
}

function crearReporte(convocatoria){
    var lin = document.getElementById(convocatoria);
    if(!lin.getAttribute("href",true)){
           var plantel = document.getElementById('cboplantel').value.toLocaleString();
           $("#mensaje").html("Generando documento");
           $("#ifArchivo").attr("hidden");
           $("#modalMensaje").modal("show");
    //var qs=document.getElementById("spin");
    //qs.classList.add("loader");
    //qs.classList.remove("hidden");
    ajax.open("GET",'ServletReporte?plantel='+plantel+'&convocatoria='+convocatoria, true);
    ajax.responseType = "json";
        ajax.onreadystatechange=function(){
            if (ajax.readyState === 4){
                const resp = ajax.response;
                //alert(typeof(resp[0]));
                if(resp[0]==="ok"){
                    var url = "Convocatoria?k="+resp[1];
                   lin.setAttribute("href",url);
                   lin.setAttribute("target","_blank");
                   //window.open(url, resp[1]);
                   $("#mensaje").html("");
                   $("#ifArchivo").attr("src",url);
                   $("#ifArchivo").removeAttr("hidden");
                   //$("#modalMensaje").modal("hide");
                   //qs.classList.add("hidden");
                   //qs.classList.remove("loader");
                }else{
                    $("#ifArchivo").attr("hidden",true);
                    $("#mensaje").html("NO SE ENCONTRO LA CONVOCATORIA <br/>PIDA SOPORTE A LA MESA DE AYUDA");
                    //alert();
                }
                }

            }
    ajax.send(null);   
    }
   
}
 
 function crearEntidades(){
     ajax.open("GET",'ServletControladorEntidad', true);
    ajax.responseType = "json";
    var entidad = document.getElementById("cboentidad");
        ajax.onreadystatechange=function(){
            if (ajax.readyState === 4){
                limpiarSelect(entidad);
                var opt = document.createElement("option");
                opt.value="-1";
                opt.text="Seleccione una entidad";
                entidad.appendChild(opt);  
                const entidades =  ajax.response;
                for (var i = 0; i < entidades.length; i++) {
                    var option = document.createElement("option");
                    option.value = entidades[i].id;
                    option.text = entidades[i].entidad;
                    entidad.appendChild(option);
                    }

                }
        }
    ajax.send(null);        
}
function cambioSubsistema(){
    $("#cboentidad").val("");
}

/*window.addEventListener('load', function() {

    crearEntidades();
    console.log('All assets are loaded');
})*/