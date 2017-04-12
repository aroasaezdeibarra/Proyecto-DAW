-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema bdproyecto
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema bdproyecto
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `bdproyecto` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci ;
USE `bdproyecto` ;

-- -----------------------------------------------------
-- Table `bdproyecto`.`Acceso`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bdproyecto`.`Acceso` (
  `idUsuario` INT NOT NULL AUTO_INCREMENT,
  `usuario` VARCHAR(30) NOT NULL,
  `pass` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idUsuario`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bdproyecto`.`Centro`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bdproyecto`.`Centro` (
  `idCentro` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(30) NOT NULL,
  `calle` VARCHAR(45) NULL,
  `numero` VARCHAR(5) NULL,
  `cp` VARCHAR(6) NULL,
  `ciudad` VARCHAR(45) NULL,
  `provincia` VARCHAR(45) NULL,
  `tlf` VARCHAR(9) NULL,
  PRIMARY KEY (`idCentro`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bdproyecto`.`Trabajador`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bdproyecto`.`Trabajador` (
  `idTrabajador` INT NOT NULL AUTO_INCREMENT,
  `dni` INT NOT NULL,
  `nombre` VARCHAR(45) NOT NULL,
  `ape1` VARCHAR(45) NOT NULL,
  `ape2` VARCHAR(45) NOT NULL,
  `dir` VARCHAR(45) NULL,
  `tlfpers` VARCHAR(9) NULL,
  `tlfempr` VARCHAR(9) NOT NULL,
  `salario` INT NULL,
  `fnac` DATE NULL,
  `categoria` VARCHAR(45) NULL,
  `Accesos_idUsuario` INT NOT NULL,
  `Centros_idCentro` INT NOT NULL,
  PRIMARY KEY (`idTrabajador`, `Accesos_idUsuario`, `Centros_idCentro`),
  INDEX `fk_Trabajadores_Accesos_idx` (`Accesos_idUsuario` ASC),
  INDEX `fk_Trabajadores_Centros1_idx` (`Centros_idCentro` ASC),
  CONSTRAINT `fk_Trabajadores_Accesos`
    FOREIGN KEY (`Accesos_idUsuario`)
    REFERENCES `bdproyecto`.`Acceso` (`idUsuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Trabajadores_Centros1`
    FOREIGN KEY (`Centros_idCentro`)
    REFERENCES `bdproyecto`.`Centro` (`idCentro`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bdproyecto`.`Vehiculo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bdproyecto`.`Vehiculo` (
  `idVehiculo` INT NOT NULL,
  `matricula` VARCHAR(7) NOT NULL,
  `marca` VARCHAR(45) NOT NULL,
  `modelo` VARCHAR(45) NOT NULL,
  `kilometraje` VARCHAR(45) NOT NULL,
  `anyo` DATE NOT NULL,
  PRIMARY KEY (`idVehiculo`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bdproyecto`.`Parte`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bdproyecto`.`Parte` (
  `idParte` INT NOT NULL AUTO_INCREMENT,
  `kmInicio` INT NOT NULL,
  `kmFin` INT NOT NULL,
  `gasto` INT NULL,
  `incidencia` VARCHAR(45) NULL,
  `Trabajadores_idTrabajador` INT NOT NULL,
  `Vehiculo_idVehiculo` INT NOT NULL,
  PRIMARY KEY (`idParte`, `Vehiculo_idVehiculo`),
  INDEX `fk_Partes_Trabajadores1_idx` (`Trabajadores_idTrabajador` ASC),
  INDEX `fk_Parte_Vehiculo1_idx` (`Vehiculo_idVehiculo` ASC),
  CONSTRAINT `fk_Partes_Trabajadores1`
    FOREIGN KEY (`Trabajadores_idTrabajador`)
    REFERENCES `bdproyecto`.`Trabajador` (`idTrabajador`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Parte_Vehiculo1`
    FOREIGN KEY (`Vehiculo_idVehiculo`)
    REFERENCES `bdproyecto`.`Vehiculo` (`idVehiculo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bdproyecto`.`Viaje`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bdproyecto`.`Viaje` (
  `idViajes` INT NOT NULL AUTO_INCREMENT,
  `horaInicio` DATE NULL,
  `horaFin` DATE NULL,
  `Partes_idParte` INT NOT NULL,
  PRIMARY KEY (`idViajes`, `Partes_idParte`),
  INDEX `fk_Viajes_Partes1_idx` (`Partes_idParte` ASC),
  CONSTRAINT `fk_Viajes_Partes1`
    FOREIGN KEY (`Partes_idParte`)
    REFERENCES `bdproyecto`.`Parte` (`idParte`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bdproyecto`.`Aviso`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bdproyecto`.`Aviso` (
  `idAviso` INT NOT NULL,
  `descripcion` VARCHAR(100) NOT NULL,
  `solucionado` TINYINT(1) NOT NULL,
  PRIMARY KEY (`idAviso`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bdproyecto`.`Aviso_has_Trabajador`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bdproyecto`.`Aviso_has_Trabajador` (
  `Aviso_idAviso` INT NOT NULL,
  `Trabajadores_idTrabajador` INT NOT NULL,
  PRIMARY KEY (`Aviso_idAviso`, `Trabajadores_idTrabajador`),
  INDEX `fk_Aviso_has_Trabajadores_Trabajadores1_idx` (`Trabajadores_idTrabajador` ASC),
  INDEX `fk_Aviso_has_Trabajadores_Aviso1_idx` (`Aviso_idAviso` ASC),
  CONSTRAINT `fk_Aviso_has_Trabajadores_Aviso1`
    FOREIGN KEY (`Aviso_idAviso`)
    REFERENCES `bdproyecto`.`Aviso` (`idAviso`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Aviso_has_Trabajadores_Trabajadores1`
    FOREIGN KEY (`Trabajadores_idTrabajador`)
    REFERENCES `bdproyecto`.`Trabajador` (`idTrabajador`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;