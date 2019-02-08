-- MySQL Script generated by MySQL Workbench
-- Fri Feb  8 11:07:05 2019
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema ece651
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema ece651
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `ece651` DEFAULT CHARACTER SET utf8 ;
USE `ece651` ;

-- -----------------------------------------------------
-- Table `ece651`.`Books`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ece651`.`Books` (
  `book_id` INT NOT NULL AUTO_INCREMENT,
  `title` VARCHAR(200) NOT NULL,
  `series` VARCHAR(200) NULL,
  `series_position` INT NULL,
  `pages` INT NULL,
  `publisher` VARCHAR(200) NULL,
  `orig_published_date` DATE NULL,
  `ISBN10` VARCHAR(10) NULL,
  `ISBN13` VARCHAR(15) NULL,
  `synopsis` TEXT NULL,
  PRIMARY KEY (`book_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ece651`.`Users`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ece651`.`Users` (
  `user_id` INT NOT NULL AUTO_INCREMENT,
  `display_name` VARCHAR(100) NOT NULL,
  `email` VARCHAR(200) NOT NULL,
  `password_hash` VARCHAR(65) NOT NULL,
  `password_salt` VARCHAR(50) NOT NULL,
  `creation_time` DATETIME NOT NULL DEFAULT now(),
  `preferences_json` TEXT NOT NULL DEFAULT '{}',
  PRIMARY KEY (`user_id`),
  UNIQUE INDEX `email_UNIQUE` (`email` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ece651`.`Categories`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ece651`.`Categories` (
  `categories_id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`categories_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ece651`.`Reviews`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ece651`.`Reviews` (
  `review_id` INT NOT NULL AUTO_INCREMENT,
  `user_id` INT NOT NULL,
  `book_id` INT NOT NULL,
  `rating` INT NOT NULL,
  `review` TEXT NULL,
  PRIMARY KEY (`review_id`),
  INDEX `book_id_fk_idx` (`book_id` ASC),
  INDEX `user_id_fk_idx` (`user_id` ASC),
  CONSTRAINT `book_id_fk`
    FOREIGN KEY (`book_id`)
    REFERENCES `ece651`.`Books` (`book_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `user_id_fk`
    FOREIGN KEY (`user_id`)
    REFERENCES `ece651`.`Users` (`user_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ece651`.`Book_Category`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ece651`.`Book_Category` (
  `book_id` INT NOT NULL,
  `category_id` INT NOT NULL,
  PRIMARY KEY (`book_id`, `category_id`),
  INDEX `category_id_fk_idx` (`category_id` ASC),
  CONSTRAINT `book_id_fk`
    FOREIGN KEY (`book_id`)
    REFERENCES `ece651`.`Books` (`book_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `category_id_fk`
    FOREIGN KEY (`category_id`)
    REFERENCES `ece651`.`Categories` (`categories_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ece651`.`AmazonDetails`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ece651`.`AmazonDetails` (
  `book_id` INT NOT NULL,
  `book_link` TEXT NOT NULL,
  `rating` DECIMAL NULL,
  `synopsis` TEXT NULL,
  `price` DECIMAL NULL,
  PRIMARY KEY (`book_id`),
  CONSTRAINT `book_id_fk`
    FOREIGN KEY (`book_id`)
    REFERENCES `ece651`.`Books` (`book_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ece651`.`Author`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ece651`.`Author` (
  `author_id` INT NOT NULL AUTO_INCREMENT,
  `last_name` VARCHAR(100) NOT NULL,
  `first_name` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`author_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ece651`.`AuthorBooks`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ece651`.`AuthorBooks` (
  `author_id` INT NOT NULL,
  `book_id` INT NOT NULL,
  PRIMARY KEY (`author_id`, `book_id`),
  INDEX `book_id_fk_idx` (`book_id` ASC),
  CONSTRAINT `author_id_fk`
    FOREIGN KEY (`author_id`)
    REFERENCES `ece651`.`Author` (`author_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `book_id_fk`
    FOREIGN KEY (`book_id`)
    REFERENCES `ece651`.`Books` (`book_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ece651`.`BookOfTheDay`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ece651`.`BookOfTheDay` (
  `idBookOfTheDay` INT NOT NULL AUTO_INCREMENT,
  `book_id` INT NOT NULL,
  `date` DATE NOT NULL,
  PRIMARY KEY (`idBookOfTheDay`),
  INDEX `book_id_fk_idx` (`book_id` ASC),
  CONSTRAINT `book_id_fk`
    FOREIGN KEY (`book_id`)
    REFERENCES `ece651`.`Books` (`book_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
