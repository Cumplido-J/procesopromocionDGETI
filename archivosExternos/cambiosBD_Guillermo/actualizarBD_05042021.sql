USE `bdpromocion`;
DROP procedure IF EXISTS `sp_selectCatEstatusidUsuario`;

DELIMITER $$
USE `bdpromocion`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_selectCatEstatusidUsuario`(in _idUsuario int)
BEGIN

	declare _perfil char(1) default null;
    declare _idPermiso int default null;
    declare _permisos int default null;
        
    select perfil into _perfil from usuario where id = _idUsuario;
    select idPermiso into _idPermiso from usuariopermiso where idusuario = _idUsuario and idPermiso = 5;
    select count(*) into _permisos from usuariopermiso where idusuario = _idUsuario;

    if (_perfil = 'A' and _idPermiso = 5 and _permisos = 1) then
		select id,estatus from catestatus where id in (6,7,8,9,10);
	else
		select id,estatus from catestatus;
	end if;

END$$

DELIMITER ;


USE `bdpromocion`;
DROP procedure IF EXISTS `sp_consultaDocentes`;

DELIMITER $$
USE `bdpromocion`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_consultaDocentes`(in _idPrograma int, in _idSubsistema int, in _idEntidad int, in _idPlantel int,in _nombre varchar(200), in _idEstatus int, in _idUsuario int)
BEGIN

	declare _perfil char(1) default null;
    declare _idPermiso int default null;
    declare _permisos int default null;
        
    select perfil into _perfil from usuario where id = _idUsuario;
    select idPermiso into _idPermiso from usuariopermiso where idusuario = _idUsuario and idPermiso = 5;
    select count(*) into _permisos from usuariopermiso where idusuario = _idUsuario;

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
    /*if(_idEstatus is not null) then
		set @consulta=concat(@consulta," and a.idEstatus =", _idEstatus);
    end if;*/
    if(_perfil = 'A' and _idPermiso = 5 and _permisos = 1 and _idEstatus is null) then
		set @consulta=concat(@consulta," and a.idEstatus in (6,7,8,9,10) ");
	elseif (_idEstatus is not null) then
		set @consulta=concat(@consulta," and a.idEstatus =", _idEstatus);
    end if;
    set @consulta=concat(@consulta,' order by evaluacion desc;');
    PREPARE instruccion FROM @consulta;
	EXECUTE instruccion;
END$$

DELIMITER ;

