INSERT INTO `bdpromocion`.`catpuntaje` (`id`, `descripcion`, `puntaje`, `multiple`, `puntajeFijo`) VALUES ('55', 'Revision Criterios', '0', 'F', 'V');

#_____________________________________________________________________________________________________________________________

INSERT INTO `bdpromocion`.`catestatus` (`id`, `estatus`) VALUES ('11', 'Información general validada por consejo dictaminador');
INSERT INTO `bdpromocion`.`catestatus` (`id`, `estatus`) VALUES ('12', 'Información de encuestados validada por consejo dictaminador');
INSERT INTO `bdpromocion`.`catestatus` (`id`, `estatus`) VALUES ('13', 'Criterios de valoración validados por consejo dictaminador');

#_____________________________________________________________________________________________________________________________

ALTER TABLE `bdpromocion`.`constanciasproceso` 
DROP FOREIGN KEY `fkCatPuntaje1`;
ALTER TABLE `bdpromocion`.`constanciasproceso` 
CHANGE COLUMN `idCatPuntaje1` `idCatPuntaje1` INT NULL DEFAULT NULL ;
ALTER TABLE `bdpromocion`.`constanciasproceso` 
ADD CONSTRAINT `fkCatPuntaje1`
  FOREIGN KEY (`idCatPuntaje1`)
  REFERENCES `bdpromocion`.`catpuntaje` (`id`);

#_____________________________________________________________________________________________________________________________

ALTER TABLE `bdpromocion`.`constanciasproceso` 
ADD COLUMN `aceptado2` CHAR(1) NOT NULL AFTER `observacion`,
ADD COLUMN `observacion2` VARCHAR(200) NULL DEFAULT NULL AFTER `aceptado2`;

#_____________________________________________________________________________________________________________________________

ALTER TABLE `bdpromocion`.`aspirantes` 
ADD COLUMN `observacionCriterios2` VARCHAR(200) NULL DEFAULT NULL AFTER `evaluacion2`;

#_____________________________________________________________________________________________________________________________

ALTER TABLE `bdpromocion`.`cursos` 
ADD COLUMN `valido2` CHAR(1) NULL DEFAULT NULL AFTER `valido`;

#_____________________________________________________________________________________________________________________________

ALTER TABLE `bdpromocion`.`aportaciones` 
ADD COLUMN `valido2` CHAR(1) NULL DEFAULT NULL AFTER `valido`;

#_____________________________________________________________________________________________________________________________

ALTER TABLE `bdpromocion`.`participaciones` 
ADD COLUMN `valido2` CHAR(1) NULL DEFAULT NULL AFTER `valido`;

#_____________________________________________________________________________________________________________________________

ALTER TABLE `bdpromocion`.`tutorias` 
ADD COLUMN `valido2` CHAR(1) NULL DEFAULT NULL AFTER `valido`;

#_____________________________________________________________________________________________________________________________

ALTER TABLE `bdpromocion`.`publicaciones` 
ADD COLUMN `valido2` CHAR(1) NULL DEFAULT NULL AFTER `valido`;

#_____________________________________________________________________________________________________________________________

ALTER TABLE `bdpromocion`.`resultados` 
ADD COLUMN `valido2` CHAR(1) NULL DEFAULT NULL AFTER `valido`;

#_____________________________________________________________________________________________________________________________

ALTER TABLE `bdpromocion`.`constanciasproceso` 
CHANGE COLUMN `aceptado` `aceptado` CHAR(1) NULL ,
CHANGE COLUMN `aceptado2` `aceptado2` CHAR(1) NULL ;

#_____________________________________________________________________________________________________________________________

USE `bdpromocion`;
DROP procedure IF EXISTS `sp_consultaConstanciasProceso`;

