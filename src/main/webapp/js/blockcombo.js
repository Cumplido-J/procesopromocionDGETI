


$(document).ready(function () {
    blockCombos();
    console.log("Working");
    blockCombos2();
});
function blockCombos() {
    const programa = document.querySelector('#programa');
    const sub = programa.getAttribute("data-sub");
    const ent = programa.getAttribute("data-ent");
    const pla = programa.getAttribute("data-pla");
    console.log(sub + " " + pla + " " + " " + ent);
    if (sub !== "" && ent !== "" && pla !== "") {
        if (( sub !== null) && ( ent !== null) && ( pla !== null )) {
        $("#subsistema").val(sub).attr('selected', 'selected');
        $("#entidad").val(ent).attr('selected', 'selected');
        $("#plantel").val(pla).attr('selected', 'selected');
        $("#subsistema").addClass("disabled");
        $("#entidad").addClass("disabled");
        $("#plantel").addClass("disabled");
        }
    }

}

function blockCombos2() {
    const subsistema = document.querySelector('#subsistema');
    const data_subsistema = subsistema.getAttribute("data-subsistema");
    if (data_subsistema != "") {
        $("#subsistema").val(data_subsistema).attr('selected', 'selected');
        $('#subsistema').addClass("disabled");
    }
}