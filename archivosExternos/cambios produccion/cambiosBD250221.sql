#____INICIO CAMBIOS GUILLERMO___________________________________________________________________________________________________

ALTER TABLE `bdpromocion`.`aspirantes` 
ADD COLUMN `evaluacion2` DECIMAL(10,2) NULL DEFAULT NULL AFTER `folio`;
#_____________________________________________________________________________________________________________________________

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
CREATE  PROCEDURE `sp_insertConstanciasProceso`(in _idUsuario int, in _idCriterio int, in _idCatPuntaje int,in _estatus char(1), in _idPermiso int)
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
CREATE  PROCEDURE `sp_finProceso`(in _idUsuario int, in _totalEncuestados int, in _observacion varchar(200),in _evaluacion DECIMAL(10,5), in _idPermiso int)
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
CREATE  PROCEDURE `sp_consultaConstanciasProceso`(in _idUsuario int, in _idPermiso int)
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

#____FIN CAMBIOS GUILLERMO___________________________________________________________________________________________________

#____INICIO CAMBIOS JONATHAN_________________________________________________________________________________________________________________________
USE `bdpromocion`;
DROP procedure IF EXISTS `sp_insertConvocatoriaBase`;

DELIMITER $$
USE `bdpromocion`$$
CREATE  PROCEDURE `sp_insertConvocatoriaBase`(in _id int, in _publicacion date,in _inicioRegistro date,in _finRegistro date,in _inicioValoracion date,in _finValoracion date,in _inicioDictaminacion date,in _finDictaminacion date, in _resultados date,in _idPlantel int,in _idPrograma int,in _tipoConvocatoria varchar(20),in _estatus varchar(15),in _idEntidad int,in _idSubsistema int)
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
			where idPlantel=_idPlantel and idPrograma=_idPrograma and estatus='0' and idSubsistema=_idSubsistema;
		
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
				where tipoConvocatoria = 'NACIONAL' and estatus='0' and idPrograma = _idPrograma and idSubsistema=_idSubsistema;
			
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
				where tipoConvocatoria = 'ESTATAL' and idEntidad=_idEntidad and estatus='0' and idPrograma = _idPrograma and idSubsistema=_idSubsistema;
			
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

USE `bdpromocion`;
DROP procedure IF EXISTS `sp_consultaRegistro`;

DELIMITER $$
USE `bdpromocion`$$
CREATE  PROCEDURE `sp_consultaRegistro`(in _idUsuario int)
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
        u.idSubsistema
        
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
#_FIN CAMBIOS JONATHAN__________________________________________________________________________________________________________________________
#_INICIO  CAMBIOS DAVID__________________________________________________________________________________________________________________________

USE `bdpromocion`;
DROP procedure IF EXISTS `sp_finRegistro`;

DELIMITER $$
USE `bdpromocion`$$
CREATE PROCEDURE `sp_finRegistro`(in _idUsuario int,in _publico char(1),in _observacion varchar(200))
BEGIN
	declare _idEstatus int default null;
    
    if _publico is not null then
		set _idEstatus=2;
    else
		set _idEstatus=3;
    end if;
    if(_observacion is null) then
		select concat(lpad(u.idEntidad,2,'0'),cp.claveFolio,lpad(u.id,5,'0'),year(now())) into @folio
		from usuario u 
		join catprogramas cp on u.idPrograma=cp.id
		where u.id=_idUsuario;
    
		update aspirantes
		set finRegistro=now(),
		publico=_publico,
		idEstatus=_idEstatus,
        folio=@folio
		where idUsuario=_idUsuario;
	else
		update aspirantes
		set observacionInfo=_observacion,
        idEstatus=8
		where idUsuario=_idUsuario;
    end if;
    
    call sp_insertBitacora(_idUsuario, 'A', 'El usuario finalizó el registro de información');
END$$

DELIMITER ;

USE `bdpromocion`;
DROP procedure IF EXISTS `sp_consultaRegistro`;

