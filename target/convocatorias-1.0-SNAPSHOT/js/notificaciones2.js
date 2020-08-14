function validarentrada1() {
    if (document.getElementById("i_plantel").value == "0")
    {
        $("#n7").text("Selecciona un PLANTEL").css("color", "red");
        $("#i_plantel").css("border", "1px solid red");

    } else {
        document.getElementById("n7").innerHTML = "";
        $("#i_plantel").css("border", "none");
    }
}

//------------------------------------------------------------------------------
function programa1() {
    if (document.getElementById("prog").value == "0")
    {
        $("#n100").text("Selecciona un PROGRAMA").css("color", "red");
        $("#prog").css("border", "1px solid red");

    } else {
        document.getElementById("n100").innerHTML = "";
        $("#prog").css("border", "none");
    }
}

//------------------------------------------------------------------------------
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


//------------------------------------------------------------------------------
const nombre = document.getElementById("nombre_nom");

nombre.addEventListener("input", function (event) {
    var nom1 = document.getElementById("nombre_nom").value;
    if (/^[A-Za-z ]+$/.test(nom1)) {
        document.getElementById("n").innerHTML = "";
        $("#nombre_nom").css("border", "none");
    } else if (nom1 == "") {
        $("#n").text("Campo NOMBRE vacio").css("color", "red");
        $("#nombre_nom").css("border", "1px solid red");

    } else {
        //document.getElementById("n").innerHTML = "El Nombre solo acepta letras";
        $("#n").text("Campo NOMBRE solo acepta letras").css("color", "red");
        $("#nombre_nom").css("border", "1px solid red");
    }
});
//------------------------------------------------------------------------------

const apellidopaterno = document.getElementById("ap");

apellidopaterno.addEventListener("input", function (event) {
    var ap1 = document.getElementById("ap").value;
    if (/^[A-Za-z ]+$/.test(ap1)) {
        document.getElementById("n1").innerHTML = "";
        $("#ap").css("border", "none");
    } else if (ap1 == "") {
        $("#n1").text("Campo APELLIDO PATERNO vacio").css("color", "red");
        $("#ap").css("border", "1px solid red");

    } else {
        //document.getElementById("n").innerHTML = "El Nombre solo acepta letras";
        $("#n1").text("Campo APELLIDO PATERNO solo acepta letras").css("color", "red");
        $("#ap").css("border", "1px solid red");
    }
});
//------------------------------------------------------------------------------

const apellidomaterno = document.getElementById("am");

apellidomaterno.addEventListener("input", function (event) {
    var am1 = document.getElementById("am").value;
    if (/^[A-Za-z ]+$/.test(am1) || am1 == "") {
        document.getElementById("n2").innerHTML = "";
        $("#am").css("border", "none");
    } else if (am1 == "") {
//        $("#n2").text("Campo APELLIDO MATERNO vacio").css("color", "red");
//        $("#am").css("border", "1px solid red");

    } else {
        //document.getElementById("n").innerHTML = "El Nombre solo acepta letras";
        $("#n2").text("Campo APELLIDO MATERNO solo acepta letras").css("color", "red");
        $("#am").css("border", "1px solid red");
    }
});
//------------------------------------------------------------------------------

const rfc = document.getElementById("rfc");

rfc.addEventListener("input", function (event) {
    var rfc1 = document.getElementById("rfc").value;
    var lonrfc1 = document.getElementById("rfc").value.length;
    if (/^([A-ZÑa-zñ\x26]{3,4}([0-9]{2})(0[1-9]|1[0-2])(0[1-9]|1[0-9]|2[0-9]|3[0-1]))([A-Za-z\d]{3})+$/.test(rfc1)) {
        document.getElementById("n3").innerHTML = "";
        $("#rfc").css("border", "none");
    } else if (rfc1 == "") {
        $("#n3").text("Campo RFC vacio").css("color", "red");
        $("#rfc").css("border", "1px solid red");

    } else if (lonrfc1 < 13) {
        $("#n3").text("Campo RFC a 13 digitos").css("color", "red");
        $("#rfc").css("border", "1px solid red");

    } else {
        //document.getElementById("n").innerHTML = "El Nombre solo acepta letras";
        $("#n3").text("Campo RFC con el formato establecido").css("color", "red");
        $("#rfc").css("border", "1px solid red");
    }
});
//------------------------------------------------------------------------------

const telefono = document.getElementById("tel");

