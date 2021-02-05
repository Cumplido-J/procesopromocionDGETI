USE `bdpromocion`;
DROP procedure IF EXISTS `sp_registraVacancia`;

DELIMITER $$
USE `bdpromocion`$$
CREATE PROCEDURE `sp_registraVacancia`(in _idEntidad int,in _idPlantel int,in _tipoCategoria varchar(3),in _plazas int,in _idCategoria int,in _idJornada int,in _idPrograma int,in _idSubsistema int,in _horas int)
BEGIN
	declare _idConvocatoria int default null;
	declare _idCategoriaAux int;
    declare _idJornadaAux int;    
    declare fin integer default 0;     
    declare cursorCategoriaJornada cursor for 
		select cj.idCategoria,cj.idJornada
		from catcategoriajornada cj
		join catcategoriasplaza cp on cj.idCategoria=cp.id
		where cp.tipo=_tipoCategoria and (idCategoria<_idCategoria) or (idCategoria=_idCategoria and idJornada<_idJornada);
	declare continue handler for not found set fin=1;
    
    select id into _idConvocatoria
    from convocatoria 
    where idPlantel=_idPlantel and idPrograma=_idPrograma;
    if(_idPrograma = '1') then
		if(_idConvocatoria is not null) then
			open cursorCategoriaJornada;
			ciclo:loop
				fetch cursorCategoriaJornada into _idCategoriaAux,_idJornadaAux;
				if fin = 1 then 
					leave ciclo;
				end if;
				if((_idJornada!=1 and _idJornadaAux!=1) or (_idJornada=1 and _idJornadaAux=1)) then
					call sp_insertVacancia(_idEntidad,_idPlantel,_tipoCategoria,_plazas,_idCategoriaAux,_idJornadaAux,'Corrimiento natural',_idPrograma,_idSubsistema,_horas);                 
				end if;            
			end loop ciclo;
			close cursorCategoriaJornada;
			call sp_insertVacancia(_idEntidad,_idPlantel,_tipoCategoria,_plazas,_idCategoria,_idJornada,'Real',_idPrograma,_idSubsistema,_horas);
			select 'ok' as respuesta;
		else
			select 'No existe una convocatoria para el plantel y programa seleccionado' as respuesta;
		end if;
	end if;
    
    if(_idPrograma = '2') then
		if(_idConvocatoria is not null) then
			call sp_insertVacancia(_idEntidad,_idPlantel,_tipoCategoria,_plazas,_idCategoria,_idJornada,'Real',_idPrograma,_idSubsistema,_horas);
			select 'ok' as respuesta;
		else
			select 'No existe una convocatoria para el plantel y programa seleccionado' as respuesta;
		end if;
	end if;
END$$

DELIMITER ;

INSERT INTO `bdpromocion`.`catpermisos` (`id`, `permiso`, `url`, `descripcion`) VALUES ('7', 'Convocatoria Base', 'busquedaConvocatoriaBase.jsp', 'Permite al usuario registrar convocatoria base');


ALTER TABLE `bdpromocion`.`aportaciones` 
ADD COLUMN `valido` CHAR(1) NULL;

ALTER TABLE `bdpromocion`.`cursos` 
ADD COLUMN `valido` CHAR(1) NULL;

ALTER TABLE `bdpromocion`.`participaciones` 
ADD COLUMN `valido` CHAR(1) NULL;

ALTER TABLE `bdpromocion`.`publicaciones` 
ADD COLUMN `valido` CHAR(1) NULL;

ALTER TABLE `bdpromocion`.`resultados` 
ADD COLUMN `valido` CHAR(1) NULL;

ALTER TABLE `bdpromocion`.`tutorias` 
ADD COLUMN `valido` CHAR(1) NULL;


USE `bdpromocion`;
DROP procedure IF EXISTS `sp_selectCursos`;

