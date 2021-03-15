USE `bdpromocion`;
DROP procedure IF EXISTS `bdpromocion`.`sp_selectCatCategoriasPresupuestales`;

DELIMITER $$
USE `bdpromocion`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_selectCatCategoriasPresupuestales`()
BEGIN
	SELECT id,clave,idCategoria,idJornada FROM catcategoriajornada ORDER BY clave;
END$$

DELIMITER ;

#_____________________________________________________________________________________________________________________________

USE `bdpromocion`;
DROP procedure IF EXISTS `bdpromocion`.`sp_consultaCatJornadas`;

DELIMITER $$
USE `bdpromocion`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_consultaCatJornadas`()
BEGIN
	SELECT id,jornada FROM catjornada ORDER BY id;
END$$

DELIMITER ;

#_____________________________________________________________________________________________________________________________