DELIMITER $$
USE `bdpromocion`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_consultaConstanciasProceso`(in _idUsuario int)
BEGIN

		select a.id,a.idUsuario,c.id as idCriterio,a.idCatPuntaje1,
			CASE
				WHEN b.puntaje is null THEN 0			
				ELSE b.puntaje
			END as puntaje,
			c.criterio,b.descripcion,a.aceptado
		from catcriteriosvaloracion c
		left join (select * from constanciasproceso where idUsuario=_idUsuario) a on c.id=a.idCriterio 
		left join catpuntaje b on a.idCatPuntaje1=b.id    
		where a.idUsuario=_idUsuario or a.idUsuario is null
		order by c.id asc;
    
END$$

DELIMITER ;

#_____________________________________________________________________________________________________________________________

USE `bdpromocion`;
DROP procedure IF EXISTS `sp_consultaConstanciasProcesoDictaminador`;

DELIMITER $$
USE `bdpromocion`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_consultaConstanciasProcesoDictaminador`(in _idUsuario int)
BEGIN

		select a.id,a.idUsuario,c.id as idCriterio,a.idCatPuntaje2,
			CASE
				WHEN b.puntaje is null THEN 0			
				ELSE b.puntaje
			END as puntaje,
			c.criterio,b.descripcion,a.aceptado2
		from catcriteriosvaloracion c
		left join (select * from constanciasproceso where idUsuario=_idUsuario) a on c.id=a.idCriterio 
		left join catpuntaje b on a.idCatPuntaje2=b.id    
		where a.idUsuario=_idUsuario or a.idUsuario is null
		order by c.id asc;
    
END$$

DELIMITER ;

#_____________________________________________________________________________________________________________________________

USE `bdpromocion`;
DROP procedure IF EXISTS `sp_finProceso`;

DELIMITER $$
USE `bdpromocion`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_finProceso`(in _idUsuario int, in _totalEncuestados int, in _observacion varchar(200),in _evaluacion DECIMAL(10,5), in _idPermiso int)
BEGIN	
	declare _idEstatus int default null;
    if _totalEncuestados<30 then
		set _idEstatus=6;
    else
		set _idEstatus=7;
    end if;
    if _evaluacion is not null then
		set _idEstatus=10;
    end if;

    if _idPermiso = 6 then    

		update aspirantes
		set finRegistro=now(),
		idEstatus=_idEstatus,observacionCriterios2=_observacion,evaluacion2=_evaluacion 
		where idUsuario=_idUsuario;    
    else    
		update aspirantes
		set finRegistro=now(),
		idEstatus=_idEstatus,observacionCriterios=_observacion,evaluacion=_evaluacion 
		where idUsuario=_idUsuario;
    
    end if;
    
    call sp_insertBitacora(_idUsuario, 'A', 'El usuario finalizó el proceso');
END$$

DELIMITER ;

#_____________________________________________________________________________________________________________________________

USE `bdpromocion`;
DROP procedure IF EXISTS `sp_aprobarCurso`;

DELIMITER $$
USE `bdpromocion`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_aprobarCurso`(in _id int, in _idPermiso int)
BEGIN

if _idPermiso = 6 then
	update cursos set valido2='V' where id=_id;
else
	update cursos set valido='V' where id=_id;
end if;

	select "ok" as respuesta;

END$$

DELIMITER ;

#_____________________________________________________________________________________________________________________________

USE `bdpromocion`;
DROP procedure IF EXISTS `sp_rechazarCurso`;

DELIMITER $$
USE `bdpromocion`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_rechazarCurso`(in _id int, in _idPermiso int)
BEGIN

if _idPermiso = 6 then
	update cursos set valido2='F' where id=_id;
else
	update cursos set valido='F' where id=_id;
end if;    
    
	select "ok" as respuesta;
END$$

DELIMITER ;

#_____________________________________________________________________________________________________________________________

USE `bdpromocion`;
DROP procedure IF EXISTS `sp_selectCursos`;

DELIMITER $$
USE `bdpromocion`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_selectCursos`(in _idUsuario int)
BEGIN
	select id,idUsuario,tipo,nombreCurso,fechaInicio,fechaFin,institucion,totalHoras,documento,valido,valido2
    from cursos where idUsuario=_idUsuario
    order by fechaInicio asc,fechafin asc;