telefono.addEventListener("input", function (event) {
    var tel1 = document.getElementById("tel").value;
    var lontel1 = document.getElementById("tel").value.length;
    if (/^[0-9]+$/.test(tel1)) {
        document.getElementById("n4").innerHTML = "";
        $("#tel").css("border", "none");
        if (lontel1 < 10) {
            $("#n4").text("Campo TELEFONO a 10 digitos").css("color", "red");
            $("#tel").css("border", "1px solid red");
        }
    } else if (tel1 == "") {
        $("#n4").text("Campo TELEFONO vacio").css("color", "red");
        $("#tel").css("border", "1px solid red");

    } else {
        $("#n4").text("Campo TELEFONO solo acepta numeros").css("color", "red");
        $("#tel").css("border", "1px solid red");
    }
});

//------------------------------------------------------------------------------

const celular = document.getElementById("cel");

celular.addEventListener("input", function (event) {
    var cel1 = document.getElementById("cel").value;
    var loncel1 = document.getElementById("cel").value.length;
    if (/^[0-9]+$/.test(cel1)) {
        document.getElementById("n5").innerHTML = "";
        $("#cel").css("border", "none");
        if (loncel1 < 10) {
            $("#n5").text("Campo CELULAR a 10 digitos").css("color", "red");
            $("#cel").css("border", "1px solid red");
        }
    } else if (cel1 == "") {
        $("#n5").text("Campo CELULAR vacio").css("color", "red");
        $("#cel").css("border", "1px solid red");

    } else {
        $("#n5").text("Campo CELULAR solo acepta numeros").css("color", "red");
        $("#cel").css("border", "1px solid red");
    }
});
//------------------------------------------------------------------------------
const mail = document.getElementById("correo");

mail.addEventListener("input", function (event) {
    var correo1 = document.getElementById("correo").value;
    if (/^[-\w.%+]{1,64}@(?:[A-Za-z0-9-]{1,63}\.){1,125}[A-Za-z]{2,63}$/.test(correo1)) {
        document.getElementById("n6").innerHTML = "";
        $("#correo").css("border", "none");
    } else if (correo1 == "") {
        $("#n6").text("Campo CORREO vacio").css("color", "red");
        $("#correo").css("border", "1px solid red");

    } else {
        //document.getElementById("n").innerHTML = "El Nombre solo acepta letras";
        $("#n6").text("Campo CORREO formato no aceptado").css("color", "red");
        $("#correo").css("border", "1px solid red");
    }
});
//------------------------------------------------------------------------------
const clave1 = document.getElementById("pass1");

clave1.addEventListener("input", function (event) {
    var pass1 = document.getElementById("pass1").value;
    if (pass1 == "") {
        $("#error1").text("Campo CONTRASEÑA vacio").css("color", "red");
        $("#pass1").css("border", "1px solid red");

    } else {
        //document.getElementById("n").innerHTML = "El Nombre solo acepta letras";
        $("#error1").text("").css("color", "red");
        $("#pass1").css("border", "none");
    }
});
//------------------------------------------------------------------------------
const clave2 = document.getElementById("pass2");

clave2.addEventListener("input", function (event) {
    var pass2 = document.getElementById("pass1").value;
    if (pass2 == "") {
        $("#error2").text("Campo CONTRASEÑA vacio").css("color", "red");
        $("#pass2").css("border", "1px solid red");

    } else {
        //document.getElementById("n").innerHTML = "El Nombre solo acepta letras";
        $("#error2").text("").css("color", "red");
        $("#pass2").css("border", "none");
    }
});
//------------------------------------------------------------------------------
const clave3 = document.getElementById("pass2");

clave3.addEventListener("input", function (event) {
    var p1 = document.getElementById("pass1").value;
    var p2 = document.getElementById("pass2").value;
    var cadenavacia = new String("");
    if (p1 != p2) {
        $("#error2").text("Las contraseñas NO Coinciden!").css("color", "red");
    } else
    {
        $("#error2").text("Las contraseñas Coinciden!").css("color", "green");
    }
});

//------------------------------------------------------------------------------


