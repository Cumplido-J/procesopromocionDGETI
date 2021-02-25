ALTER TABLE `bdpromocion`.`aspirantes` 
ADD COLUMN `evaluacion2` DECIMAL(10,2) NULL DEFAULT NULL AFTER `folio`;
#_____________________________________________________________________________________________________________________________

USE `bdpromocion`;
DROP procedure IF EXISTS `sp_consultaDocentes`;

DELIMITER $$
USE `bdpromocion`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_consultaDocentes`(in _idPrograma int, in _idSubsistema int, in _idEntidad int, in _idPlantel int,in _nombre varchar(200), in _idEstatus int)
BEGIN
	set @consulta="select u.id,u.idEntidad,e.entidad,u.idPlantel,p.plantel,
    concat(u.nombre,' ',
    CASE
		WHEN u.primerApellido is null then ''		
		ELSE u.primerApellido
	END,' ',
    CASE
		WHEN u.segundoApellido is null then ''		
		ELSE u.segundoApellido
	END) as nombre,u.curp,a.idEstatus, case when ce.estatus is null then 'Pre-registro' else ce.estatus end as estatus,u.idSubsistema ,s.subsistema,u.idPrograma,pr.programa,
    CASE
		WHEN a.evaluacion is null then ''		
		ELSE round(a.evaluacion,2)
	END as evaluacion,
    CASE
		WHEN a.evaluacion2 is null then ''		
		ELSE round(a.evaluacion2,2)
	END as evaluacion2    
	from usuario u
	join catplanteles p on u.idPlantel=p.id
    join catsubsistema s on u.idSubsistema=s.id
	join catentidades e on u.idEntidad=e.id
	left join aspirantes a on u.id=a.idUsuario
	left join catestatus ce on ce.id=a.idEstatus 
    join catprogramas pr on u.idPrograma=pr.id
    where u.perfil='D' ";
	if(_idPrograma is not null) then
		set @consulta=concat(@consulta," and u.idPrograma = ",_idPrograma);
    end if;
    if(_idSubsistema is not null) then
		set @consulta=concat(@consulta," and u.idSubsistema = ",_idSubsistema);
    end if;    
    if(_idEntidad is not null) then
		set @consulta=concat(@consulta," and u.idEntidad = ",_idEntidad);
    end if;
    if(_idPlantel is not null) then
		set @consulta=concat(@consulta," and u.idPlantel = ",_idPlantel);
    end if;
    if(_nombre is not null) then
		set @consulta=concat(@consulta," and (u.curp like '%",_nombre,"%' or concat(u.nombre,' ',u.primerApellido,' ',u.segundoApellido) like '%",_nombre,"%') ");
    end if;
    if(_idEstatus is not null) then
		set @consulta=concat(@consulta," and a.idEstatus =", _idEstatus);
    end if;
    set @consulta=concat(@consulta,' order by evaluacion desc;');
    PREPARE instruccion FROM @consulta;
	EXECUTE instruccion;
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
    
    if _idPermiso = 6 then	#Usuario con permiso Consejo Dictaminador 

		if _aux is null then
			insert into constanciasproceso (idUsuario,idCriterio,idCatPuntaje2,aceptado)
			values (_idUsuario,_idCriterio,_idCatPuntaje,_estatus);        
		else
			update constanciasproceso
			set idCatPuntaje2=_idCatPuntaje,
				aceptado=_estatus
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
    
    select puntaje from catpuntaje where id=_idCatPuntaje;
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

    if _idPermiso = 6 then 	#Usuario con permiso Consejo Dictaminador    

		update aspirantes
		set finRegistro=now(),
		idEstatus=_idEstatus,observacionCriterios=_observacion,evaluacion2=_evaluacion 
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
DROP procedure IF EXISTS `sp_consultaConstanciasProceso`;

DELIMITER $$
USE `bdpromocion`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_consultaConstanciasProceso`(in _idUsuario int, in _idPermiso int)
BEGIN
	select a.id,a.idUsuario,c.id as idCriterio,    
		CASE
			WHEN _idPermiso = 6 THEN a.idCatPuntaje2  #Usuario con permiso Consejo Dictaminador			
			ELSE a.idCatPuntaje1
		END as idCatPuntaje,
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






