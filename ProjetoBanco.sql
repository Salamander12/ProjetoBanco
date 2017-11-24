-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema banco
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema banco
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `banco` DEFAULT CHARACTER SET latin1 ;
USE `banco` ;

-- -----------------------------------------------------
-- Table `banco`.`arq_texto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `banco`.`arq_texto` (
  `ExtensãoDeTexto` VARCHAR(40) NOT NULL,
  `Num_palavras` INT(20) NOT NULL,
  `ID_Text` VARCHAR(45) NOT NULL,
  `caminho` BLOB NULL DEFAULT NULL,
  PRIMARY KEY (`ID_Text`))
ENGINE = MyISAM
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `banco`.`arquivos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `banco`.`arquivos` (
  `Tipo` VARCHAR(40) NOT NULL,
  `ID` VARCHAR(45) NOT NULL,
  `Nome` VARCHAR(40) NOT NULL,
  `Tamanho` VARCHAR(40) NOT NULL,
  `Data_arq` DATE NOT NULL,
  PRIMARY KEY (`ID`))
ENGINE = MyISAM
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `banco`.`arquivos_log`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `banco`.`arquivos_log` (
  `ID_Log` INT(11) NOT NULL,
  `Nome` VARCHAR(50) NOT NULL,
  `DATA_Mudança` DATETIME NULL DEFAULT NULL,
  `ação` VARCHAR(50) NULL DEFAULT NULL)
ENGINE = MyISAM
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `banco`.`imagem`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `banco`.`imagem` (
  `Extensão_Img` VARCHAR(40) NOT NULL,
  `Qualidade` VARCHAR(45) NOT NULL,
  `ID_IMG` VARCHAR(40) NOT NULL,
  `Dados_imagem` LONGBLOB NOT NULL,
  PRIMARY KEY (`ID_IMG`),
  INDEX `Imagens_IDX` (`ID_IMG` ASC))
ENGINE = MyISAM
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `banco`.`video`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `banco`.`video` (
  `Extensão_Vid` VARCHAR(20) NOT NULL,
  `Duração` TIME(6) NOT NULL,
  `Qualidade_vid` VARCHAR(45) NOT NULL,
  `ID_VID` VARCHAR(40) NOT NULL,
  `caminho` BLOB NULL DEFAULT NULL,
  PRIMARY KEY (`ID_VID`))
ENGINE = MyISAM
DEFAULT CHARACTER SET = latin1;

USE `banco` ;

-- -----------------------------------------------------
-- procedure Another_Procedure
-- -----------------------------------------------------

DELIMITER $$
USE `banco`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `Another_Procedure`()
BEGIN
SELECT arquivos.ID, arq_texto.Num_palavras
FROM arquivos, arq_texto
WHERE ID = '670'
AND arq_texto.Num_palavras = '1000';
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure Arquivo_procedure
-- -----------------------------------------------------

DELIMITER $$
USE `banco`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `Arquivo_procedure`()
BEGIN
SELECT arquivos.Tipo, imagem.Qualidade
FROM arquivos, imagem
WHERE Tipo = 'IMG'
AND imagem.Qualidade = '4K';
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure Imagem_Procedure
-- -----------------------------------------------------

DELIMITER $$
USE `banco`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `Imagem_Procedure`()
BEGIN
SELECT Imagem.qualidade, Video.qualidade_vid
FROM Imagem, video
WHERE Qualidade = 1440×1080
AND Video.qualidade_vid = 1920x1080;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure Text_Procedure
-- -----------------------------------------------------

DELIMITER $$
USE `banco`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `Text_Procedure`()
BEGIN
SELECT arq_texto.Num_palavras, arquivos.tipo
FROM arq_texto, arquivos
WHERE arq_texto.Num_palavras = 1000
AND arquivos.tipo = txt;
END$$

DELIMITER ;
USE `banco`;

DELIMITER $$
USE `banco`$$
CREATE
DEFINER=`root`@`localhost`
TRIGGER `banco`.`tb_Trigger6`
BEFORE UPDATE ON `banco`.`arq_texto`
FOR EACH ROW
BEGIN
insert into arquivos_log
set ação = 'update',
ID_Log = ID_Log,
Num_palavras = new.num_palavras;
END$$

USE `banco`$$
CREATE
DEFINER=`root`@`localhost`
TRIGGER `banco`.`tb_Trigger1`
BEFORE UPDATE ON `banco`.`arquivos`
FOR EACH ROW
BEGIN
 Insert Into Arquivos_Log
 Set ação = 'update',
 ID_Log = ID_Log,
 nome = NEW.nome,
 DATA_Mudança = now();
 END$$

USE `banco`$$
CREATE
DEFINER=`root`@`localhost`
TRIGGER `banco`.`tb_Trigger5`
BEFORE UPDATE ON `banco`.`arquivos`
FOR EACH ROW
BEGIN
 Insert Into Arquivos_Log
 Set ação = 'update',
 ID_Log = ID_Log,
 Data_arq = NEW.Data_arq,
 DATA_Mudança = now();
 END$$

USE `banco`$$
CREATE
DEFINER=`root`@`localhost`
TRIGGER `banco`.`tb_Trigger2`
BEFORE UPDATE ON `banco`.`imagem`
FOR EACH ROW
BEGIN
 Insert Into Arquivos_Log
 Set ação = 'update',
 ID_Log = ID_Log,
 DATA_Mudança = now();
 END$$

USE `banco`$$
CREATE
DEFINER=`root`@`localhost`
TRIGGER `banco`.`tb_Trigger4`
AFTER UPDATE ON `banco`.`imagem`
FOR EACH ROW
BEGIN
 Insert Into Arquivos_Log
 Set ação = 'update',
 ID_Log = ID_Log,
 DATA_Mudança = now();
 END$$

USE `banco`$$
CREATE
DEFINER=`root`@`localhost`
TRIGGER `banco`.`tb_Trigger3`
AFTER INSERT ON `banco`.`video`
FOR EACH ROW
BEGIN
 Insert Into Arquivos_Log
 Set ação = 'update',
 ID_Log = ID_Log,
 DATA_Mudança = now();
 END$$


DELIMITER ;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
