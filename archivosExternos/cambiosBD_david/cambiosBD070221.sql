USE `bdpromocion`;
DROP procedure IF EXISTS `sp_consultaCBase`;

DELIMITER $$
USE `bdpromocion`$$
CREATE PROCEDURE `sp_consultaCBase`(in _idEntidad int,in _idPlantel int,in _idSubsistema int, in _idPrograma int)
BEGIN

	declare _aux varchar(20) default null;
    declare _aux2 varchar(20) default null;
    declare _aux3 varchar(20) default null;
    
	select id into _aux
	from convocatoriaBase
    where idEntidad=_idEntidad
	and idPlantel=_idPlantel
    and idSubsistema=_idSubsistema and estatus='0' and idPrograma=_idPrograma;
        
	if(_aux is not null) then
		select *
		from convocatoriabase
        where id=_aux;
	end if;
    
    if(_aux is null) then
		select id into _aux2
		from convocatoriaBase
		where idEntidad=_idEntidad
		and idSubsistema=_idSubsistema and estatus='0' and idPrograma=_idPrograma and tipoConvocatoria = 'ESTATAL';
	end if;
    
    if(_aux2 is not null) then
		select *
		from convocatoriabase
        where id=_aux2;
	end if;
    
    if(_aux2 is null) then
		select id into _aux3
		from convocatoriaBase
		where tipoConvocatoria = 'NACIONAL'
		and idSubsistema=_idSubsistema and estatus='0' and idPrograma=_idPrograma;
	end if;
    
    if(_aux3 is not null) then
		select *
		from convocatoriabase
        where id=_aux3;
	end if;
    
END$$

DELIMITER ;

USE `bdpromocion`;
DROP procedure IF EXISTS `sp_insertConvocatoriaBase`;

DELIMITER $$
USE `bdpromocion`$$
CREATE PROCEDURE `sp_insertConvocatoriaBase`(in _id int, in _publicacion date,in _inicioRegistro date,in _finRegistro date,in _inicioValoracion date,in _finValoracion date,in _inicioDictaminacion date,in _finDictaminacion date, in _resultados date,in _idPlantel int,in _idPrograma int,in _tipoConvocatoria varchar(20),in _estatus varchar(15),in _idEntidad int,in _idSubsistema int)
BEGIN
	declare _aux int default null;
    
    declare tPlantel varchar(20);
    declare tEstatal varchar(20);
    declare tNacional varchar(20);
    set tPlantel = 'PLANTEL';
    set tEstatal = 'ESTATAL';
    set tNacional = 'NACIONAL';
    
    if(_idPrograma = 3)then
		select 'No puedes agregar este programa' as respuesta;
    end if;
    
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
		
        if(_idPrograma != 3) then
			if(_tipoConvocatoria = tNacional) then
				select count(id) into _aux
				from convocatoriaBase
				where tipoConvocatoria = 'NACIONAL' and estatus='0' and idPrograma = _idPrograma;
			
				if(_aux < 1) then
					INSERT INTO convocatoriaBase(publicacion,inicioRegistro,finRegistro,inicioValoracion,finValoracion,inicioDictaminacion,finDictaminacion,resultados,idPlantel,idPrograma,tipoConvocatoria,estatus,idEntidad,idSubsistema) 
					VALUES(_publicacion,_inicioRegistro,_finRegistro,_inicioValoracion,_finValoracion,_inicioDictaminacion,_finDictaminacion,_resultados,_idPlantel,_idPrograma,_tipoConvocatoria,"0",0,_idSubsistema);
					select 'ok' as respuesta;
				else
					select 'Convocatoria previamente registrada' as respuesta;
				end if;
			end if;	
        end if;
        
        if(_idPrograma != 3) then
			if(_tipoConvocatoria = tEstatal) then
				select count(id) into _aux
				from convocatoriaBase
				where tipoConvocatoria = 'ESTATAL' and idEntidad=_idEntidad and estatus='0' and idPrograma = _idPrograma;
			
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
END$$

DELIMITER ;