DELIMITER $$
USE `bdpromocion`$$
CREATE DEFINER=`admin`@`localhost` PROCEDURE `sp_consultaRegistro`(in _idUsuario int)
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
        u.idSubsistema,
        a.folio
        
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

CREATE TABLE `bdpromocion`.`periodoregistro` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `periodo` VARCHAR(45) NOT NULL,
  `activo` CHAR(1) NOT NULL DEFAULT 'F',
  PRIMARY KEY (`id`));

INSERT INTO `bdpromocion`.`periodoregistro` (`id`,`periodo`, `activo`) VALUES ('1','Convocatorias marzo', 'V');

UPDATE `bdpromocion`.`usuario` SET `idPeriodo` = '1' WHERE (`id` > '0');


ALTER TABLE `bdpromocion`.`usuario` 
ADD COLUMN `idPeriodo` INT UNSIGNED NULL AFTER `idPrograma`;

ALTER TABLE `bdpromocion`.`usuario` 
ADD INDEX `fkUsuarioPeriodo_idx` (`idPeriodo` ASC) VISIBLE;
;
ALTER TABLE `bdpromocion`.`usuario` 
ADD CONSTRAINT `fkUsuarioPeriodo`
  FOREIGN KEY (`idPeriodo`)
  REFERENCES `bdpromocion`.`periodoregistro` (`id`)
  ON DELETE RESTRICT
  ON UPDATE RESTRICT;

USE `bdpromocion`;
DROP procedure IF EXISTS `sp_consultaInfoLogin`;

DELIMITER $$
USE `bdpromocion`$$
CREATE DEFINER=`admin`@`localhost` PROCEDURE `sp_consultaInfoLogin`(in _rfc varchar(18))
BEGIN
	select u.id,u.idSubsistema,u.idEntidad,u.idPlantel,concat(u.nombre," ",u.primerApellido," ",u.segundoApellido) as nombre,u.clave as clave,u.curp,u.perfil,up.idPermiso,cp.permiso,cp.url,u.idPrograma,u.nivel,u.correo,up.permisoEdicion
	from usuario u
	left join usuariopermiso up on u.id=up.idUsuario
	left join catpermisos cp on up.idPermiso=cp.id
    join periodoregistro pr on u.idPeriodo=pr.id
	where u.curp=(select _rfc COLLATE utf8_spanish_ci) and pr.activo='V';
END$$

DELIMITER ;

USE `bdpromocion`;
DROP procedure IF EXISTS `sp_insertUsuario`;

DELIMITER $$
USE `bdpromocion`$$
CREATE DEFINER=`admin`@`localhost` PROCEDURE `sp_insertUsuario`(in _idEntidad int,in _idPlantel int,in _nombre varchar(200),in _primerApellido varchar(50),in _segundoApellido varchar(50),in _correo varchar(50),in _pass varchar(200),in _curp varchar(18),in _telfijo varchar(10),in _telcel varchar(10),in _perfil varchar(1),in _consideraciones varchar(200),in _nivel char(1),in _idSubsistema int,in _idPrograma int,in _idUsuario int)
BEGIN
	declare _idAux int default null;
    
    select id into @idPeriodo from periodoRegistro where activo='V' limit 1;
    
    if(_idUsuario is null) then
		select id into _idAux 
		from usuario
		where curp= (select _curp COLLATE utf8_spanish_ci);
		if(_idAux is null) then		
			insert into usuario (idEntidad,idPlantel,nombre,primerApellido,segundoApellido,correo,clave,curp,telfijo,telcel,perfil,consideraciones,nivel,idSubsistema,idPrograma,idPeriodo)
			values(_idEntidad,_idPlantel,_nombre,_primerApellido,_segundoApellido,_correo,_pass,_curp,_telfijo,_telcel,_perfil,_consideraciones,_nivel,_idSubsistema,_idPrograma,@idPeriodo);
			select "ok" as resultado; 		
		else
			select 'Usuario previamente registrado' as resultado;
		end if; 
	else
		call sp_deleteUsuarioPermiso(_idUsuario);
		update usuario 
        set idEntidad=_idEntidad,
			idPlantel=_idPlantel,
            nombre=_nombre,
            primerApellido=_primerApellido,
            segundoApellido=_segundoApellido,
            correo=_correo,
            curp=_curp,
            telfijo=_telfijo,
            telcel=_telcel,
            perfil=_perfil,
            consideraciones=_consideraciones,
            nivel=_nivel,
            idSubsistema=_idSubsistema,
            idPrograma=_idPrograma
		where id=_idUsuario;
    end if;
