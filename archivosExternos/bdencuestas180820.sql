CREATE DATABASE  IF NOT EXISTS `bdencuestas` /*!40100 DEFAULT CHARACTER SET utf8 */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `bdencuestas`;
-- MySQL dump 10.13  Distrib 8.0.20, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: bdencuestas
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

--
-- Table structure for table `consulta_resultado`
--

DROP TABLE IF EXISTS `consulta_resultado`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `consulta_resultado` (
  `id` int NOT NULL AUTO_INCREMENT,
  `rfc` varchar(13) COLLATE utf8_spanish2_ci NOT NULL,
  `puntaje1` int DEFAULT NULL,
  `puntaje2` int DEFAULT NULL,
  `puntaje3` int DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish2_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `consulta_resultado`
--

LOCK TABLES `consulta_resultado` WRITE;
/*!40000 ALTER TABLE `consulta_resultado` DISABLE KEYS */;
/*!40000 ALTER TABLE `consulta_resultado` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lectura_url`
--

DROP TABLE IF EXISTS `lectura_url`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `lectura_url` (
  `id` int NOT NULL AUTO_INCREMENT,
  `rfc` char(14) COLLATE utf8_spanish2_ci NOT NULL,
  `curp` char(19) COLLATE utf8_spanish2_ci NOT NULL,
  `pin` blob NOT NULL,
  `parametro` char(1) COLLATE utf8_spanish2_ci NOT NULL,
  `correo` varchar(50) COLLATE utf8_spanish2_ci NOT NULL,
  `estatus` varchar(10) COLLATE utf8_spanish2_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=83 DEFAULT CHARSET=utf8 COLLATE=utf8_spanish2_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lectura_url`
--

LOCK TABLES `lectura_url` WRITE;
/*!40000 ALTER TABLE `lectura_url` DISABLE KEYS */;
INSERT INTO `lectura_url` VALUES (76,'AAAS860114A5A','rema940831hmcyrn01',_binary '\0µ®RŒù,Ö\‡\ÓùB¸ˆ®','1','david.reyna31@gmail.com','CONCLUIDO'),(77,'AAAS860114A5A','rema940831hmcyrn02',_binary 'Dã9U˛\À‘åx,e“ë','2','tony310894@hotmail.com','CONCLUIDO'),(78,'AAAS860114A5A','rema940831hmcyrn03',_binary '*4rEÖî∫ämzPı\÷\\ù','2','correo@mail.com','CANCELADO'),(79,'AAAS860114A5A','rema940831hmcyrn04',_binary 'óQIç\"\Àö‘êlû\Íh}ˆ','3','correo10@mail.com','CANCELADO'),(80,'AAAS860114A5A','rema940831hmcyrn05',_binary '¨Q\\F\Áê;£◊æ¢Ω&\—z','2','correo5@mail.com','CONCLUIDO'),(81,'AAAS860114A5A','rema940831hmcyrn36',_binary '˝µôª\—D\∆\‹k\“\⁄¯\œ]s','1','correo36@mail.com','PENDIENTE'),(82,'AAAS860114A5A','rema940831hmcyrn11',_binary 'ÙH˙tâ?ı){\ŒO\¬hSM','3','correo11@mail.com','PENDIENTE');
/*!40000 ALTER TABLE `lectura_url` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'bdencuestas'
--
/*!50003 DROP PROCEDURE IF EXISTS `sp_cancelaPin` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE  PROCEDURE `sp_cancelaPin`(in _id int)
BEGIN
	declare _estatus varchar(10) default null;    
    select estatus into _estatus from lectura_url where id=_id;
    
    if _estatus='PENDIENTE' then    
		update lectura_url set estatus='CANCELADO' where id=_id;
		Select "ok" as respuesta;
	else
		select "Esta informaci√≥n no puede ser eliminada" as respuesta;
	end if;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_insertLecturaUrl` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE  PROCEDURE `sp_insertLecturaUrl`(in _rfc char(14),in _curp char(19),in _pin char(6),in _parametro char(1),in _correo varchar(50))
BEGIN
	declare _fecha datetime;
    declare _fecha64 varchar(50);  
    declare _aux int default null;
    declare _estatus varchar(10) default null;
    set _fecha='2020-08-05 19:14:28';
    set _fecha64=to_base64(_fecha);    
    
    select id,estatus into _aux,_estatus
    from lectura_url
    where rfc=_rfc and (curp=_curp or correo=_correo) limit 1;
    
    if(_aux is null) then    
		insert into lectura_url (rfc,curp,pin,parametro,correo,estatus)
		values (_rfc,_curp,AES_ENCRYPT(_pin, _fecha64),_parametro,_correo,'PENDIENTE');
        select 'ok' as respuesta;
	else
		if(_estatus !='CANCELADO') then
			select "CURP o correo previamente registrado" as respuesta;
		else
			update lectura_url
            set curp=_curp,
            pin = AES_ENCRYPT(_pin, _fecha64),
            parametro=_parametro,
            correo=_correo,
            estatus='PENDIENTE'
            WHERE id=_aux;
            select 'ok' as respuesta;
		end if;
    end if;
	
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_selectLecturaUrl` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE  PROCEDURE `sp_selectLecturaUrl`(in _pin char(6))
BEGIN
	declare _fecha datetime;
    set _fecha='2020-08-05 19:14:28';
	select id,rfc,curp,pin,parametro
    from lectura_url
    where pin = AES_ENCRYPT(_pin, to_base64(_fecha));
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_selectLecturaUrlRFC` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE  PROCEDURE `sp_selectLecturaUrlRFC`(in _rfc char(14))
BEGIN	
	select id,rfc,curp,parametro,correo,estatus
    from lectura_url
    where rfc=_rfc and (estatus='PENDIENTE' OR estatus='CONCLUIDO');
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2020-08-18 19:43:26
