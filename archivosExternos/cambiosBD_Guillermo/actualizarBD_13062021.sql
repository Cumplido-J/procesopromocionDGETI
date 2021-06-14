-- MySQL dump 10.13  Distrib 8.0.20, for Win64 (x86_64)
--
-- Host: localhost    Database: bdpromocion
-- ------------------------------------------------------
-- Server version	8.0.20

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

USE `bdpromocion`;

--
-- Table structure for table `catpuntajeporcategoria`
--

DROP TABLE IF EXISTS `catpuntajeporcategoria`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `catpuntajeporcategoria` (
  `id` int NOT NULL AUTO_INCREMENT,
  `idPeriodoRegistro` int NOT NULL DEFAULT '1',
  `idEntidad` int DEFAULT NULL,
  `idPrograma` int NOT NULL,
  `idSubsistema` int NOT NULL,
  `idPuntaje` int NOT NULL,
  `puntaje` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UcCategoria` (`idEntidad`,`idPrograma`,`idSubsistema`,`idPuntaje`),
  KEY `FkProgramasPuntajeCateg_idx` (`idPrograma`),
  KEY `FKSubsistemaPuntajeCateg_idx` (`idSubsistema`),
  KEY `IxCategoria` (`idEntidad`,`idPrograma`,`idSubsistema`,`idPuntaje`) /*!80000 INVISIBLE */,
  CONSTRAINT `FkEntidadPuntajeCateg` FOREIGN KEY (`idEntidad`) REFERENCES `catentidades` (`id`),
  CONSTRAINT `FkProgramasPuntajeCateg` FOREIGN KEY (`idPrograma`) REFERENCES `catprogramas` (`id`),
  CONSTRAINT `FKSubsistemaPuntajeCateg` FOREIGN KEY (`idSubsistema`) REFERENCES `catsubsistema` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=114 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `catpuntajeporcategoria`
--

LOCK TABLES `catpuntajeporcategoria` WRITE;
/*!40000 ALTER TABLE `catpuntajeporcategoria` DISABLE KEYS */;
INSERT INTO `catpuntajeporcategoria` (`id`, `idPeriodoRegistro`, `idEntidad`, `idPrograma`, `idSubsistema`, `idPuntaje`, `puntaje`) VALUES (1,1,NULL,1,1,0,0),(2,1,NULL,1,1,1,10),(3,1,NULL,1,1,2,20),(4,1,NULL,1,1,3,30),(5,1,NULL,1,1,4,40),(6,1,NULL,1,1,5,50),(7,1,NULL,1,1,6,25),(8,1,NULL,1,1,7,50),(9,1,NULL,1,1,8,10),(10,1,NULL,1,1,9,20),(11,1,NULL,1,1,10,20),(12,1,NULL,1,1,11,30),(13,1,NULL,1,1,12,50),(14,1,NULL,1,1,13,60),(15,1,NULL,1,1,14,70),(16,1,NULL,1,1,15,100),(17,1,NULL,1,1,16,10),(18,1,NULL,1,1,17,40),(19,1,NULL,1,1,18,50),(20,1,NULL,1,1,19,60),(21,1,NULL,1,1,20,30),(22,1,NULL,1,1,21,55),(23,1,NULL,1,1,22,80),(24,1,NULL,1,1,23,105),(25,1,NULL,1,1,24,130),(26,1,NULL,1,1,25,30),(27,1,NULL,1,1,26,55),(28,1,NULL,1,1,27,80),(29,1,NULL,1,1,28,105),(30,1,NULL,1,1,29,130),(31,1,NULL,1,1,30,35),(32,1,NULL,1,1,31,70),(33,1,NULL,1,1,32,25),(34,1,NULL,1,1,33,50),(35,1,NULL,1,1,34,25),(36,1,NULL,1,1,35,0),(37,1,NULL,1,1,36,25),(38,1,NULL,1,1,37,0),(39,1,NULL,1,1,38,25),(40,1,NULL,1,1,39,35),(41,1,NULL,1,1,40,50),(42,1,NULL,1,1,41,5),(43,1,NULL,1,1,42,10),(44,1,NULL,1,1,43,15),(45,1,NULL,1,1,44,20),(46,1,NULL,1,1,45,25),(47,1,NULL,1,1,46,10),(48,1,NULL,1,1,47,15),(49,1,NULL,1,1,48,25),(50,1,NULL,1,1,49,30),(51,1,NULL,1,1,50,55),(52,1,NULL,1,1,51,80),(53,1,NULL,1,1,52,105),(54,1,NULL,1,1,53,130),(55,1,NULL,1,1,54,150),(56,1,NULL,1,1,55,0),(57,1,NULL,2,1,0,0),(58,1,NULL,2,1,1,10),(59,1,NULL,2,1,2,20),(60,1,NULL,2,1,3,30),(61,1,NULL,2,1,4,40),(62,1,NULL,2,1,5,50),(63,1,NULL,2,1,6,25),(64,1,NULL,2,1,7,50),(65,1,NULL,2,1,8,10),(66,1,NULL,2,1,9,20),(67,1,NULL,2,1,10,20),(68,1,NULL,2,1,11,30),(69,1,NULL,2,1,12,50),(70,1,NULL,2,1,13,60),(71,1,NULL,2,1,14,70),(72,1,NULL,2,1,15,100),(73,1,NULL,2,1,16,10),(74,1,NULL,2,1,17,40),(75,1,NULL,2,1,18,50),(76,1,NULL,2,1,19,60),(77,1,NULL,2,1,20,30),(78,1,NULL,2,1,21,55),(79,1,NULL,2,1,22,80),(80,1,NULL,2,1,23,105),(81,1,NULL,2,1,24,130),(82,1,NULL,2,1,25,20),(83,1,NULL,2,1,26,40),(84,1,NULL,2,1,27,60),(85,1,NULL,2,1,28,80),(86,1,NULL,2,1,29,100),(87,1,NULL,2,1,30,25),(88,1,NULL,2,1,31,50),(89,1,NULL,2,1,32,25),(90,1,NULL,2,1,33,50),(91,1,NULL,2,1,34,25),(92,1,NULL,2,1,35,0),(93,1,NULL,2,1,36,25),(94,1,NULL,2,1,37,0),(95,1,NULL,2,1,38,25),(96,1,NULL,2,1,39,35),(97,1,NULL,2,1,40,50),(98,1,NULL,2,1,41,5),(99,1,NULL,2,1,42,10),(100,1,NULL,2,1,43,15),(101,1,NULL,2,1,44,20),(102,1,NULL,2,1,45,25),(103,1,NULL,2,1,46,10),(104,1,NULL,2,1,47,15),(105,1,NULL,2,1,48,25),(106,1,NULL,2,1,49,30),(107,1,NULL,2,1,50,60),(108,1,NULL,2,1,51,90),(109,1,NULL,2,1,52,120),(110,1,NULL,2,1,53,150),(111,1,NULL,2,1,54,200),(112,1,NULL,2,1,55,0);
/*!40000 ALTER TABLE `catpuntajeporcategoria` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2021-06-05 13:39:01

USE `bdpromocion`;
DROP procedure IF EXISTS `sp_consultaConstanciasProceso_v2`;

DELIMITER $$
USE `bdpromocion`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_consultaConstanciasProceso_v2`(in _idUsuario int)
BEGIN

    declare _idEntidad int default null;
    declare _idPrograma int default null;
    declare _idSubsistema int default null;
    declare _idPeriodoRegistro int default null;
    declare _aux int default 0; 
    
    select idEntidad, idPrograma, idSubsistema, idPeriodo into _idEntidad, _idPrograma, _idSubsistema, _idPeriodoRegistro from usuario where id =_idUsuario limit 1;
  
    select ifnull(count(idEntidad),0) into _aux from catpuntajeporcategoria where idEntidad = _idEntidad;

    if _aux = 0 then 
		select a.id,a.idUsuario,c.id as idCriterio,a.idCatPuntaje1,
			CASE
				WHEN cpc.puntaje is null THEN 0			
				ELSE cpc.puntaje
			END as puntaje,
			c.criterio,b.descripcion,a.aceptado
		from catcriteriosvaloracion c
		left join (select * from constanciasproceso where idUsuario=_idUsuario) a on c.id=a.idCriterio 
		left join catpuntaje b on a.idCatPuntaje1=b.id
		left join catpuntajeporcategoria cpc on b.id = cpc.idPuntaje and cpc.idPeriodoRegistro = _idPeriodoRegistro and cpc.idEntidad is null and cpc.idPrograma = _idPrograma and cpc.idSubsistema = _idSubsistema
		where a.idUsuario=_idUsuario or a.idUsuario is null
		order by c.id asc;
    else
		select a.id,a.idUsuario,c.id as idCriterio,a.idCatPuntaje1,
			CASE
				WHEN cpc.puntaje is null THEN 0			
				ELSE cpc.puntaje
			END as puntaje,
			c.criterio,b.descripcion,a.aceptado
		from catcriteriosvaloracion c
		left join (select * from constanciasproceso where idUsuario=_idUsuario) a on c.id=a.idCriterio 
		left join catpuntaje b on a.idCatPuntaje1=b.id
		left join catpuntajeporcategoria cpc on b.id = cpc.idPuntaje and cpc.idPeriodoRegistro = _idPeriodoRegistro and cpc.idEntidad = _idEntidad and cpc.idPrograma = _idPrograma and cpc.idSubsistema = _idSubsistema
		where a.idUsuario=_idUsuario or a.idUsuario is null
		order by c.id asc;
    end if;
    
END$$

DELIMITER ;

USE `bdpromocion`;
DROP procedure IF EXISTS `sp_consultaConstanciasProcesoDictaminador_v2`;

DELIMITER $$
USE `bdpromocion`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_consultaConstanciasProcesoDictaminador_v2`(in _idUsuario int)
BEGIN

    declare _idEntidad int default null;
    declare _idPrograma int default null;
    declare _idSubsistema int default null;
    declare _idPeriodoRegistro int default null;
    declare _aux int default 0; 

    select idEntidad, idPrograma, idSubsistema, idPeriodo into _idEntidad, _idPrograma, _idSubsistema, _idPeriodoRegistro from usuario where id =_idUsuario limit 1;

    select ifnull(count(idEntidad),0) into _aux from catpuntajeporcategoria where idEntidad = _idEntidad;

    if _aux = 0 then 
    
		select a.id,a.idUsuario,c.id as idCriterio,a.idCatPuntaje2,
			CASE
				WHEN cpc.puntaje is null THEN 0			
				ELSE cpc.puntaje
			END as puntaje,
			c.criterio,b.descripcion,a.aceptado2
		from catcriteriosvaloracion c
		left join (select * from constanciasproceso where idUsuario=_idUsuario) a on c.id=a.idCriterio 
		left join catpuntaje b on a.idCatPuntaje2=b.id    
		left join catpuntajeporcategoria cpc on b.id = cpc.idPuntaje and cpc.idPeriodoRegistro = _idPeriodoRegistro and cpc.idEntidad is null and cpc.idPrograma = _idPrograma and cpc.idSubsistema = _idSubsistema
		where a.idUsuario=_idUsuario or a.idUsuario is null
		order by c.id asc;

    else
    
		select a.id,a.idUsuario,c.id as idCriterio,a.idCatPuntaje2,
			CASE
				WHEN cpc.puntaje is null THEN 0			
				ELSE cpc.puntaje
			END as puntaje,
			c.criterio,b.descripcion,a.aceptado2
		from catcriteriosvaloracion c
		left join (select * from constanciasproceso where idUsuario=_idUsuario) a on c.id=a.idCriterio 
		left join catpuntaje b on a.idCatPuntaje2=b.id    
		left join catpuntajeporcategoria cpc on b.id = cpc.idPuntaje and cpc.idPeriodoRegistro = _idPeriodoRegistro and cpc.idEntidad = _idEntidad and cpc.idPrograma = _idPrograma and cpc.idSubsistema = _idSubsistema
		where a.idUsuario=_idUsuario or a.idUsuario is null
		order by c.id asc;    
    
    end if;
        
END$$

DELIMITER ;

USE `bdpromocion`;
DROP procedure IF EXISTS `sp_selectCatPuntaje_v2`;

DELIMITER $$
USE `bdpromocion`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_selectCatPuntaje_v2`(in _idCriterio int, in _idUsuario int)
BEGIN

    declare _idEntidad int default null;
    declare _idPrograma int default null;
    declare _idSubsistema int default null;
    declare _idPeriodoRegistro int default null;
    declare _aux int default 0;
    
    select idEntidad, idPrograma, idSubsistema, idPeriodo into _idEntidad, _idPrograma, _idSubsistema, _idPeriodoRegistro from usuario where id =_idUsuario limit 1;
  
    select ifnull(count(idEntidad),0) into _aux from catpuntajeporcategoria where idEntidad = _idEntidad;

    if _aux = 0 then 
		select cp.id, cp.descripcion, cpc.puntaje, cp.multiple, cp.puntajeFijo
		from catpuntaje cp 
		inner join catpuntajeporcategoria cpc on cp.id = cpc.idPuntaje and cpc.idPeriodoRegistro = _idPeriodoRegistro and cpc.idEntidad is null and cpc.idPrograma = _idPrograma and cpc.idSubsistema = _idSubsistema
		where cp.idCriterio=_idCriterio;
	else
		select cp.id, cp.descripcion, cpc.puntaje, cp.multiple, cp.puntajeFijo
		from catpuntaje cp 
		inner join catpuntajeporcategoria cpc on cp.id = cpc.idPuntaje and cpc.idPeriodoRegistro = _idPeriodoRegistro and cpc.idEntidad = _idEntidad and cpc.idPrograma = _idPrograma and cpc.idSubsistema = _idSubsistema
		where cp.idCriterio=_idCriterio;
    end if;

END$$

DELIMITER ;

USE `bdpromocion`;
DROP procedure IF EXISTS `sp_selectCursos_v2`;

DELIMITER $$
USE `bdpromocion`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_selectCursos_v2`(in _idUsuario int)
BEGIN
	
    
    declare _idEntidad int default null;
    declare _idPrograma int default null;
    declare _idSubsistema int default null;
    declare _idPeriodoRegistro int default null;
    declare _totalHorasRevisor int default 0;
    declare _totalHorasDictamiador int default 0;
    declare _puntajeRevisor int default 0;
    declare _puntajeDictamiador int default 0;
    declare _puntaje_A int default null;
    declare _puntaje_B1 int default null;
    declare _puntaje_B2 int default null;
    declare _puntaje_B3 int default null;
    declare _aux int default 0; 
    
    select idEntidad, idPrograma, idSubsistema, idPeriodo into _idEntidad, _idPrograma, _idSubsistema, _idPeriodoRegistro from usuario where id =_idUsuario limit 1;
  
    select ifnull(count(idEntidad),0) into _aux from catpuntajeporcategoria where idEntidad = _idEntidad;
    
    if _aux = 0 then 
		select puntaje into _puntaje_A  from catpuntajeporcategoria where idPeriodoRegistro = _idPeriodoRegistro and idEntidad is null and idPrograma = _idPrograma and idSubsistema = _idSubsistema and idPuntaje = 16;
		select puntaje into _puntaje_B1 from catpuntajeporcategoria where idPeriodoRegistro = _idPeriodoRegistro and idEntidad is null and idPrograma = _idPrograma and idSubsistema = _idSubsistema and idPuntaje = 17;
		select puntaje into _puntaje_B2 from catpuntajeporcategoria where idPeriodoRegistro = _idPeriodoRegistro and idEntidad is null and idPrograma = _idPrograma and idSubsistema = _idSubsistema and idPuntaje = 18;
		select puntaje into _puntaje_B3 from catpuntajeporcategoria where idPeriodoRegistro = _idPeriodoRegistro and idEntidad is null and idPrograma = _idPrograma and idSubsistema = _idSubsistema and idPuntaje = 19;
    else
		select puntaje into _puntaje_A  from catpuntajeporcategoria where idPeriodoRegistro = _idPeriodoRegistro and idEntidad = _idEntidad and idPrograma = _idPrograma and idSubsistema = _idSubsistema and idPuntaje = 16;
		select puntaje into _puntaje_B1 from catpuntajeporcategoria where idPeriodoRegistro = _idPeriodoRegistro and idEntidad = _idEntidad and idPrograma = _idPrograma and idSubsistema = _idSubsistema and idPuntaje = 17;
		select puntaje into _puntaje_B2 from catpuntajeporcategoria where idPeriodoRegistro = _idPeriodoRegistro and idEntidad = _idEntidad and idPrograma = _idPrograma and idSubsistema = _idSubsistema and idPuntaje = 18;
		select puntaje into _puntaje_B3 from catpuntajeporcategoria where idPeriodoRegistro = _idPeriodoRegistro and idEntidad = _idEntidad and idPrograma = _idPrograma and idSubsistema = _idSubsistema and idPuntaje = 19;
    end if;
 
 	if _puntaje_A is not null and _puntaje_B1 is not null and _puntaje_B2 is not null and _puntaje_B3 is not null then

		select sum(totalHoras) into _totalHorasRevisor from cursos where tipo = "CU" and valido = "V" and idUsuario=_idUsuario;
        select sum(totalHoras) into _totalHorasDictamiador from cursos where tipo = "CU" and valido2 = "V" and idUsuario=_idUsuario;
		select _puntaje_A into _puntajeRevisor from cursos where tipo = "CE" and valido = "V" and idUsuario=_idUsuario limit 1;
        select _puntaje_A into _puntajeDictamiador from cursos where tipo = "CE" and valido2 = "V" and idUsuario=_idUsuario limit 1;
    
		if (_totalHorasRevisor>=120 AND _totalHorasRevisor<=160) then
			set _puntajeRevisor = _puntajeRevisor + _puntaje_B1;
		elseif (_totalHorasRevisor>=161 AND _totalHorasRevisor<=199) then
			set _puntajeRevisor = _puntajeRevisor + _puntaje_B2;
		elseif (_totalHorasRevisor>=200) then
			set _puntajeRevisor = _puntajeRevisor + _puntaje_B3;
		end if;
        
        if (_totalHorasDictamiador>=120 AND _totalHorasDictamiador<=160) then
			set _puntajeDictamiador = _puntajeDictamiador + _puntaje_B1;
		elseif (_totalHorasDictamiador>=161 AND _totalHorasDictamiador<=199) then
			set _puntajeDictamiador = _puntajeDictamiador + _puntaje_B2;
		elseif (_totalHorasDictamiador>=200) then
			set _puntajeDictamiador = _puntajeDictamiador + _puntaje_B3;
		end if;

    select id, idUsuario, tipo, nombreCurso, fechaInicio, fechaFin, institucion, totalHoras, documento, valido, valido2, _puntajeRevisor as puntajeRevisor, _puntajeDictamiador as puntajeDictamiador
    from cursos where idUsuario=_idUsuario order by fechaInicio asc,fechafin asc; 
    
	end if;
        
END$$

DELIMITER ;

USE `bdpromocion`;
DROP procedure IF EXISTS `sp_consultaAportaciones_v2`;

DELIMITER $$
USE `bdpromocion`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_consultaAportaciones_v2`(in _idUsuario int)
BEGIN

    declare _idEntidad int default null;
    declare _idPrograma int default null;
    declare _idSubsistema int default null;
    declare _idPeriodoRegistro int default null;
    declare _totalValidoRevisor int default 0;
    declare _totalValidoDictamiador int default 0;
    declare _puntajeRevisor int default 0;
    declare _puntajeDictamiador int default 0;
    declare _puntaje_0A int default 0;
    declare _puntaje_1A int default null;
    declare _puntaje_2A int default null;
    declare _puntaje_3A int default null;
    declare _puntaje_4A int default null;
    declare _puntaje_5A int default null;
    declare _aux int default 0;
    
    select idEntidad, idPrograma, idSubsistema, idPeriodo into _idEntidad, _idPrograma, _idSubsistema, _idPeriodoRegistro from usuario where id =_idUsuario limit 1;
  
    select ifnull(count(idEntidad),0) into _aux from catpuntajeporcategoria where idEntidad = _idEntidad;
    
    if _aux = 0 then 
		select puntaje into _puntaje_1A  from catpuntajeporcategoria where idPeriodoRegistro = _idPeriodoRegistro and idEntidad is null and idPrograma = _idPrograma and idSubsistema = _idSubsistema and idPuntaje = 20;
		select puntaje into _puntaje_2A from catpuntajeporcategoria where idPeriodoRegistro = _idPeriodoRegistro and idEntidad is null and idPrograma = _idPrograma and idSubsistema = _idSubsistema and idPuntaje = 21;
		select puntaje into _puntaje_3A from catpuntajeporcategoria where idPeriodoRegistro = _idPeriodoRegistro and idEntidad is null and idPrograma = _idPrograma and idSubsistema = _idSubsistema and idPuntaje = 22;
		select puntaje into _puntaje_4A from catpuntajeporcategoria where idPeriodoRegistro = _idPeriodoRegistro and idEntidad is null and idPrograma = _idPrograma and idSubsistema = _idSubsistema and idPuntaje = 23;
		select puntaje into _puntaje_5A from catpuntajeporcategoria where idPeriodoRegistro = _idPeriodoRegistro and idEntidad is null and idPrograma = _idPrograma and idSubsistema = _idSubsistema and idPuntaje = 24;
    else
		select puntaje into _puntaje_1A  from catpuntajeporcategoria where idPeriodoRegistro = _idPeriodoRegistro and idEntidad = _idEntidad and idPrograma = _idPrograma and idSubsistema = _idSubsistema and idPuntaje = 20;
		select puntaje into _puntaje_2A from catpuntajeporcategoria where idPeriodoRegistro = _idPeriodoRegistro and idEntidad = _idEntidad and idPrograma = _idPrograma and idSubsistema = _idSubsistema and idPuntaje = 21;
		select puntaje into _puntaje_3A from catpuntajeporcategoria where idPeriodoRegistro = _idPeriodoRegistro and idEntidad = _idEntidad and idPrograma = _idPrograma and idSubsistema = _idSubsistema and idPuntaje = 22;
		select puntaje into _puntaje_4A from catpuntajeporcategoria where idPeriodoRegistro = _idPeriodoRegistro and idEntidad = _idEntidad and idPrograma = _idPrograma and idSubsistema = _idSubsistema and idPuntaje = 23;
		select puntaje into _puntaje_5A from catpuntajeporcategoria where idPeriodoRegistro = _idPeriodoRegistro and idEntidad = _idEntidad and idPrograma = _idPrograma and idSubsistema = _idSubsistema and idPuntaje = 24;
    end if;
    
    if _puntaje_1A is not null and _puntaje_2A is not null and _puntaje_3A is not null and _puntaje_4A is not null and _puntaje_5A is not null then

		select ifnull(count(*),0) into _totalValidoRevisor from aportaciones where valido = "V" and idUsuario=_idUsuario;
        select ifnull(count(*),0) into _totalValidoDictamiador from aportaciones where valido2 = "V" and idUsuario=_idUsuario;
    
        case _totalValidoRevisor
			when 0 then set _puntajeRevisor = _puntaje_0A;
			when 1 then set _puntajeRevisor = _puntaje_1A;
			when 2 then set _puntajeRevisor = _puntaje_2A;
			when 3 then set _puntajeRevisor = _puntaje_3A;
			when 4 then set _puntajeRevisor = _puntaje_4A;
			else set _puntajeRevisor = _puntaje_5A;
        end case;
    
        case _totalValidoDictamiador
			when 0 then set _puntajeDictamiador = _puntaje_0A;
			when 1 then set _puntajeDictamiador = _puntaje_1A;
			when 2 then set _puntajeDictamiador = _puntaje_2A;
			when 3 then set _puntajeDictamiador = _puntaje_3A;
			when 4 then set _puntajeDictamiador = _puntaje_4A;
			else set _puntajeDictamiador = _puntaje_5A;
        end case;    

	select a.id, a.idUsuario, a.idAportacion, b.aportacion, a.fechaInicio, a.fechaFin, a.institucion, a.documento, a.valido, a.valido2, _puntajeRevisor as puntajeRevisor, _puntajeDictamiador as puntajeDictamiador
    from aportaciones a
    join cataportacion b on a.idAportacion=b.id
    where a.idUsuario=_idUsuario
    order by a.fechaInicio asc,a.fechafin asc;
   
	end if;

END$$

DELIMITER ;

USE `bdpromocion`;
DROP procedure IF EXISTS `sp_consultaParticipaciones_v2`;

DELIMITER $$
USE `bdpromocion`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_consultaParticipaciones_v2`(in _idUsuario int)
BEGIN

    declare _idEntidad int default null;
    declare _idPrograma int default null;
    declare _idSubsistema int default null;
    declare _idPeriodoRegistro int default null;
    declare _totalValidoRevisor int default 0;
    declare _totalValidoDictamiador int default 0;
    declare _puntajeRevisor int default 0;
    declare _puntajeDictamiador int default 0;
    declare _puntaje_0P int default 0;
    declare _puntaje_1P int default null;
    declare _puntaje_2P int default null;
    declare _puntaje_3P int default null;
    declare _puntaje_4P int default null;
    declare _puntaje_5P int default null;
    declare _aux int default 0;
    
    select idEntidad, idPrograma, idSubsistema, idPeriodo into _idEntidad, _idPrograma, _idSubsistema, _idPeriodoRegistro from usuario where id =_idUsuario limit 1;
  
    select ifnull(count(idEntidad),0) into _aux from catpuntajeporcategoria where idEntidad = _idEntidad;
    
    if _aux = 0 then 
		select puntaje into _puntaje_1P  from catpuntajeporcategoria where idPeriodoRegistro = _idPeriodoRegistro and idEntidad is null and idPrograma = _idPrograma and idSubsistema = _idSubsistema and idPuntaje = 25;
		select puntaje into _puntaje_2P from catpuntajeporcategoria where idPeriodoRegistro = _idPeriodoRegistro and idEntidad is null and idPrograma = _idPrograma and idSubsistema = _idSubsistema and idPuntaje = 26;
		select puntaje into _puntaje_3P from catpuntajeporcategoria where idPeriodoRegistro = _idPeriodoRegistro and idEntidad is null and idPrograma = _idPrograma and idSubsistema = _idSubsistema and idPuntaje = 27;
		select puntaje into _puntaje_4P from catpuntajeporcategoria where idPeriodoRegistro = _idPeriodoRegistro and idEntidad is null and idPrograma = _idPrograma and idSubsistema = _idSubsistema and idPuntaje = 28;
		select puntaje into _puntaje_5P from catpuntajeporcategoria where idPeriodoRegistro = _idPeriodoRegistro and idEntidad is null and idPrograma = _idPrograma and idSubsistema = _idSubsistema and idPuntaje = 29;
    else
		select puntaje into _puntaje_1P  from catpuntajeporcategoria where idPeriodoRegistro = _idPeriodoRegistro and idEntidad = _idEntidad and idPrograma = _idPrograma and idSubsistema = _idSubsistema and idPuntaje = 25;
		select puntaje into _puntaje_2P from catpuntajeporcategoria where idPeriodoRegistro = _idPeriodoRegistro and idEntidad = _idEntidad and idPrograma = _idPrograma and idSubsistema = _idSubsistema and idPuntaje = 26;
		select puntaje into _puntaje_3P from catpuntajeporcategoria where idPeriodoRegistro = _idPeriodoRegistro and idEntidad = _idEntidad and idPrograma = _idPrograma and idSubsistema = _idSubsistema and idPuntaje = 27;
		select puntaje into _puntaje_4P from catpuntajeporcategoria where idPeriodoRegistro = _idPeriodoRegistro and idEntidad = _idEntidad and idPrograma = _idPrograma and idSubsistema = _idSubsistema and idPuntaje = 28;
		select puntaje into _puntaje_5P from catpuntajeporcategoria where idPeriodoRegistro = _idPeriodoRegistro and idEntidad = _idEntidad and idPrograma = _idPrograma and idSubsistema = _idSubsistema and idPuntaje = 29;
    end if;
    
    if _puntaje_1P is not null and _puntaje_2P is not null and _puntaje_3P is not null and _puntaje_4P is not null and _puntaje_5P is not null then

		select ifnull(count(*),0) into _totalValidoRevisor from participaciones where valido = "V" and idUsuario=_idUsuario;
        select ifnull(count(*),0) into _totalValidoDictamiador from participaciones where valido2 = "V" and idUsuario=_idUsuario;
    
        case _totalValidoRevisor
			when 0 then set _puntajeRevisor = _puntaje_0P;
			when 1 then set _puntajeRevisor = _puntaje_1P;
			when 2 then set _puntajeRevisor = _puntaje_2P;
			when 3 then set _puntajeRevisor = _puntaje_3P;
			when 4 then set _puntajeRevisor = _puntaje_4P;
			else set _puntajeRevisor = _puntaje_5P;
        end case;
    
        case _totalValidoDictamiador
			when 0 then set _puntajeDictamiador = _puntaje_0P;
			when 1 then set _puntajeDictamiador = _puntaje_1P;
			when 2 then set _puntajeDictamiador = _puntaje_2P;
			when 3 then set _puntajeDictamiador = _puntaje_3P;
			when 4 then set _puntajeDictamiador = _puntaje_4P;
			else set _puntajeDictamiador = _puntaje_5P;
        end case;    

	select a.id, a.idUsuario, a.idParticipacion, b.participacion, a.fechaInicio, a.fechaFin, a.institucion, a.documento, a.valido, a.valido2, _puntajeRevisor as puntajeRevisor, _puntajeDictamiador as puntajeDictamiador
    from participaciones a
    join catparticipacion b on a.idParticipacion=b.id
    where a.idUsuario=_idUsuario
    order by a.fechaInicio asc,a.fechafin asc;
    
	end if;

END$$

DELIMITER ;

USE `bdpromocion`;
DROP procedure IF EXISTS `sp_selectTutorias_v2`;

DELIMITER $$
USE `bdpromocion`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_selectTutorias_v2`(in _idUsuario int)
BEGIN

    declare _idEntidad int default null;
    declare _idPrograma int default null;
    declare _idSubsistema int default null;
    declare _idPeriodoRegistro int default null;
    declare _totalValidoRevisor int default 0;
    declare _totalValidoDictamiador int default 0;
    declare _puntajeRevisor int default 0;
    declare _puntajeDictamiador int default 0;
    declare _puntaje_0T int default 0;
    declare _puntaje_1T int default null;
    declare _puntaje_2T int default null;
    declare _aux int default 0;
    
    select idEntidad, idPrograma, idSubsistema, idPeriodo into _idEntidad, _idPrograma, _idSubsistema, _idPeriodoRegistro from usuario where id =_idUsuario limit 1;
  
    select ifnull(count(idEntidad),0) into _aux from catpuntajeporcategoria where idEntidad = _idEntidad;
    
    if _aux = 0 then 
		select puntaje into _puntaje_1T  from catpuntajeporcategoria where idPeriodoRegistro = _idPeriodoRegistro and idEntidad is null and idPrograma = _idPrograma and idSubsistema = _idSubsistema and idPuntaje = 30;
		select puntaje into _puntaje_2T from catpuntajeporcategoria where idPeriodoRegistro = _idPeriodoRegistro and idEntidad is null and idPrograma = _idPrograma and idSubsistema = _idSubsistema and idPuntaje = 31;
    else
		select puntaje into _puntaje_1T  from catpuntajeporcategoria where idPeriodoRegistro = _idPeriodoRegistro and idEntidad = _idEntidad and idPrograma = _idPrograma and idSubsistema = _idSubsistema and idPuntaje = 30;
		select puntaje into _puntaje_2T from catpuntajeporcategoria where idPeriodoRegistro = _idPeriodoRegistro and idEntidad = _idEntidad and idPrograma = _idPrograma and idSubsistema = _idSubsistema and idPuntaje = 31;
    end if;
    
    if _puntaje_1T is not null and _puntaje_2T is not null then

		select ifnull(count(*),0) into _totalValidoRevisor from tutorias where valido = "V" and idUsuario=_idUsuario;
        select ifnull(count(*),0) into _totalValidoDictamiador from tutorias where valido2 = "V" and idUsuario=_idUsuario;
    
        case _totalValidoRevisor
			when 0 then set _puntajeRevisor = _puntaje_0T;
			when 1 then set _puntajeRevisor = _puntaje_1T;
			else set _puntajeRevisor = _puntaje_2T;
        end case;
    
        case _totalValidoDictamiador
			when 0 then set _puntajeDictamiador = _puntaje_0T;
			when 1 then set _puntajeDictamiador = _puntaje_1T;
			else set _puntajeDictamiador = _puntaje_2T;
        end case;    

	select id,idUsuario,fechaInicio,fechaFin,documento,valido, valido2, _puntajeRevisor as puntajeRevisor, _puntajeDictamiador as puntajeDictamiador
    from tutorias 
    where idUsuario=_idUsuario
    order by fechaInicio asc,fechafin asc;
    
	end if;
    
END$$

DELIMITER ;

USE `bdpromocion`;
DROP procedure IF EXISTS `sp_selectPublicaciones_v2`;

DELIMITER $$
USE `bdpromocion`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_selectPublicaciones_v2`(in _idUsuario int)
BEGIN

    declare _idEntidad int default null;
    declare _idPrograma int default null;
    declare _idSubsistema int default null;
    declare _idPeriodoRegistro int default null;
    declare _totalValidoRevisor int default 0;
    declare _totalValidoDictamiador int default 0;
    declare _puntajeRevisor int default 0;
    declare _puntajeDictamiador int default 0;
    declare _puntaje_0P int default 0;
    declare _puntaje_1P int default null;
    declare _puntaje_2P int default null;
    declare _aux int default 0;
    
    select idEntidad, idPrograma, idSubsistema, idPeriodo into _idEntidad, _idPrograma, _idSubsistema, _idPeriodoRegistro from usuario where id =_idUsuario limit 1;
  
    select ifnull(count(idEntidad),0) into _aux from catpuntajeporcategoria where idEntidad = _idEntidad;
    
    if _aux = 0 then 
		select puntaje into _puntaje_1P  from catpuntajeporcategoria where idPeriodoRegistro = _idPeriodoRegistro and idEntidad is null and idPrograma = _idPrograma and idSubsistema = _idSubsistema and idPuntaje = 32;
		select puntaje into _puntaje_2P from catpuntajeporcategoria where idPeriodoRegistro = _idPeriodoRegistro and idEntidad is null and idPrograma = _idPrograma and idSubsistema = _idSubsistema and idPuntaje = 33;
    else
		select puntaje into _puntaje_1P  from catpuntajeporcategoria where idPeriodoRegistro = _idPeriodoRegistro and idEntidad = _idEntidad and idPrograma = _idPrograma and idSubsistema = _idSubsistema and idPuntaje = 32;
		select puntaje into _puntaje_2P from catpuntajeporcategoria where idPeriodoRegistro = _idPeriodoRegistro and idEntidad = _idEntidad and idPrograma = _idPrograma and idSubsistema = _idSubsistema and idPuntaje = 33;
    end if;
    
    if _puntaje_1P is not null and _puntaje_2P is not null then

		select ifnull(count(*),0) into _totalValidoRevisor from publicaciones where valido = "V" and idUsuario=_idUsuario;
        select ifnull(count(*),0) into _totalValidoDictamiador from publicaciones where valido2 = "V" and idUsuario=_idUsuario;
    
        case _totalValidoRevisor
			when 0 then set _puntajeRevisor = _puntaje_0P;
			when 1 then set _puntajeRevisor = _puntaje_1P;
			else set _puntajeRevisor = _puntaje_2P;
        end case;
    
        case _totalValidoDictamiador
			when 0 then set _puntajeDictamiador = _puntaje_0P;
			when 1 then set _puntajeDictamiador = _puntaje_1P;
			else set _puntajeDictamiador = _puntaje_2P;
        end case;    

	select id, idUsuario, nombre,
    CASE
		WHEN medio = "I" THEN "Impreso"
		WHEN medio = "E" THEN "Electrónico"
		ELSE medio
	END as medio
    ,fecha, ISSN, valido, valido2, _puntajeRevisor as puntajeRevisor, _puntajeDictamiador as puntajeDictamiador
    from publicaciones where idUsuario=_idUsuario
    order by fecha asc;
        
	end if;
    
END$$

DELIMITER ;

USE `bdpromocion`;
DROP procedure IF EXISTS `sp_consultaResultados_v2`;

DELIMITER $$
USE `bdpromocion`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_consultaResultados_v2`(in _idUsuario int)
BEGIN

    declare _idEntidad int default null;
    declare _idPrograma int default null;
    declare _idSubsistema int default null;
    declare _idPeriodoRegistro int default null;
    declare _totalValidoRevisor int default 0;
    declare _totalValidoDictamiador int default 0;
    declare _puntajeRevisor int default 0;
    declare _puntajeDictamiador int default 0;
    declare _puntaje_0R int default 0;
    declare _puntaje_1R int default null;
    declare _puntaje_2R int default null;
    declare _puntaje_3R int default null;
    declare _puntaje_4R int default null;
    declare _puntaje_5R int default null;
    declare _puntaje_6R int default null;
    declare _aux int default 0;  
    
    select idEntidad, idPrograma, idSubsistema, idPeriodo into _idEntidad, _idPrograma, _idSubsistema, _idPeriodoRegistro from usuario where id =_idUsuario limit 1;
  
    select ifnull(count(idEntidad),0) into _aux from catpuntajeporcategoria where idEntidad = _idEntidad;
    
    if _aux = 0 then 
		select puntaje into _puntaje_1R  from catpuntajeporcategoria where idPeriodoRegistro = _idPeriodoRegistro and idEntidad is null and idPrograma = _idPrograma and idSubsistema = _idSubsistema and idPuntaje = 49;
		select puntaje into _puntaje_2R from catpuntajeporcategoria where idPeriodoRegistro = _idPeriodoRegistro and idEntidad is null and idPrograma = _idPrograma and idSubsistema = _idSubsistema and idPuntaje = 50;
		select puntaje into _puntaje_3R from catpuntajeporcategoria where idPeriodoRegistro = _idPeriodoRegistro and idEntidad is null and idPrograma = _idPrograma and idSubsistema = _idSubsistema and idPuntaje = 51;
		select puntaje into _puntaje_4R from catpuntajeporcategoria where idPeriodoRegistro = _idPeriodoRegistro and idEntidad is null and idPrograma = _idPrograma and idSubsistema = _idSubsistema and idPuntaje = 52;
		select puntaje into _puntaje_5R from catpuntajeporcategoria where idPeriodoRegistro = _idPeriodoRegistro and idEntidad is null and idPrograma = _idPrograma and idSubsistema = _idSubsistema and idPuntaje = 53;
		select puntaje into _puntaje_6R from catpuntajeporcategoria where idPeriodoRegistro = _idPeriodoRegistro and idEntidad is null and idPrograma = _idPrograma and idSubsistema = _idSubsistema and idPuntaje = 54;
    else
		select puntaje into _puntaje_1R  from catpuntajeporcategoria where idPeriodoRegistro = _idPeriodoRegistro and idEntidad = _idEntidad and idPrograma = _idPrograma and idSubsistema = _idSubsistema and idPuntaje = 49;
		select puntaje into _puntaje_2R from catpuntajeporcategoria where idPeriodoRegistro = _idPeriodoRegistro and idEntidad = _idEntidad and idPrograma = _idPrograma and idSubsistema = _idSubsistema and idPuntaje = 50;
		select puntaje into _puntaje_3R from catpuntajeporcategoria where idPeriodoRegistro = _idPeriodoRegistro and idEntidad = _idEntidad and idPrograma = _idPrograma and idSubsistema = _idSubsistema and idPuntaje = 51;
		select puntaje into _puntaje_4R from catpuntajeporcategoria where idPeriodoRegistro = _idPeriodoRegistro and idEntidad = _idEntidad and idPrograma = _idPrograma and idSubsistema = _idSubsistema and idPuntaje = 52;
		select puntaje into _puntaje_5R from catpuntajeporcategoria where idPeriodoRegistro = _idPeriodoRegistro and idEntidad = _idEntidad and idPrograma = _idPrograma and idSubsistema = _idSubsistema and idPuntaje = 53;
		select puntaje into _puntaje_6R from catpuntajeporcategoria where idPeriodoRegistro = _idPeriodoRegistro and idEntidad = _idEntidad and idPrograma = _idPrograma and idSubsistema = _idSubsistema and idPuntaje = 54;
    end if;
    
    if _puntaje_1R is not null and _puntaje_2R is not null and _puntaje_3R is not null and _puntaje_4R is not null and _puntaje_5R is not null and _puntaje_6R is not null then

		select ifnull(count(*),0) into _totalValidoRevisor from resultados where valido = "V" and idUsuario=_idUsuario;
        select ifnull(count(*),0) into _totalValidoDictamiador from resultados where valido2 = "V" and idUsuario=_idUsuario;
    
        case _totalValidoRevisor
			when 0 then set _puntajeRevisor = _puntaje_0R;
			when 1 then set _puntajeRevisor = _puntaje_1R;
			when 2 then set _puntajeRevisor = _puntaje_1R;
            when 3 then set _puntajeRevisor = _puntaje_2R;
            when 4 then set _puntajeRevisor = _puntaje_2R;
            when 5 then set _puntajeRevisor = _puntaje_3R;
            when 6 then set _puntajeRevisor = _puntaje_3R;
            when 7 then set _puntajeRevisor = _puntaje_4R;
            when 8 then set _puntajeRevisor = _puntaje_4R;
            when 9 then set _puntajeRevisor = _puntaje_5R;
            when 10 then set _puntajeRevisor = _puntaje_5R;
            else set _puntajeRevisor = _puntaje_6R;
        end case;
    
        case _totalValidoDictamiador
			when 0 then set _puntajeDictamiador = _puntaje_0R;
			when 1 then set _puntajeDictamiador = _puntaje_1R;
			when 2 then set _puntajeDictamiador = _puntaje_1R;
			when 3 then set _puntajeDictamiador = _puntaje_2R;
			when 4 then set _puntajeDictamiador = _puntaje_2R;
			when 5 then set _puntajeDictamiador = _puntaje_3R;
			when 6 then set _puntajeDictamiador = _puntaje_3R;
			when 7 then set _puntajeDictamiador = _puntaje_4R;
			when 8 then set _puntajeDictamiador = _puntaje_4R;
			when 9 then set _puntajeDictamiador = _puntaje_5R;
			when 10 then set _puntajeDictamiador = _puntaje_5R;
			else set _puntajeDictamiador = _puntaje_6R;
        end case;    

	select r.id, r.idUsuario, r.idResultado, cr.resultado, r.fechaInicio, r.fechaFin, r.documento, r.valido, r.valido2, _puntajeRevisor as puntajeRevisor, _puntajeDictamiador as puntajeDictamiador
    from resultados r
    join catresultado cr on r.idResultado=cr.id
    where r.idUsuario=_idUsuario
    order by r.fechaInicio asc,r.fechafin asc;
    
	end if;

END$$

DELIMITER ;