DELIMITER $$
USE `bdpromocion`$$
CREATE DEFINER=`admin`@`localhost` PROCEDURE `sp_selectCursos`(in _idUsuario int)
BEGIN
	select id,idUsuario,tipo,nombreCurso,fechaInicio,fechaFin,institucion,totalHoras,documento,valido
    from cursos where idUsuario=_idUsuario
    order by fechaInicio asc,fechafin asc;
END$$

DELIMITER ;

USE `bdpromocion`;
DROP procedure IF EXISTS `sp_consultaAportaciones`;

DELIMITER $$
USE `bdpromocion`$$
CREATE DEFINER=`admin`@`localhost` PROCEDURE `sp_consultaAportaciones`(in _idUsuario int)
BEGIN
	select a.id,a.idUsuario,a.idAportacion,b.aportacion,a.fechaInicio,a.fechaFin,a.institucion,a.documento,a.valido
    from aportaciones a
    join cataportacion b on a.idAportacion=b.id
    where a.idUsuario=_idUsuario
    order by a.fechaInicio asc,a.fechafin asc;
END$$

DELIMITER ;

USE `bdpromocion`;
DROP procedure IF EXISTS `sp_consultaParticipaciones`;

DELIMITER $$
USE `bdpromocion`$$
CREATE DEFINER=`admin`@`localhost` PROCEDURE `sp_consultaParticipaciones`(in _idUsuario int)
BEGIN
	select a.id,a.idUsuario,a.idParticipacion,b.participacion,a.fechaInicio,a.fechaFin,a.institucion,a.documento,a.valido
    from participaciones a
    join catparticipacion b on a.idParticipacion=b.id
    where a.idUsuario=_idUsuario
    order by a.fechaInicio asc,a.fechafin asc;
END$$

DELIMITER ;

USE `bdpromocion`;
DROP procedure IF EXISTS `sp_selectTutorias`;

DELIMITER $$
USE `bdpromocion`$$
CREATE DEFINER=`admin`@`localhost` PROCEDURE `sp_selectTutorias`(in _idUsuario int)
BEGIN
	select id,idUsuario,fechaInicio,fechaFin,documento,valido
    from tutorias 
    where idUsuario=_idUsuario
    order by fechaInicio asc,fechafin asc;
END$$

DELIMITER ;

USE `bdpromocion`;
DROP procedure IF EXISTS `sp_selectPublicaciones`;

DELIMITER $$
USE `bdpromocion`$$
CREATE DEFINER=`admin`@`localhost` PROCEDURE `sp_selectPublicaciones`(in _idUsuario int)
BEGIN
	select id,idUsuario,nombre,
    CASE
		WHEN medio = "I" THEN "Impreso"
		WHEN medio = "E" THEN "Electrónico"
		ELSE medio
	END as medio
    ,fecha,ISSN,valido
    from publicaciones where idUsuario=_idUsuario
    order by fecha asc;
END$$

DELIMITER ;

USE `bdpromocion`;
DROP procedure IF EXISTS `sp_consultaResultados`;

DELIMITER $$
USE `bdpromocion`$$
CREATE DEFINER=`admin`@`localhost` PROCEDURE `sp_consultaResultados`(in _idUsuario int)
BEGIN
	select r.id,r.idUsuario,r.idResultado,cr.resultado,r.fechaInicio,r.fechaFin,r.documento,r.valido
    from resultados r
    join catresultado cr on r.idResultado=cr.id
    where r.idUsuario=_idUsuario
    order by r.fechaInicio asc,r.fechafin asc;
END$$

DELIMITER ;

USE `bdpromocion`;
DROP procedure IF EXISTS `sp_aprobarCurso`;

DELIMITER $$
USE `bdpromocion`$$
CREATE PROCEDURE `sp_aprobarCurso` (in _id int)
BEGIN
	update cursos set valido='V' where id=_id;
	select "ok" as respuesta;
END$$

DELIMITER ;

USE `bdpromocion`;
DROP procedure IF EXISTS `sp_rechazarCurso`;