END$$

DELIMITER ;

#_____________________________________________________________________________________________________________________________

USE `bdpromocion`;
DROP procedure IF EXISTS `sp_consultaAportaciones`;

DELIMITER $$
USE `bdpromocion`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_consultaAportaciones`(in _idUsuario int)
BEGIN
	select a.id,a.idUsuario,a.idAportacion,b.aportacion,a.fechaInicio,a.fechaFin,a.institucion,a.documento,a.valido,a.valido2
    from aportaciones a
    join cataportacion b on a.idAportacion=b.id
    where a.idUsuario=_idUsuario
    order by a.fechaInicio asc,a.fechafin asc;
END$$

DELIMITER ;

#_____________________________________________________________________________________________________________________________

USE `bdpromocion`;
DROP procedure IF EXISTS `sp_aprobarAportacion`;

DELIMITER $$
USE `bdpromocion`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_aprobarAportacion`(in _id int, in _idPermiso int)
BEGIN

if _idPermiso = 6 then
	update aportaciones set valido2='V' where id=_id;
else
	update aportaciones set valido='V' where id=_id;
end if;    
    
	select "ok" as respuesta;
END$$

DELIMITER ;

#_____________________________________________________________________________________________________________________________

USE `bdpromocion`;
DROP procedure IF EXISTS `sp_rechazarAportacion`;

DELIMITER $$
USE `bdpromocion`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_rechazarAportacion`(in _id int, in _idPermiso int)
BEGIN
    
if _idPermiso = 6 then
	update aportaciones set valido2='F' where id=_id;
else
	update aportaciones set valido='F' where id=_id;
end if; 
    
	select "ok" as respuesta;
END$$

DELIMITER ;

#_____________________________________________________________________________________________________________________________

USE `bdpromocion`;
DROP procedure IF EXISTS `sp_consultaParticipaciones`;

DELIMITER $$
USE `bdpromocion`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_consultaParticipaciones`(in _idUsuario int)
BEGIN
	select a.id,a.idUsuario,a.idParticipacion,b.participacion,a.fechaInicio,a.fechaFin,a.institucion,a.documento,a.valido,a.valido2
    from participaciones a
    join catparticipacion b on a.idParticipacion=b.id
    where a.idUsuario=_idUsuario
    order by a.fechaInicio asc,a.fechafin asc;
END$$

DELIMITER ;

#_____________________________________________________________________________________________________________________________

USE `bdpromocion`;
DROP procedure IF EXISTS `sp_aprobarParticipacion`;

DELIMITER $$
USE `bdpromocion`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_aprobarParticipacion`(in _id int, in _idPermiso int)
BEGIN
    
if _idPermiso = 6 then
	update participaciones set valido2='V' where id=_id;
else
	update participaciones set valido='V' where id=_id;
end if;        
    
	select "ok" as respuesta;
END$$

DELIMITER ;

#_____________________________________________________________________________________________________________________________

USE `bdpromocion`;
DROP procedure IF EXISTS `sp_rechazarParticipacion`;

DELIMITER $$
USE `bdpromocion`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_rechazarParticipacion`(in _id int, in _idPermiso int)
BEGIN

	if _idPermiso = 6 then
		update participaciones set valido2='F' where id=_id;
	else
		update participaciones set valido='F' where id=_id;
	end if;   

	select "ok" as respuesta;
END$$

DELIMITER ;

#_____________________________________________________________________________________________________________________________

USE `bdpromocion`;
DROP procedure IF EXISTS `sp_selectTutorias`;

