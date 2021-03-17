USE `bdpromocion`;
DROP procedure IF EXISTS `sp_consultaFechasConvocatoria`;

DELIMITER $$
USE `bdpromocion`$$
CREATE PROCEDURE `sp_consultaFechasConvocatoria`(in _idPlantel int, in _idPrograma int, in _idSubsistema int, in _perfil char(1))
BEGIN
	if(_perfil = 'D') then
		SELECT count(*)
		FROM convocatoria c
		where c.idPrograma=_idPrograma and c.idPlantel=_idPlantel
		and c.idSubsistema=_idSubsistema
		and now() between c.inicioRegistro and  c.finRegistro;
	end if;
    
    if(_perfil = 'A') then
		SELECT count(*)
		FROM convocatoria c
		where c.idPrograma=_idPrograma and c.idPlantel=_idPlantel
		and c.idSubsistema=_idSubsistema
		and now() between c.inicioValoracion and  c.finValoracion;
	end if;
	
END$$

DELIMITER ;