function  validate() {
    //------------------------------------------------------------------------------

    var p1 = document.getElementById("pass1").value;
    var p2 = document.getElementById("pass2").value;
    var cadenavacia = new String("");
    if (p1 != p2) {
        $("#error2").text("Las contraseñas NO Coinciden!").css("color", "red");
        return false;
    } else
    {
        $("#error2").text("Las contraseñas Coinciden!").css("color", "green");
    }

//------------------------------------------------------------------------------
    var prog1 = document.getElementById("prog").value;
    if (prog1 == "0") {
        $("#n100").text("Campo PROGRAMA vacio").css("color", "red");
        $("#prog").css("border", "1px solid red");
    }

    var ent1 = document.getElementById("entidad").value;
    if (ent1 == "0") {
        $("#n8").text("Campo ENTIDAD vacio").css("color", "red");
        $("#entidad").css("border", "1px solid red");
    }

    var pla1 = document.getElementById("i_plantel").value;
    if (pla1 == "0") {
        $("#n7").text("Campo PLANTEL vacio").css("color", "red");
        $("#i_plantel").css("border", "1px solid red");
    }

    var nom1 = document.getElementById("nombre_nom").value;
    if (nom1 == "") {
        $("#n").text("Campo NOMBRE vacio").css("color", "red");
        $("#nombre_nom").css("border", "1px solid red");
    }

    var ap1 = document.getElementById("ap").value;
    if (ap1 == "") {
        $("#n1").text("Campo APELLIDO PATERNO vacio").css("color", "red");
        $("#ap").css("border", "1px solid red");
    }

    var rfc1 = document.getElementById("rfc").value;
    if (rfc1 == "") {
        $("#n3").text("Campo RFC vacio").css("color", "red");
        $("#rfc").css("border", "1px solid red");
    }

    var tel1 = document.getElementById("tel").value;
    if (tel1 == "") {
        $("#n4").text("Campo TELEFONO vacio").css("color", "red");
        $("#tel").css("border", "1px solid red");
    }

    var cel1 = document.getElementById("cel").value;
    if (cel1 == "") {
        $("#n5").text("Campo CELULAR vacio").css("color", "red");
        $("#cel").css("border", "1px solid red");
    }

    var correo1 = document.getElementById("correo").value;
    if (correo1 == "") {
        $("#n6").text("Campo CORREO vacio").css("color", "red");
        $("#correo").css("border", "1px solid red");
    }

    var p1 = document.getElementById("pass1").value;
    var p2 = document.getElementById("pass2").value;
    if (p1 == "") {
        $("#error1").text("Campo Contraseña vacio").css("color", "red");
        $("#pass1").css("border", "1px solid red");
    }
    if (p2 == "") {
        $("#error2").text("Campo Contraseña vacio").css("color", "red");
        $("#pass2").css("border", "1px solid red");
    }



//----------------------------------------------------------------------------
    var nom = document.getElementById("nombre_nom").value;
    if (nom == cadenavacia)
    {
        return false;
    }

    if (/^[A-Za-z ]+$/.test(nom)) {
    } else {
        return false;
    }

//----------------------------------------------------------------------------

    var ap1 = document.getElementById("ap").value;
    if (ap1 == cadenavacia)
    {
        return false;
    }

    if (/^[A-Za-z ]+$/.test(ap1)) {
    } else {
        return false;
    }

//----------------------------------------------------------------------------

    var am1 = document.getElementById("am").value;
//    if (am1 == cadenavacia)
//    {
//        return false;
//    }

    if (/^[A-Za-z ]+$/.test(am1)) {
    } else {
//        return false;
    }

//----------------------------------------------------------------------------
    var rfc1 = document.getElementById("rfc").value;
    var lonrfc1 = document.getElementById("rfc").value.length;
    if (rfc1 == cadenavacia)
    {
        return false;
    }

    if (/^([A-ZÑa-zñ\x26]{3,4}([0-9]{2})(0[1-9]|1[0-2])(0[1-9]|1[0-9]|2[0-9]|3[0-1]))([A-Za-z\d]{3})+$/.test(rfc1)) {
    } else {
        return false;
    }

    if (lonrfc1 < 13)
    {
        return false;
    }
//----------------------------------------------------------------------------

    var tel1 = document.getElementById("tel").value;
    var lontel1 = document.getElementById("tel").value.length;
    if (tel1 == cadenavacia)
    {
        return false;
    }

    if (/^[0-9]+$/.test(tel1)) {
    } else {
        return false;
    }

    if (lontel1 < 10)
    {
        return false;
    }
//----------------------------------------------------------------------------

    var cel1 = document.getElementById("cel").value;
    var loncel1 = document.getElementById("cel").value.length;
    if (cel1 == cadenavacia)
    {
        return false;
    }

    if (/^[0-9]+$/.test(cel1)) {
    } else {
        return false;
    }

    if (loncel1 < 10)
    {
        return false;
    }
//----------------------------------------------------------------------------

    var correo1 = document.getElementById("correo").value;
    if (correo1 == cadenavacia)
    {
        return false;
    }

    if (/^[-\w.%+]{1,64}@(?:[A-Za-z0-9-]{1,63}\.){1,125}[A-Za-z]{2,63}$/.test(correo1)) {
    } else {
        return false;
    }
//----------------------------------------------------------------------------

    if (document.getElementById("i_plantel").value == "0")
    {
        return false;
    } else {
    }

//----------------------------------------------------------------------------
    if (document.getElementById("entidad").value == "0")
    {
        return false;
    } else {
    }

//----------------------------------------------------------------------------

    if (document.getElementById("prog").value == "0")
    {
        return false;
    } else {
    }

}