DELIMITER $$
USE `bdpromocion`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_selectTutorias`(in _idUsuario int)
BEGIN
	select id,idUsuario,fechaInicio,fechaFin,documento,valido, valido2
    from tutorias 
    where idUsuario=_idUsuario
    order by fechaInicio asc,fechafin asc;
END$$

DELIMITER ;

#_____________________________________________________________________________________________________________________________

USE `bdpromocion`;
DROP procedure IF EXISTS `sp_aprobarTutoria`;

DELIMITER $$
USE `bdpromocion`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_aprobarTutoria`(in _id int, in _idPermiso int)
BEGIN

	if _idPermiso = 6 then
		update tutorias set valido2='V' where id=_id;
	else
		update tutorias set valido='V' where id=_id;
	end if;       
    
	select "ok" as respuesta;
END$$

DELIMITER ;

#_____________________________________________________________________________________________________________________________

USE `bdpromocion`;
DROP procedure IF EXISTS `sp_rechazarTutoria`;

DELIMITER $$
USE `bdpromocion`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_rechazarTutoria`(in _id int, in _idPermiso int)
BEGIN
    
	if _idPermiso = 6 then
		update tutorias set valido2='F' where id=_id;
	else
		update tutorias set valido='F' where id=_id;
	end if;     
    
	select "ok" as respuesta;
END$$

DELIMITER ;

#_____________________________________________________________________________________________________________________________

USE `bdpromocion`;
DROP procedure IF EXISTS `sp_selectPublicaciones`;

DELIMITER $$
USE `bdpromocion`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_selectPublicaciones`(in _idUsuario int)
BEGIN
	select id,idUsuario,nombre,
    CASE
		WHEN medio = "I" THEN "Impreso"
		WHEN medio = "E" THEN "Electrónico"
		ELSE medio
	END as medio
    ,fecha,ISSN,valido,valido2
    from publicaciones where idUsuario=_idUsuario
    order by fecha asc;
END$$

DELIMITER ;

#_____________________________________________________________________________________________________________________________

USE `bdpromocion`;
DROP procedure IF EXISTS `sp_aprobarPublicacion`;

DELIMITER $$
USE `bdpromocion`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_aprobarPublicacion`(in _id int, in _idPermiso int)
BEGIN

if _idPermiso = 6 then
	update publicaciones set valido2='V' where id=_id;
else
	update publicaciones set valido='V' where id=_id;
end if;    

	select "ok" as respuesta;
END$$

DELIMITER ;

#_____________________________________________________________________________________________________________________________

USE `bdpromocion`;
DROP procedure IF EXISTS `sp_rechazarPublicacion`;

DELIMITER $$
USE `bdpromocion`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_rechazarPublicacion`(in _id int, in _idPermiso int)
BEGIN

if _idPermiso = 6 then
	update publicaciones set valido2='F' where id=_id;
else
	update publicaciones set valido='F' where id=_id;
end if;    

	select "ok" as respuesta;
END$$

DELIMITER ;

#_____________________________________________________________________________________________________________________________

USE `bdpromocion`;
DROP procedure IF EXISTS `sp_consultaResultados`;

DELIMITER $$
USE `bdpromocion`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_consultaResultados`(in _idUsuario int)
BEGIN
	select r.id,r.idUsuario,r.idResultado,cr.resultado,r.fechaInicio,r.fechaFin,r.documento,r.valido,r.valido2
    from resultados r
    join catresultado cr on r.idResultado=cr.id
    where r.idUsuario=_idUsuario
    order by r.fechaInicio asc,r.fechafin asc;
END$$

DELIMITER ;

#_____________________________________________________________________________________________________________________________

USE `bdpromocion`;
DROP procedure IF EXISTS `sp_aprobarResultado`;

DELIMITER $$
USE `bdpromocion`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_aprobarResultado`(in _id int, in _idPermiso int)
BEGIN
	
if _idPermiso = 6 then
	update resultados set valido2='V' where id=_id;
else
	update resultados set valido='V' where id=_id;
end if;        
    
	select "ok" as respuesta;
END$$

DELIMITER ;

