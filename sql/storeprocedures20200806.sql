
CREATE PROCEDURE `sp_selectConvocatoriasVigentes`(in _fecha date)
BEGIN
select id,nombre from convocatoria where _fecha between publicacion and finRegistro;
END


CREATE PROCEDURE `sp_selectVacanciaPlantelConvocatoriaVigente`(in _idConvocatoria int, in _plantel int)
BEGIN
select count(*) as total from vacancia where 
	idConvocatoria=_idConvocatoria and plantel=_plantel;
END