END$$

DELIMITER ;

ALTER TABLE `bdpromocion`.`usuarioplaza` 
ADD COLUMN `cargoDirectivo` CHAR(1) NULL AFTER `actual`,
ADD COLUMN `fechaRenuncia` DATE NULL AFTER `cargoDirectivo`;

USE `bdpromocion`;
DROP procedure IF EXISTS `sp_consultaUsuarioPlaza`;

DELIMITER $$
USE `bdpromocion`$$
CREATE DEFINER=`admin`@`localhost` PROCEDURE `sp_consultaUsuarioPlaza`(in _idUsuario int)
BEGIN
	select up.id,up.idUsuario,up.idCategoria,cp.categoria, up.idJornada,j.jornada,up.horas,DATE_FORMAT(up.fecha, "%d/%m/%Y") as fecha,up.idTipoNombramiento,ctn.codigo, ctn.descripcion,up.clave,up.actual,
	CASE
		WHEN up.cargoDirectivo is null then '-'		
		ELSE up.cargoDirectivo
	END as cargoDirectivo
	,DATE_FORMAT(up.fechaRenuncia, "%d/%m/%Y") as fechaRenuncia,u.idPrograma
    from usuarioplaza up
    join catcategoriasplaza cp on up.idCategoria=cp.id
    join catjornada j on up.idJornada=j.id
    join cattiposnombramiento ctn on up.idTipoNombramiento=ctn.id 
    join usuario u on up.idUsuario=u.id
    where up.idUsuario=_idUsuario;
END$$

DELIMITER ;



USE `bdpromocion`;
DROP procedure IF EXISTS `sp_insertUsuarioPlaza`;

DELIMITER $$
USE `bdpromocion`$$
CREATE DEFINER=`admin`@`localhost` PROCEDURE `sp_insertUsuarioPlaza`(in _idUsuario int, in _idCategoria int, in _idJornada int,in _horas int,in _fecha date,in _idTipoNombramiento int,in _clave varchar(25),in _cargoDirectivo char(1),in _fechaRenuncia date)
BEGIN
	
    if(_fechaRenuncia is not null) then
    
		if(_fecha < _fechaRenuncia) then        
			select c.inicioRegistro into @fechaInicioRegistro 
			from usuario u
			join convocatoria c on c.idPrograma=u.idPrograma and c.idPlantel=u.idPlantel and c.idSubsistema=u.idSubsistema
			where u.id=_idUsuario;
			if(_fechaRenuncia<@fechaInicioRegistro) then		
				set @continuar=true;
			else
				set @continuar=false;
				set @respuesta="La fecha de renuncia debe ser anterior a la fecha de inicio de la convocatoria";
			end if;
		else
			set @continuar=false;
			set @respuesta="La fecha desde que ostenta la plaza debe ser menor a la fecha de renuncia";
        end if;
	else
		set @continuar=true; 
    end if;
    if(@continuar) then
		insert into usuarioplaza (idUsuario,idCategoria,idJornada,horas,fecha,idTipoNombramiento,clave,actual,cargoDirectivo,fechaRenuncia)
		values(_idUsuario,_idCategoria,_idJornada,_horas,_fecha,_idTipoNombramiento,_clave,'F',_cargoDirectivo,_fechaRenuncia);
		set @respuesta="ok";        
    end if;
    select @respuesta as respuesta;
END$$

DELIMITER ;











#_FIN CAMBIOS DAVID__________________________________________________________________________________________________________________________







