
const titulo1 = document.getElementById("programa");

titulo1.addEventListener("input", function (event) {
    var prog1 = document.getElementById("programa").value;

    if (prog1 == "") {
        $("#c1").text("Campo PROGRAMA vacio").css("color", "red");
        $("#programa").css("border", "1px solid red");
    } else {
        $("#c1").text("").css("color", "red");
        $("#programa").css("border", "1px solid black");
    }
});


const publicacion1 = document.getElementById("publicacion");

publicacion1.addEventListener("input", function (event) {
    var publi1 = document.getElementById("publicacion").value;

    if (publi1 == 0) {
        $("#c2").text("Campo FECHA PUBLICACION vacio").css("color", "red");
        $("#publicacion").css("border", "1px solid red");
    } else {
        $("#c2").text("").css("color", "red");
        $("#publicacion").css("border", "1px solid black");
    }
});


const periodo_registro_inicio1 = document.getElementById("periodo_registro_inicio");

periodo_registro_inicio1.addEventListener("input", function (event) {
    var regini1 = document.getElementById("periodo_registro_inicio").value;

    if (regini1 == 0) {
        $("#c3").text("Campo REGISTRO INICIO vacio").css("color", "red");
        $("#periodo_registro_inicio").css("border", "1px solid red");
    } else {
        $("#c3").text("").css("color", "red");
        $("#periodo_registro_inicio").css("border", "1px solid black");
    }
});

const periodo_registro_fin1 = document.getElementById("periodo_registro_fin");

periodo_registro_fin1.addEventListener("input", function (event) {
    var regfin1 = document.getElementById("periodo_registro_fin").value;

    if (regfin1 == 0) {
        $("#c4").text("Campo REGISTRO FINAL vacio").css("color", "red");
        $("#periodo_registro_fin").css("border", "1px solid red");
    } else {
        $("#c4").text("").css("color", "red");
        $("#periodo_registro_fin").css("border", "1px solid black");
    }
});

const periodo_valoracion_inicio1 = document.getElementById("periodo_valoracion_inicio");

periodo_valoracion_inicio1.addEventListener("input", function (event) {
    var valini1 = document.getElementById("periodo_valoracion_inicio").value;

    if (valini1 == 0) {
        $("#c5").text("Campo VALORACION INICIO vacio").css("color", "red");
        $("#periodo_valoracion_inicio").css("border", "1px solid red");
    } else {
        $("#c5").text("").css("color", "red");
        $("#periodo_valoracion_inicio").css("border", "1px solid black");
    }
});

const periodo_valoracion_fin1 = document.getElementById("periodo_valoracion_fin");

periodo_valoracion_fin1.addEventListener("input", function (event) {
    var valfin1 = document.getElementById("periodo_valoracion_fin").value;

    if (valfin1 == 0) {
        $("#c6").text("Campo VALORACION FINAL vacio").css("color", "red");
        $("#periodo_valoracion_fin").css("border", "1px solid red");
    } else {
        $("#c6").text("").css("color", "red");
        $("#periodo_valoracion_fin").css("border", "1px solid black");
    }
});

const periodo_dictaminacion_inicio1 = document.getElementById("periodo_dictaminacion_inicio");

periodo_dictaminacion_inicio1.addEventListener("input", function (event) {
    var dicini1 = document.getElementById("periodo_dictaminacion_inicio").value;

    if (dicini1 == 0) {
        $("#c7").text("Campo DICTAMINACION INICIO vacio").css("color", "red");
        $("#periodo_dictaminacion_inicio").css("border", "1px solid red");
    } else {
        $("#c7").text("").css("color", "red");
        $("#periodo_dictaminacion_inicio").css("border", "1px solid black");
    }
});

const periodo_dictaminacion_fin1 = document.getElementById("periodo_dictaminacion_fin");

periodo_dictaminacion_fin1.addEventListener("input", function (event) {
    var dicfin1 = document.getElementById("periodo_dictaminacion_fin").value;

    if (dicfin1 == 0) {
        $("#c8").text("Campo DICTAMINICACION FINAL vacio").css("color", "red");
        $("#periodo_dictaminacion_fin").css("border", "1px solid red");
    } else {
        $("#c8").text("").css("color", "red");
        $("#periodo_dictaminacion_fin").css("border", "1px solid black");
    }
});

