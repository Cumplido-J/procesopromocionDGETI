USE `bdpromocion`;
DROP procedure IF EXISTS `sp_actualizarPlazaActual`;

DELIMITER $$
USE `bdpromocion`$$
CREATE PROCEDURE `sp_actualizarPlazaActual` (in _id int,in _actual char(1))
BEGIN	
    update usuarioplaza set actual=_actual where id=_id;
    select 'ok' as respuesta;
END$$

DELIMITER ;

USE `bdpromocion`;
DROP procedure IF EXISTS `sp_consultaDocentes`;

DELIMITER $$
USE `bdpromocion`$$
CREATE  PROCEDURE `sp_consultaDocentes`(in _idPrograma int, in _idSubsistema int, in _idEntidad int, in _idPlantel int,in _nombre varchar(200), in _idEstatus int)
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
		ELSE a.evaluacion
	END as evaluacion
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




USE `bdpromocion`;
DROP procedure IF EXISTS `sp_consultaCBase`;

DELIMITER ;;
CREATE  PROCEDURE `sp_consultaCBase`(in _idEntidad int,in _idPlantel int,in _idSubsistema int)
BEGIN

	declare _aux varchar(20) default null;
    
	select id into _aux
	from convocatoriaBase
    where idEntidad=_idEntidad
	and idPlantel=_idPlantel
    and idSubsistema=_idSubsistema and estatus='0';
        
	if(_aux is not null) then
		select *
		from convocatoriabase
        where id=_aux;
	end if;
END ;;
DELIMITER ;

DROP procedure IF EXISTS `sp_consultaConvocatoriaBase`;

DELIMITER ;;
CREATE  PROCEDURE `sp_consultaConvocatoriaBase`(in _id int)
BEGIN

	declare _aux varchar(20) default null;
    declare tPlantel varchar(20);
    declare tEstatal varchar(20);
    declare tNacional varchar(20);
    
    set tPlantel = 'PLANTEL';
    set tEstatal = 'ESTATAL';
    set tNacional = 'NACIONAL';
    
	if(_id > 0) then
		select tipoConvocatoria into _aux
		from convocatoriaBase
        where id=_id;
	end if;

	if(_aux = tPlantel) then
		select c.id,idPrograma,cp.idSubsistema,cp.idEntidad,c.idPlantel,publicacion,inicioRegistro,finRegistro,inicioValoracion,finValoracion,inicioDictaminacion,finDictaminacion,resultados,tipoConvocatoria,c.estatus
		from convocatoriabase c
		join catplanteles cp on c.idPlantel=cp.id
		where c.id=_id and c.estatus = '0';
	end if;
    
    if(_aux = tEstatal) then
		select c.id,idPrograma,c.idSubsistema,c.idEntidad,c.idPlantel,publicacion,inicioRegistro,finRegistro,inicioValoracion,finValoracion,inicioDictaminacion,finDictaminacion,resultados,tipoConvocatoria,c.estatus
		from convocatoriabase c
		where c.id=_id and c.tipoConvocatoria = 'ESTATAL' and c.estatus = '0';
	end if;

	if(_aux = tNacional) then
		select c.id,idPrograma,c.idSubsistema,c.idEntidad,c.idPlantel,publicacion,inicioRegistro,finRegistro,inicioValoracion,finValoracion,inicioDictaminacion,finDictaminacion,resultados,tipoConvocatoria,c.estatus
		from convocatoriabase c
		where c.id=_id and c.tipoConvocatoria = 'NACIONAL' and c.estatus = '0';
	end if;

END ;;
DELIMITER ;

DROP procedure IF EXISTS `sp_consultaConvocatorias`;
DELIMITER ;;

CREATE  PROCEDURE `sp_consultaConvocatorias`(in _idPrograma int,in _idSubsistema int,in _idEntidad int,in _idPlantel int,in _estatus varchar(15))
BEGIN
   set @consulta="select c.id,c.idPrograma,cpr.programa,cp.idSubsistema,cs.subsistema,cp.idEntidad,ce.entidad,c.idPlantel,cp.plantel,c.estatus
		from convocatoria c
		join catprogramas cpr on c.idPrograma=cpr.id
		join catplanteles cp on c.idPlantel=cp.id
		join catentidades ce on cp.idEntidad=ce.id
		join catsubsistema cs on cp.idSubsistema=cs.id where c.id>0 ";
	if(_idPrograma is not null) then
		set @consulta=concat(@consulta," and c.idPrograma = ",_idPrograma);
    end if;
    if(_idSubsistema is not null) then
		set @consulta=concat(@consulta," and cp.idSubsistema = ",_idSubsistema);
    end if;    
    if(_idEntidad is not null) then
		set @consulta=concat(@consulta," and cp.idEntidad = ",_idEntidad);
    end if;
    if(_idPlantel is not null) then
		set @consulta=concat(@consulta," and c.idPlantel = ",_idPlantel);
    end if;
    if(_estatus is not null) then
		set @consulta=concat(@consulta," and c.estatus = '",_estatus,"' ");
    end if;    
    set @consulta=concat(@consulta,' order by cp.idEntidad asc,c.idPlantel asc;');
	
    PREPARE instruccion FROM @consulta;
	EXECUTE instruccion;