#_____________________________________________________________________________________________________________________________

USE `bdpromocion`;
DROP procedure IF EXISTS `sp_rechazarResultado`;

DELIMITER $$
USE `bdpromocion`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_rechazarResultado`(in _id int, in _idPermiso int)
BEGIN
	
if _idPermiso = 6 then
	update resultados set valido2='F' where id=_id;
else
	update resultados set valido='F' where id=_id;
end if;
    
	select "ok" as respuesta;
END$$

DELIMITER ;

#_____________________________________________________________________________________________________________________________

USE `bdpromocion`;
DROP procedure IF EXISTS `sp_consultaRegistro`;

DELIMITER $$
USE `bdpromocion`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_consultaRegistro`(in _idUsuario int)
BEGIN
	SELECT 
		u.id,
		u.nombre,
        u.primerApellido,
        u.segundoApellido,
        u.correo,
        u.curp,		
		u.idPlantel,
        u.idEntidad,
        q.entidad,
        b.cct,
        b.plantel,
		u.telfijo,
		u.telcel,
		u.consideraciones,
		a.idEscuelaEstudio,
        c.escuela,
		a.idCarrera,
        d.carrera,
		a.anioEgreso,
		a.idGradoAcademico,
        e.grado,
		a.idModalidadTitulacion,
        f.modalidad,
		a.anioTitulacion,
		a.cedula,
		a.activo,
		a.ingresoSubsistema,
		a.ingresoPlantel,
		g.id as idCategoriaJornada,
        g.clave,
        g.idCategoria,
        h.categoria,
        g.idJornada,
        i.jornada,
		a.fechaPlaza,
		a.idTipoNombramiento,
        j.codigo,
        j.descripcion,
        j.tipo,
		a.fechaUltimaPromocion,
		k.id as idCategoriaJornadaAspira,
        k.clave as claveAspira,
        k.idCategoria as idCategoriaAspira,
        l.categoria as categoriaAspira,        
        k.idJornada as idJornadaAspira,
        m.jornada as jornadaAspira,
		a.idPerfilRequerido,
        n.requisito,
		a.notaSancion,
		a.compatibilidad,
		a.horasOtroSubsistema,
		a.nivelCENNI,
		a.folioCENNI,
		a.idCCT,
        o.cct as cctEstudio,
		a.idEntidadEstudio,
        a.idInstitucion,
        a.idTipoInstitucion,
        b.gradoMarginacion,
        a.frenteGrupo,
        a.funcionesOtro,
		a.finRegistro,
        u.consideraciones,
        a.publico,
        u.idPrograma,
        p.id as idConvocatoria,
        a.idEstatus,
        a.observacionInfo,
        a.observacionEncuestados,
        a.observacionCriterios,
        aia.institucion as institucionOtra,
        aia.cct as cctOtro,
        aia.escuela as escuelaOtra,
        aia.carrera as carreraOtra,
        a.observacionCriterios2
        
	FROM usuario u
    left join aspirantes a on u.id=a.idUsuario
    left join catplanteles b on u.idPlantel=b.id
    left join catentidades q on u.idEntidad=q.id
    left join catescuelas c on a.idEscuelaEstudio=c.id
    left join catcarreras d on a.idCarrera=d.id
    left join catgradosacademicos e on a.idGradoAcademico=e.id
    left join catmodalidadestitulacion f on a.idModalidadTitulacion=f.id    
    left join catcategoriasplaza h on a.idCategoria=h.id
    left join catjornada i on a.idJornada=i.id
    left join cattiposnombramiento j on a.idTipoNombramiento=j.id    
    left join catcategoriasplaza l on a.idCategoriaAspira=l.id
    left join catjornada m on a.idJornadaAspira=m.id
    left join catrequisitosplaza n on a.idPerfilRequerido=n.id
    left join catinstitucioncct o on a.idCCT=o.id    
    left join convocatoria p on (u.idPrograma=p.idPrograma and u.idPlantel=p.idPlantel)
    left join catcategoriajornada g on (a.idJornada=g.idJornada and a.idCategoria=g.idCategoria)
    left join catcategoriajornada k on (a.idJornadaAspira=k.idJornada and a.idCategoriaAspira=k.idCategoria)
    left join auxinfoacademica aia on a.idUsuario=aia.idUsuario
	where u.id=_idUsuario;