const publicacion_resultados1 = document.getElementById("publicacion_resultados");

publicacion_resultados1.addEventListener("input", function (event) {
    var resul1 = document.getElementById("publicacion_resultados").value;

    if (resul1 == 0) {
        $("#c9").text("Campo FECHA RESULTADOS vacio").css("color", "red");
        $("#publicacion_resultados").css("border", "1px solid red");
    } else {
        $("#c9").text("").css("color", "red");
        $("#publicacion_resultados").css("border", "1px solid black");
    }
});


function  validar_datos() {
var programa1 = document.getElementById("programa").value;
    if (programa1 == 0) {
        $("#c1").text("Campo PROGRAMA vacio").css("color", "red");
        $("#programa").css("border", "1px solid red");
    }

    var publicacion1 = document.getElementById("publicacion").value;
    if (publicacion1 == 0) {
        $("#c2").text("Campo FECHA PUBLICACION vacio").css("color", "red");
        $("#publicacion").css("border", "1px solid red");
    }

    var periodo_registro_inicio1 = document.getElementById("periodo_registro_inicio").value;
    if (periodo_registro_inicio1 == 0) {
        $("#c3").text("Campo REGISTRO INICIO vacio").css("color", "red");
        $("#periodo_registro_inicio").css("border", "1px solid red");
    }

    var periodo_registro_fin1 = document.getElementById("periodo_registro_fin").value;
    if (periodo_registro_fin1 == 0) {
        $("#c4").text("Campo REGISTRO FINAL vacio").css("color", "red");
        $("#periodo_registro_fin").css("border", "1px solid red");
    }

    var periodo_valoracion_inicio1 = document.getElementById("periodo_valoracion_inicio").value;
    if (periodo_valoracion_inicio1 == 0) {
        $("#c5").text("Campo VALORACION INICIO vacio").css("color", "red");
        $("#periodo_valoracion_inicio").css("border", "1px solid red");
    }

    var periodo_valoracion_fin1 = document.getElementById("periodo_valoracion_fin").value;
    if (periodo_valoracion_fin1 == 0) {
        $("#c6").text("Campo VALORACION FINAL vacio").css("color", "red");
        $("#periodo_valoracion_fin").css("border", "1px solid red");
    }

    var periodo_dictaminacion_inicio1 = document.getElementById("periodo_dictaminacion_inicio").value;
    if (periodo_dictaminacion_inicio1 == 0) {
        $("#c7").text("Campo DICTAMINACION INICIO vacio").css("color", "red");
        $("#periodo_dictaminacion_inicio").css("border", "1px solid red");
    }

    var periodo_dictaminacion_fin1 = document.getElementById("periodo_dictaminacion_fin").value;
    if (periodo_dictaminacion_fin1 == 0) {
        $("#c8").text("Campo DICTAMINACION FINAL vacio").css("color", "red");
        $("#periodo_dictaminacion_fin").css("border", "1px solid red");
    }

    var publicacion_resultados1 = document.getElementById("publicacion_resultados").value;
    if (publicacion_resultados1 == 0) {
        $("#c9").text("Campo PUBLICACION RESULTADOS vacio").css("color", "red");
        $("#publicacion_resultados").css("border", "1px solid red");
    }
//----------------------------------------------------------------------------
if (document.getElementById("programa").value === "")
    {
        return false;
    } else {
    }
   
//----------------------------------------------------------------------------

    if (document.getElementById("publicacion").value === "")
    {
        return false;
    } else {
    }

//----------------------------------------------------------------------------

    if (document.getElementById("periodo_registro_inicio").value === "")
    {
        return false;
    } else {
    }

    if (document.getElementById("periodo_registro_fin").value === "")
    {
        return false;
    } else {
    }
    if (document.getElementById("periodo_valoracion_inicio").value === "")
    {
        return false;
    } else {
    }
    if (document.getElementById("periodo_valoracion_fin").value === "")
    {
        return false;
    } else {
    }
    if (document.getElementById("periodo_dictaminacion_inicio").value === "")
    {
        return false;
    } else {
    }
    if (document.getElementById("periodo_dictaminacion_fin").value === "")
    {
        return false;
    } else {
    }
    if (document.getElementById("publicacion_resultados").value === "")
    {
        return false;
    } else {
    }

}