END ;;
DELIMITER ;

DROP procedure IF EXISTS `sp_consultaConvocatoriasBase`;
DELIMITER ;;
CREATE  PROCEDURE `sp_consultaConvocatoriasBase`(in _idPrograma int,in _idSubsistema int,in _idEntidad int,in _idPlantel int,in _estatus varchar(15),in _tipoConvocatoria varchar(20))
BEGIN
	declare tPlantel varchar(20);
    declare tEstatal varchar(20);
    declare tNacional varchar(20);
    
    set tPlantel = 'PLANTEL';
    set tEstatal = 'ESTATAL';
    set tNacional = 'NACIONAL';
    
    if(_tipoConvocatoria = tPlantel) then
    set @consulta="select c.id,c.idPrograma,cpr.programa,cp.idSubsistema,cs.subsistema,cp.idEntidad,ce.entidad,c.idPlantel,cp.plantel,c.tipoConvocatoria
		from convocatoriabase c
		join catprogramas cpr on c.idPrograma=cpr.id
		join catplanteles cp on c.idPlantel=cp.id
		join catentidades ce on cp.idEntidad=ce.id
		join catsubsistema cs on cp.idSubsistema=cs.id where c.id>0 and c.tipoConvocatoria=tipoConvocatoria";
        
        if(_idPrograma is not null) then
		set @consulta=concat(@consulta," and c.idPrograma = ",_idPrograma);
		end if;
		if(_idSubsistema is not null) then
			set @consulta=concat(@consulta," and cp.idSubsistema = ",_idSubsistema);
		end if;    
		if(_idEntidad is not null) then
			set @consulta=concat(@consulta," and cp.idEntidad = ",_idEntidad);
		end if;
		if(_idPlantel is not null) then
			set @consulta=concat(@consulta," and c.idPlantel = ",_idPlantel);
		end if;
		if(_estatus is not null) then
			set @consulta=concat(@consulta," and c.estatus = '",'0',"' ");
		end if;
		if(_tipoConvocatoria is not null) then
			set @consulta=concat(@consulta," and c.tipoConvocatoria = '",_tipoConvocatoria,"' ");
		end if;
		set @consulta=concat(@consulta,' order by cp.idEntidad asc,c.idPlantel asc;');
	end if;
    
    if(_tipoConvocatoria = tEstatal) then
    set @consulta="select c.id,c.idPrograma,cpr.programa,c.idSubsistema,cs.subsistema,c.idEntidad,ce.entidad,c.idPlantel,'',c.tipoConvocatoria
		from convocatoriabase c
		join catprogramas cpr on c.idPrograma=cpr.id
		join catentidades ce on c.idEntidad=ce.id
		join catsubsistema cs on c.idSubsistema=cs.id where c.id>0 and c.tipoConvocatoria='ESTATAL' and c.estatus = '0'";
        
        if(_idPrograma is not null) then
		set @consulta=concat(@consulta," and c.idPrograma = ",_idPrograma);
		end if;
		if(_idSubsistema is not null) then
			set @consulta=concat(@consulta," and idSubsistema = ",_idSubsistema);
		end if;
		if(_tipoConvocatoria is not null) then
			set @consulta=concat(@consulta," and c.tipoConvocatoria = '",_tipoConvocatoria,"' ");
		end if;
		set @consulta=concat(@consulta,' order by c.idEntidad asc;');
	end if;
	
	if(_tipoConvocatoria = tNacional) then
    set @consulta="select c.id,c.idPrograma,cpr.programa,c.idSubsistema,cs.subsistema,'','','','',c.tipoConvocatoria
		from convocatoriabase c
		join catprogramas cpr on c.idPrograma=cpr.id
		join catsubsistema cs on c.idSubsistema=cs.id where c.id>0 and c.tipoConvocatoria='NACIONAL' and c.estatus = '0'";
        
        if(_idPrograma is not null) then
		set @consulta=concat(@consulta," and c.idPrograma = ",_idPrograma);
		end if;
		if(_idSubsistema is not null) then
			set @consulta=concat(@consulta," and idSubsistema = ",_idSubsistema);
		end if;
		if(_tipoConvocatoria is not null) then
			set @consulta=concat(@consulta," and c.tipoConvocatoria = '",_tipoConvocatoria,"' ");
		end if;
	end if;
    
    if(_tipoConvocatoria is null) then
    set @consulta="select c.id,c.idPrograma,cpr.programa,cp.idSubsistema,cs.subsistema,cp.idEntidad,ce.entidad,c.idPlantel,cp.plantel,c.tipoConvocatoria
		from convocatoriabase c
		join catprogramas cpr on c.idPrograma=cpr.id
		join catplanteles cp on c.idPlantel=cp.id
		join catentidades ce on cp.idEntidad=ce.id
		join catsubsistema cs on cp.idSubsistema=cs.id where c.id>0 and c.tipoConvocatoria=tipoConvocatoria";
        
        if(_idPrograma is not null) then
		set @consulta=concat(@consulta," and c.idPrograma = ",_idPrograma);
		end if;
		if(_idSubsistema is not null) then
			set @consulta=concat(@consulta," and cp.idSubsistema = ",_idSubsistema);
		end if;    
		if(_idEntidad is not null) then
			set @consulta=concat(@consulta," and cp.idEntidad = ",_idEntidad);
		end if;
		if(_idPlantel is not null) then
			set @consulta=concat(@consulta," and c.idPlantel = ",_idPlantel);
		end if;
		if(_estatus is not null) then
			set @consulta=concat(@consulta," and c.estatus = '",_estatus,"' ");
		end if;
		if(_tipoConvocatoria is not null) then
			set @consulta=concat(@consulta," and c.tipoConvocatoria = '",_tipoConvocatoria,"' ");
		end if;
		set @consulta=concat(@consulta,' order by cp.idEntidad asc,c.idPlantel asc;');
	end if;
    
    PREPARE instruccion FROM @consulta;
	EXECUTE instruccion;
