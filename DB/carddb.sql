-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema cardsdb
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `cardsdb` ;

-- -----------------------------------------------------
-- Schema cardsdb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `cardsdb` DEFAULT CHARACTER SET utf8 ;
USE `cardsdb` ;

-- -----------------------------------------------------
-- Table `card`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `card` ;

CREATE TABLE IF NOT EXISTS `card` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `image_url` TEXT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;

SET SQL_MODE = '';
DROP USER IF EXISTS card@localhost;
SET SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';
CREATE USER 'card'@'localhost' IDENTIFIED BY 'card';

GRANT SELECT, INSERT, TRIGGER, UPDATE, DELETE ON TABLE * TO 'card'@'localhost';

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- -----------------------------------------------------
-- Data for table `card`
-- -----------------------------------------------------
START TRANSACTION;
USE `cardsdb`;
INSERT INTO `card` (`id`, `name`, `image_url`) VALUES (1, 'test', 'test');
INSERT INTO `card` (`id`, `name`, `image_url`) VALUES (2, 'test2', 'test2');

COMMIT;

