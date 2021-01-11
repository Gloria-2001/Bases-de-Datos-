-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema park
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `park` ;

-- -----------------------------------------------------
-- Schema park
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `park` ;
USE `park` ;

-- -----------------------------------------------------
-- Table `park`.`parques`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `park`.`parques` (
  `nombre_parque` VARCHAR(100) NOT NULL,
  `horario` TIME NOT NULL,
  `capacidad` INT(10) NOT NULL,
  `ubicacion` VARCHAR(100) NULL,
  `idparques` INT(10) NOT NULL,
  PRIMARY KEY (`idparques`),
  UNIQUE INDEX `idparques_UNIQUE` (`idparques` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `park`.`hoteles`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `park`.`hoteles` (
  `nombre_hotel` VARCHAR(100) NOT NULL,
  `restaurantes` VARCHAR(100) NOT NULL,
  `idhotel` INT(10) NULL,
  PRIMARY KEY (`idhotel`),
  UNIQUE INDEX `idhotel_UNIQUE` (`idhotel` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `park`.`paquetes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `park`.`paquetes` (
  `nombre_paquete` VARCHAR(100) NOT NULL,
  `precio` DOUBLE NOT NULL,
  `idpaquete` INT(10) NOT NULL,
  PRIMARY KEY (`idpaquete`),
  UNIQUE INDEX `idpaquete_UNIQUE` (`idpaquete` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `park`.`parques_paquetes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `park`.`parques_paquetes` (
  `idparques` INT(10) NULL,
  `idpaquete` INT(10) NULL,
  PRIMARY KEY (`idparques`, `idpaquete`),
  CONSTRAINT `idparques `
    FOREIGN KEY ()
    REFERENCES `park`.`parques` ()
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `idpaquete`
    FOREIGN KEY ()
    REFERENCES `park`.`paquetes` ()
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `park`.`nacionalidad`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `park`.`nacionalidad` (
  `idNacionalidad` INT(10) NOT NULL,
  `nombreNacionalidad` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`idNacionalidad`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `park`.`cliente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `park`.`cliente` (
  `idCliente` INT(10) NOT NULL,
  `nombre` VARCHAR(100) NOT NULL,
  `apellido` VARCHAR(100) NOT NULL,
  `idNacionalidad` INT(10) NOT NULL,
  PRIMARY KEY (`idCliente`),
  INDEX `idNacionalidad_idx` (`idNacionalidad` ASC),
  CONSTRAINT `idNacionalidad`
    FOREIGN KEY (`idNacionalidad`)
    REFERENCES `park`.`nacionalidad` (`idNacionalidad`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `park`.`compra_boletos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `park`.`compra_boletos` (
  `no. boletos` INT NOT NULL,
  `precioUnitario` DOUBLE NOT NULL,
  `precioTotal` DOUBLE ZEROFILL NULL,
  `idpaquete` INT(10) NOT NULL,
  `idcompraBoleto` INT(10) NOT NULL,
  `idCliente` INT(10) NOT NULL,
  PRIMARY KEY (`idcompraBoleto`),
  UNIQUE INDEX `idcompra_UNIQUE` (`idcompraBoleto` ASC),
  INDEX `idpaquete _idx` (`idpaquete` ASC),
  INDEX `idCliente_idx` (`idCliente` ASC),
  CONSTRAINT `idpaquete `
    FOREIGN KEY (`idpaquete`)
    REFERENCES `park`.`paquetes` (`idpaquete`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `idCliente`
    FOREIGN KEY (`idCliente`)
    REFERENCES `park`.`cliente` (`idCliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `park`.`parques_boletos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `park`.`parques_boletos` (
  `idparques` INT(10) NULL,
  `idcompra` INT(10) NULL,
  `fecha` DATE NOT NULL,
  PRIMARY KEY (`idparques`, `idcompra`),
  CONSTRAINT `idparques`
    FOREIGN KEY ()
    REFERENCES `park`.`parques` ()
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `idcompra `
    FOREIGN KEY ()
    REFERENCES `park`.`compra_boletos` ()
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `park`.`compra_estadia`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `park`.`compra_estadia` (
  `idCompra` INT(10) NOT NULL,
  `tiempoHospedaje` TIME NOT NULL,
  `precioUnitario` DOUBLE NOT NULL,
  `precioTotal` DOUBLE NULL,
  `idpaquete` INT(10) NOT NULL,
  `idCliente` INT(10) NOT NULL,
  PRIMARY KEY (`idCompra`),
  INDEX `idpaquete_idx` (`idpaquete` ASC),
  INDEX `idCliente_idx` (`idCliente` ASC),
  CONSTRAINT `idpaquete`
    FOREIGN KEY (`idpaquete`)
    REFERENCES `park`.`paquetes` (`idpaquete`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `idCliente`
    FOREIGN KEY (`idCliente`)
    REFERENCES `park`.`cliente` (`idCliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `park`.`compra_hoteles`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `park`.`compra_hoteles` (
  `idhotel` INT(10) NOT NULL,
  `idCompra` INT(10) NOT NULL,
  `fecha` DATE NOT NULL,
  PRIMARY KEY (`idhotel`, `idCompra`),
  CONSTRAINT `idhotel`
    FOREIGN KEY ()
    REFERENCES `park`.`hoteles` ()
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `idCompra`
    FOREIGN KEY ()
    REFERENCES `park`.`compra_estadia` ()
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `park`.`evento`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `park`.`evento` (
  `idevento` INT(10) NOT NULL,
  `nombre_evento` VARCHAR(100) NOT NULL,
  `temporada` VARCHAR(45) NOT NULL,
  `idparques` INT(10) NOT NULL,
  PRIMARY KEY (`idevento`),
  INDEX `idparques_idx` (`idparques` ASC),
  CONSTRAINT `idparques`
    FOREIGN KEY (`idparques`)
    REFERENCES `park`.`parques` (`idparques`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `park`.`tipo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `park`.`tipo` (
  `idTipo` INT(10) NOT NULL,
  `nombreTipo` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`idTipo`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `park`.`complementos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `park`.`complementos` (
  `idComplementos` INT(10) NOT NULL,
  `nombreComplemento` VARCHAR(100) NOT NULL,
  `horarioComplemento` TIME NOT NULL,
  `idparques` INT(10) NOT NULL,
  `idTipo` INT(10) NOT NULL,
  PRIMARY KEY (`idComplementos`),
  INDEX `idparques_idx` (`idparques` ASC),
  INDEX `idTipo_idx` (`idTipo` ASC),
  CONSTRAINT `idparques`
    FOREIGN KEY (`idparques`)
    REFERENCES `park`.`parques` (`idparques`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `idTipo`
    FOREIGN KEY (`idTipo`)
    REFERENCES `park`.`tipo` (`idTipo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

USE `park` ;