END ;;
DELIMITER ;

drop procedure if exists  `sp_consultaConvocatoriasBaseNacional`;

DELIMITER ;;
CREATE  PROCEDURE `sp_consultaConvocatoriasBaseNacional`(in _idPrograma int,in _idSubsistema int,in _idEntidad int,in _idPlantel int,in _estatus varchar(15),in _tipoConvocatoria varchar(20))
BEGIN
	set @consulta="select id,idPrograma,programa,idSubsistema,subsistema,idEntidad,entidad,idPlantel,plantel,tipoConvocatoria
		from convocatoriabase
		and tipoConvocatoria=tipoConvocatoria";
    if(_tipoConvocatoria is not null) then
		set @consulta=concat(@consulta," and tipoConvocatoria = '",_tipoConvocatoria,"' ");
    end if;
    PREPARE instruccion FROM @consulta;
	EXECUTE instruccion;
END ;;
DELIMITER ;

DROP procedure IF EXISTS `sp_insertConvocatoria`;
DELIMITER ;;
CREATE  PROCEDURE `sp_insertConvocatoria`(in _id int, in _publicacion date,in _inicioRegistro date,in _finRegistro date,in _inicioValoracion date,in _finValoracion date,in _inicioDictaminacion date,in _finDictaminacion date, in _resultados date,in _idPlantel int,in _idPrograma int,in _estatus varchar(15),in _idEntidad int,in _tipoConvocatoria varchar(45),in _idSubsistema int)
BEGIN
	declare _aux int default null;
    if _id is null then    
		select id into _aux
		from convocatoria 
		where idPlantel=_idPlantel and idPrograma=_idPrograma and idEntidad = _idEntidad;
		
		if(_aux is null) then
			INSERT INTO convocatoria(publicacion,inicioRegistro,finRegistro,inicioValoracion,finValoracion,inicioDictaminacion,finDictaminacion,resultados,idPlantel,idPrograma,estatus,idEntidad,tipoConvocatoria,idSubsistema) 
			VALUES(_publicacion,_inicioRegistro,_finRegistro,_inicioValoracion,_finValoracion,_inicioDictaminacion,_finDictaminacion,_resultados,_idPlantel,_idPrograma,_estatus,_idEntidad,_tipoConvocatoria,_idSubsistema);
			select 'ok' as respuesta;
		else
			select 'Convocatoria previamente registrada' as respuesta;
		end if;		
	else
		update convocatoria 
        set publicacion=_publicacion,
			inicioRegistro=_inicioRegistro,
            finRegistro=_finRegistro,
            inicioValoracion=_inicioValoracion,
            finValoracion=_finValoracion,
            inicioDictaminacion=_inicioDictaminacion,
            finDictaminacion=_finDictaminacion,
            resultados=_resultados,
            idPlantel=_idPlantel,
            idPrograma=_idPrograma,
            estatus=_estatus,
            idEntidad=_idEntidad,
            tipoConvocatoria=_tipoConvocatoria
		where id=_id;
        select 'ok' as respuesta;
    end if;
