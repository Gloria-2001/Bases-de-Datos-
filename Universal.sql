-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema park
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `park` ;
SET GLOBAL time_zone = '-3:00';
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
  `horario` VARCHAR(100) NOT NULL,
  `ubicacion` VARCHAR(100) NULL,
  `idparques` INT(10) NOT NULL,
  PRIMARY KEY (`idparques`),
  UNIQUE INDEX `idparques_UNIQUE` (`idparques` ASC))
ENGINE = InnoDB;

insert into parques values
	("Universal Studios Florida","9:00-17:00","6000 Universal Blvd, Orlando, FL 32819, Estados Unidos",123),
    ("Universal's Islands of Adventure","10:00-18:00","Universal Blvd, Orlando, FL 32819, Estados Unidos",456),
    ("Universal's Volcano Bay","9:00-17:00","6000 Universal Blvd, Orlando, FL 32819, Estados Unidos",789),
    ("Universal CityWalk","8:00-22:00","6000 Universal Blvd, Orlando, FL 32819, Estados Unidos",012);
select * from parques;
-- -----------------------------------------------------
-- Table `park`.`hoteles`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `park`.`hoteles` (
  `nombre_hotel` VARCHAR(100) NOT NULL,
  `beneficios` VARCHAR(10000) NOT NULL,
  `idhotel` INT(10) NOT NULL,
  PRIMARY KEY (`idhotel`),
  UNIQUE INDEX `idhotel_UNIQUE` (`idhotel` ASC))
ENGINE = InnoDB;

insert into hoteles values
	("Universal's Cabana Bay Beach Resort","Encuentros de personajes,Piscina,Alquiler cabañas,Gimnasio,Sala de juegos",607),
    ("Loews Sapphire Falls Resort","Rum Dinner,Acceso a la playa,Piscina,Gimnasio,Servicio de bodas",608),
	("Universal’s Aventura Hotel","Restaurante,Gimnasio,Piscina,Zona azuatica para niños,Campamentos para niños",609),
    ("Loews Royal Pacific Resort","Piscina estilo laguna,Gimnasio,Ceremonia de antorchas,Servicio de bodas",610),
    ("Hard Rock Hotel","Conciertos,Escuchar musica bajo el agua,Museo del Rock,Gimnasio,Servicio de bodas",611),
    ("Loews Portofino Bay Hotel","Servicio de cabaña,Jacuzzi,Sala de juego,Tienda Italiana,Servicio de bodas,Spa",612),
    ("Universal’s Endless Summer Resort–Surfside Inn and Suites","Piscina,Gimnasio,Sala de juegos",613),
    ("Universal’s Endless Summer Resort-Dockside Inn and Suites","Piscina,Gimnasio,Sala de juegos",614);
select * from hoteles;
-- -----------------------------------------------------
-- Table `park`.`paquetes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `park`.`paquetes` (
  `nombre_paquete` VARCHAR(100) NOT NULL,
  `precio_dls_por_persona` DOUBLE NOT NULL,
  `idpaquete` INT(10) NOT NULL,
  `beneficios` VARCHAR(1000) NOT NULL,
  PRIMARY KEY (`idpaquete`),
  UNIQUE INDEX `idpaquete_UNIQUE` (`idpaquete` ASC))
ENGINE = InnoDB;

insert into paquetes values
	("Universal Express",69.99,450,"Incluye 1 parque,Evita filas"),
    ("Universal Express Unlimited",90.00,451,"Acceso ilimitado a todos los parques,Evita filas"),
    ("Volcano Bay Express",67.00,452,"Acceso ilimitado a 3 parques,Dura 14 dias"),
    ("Paquete vacacional exclusivo para The Wizarding World of Harry Potter",105.00,453,"Acceso a The Wizarding World of Harry Potter,Hospedaje 5 noches"),
    ("Paquete vacacional Premium",175.00,454,"Hospedaje 5 noches,Acceso a 2 parques"),
    ("Paquete Vacacional Exclusivo Star-Worthy de American Express",105.00,455,"Hospedaje 4 noches,Ahorro al comprar con American Express"),
    ("Pase anual 1",269.00,456,"Descuentos para Habitaciones del Hotel,Acceso a 2 parques"),
    ("Pase anual 2",319.00,457,"Descuentos para Habitaciones del Hotel,Acceso a 2 parques,Descuento en estacionamiento"),
    ("Pase anual 3",359.00,458,"Descuentos para Habitaciones del Hotel,Acceso a 2 parques,Descuento en estacionamiento y comidas"),
    ("Pase anual 4",509.00,459,"Entrada a todos los parques,Descuento en estacionamiento,Entrada temprana al parque,Descuento en habitaciones y comida");

select * from paquetes;
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
  `idparques` INT(10) NOT NULL,
  `idcompraBoleto` INT(10) NOT NULL,
  `fecha` DATE NOT NULL,
  PRIMARY KEY (`idparques`, `idcompraBoleto`),
  CONSTRAINT `idparques`
    FOREIGN KEY (`idparques`)
    REFERENCES `park`.`parques` (`idparques`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `idcompraBoleto`
    FOREIGN KEY (`idcompraBoleto`)
    REFERENCES `park`.`compra_boletos` (`idcompraBoleto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `park`.`compra_estadia`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `park`.`compra_estadia` (
  `idCompra` INT(10) NOT NULL,
  `tiempoHospedaje` VARCHAR(50) NOT NULL,
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
    FOREIGN KEY (`idhotel`)
    REFERENCES `park`.`hoteles` (`idhotel`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `idCompra`
    FOREIGN KEY (`idCompra`)
    REFERENCES `park`.`compra_estadia` (`idCompra`)
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
