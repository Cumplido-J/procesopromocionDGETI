function plaza() {
    var cod = document.getElementById("plaza1").value;

    var combo = document.getElementById("plaza1");
    var selected = combo.options[combo.selectedIndex].text;


    if (document.getElementById("plaza1").value == "0")
    {
        $("#n30").text("Selecciona una PLAZA").css("color", "red");
        $("#plaza1").css("border", "1px solid red");

    } else {
        document.getElementById("n30").innerHTML = "";
        $("#plaza1").css("border", "none");
    }

    $("#i_opc2").val("1");
    $.post("combo2.jsp", $("#data").serialize(), function (data) {
        $("#i_plantel2").html(data);
    });
}


function validarentrada3() {
    if (document.getElementById("i_plantel").value == "0")
    {
        $("#n7").text("Selecciona un PLANTEL").css("color", "red");
        $("#i_plantel").css("border", "1px solid red");

    } else {
        document.getElementById("n7").innerHTML = "";
        $("#i_plantel").css("border", "none");
    }
}




function jornada1() {
    var cod = document.getElementById("i_plantel3").value;

    var combo = document.getElementById("i_plantel3");
    var selected = combo.options[combo.selectedIndex].text;
    document.data.campojornada.value = selected;

    if (document.getElementById("i_plantel3").value == "0")
    {
        $("#n50").text("Selecciona una JORNADA").css("color", "red");
        $("#i_plantel3").css("border", "1px solid red");

    } else {
        document.getElementById("n50").innerHTML = "";
        $("#i_plantel3").css("border", "none");
    }
}


function convocatoria1() {


    var combo = document.getElementById("convocatoria");
    var selected = combo.options[combo.selectedIndex].text;
    document.data.campojornada.value = selected;

    if (document.getElementById("convocatoria").value == "0")
    {
        $("#n80").text("Selecciona una CONVOCATORIA").css("color", "red");
        $("#convocatoria").css("border", "1px solid red");

    } else {
        document.getElementById("n80").innerHTML = "";
        $("#convocatoria").css("border", "none");
    }
}

//function grado1() {
//    var cod = document.getElementById("i_plantel4").value;
//
//    var combo = document.getElementById("i_plantel4");
//    var selected = combo.options[combo.selectedIndex].text;
//    document.data.campogrado1.value = selected;
//
//    if (document.getElementById("i_plantel4").value == "0")
//    {
//        $("#n60").text("Selecciona una GRADO ACADEMICO").css("color", "red");
//        $("#i_plantel4").css("border", "1px solid red");
//
//    } else {
//        document.getElementById("n60").innerHTML = "";
//        $("#i_plantel4").css("border", "none");
//    }
//}


function vacancia1() {
    var cod = document.getElementById("tipovacancia").value;

    var combo = document.getElementById("tipovacancia");
    var selected = combo.options[combo.selectedIndex].text;

    if (document.getElementById("tipovacancia").value == "0")
    {
        $("#n70").text("Selecciona un TIPO DE VACANCIA").css("color", "red");
        $("#tipovacancia").css("border", "1px solid red");

    } else {
        document.getElementById("n70").innerHTML = "";
        $("#tipovacancia").css("border", "none");
    }
}

const cantidad1 = document.getElementById("cantidad");

cantidad1.addEventListener("input", function (event) {
    var usu1 = document.getElementById("cantidad").value;
    var usu1on = document.getElementById("cantidad").value.length;

    if (/^[0-9]+$/.test(usu1)) {
        document.getElementById("n100").innerHTML = "";
        $("#cantidad").css("border", "none");
    } else if (usu1 == "") {
        $("#n100").text("Campo CANTIDAD PLAZAS vacio").css("color", "red");
        $("#cantidad").css("border", "1px solid red");
    } else {
        $("#n100").text("Campo CANTIDAD PLAZAS solo acepta numeros").css("color", "red");
        $("#cantidad").css("border", "1px solid red");
    }
});

function  validate() {
    var ent1 = document.getElementById("entidad").value;
    var control_combobox = document.getElementById("control_combobox").value;

    if (ent1 === "0" && control_combobox === "false") {
        $("#n8").text("Campo ENTIDAD vacio").css("color", "red");
        $("#entidad").css("border", "1px solid red");
    }

    var pla1 = document.getElementById("i_plantel").value;
    if (pla1 === "0" && control_combobox === "false") {
        $("#n7").text("Campo PLANTEL vacio").css("color", "red");
        $("#i_plantel").css("border", "1px solid red");
    }
    
    var plaz1 = document.getElementById("plaza1").value;
    if (plaz1 == "0") {
        $("#n30").text("Campo CATEGORIA PLAZA vacio").css("color", "red");
        $("#plaza1").css("border", "1px solid red");
    }

    var cat1 = document.getElementById("cantidad").value;
    if (cat1 == "") {
        $("#n100").text("Campo CANTIDAD PLAZAS vacio").css("color", "red");
        $("#cantidad").css("border", "1px solid red");
    }

    var tipo1 = document.getElementById("i_plantel2").value;
    if (tipo1 == "0") {
        $("#n40").text("Campo TIPO DE CATEGORIA vacio").css("color", "red");
        $("#i_plantel2").css("border", "1px solid red");
    }

    var jor1 = document.getElementById("i_plantel3").value;
    if (jor1 == "0") {
        $("#n50").text("Campo JORNADA vacio").css("color", "red");
        $("#i_plantel3").css("border", "1px solid red");
    }

    var con1 = document.getElementById("convocatoria").value;
    if (con1 == "0") {
        $("#n80").text("Campo CONVOCATORIA vacio").css("color", "red");
        $("#convocatoria").css("border", "1px solid red");
    }
//    var gra1 = document.getElementById("i_plantel4").value;
//    if (gra1 == "0") {
//        $("#n60").text("Campo GRADO ACADEMICO vacio").css("color", "red");
//        $("#i_plantel4").css("border", "1px solid red");
//    }

    var vac1 = document.getElementById("tipovacancia").value;
    if (vac1 == "0") {
        $("#n70").text("Campo VACANCIA vacio").css("color", "red");
        $("#tipovacancia").css("border", "1px solid red");
    }

//----------------------------------------------------------------------------
   if (document.getElementById("i_plantel").value === "0" && control_combobox === "false")
    {
        return false;
    } else {
    }

//----------------------------------------------------------------------------
    if (document.getElementById("entidad").value === "0" && control_combobox === "false")
    {
        return false;
    } else {
    }

//----------------------------------------------------------------------------
    if (document.getElementById("plaza1").value == "0")
    {
        return false;
    } else {
    }
//----------------------------------------------------------------------------
    if (document.getElementById("cantidad").value == "")
    {
        return false;
    } else {
    }
//----------------------------------------------------------------------------
    if (document.getElementById("i_plantel2").value == "0")
    {
        return false;
    } else {
    }

//----------------------------------------------------------------------------
    if (document.getElementById("i_plantel3").value == "0")
    {
        return false;
    } else {
    }

//----------------------------------------------------------------------------
//    if (document.getElementById("i_plantel4").value == "0")
//    {
//        return false;
//    } else {
//    }

//----------------------------------------------------------------------------
    if (document.getElementById("tipovacancia").value == "0")
    {
        return false;
    } else {
    }

//----------------------------------------------------------------------------
    if (document.getElementById("convocatoria").value == "0")
    {
        return false;
    } else {
    }

}