END$$

DELIMITER ;

#_____________________________________________________________________________________________________________________________

USE `bdpromocion`;
DROP procedure IF EXISTS `sp_finProceso`;

DELIMITER $$
USE `bdpromocion`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_finProceso`(in _idUsuario int, in _totalEncuestados int, in _observacion varchar(200),in _evaluacion DECIMAL(10,5), in _idPermiso int)
BEGIN	
	declare _idEstatus int default null;
    if _totalEncuestados<30 then
		set _idEstatus=6;
    else
		set _idEstatus=7;
    end if;
  
    if _idPermiso = 6 then    

		if _evaluacion is not null then
			set _idEstatus=13;
		end if;

		update aspirantes
		set finRegistro=now(),
		idEstatus=_idEstatus,observacionCriterios2=_observacion,evaluacion2=_evaluacion 
		where idUsuario=_idUsuario;    
    else    

		if _evaluacion is not null then
			set _idEstatus=10;
		end if;

		update aspirantes
		set finRegistro=now(),
		idEstatus=_idEstatus,observacionCriterios=_observacion,evaluacion=_evaluacion 
		where idUsuario=_idUsuario;
    
    end if;
    
    call sp_insertBitacora(_idUsuario, 'A', 'El usuario finalizó el proceso');
END$$

DELIMITER ;

#_____________________________________________________________________________________________________________________________

USE `bdpromocion`;
DROP procedure IF EXISTS `sp_insertConstanciasProceso`;

DELIMITER $$
USE `bdpromocion`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_insertConstanciasProceso`(in _idUsuario int, in _idCriterio int, in _idCatPuntaje int,in _estatus char(1), in _idPermiso int)
BEGIN
	declare _aux int default null;
    select id into _aux
    from constanciasproceso 
    where idUsuario=_idUsuario 
        and idCriterio=_idCriterio;
    
    if _idPermiso = 6 then

		if _aux is null then
			insert into constanciasproceso (idUsuario,idCriterio,idCatPuntaje2,aceptado2)
			values (_idUsuario,_idCriterio,_idCatPuntaje,_estatus);        
		else
			update constanciasproceso
			set idCatPuntaje2=_idCatPuntaje,
				aceptado2=_estatus
			where id=_aux;
		end if;
    
    else

		if _estatus = 'P' then

			if _aux is null then
				insert into constanciasproceso (idUsuario,idCriterio,idCatPuntaje1,idCatPuntaje2,idCatPuntaje3,aceptado,aceptado2)
				values (_idUsuario,_idCriterio,_idCatPuntaje,_idCatPuntaje,_idCatPuntaje,_estatus,_estatus);        
			else
				update constanciasproceso
				set idCatPuntaje1=_idCatPuntaje,
					idCatPuntaje2=_idCatPuntaje,
					idCatPuntaje3=_idCatPuntaje,
					aceptado=_estatus,
                    aceptado2=_estatus
				where id=_aux;
			end if;
        
        else
		
			if _aux is null then
				insert into constanciasproceso (idUsuario,idCriterio,idCatPuntaje1,aceptado)
				values (_idUsuario,_idCriterio,_idCatPuntaje,_estatus);        
			else
				update constanciasproceso
				set idCatPuntaje1=_idCatPuntaje,
					aceptado=_estatus
				where id=_aux;
			end if;
        
        end if;
    
    end if;
    
    select puntaje from catpuntaje where id=_idCatPuntaje;
END$$

DELIMITER ;

#_____________________________________________________________________________________________________________________________