DELIMITER $$
USE `bdpromocion`$$
CREATE PROCEDURE `sp_rechazarCurso` (in _id int)
BEGIN
	update cursos set valido='F' where id=_id;
	select "ok" as respuesta;
END$$

DELIMITER ;

DELIMITER ;

USE `bdpromocion`;
DROP procedure IF EXISTS `sp_aprobarAportacion`;

DELIMITER $$
USE `bdpromocion`$$
CREATE PROCEDURE `sp_aprobarAportacion` (in _id int)
BEGIN
	update aportaciones set valido='V' where id=_id;
	select "ok" as respuesta;
END$$

DELIMITER ;

USE `bdpromocion`;
DROP procedure IF EXISTS `sp_rechazarAportacion`;

DELIMITER $$
USE `bdpromocion`$$
CREATE PROCEDURE `sp_rechazarAportacion` (in _id int)
BEGIN
	update aportaciones set valido='F' where id=_id;
	select "ok" as respuesta;
END$$

DELIMITER ;

DELIMITER ;

USE `bdpromocion`;
DROP procedure IF EXISTS `sp_aprobarParticipacion`;

DELIMITER $$
USE `bdpromocion`$$
CREATE PROCEDURE `sp_aprobarParticipacion` (in _id int)
BEGIN
	update participaciones set valido='V' where id=_id;
	select "ok" as respuesta;
END$$

DELIMITER ;

USE `bdpromocion`;
DROP procedure IF EXISTS `sp_rechazarParticipacion`;

DELIMITER $$
USE `bdpromocion`$$
CREATE PROCEDURE `sp_rechazarParticipacion` (in _id int)
BEGIN
	update participaciones set valido='F' where id=_id;
	select "ok" as respuesta;
END$$

DELIMITER ;

DELIMITER ;

USE `bdpromocion`;
DROP procedure IF EXISTS `sp_aprobarTutoria`;

DELIMITER $$
USE `bdpromocion`$$
CREATE PROCEDURE `sp_aprobarTutoria` (in _id int)
BEGIN
	update tutorias set valido='V' where id=_id;
	select "ok" as respuesta;
END$$

DELIMITER ;

USE `bdpromocion`;
DROP procedure IF EXISTS `sp_rechazarTutoria`;

DELIMITER $$
USE `bdpromocion`$$
CREATE PROCEDURE `sp_rechazarTutoria` (in _id int)
BEGIN
	update tutorias set valido='F' where id=_id;
	select "ok" as respuesta;
END$$

DELIMITER ;

DELIMITER ;

USE `bdpromocion`;
DROP procedure IF EXISTS `sp_aprobarPublicacion`;

DELIMITER $$
USE `bdpromocion`$$
CREATE PROCEDURE `sp_aprobarPublicacion` (in _id int)
BEGIN
	update publicaciones set valido='V' where id=_id;
	select "ok" as respuesta;
END$$

DELIMITER ;

USE `bdpromocion`;
DROP procedure IF EXISTS `sp_rechazarPublicacion`;

DELIMITER $$
USE `bdpromocion`$$
CREATE PROCEDURE `sp_rechazarPublicacion` (in _id int)
BEGIN
	update publicaciones set valido='F' where id=_id;
	select "ok" as respuesta;
END$$

DELIMITER ;

DELIMITER ;

USE `bdpromocion`;
DROP procedure IF EXISTS `sp_aprobarResultado`;

DELIMITER $$
USE `bdpromocion`$$
CREATE PROCEDURE `sp_aprobarResultado` (in _id int)
BEGIN
	update resultados set valido='V' where id=_id;
	select "ok" as respuesta;
END$$

DELIMITER ;

USE `bdpromocion`;
DROP procedure IF EXISTS `sp_rechazarResultado`;

DELIMITER $$
USE `bdpromocion`$$
CREATE PROCEDURE `sp_rechazarResultado` (in _id int)
BEGIN
	update resultados set valido='F' where id=_id;
	select "ok" as respuesta;
END$$

DELIMITER ;