END ;;
DELIMITER ;

DROP procedure IF EXISTS `sp_insertConvocatoriaBase`;
DELIMITER ;;
CREATE  PROCEDURE `sp_insertConvocatoriaBase`(in _id int, in _publicacion date,in _inicioRegistro date,in _finRegistro date,in _inicioValoracion date,in _finValoracion date,in _inicioDictaminacion date,in _finDictaminacion date, in _resultados date,in _idPlantel int,in _idPrograma int,in _tipoConvocatoria varchar(20),in _estatus varchar(15),in _idEntidad int,in _idSubsistema int)
BEGIN
	declare _aux int default null;
    
    declare tPlantel varchar(20);
    declare tEstatal varchar(20);
    declare tNacional varchar(20);
    set tPlantel = 'PLANTEL';
    set tEstatal = 'ESTATAL';
    set tNacional = 'NACIONAL';
    
    if (_id is null) then
		if(_idPrograma != 3) then
			if(_tipoConvocatoria = tPlantel) then
			select id into _aux
			from convocatoriaBase
			where idPlantel=_idPlantel and idPrograma=_idPrograma and estatus='0';
		
			if(_aux is null) then
				INSERT INTO convocatoriaBase(publicacion,inicioRegistro,finRegistro,inicioValoracion,finValoracion,inicioDictaminacion,finDictaminacion,resultados,idPlantel,idPrograma,tipoConvocatoria,estatus,idEntidad,idSubsistema) 
				VALUES(_publicacion,_inicioRegistro,_finRegistro,_inicioValoracion,_finValoracion,_inicioDictaminacion,_finDictaminacion,_resultados,_idPlantel,_idPrograma,_tipoConvocatoria,"0",_idEntidad,_idSubsistema);
				select 'ok' as respuesta;
			else
				select 'Convocatoria previamente registrada' as respuesta;
			end if;
		end if;
		
        if(_tipoConvocatoria = tNacional) then
			select count(id) into _aux
            from convocatoriaBase
            where tipoConvocatoria = 'NACIONAL' and estatus='0';
		
			if(_aux < 1) then
				INSERT INTO convocatoriaBase(publicacion,inicioRegistro,finRegistro,inicioValoracion,finValoracion,inicioDictaminacion,finDictaminacion,resultados,idPlantel,idPrograma,tipoConvocatoria,estatus,idEntidad,idSubsistema) 
				VALUES(_publicacion,_inicioRegistro,_finRegistro,_inicioValoracion,_finValoracion,_inicioDictaminacion,_finDictaminacion,_resultados,_idPlantel,_idPrograma,_tipoConvocatoria,"0",0,_idSubsistema);
				select 'ok' as respuesta;
			else
				select 'Convocatoria previamente registrada' as respuesta;
			end if;
		end if;	
        
        if(_tipoConvocatoria = tEstatal) then
			select count(id) into _aux
            from convocatoriaBase
            where idEntidad=_idEntidad and estatus='0';
		
			if(_aux < 1) then
				INSERT INTO convocatoriaBase(publicacion,inicioRegistro,finRegistro,inicioValoracion,finValoracion,inicioDictaminacion,finDictaminacion,resultados,idPlantel,idPrograma,tipoConvocatoria,estatus,idEntidad,idSubsistema) 
				VALUES(_publicacion,_inicioRegistro,_finRegistro,_inicioValoracion,_finValoracion,_inicioDictaminacion,_finDictaminacion,_resultados,_idPlantel,_idPrograma,_tipoConvocatoria,"0",_idEntidad,_idSubsistema);
				select 'ok' as respuesta;
			else
				select 'Convocatoria previamente registrada' as respuesta;
			end if;
		end if;
        else
				select 'No se puede agregar este programa a la convocatoria base' as respuesta;
		end if;
    
		
        
	else 
		update convocatoriaBase 
        set publicacion=_publicacion,
			inicioRegistro=_inicioRegistro,
            finRegistro=_finRegistro,
            inicioValoracion=_inicioValoracion,
            finValoracion=_finValoracion,
            inicioDictaminacion=_inicioDictaminacion,
            finDictaminacion=_finDictaminacion,
            resultados=_resultados,
            idPlantel=_idPlantel,
            idPrograma=_idPrograma,
            tipoConvocatoria=_tipoConvocatoria,
            estatus=_estatus,
            idEntidad=_idEntidad
		where id=_id;
        select 'ok' as respuesta;
    end if;
END ;;