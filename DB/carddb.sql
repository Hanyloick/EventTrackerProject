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
  `name` VARCHAR(200) NOT NULL,
  `type` VARCHAR(200) NULL,
  `cost` VARCHAR(100) NULL,
  `rarity` VARCHAR(45) NULL,
  `image_url` TEXT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `user`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `user` ;

CREATE TABLE IF NOT EXISTS `user` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `first_name` VARCHAR(50) NOT NULL,
  `last_name` VARCHAR(50) NOT NULL,
  `username` VARCHAR(45) NOT NULL,
  `password` VARCHAR(45) NOT NULL,
  `email` VARCHAR(100) NULL,
  `image_url` TEXT NULL,
  `balance` DECIMAL(8,2) UNSIGNED NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `card_condition`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `card_condition` ;

CREATE TABLE IF NOT EXISTS `card_condition` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `grade` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `purchase`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `purchase` ;

CREATE TABLE IF NOT EXISTS `purchase` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `amount` DECIMAL(6,2) UNSIGNED NOT NULL,
  `payment_date` DATETIME NULL,
  `user_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_purchase_user1_idx` (`user_id` ASC),
  CONSTRAINT `fk_purchase_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `inventory_item`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `inventory_item` ;

CREATE TABLE IF NOT EXISTS `inventory_item` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `price` DECIMAL(6,2) UNSIGNED NULL,
  `card_id` INT NOT NULL,
  `card_condition_id` INT UNSIGNED NOT NULL,
  `purchase_id` INT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_inventory_item_card1_idx` (`card_id` ASC),
  INDEX `fk_inventory_item_card_condition1_idx` (`card_condition_id` ASC),
  INDEX `fk_inventory_item_purchase1_idx` (`purchase_id` ASC),
  CONSTRAINT `fk_inventory_item_card1`
    FOREIGN KEY (`card_id`)
    REFERENCES `card` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_inventory_item_card_condition1`
    FOREIGN KEY (`card_condition_id`)
    REFERENCES `card_condition` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_inventory_item_purchase1`
    FOREIGN KEY (`purchase_id`)
    REFERENCES `purchase` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `user_deckbuilder`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `user_deckbuilder` ;

CREATE TABLE IF NOT EXISTS `user_deckbuilder` (
  `card_id` INT NOT NULL,
  `user_id` INT NOT NULL,
  PRIMARY KEY (`card_id`, `user_id`),
  INDEX `fk_card_has_user_user1_idx` (`user_id` ASC),
  INDEX `fk_card_has_user_card1_idx` (`card_id` ASC),
  CONSTRAINT `fk_card_has_user_card1`
    FOREIGN KEY (`card_id`)
    REFERENCES `card` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_card_has_user_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
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
INSERT INTO `card` (`id`, `name`, `type`, `cost`, `rarity`, `image_url`) VALUES (1, 'Armored Scrapgorger', 'Creature - Phyrexian Beast', '{1}{G}', 'Uncommon', 'https://s.deckbox.org/system/images/mtg/cards/2037310.jpg');
INSERT INTO `card` (`id`, `name`, `type`, `cost`, `rarity`, `image_url`) VALUES (2, 'Atraxa\'s Fall', 'Sorcery', '{1}{G}', 'Common', 'https://s.deckbox.org/system/images/mtg/cards/2040788.jpg');
INSERT INTO `card` (`id`, `name`, `type`, `cost`, `rarity`, `image_url`) VALUES (3, 'Beanstalk Giant // Fertile Footsteps', 'Creature - Giant // Sorcery - Adventure', '{6}{G} // {2}{G}', 'Uncommon', 'https://s.deckbox.org/system/images/mtg/cards/2005389.jpg');
INSERT INTO `card` (`id`, `name`, `type`, `cost`, `rarity`, `image_url`) VALUES (4, 'Beast Within', 'Instant', '{2}{G}', 'Uncommon', 'https://s.deckbox.org/system/images/mtg/cards/2016129.jpg');
INSERT INTO `card` (`id`, `name`, `type`, `cost`, `rarity`, `image_url`) VALUES (5, 'Blighted Woodland', 'Land', '', 'Uncommon', 'https://s.deckbox.org/system/images/mtg/cards/2016182.jpg');
INSERT INTO `card` (`id`, `name`, `type`, `cost`, `rarity`, `image_url`) VALUES (6, 'Boseiju Reaches Skyward // Branch of Boseiju', 'Enchantment - Saga // Enchantment Creature - Plant', '{3}{G}', 'Uncommon', 'https://s.deckbox.org/system/images/mtg/cards/2025666.jpg');
INSERT INTO `card` (`id`, `name`, `type`, `cost`, `rarity`, `image_url`) VALUES (7, 'Broken Bond', 'Sorcery', '{1}{G}', 'Common', 'https://s.deckbox.org/system/images/mtg/cards/443045.jpg');
INSERT INTO `card` (`id`, `name`, `type`, `cost`, `rarity`, `image_url`) VALUES (8, 'Broodhatch Nantuko', 'Creature - Insect Druid', '{1}{G}', 'Uncommon', 'https://s.deckbox.org/system/images/mtg/cards/442151.jpg');
INSERT INTO `card` (`id`, `name`, `type`, `cost`, `rarity`, `image_url`) VALUES (9, 'Bushwhack', 'Sorcery', '{G}', 'Uncommon', 'https://s.deckbox.org/system/images/mtg/cards/2033517.jpg');
INSERT INTO `card` (`id`, `name`, `type`, `cost`, `rarity`, `image_url`) VALUES (10, 'Colossification', 'Enchantment - Aura', '{5}{G}{G}', 'Rare', 'https://s.deckbox.org/system/images/mtg/cards/2011669.jpg');
INSERT INTO `card` (`id`, `name`, `type`, `cost`, `rarity`, `image_url`) VALUES (11, 'Conduit of Worlds', 'Artifact', '{2}{G}{G}', 'Rare', 'https://s.deckbox.org/system/images/mtg/cards/2037315.jpg');
INSERT INTO `card` (`id`, `name`, `type`, `cost`, `rarity`, `image_url`) VALUES (12, 'Conjurer\'s Closet', 'Artifact', '{5}', 'Rare', 'https://s.deckbox.org/system/images/mtg/cards/240030.jpg');
INSERT INTO `card` (`id`, `name`, `type`, `cost`, `rarity`, `image_url`) VALUES (13, 'Crash the Party', 'Instant', '{5}{G}', 'Rare', 'https://s.deckbox.org/system/images/mtg/cards/2027120.jpg');
INSERT INTO `card` (`id`, `name`, `type`, `cost`, `rarity`, `image_url`) VALUES (14, 'Cultivate', 'Sorcery', '{2}{G}', 'Common', 'https://s.deckbox.org/system/images/mtg/cards/2016130.jpg');
INSERT INTO `card` (`id`, `name`, `type`, `cost`, `rarity`, `image_url`) VALUES (15, 'Deeproot Wayfinder', 'Creature - Merfolk Scout', '{1}{G}', 'Rare', 'https://s.deckbox.org/system/images/mtg/cards/2040797.jpg');
INSERT INTO `card` (`id`, `name`, `type`, `cost`, `rarity`, `image_url`) VALUES (16, 'Defiler of Vigor', 'Creature - Phyrexian Wurm', '{3}{G}{G}', 'Rare', 'https://s.deckbox.org/system/images/mtg/cards/2030557.jpg');
INSERT INTO `card` (`id`, `name`, `type`, `cost`, `rarity`, `image_url`) VALUES (17, 'Drownyard Temple', 'Land', '', 'Rare', 'https://s.deckbox.org/system/images/mtg/cards/470786.jpg');
INSERT INTO `card` (`id`, `name`, `type`, `cost`, `rarity`, `image_url`) VALUES (18, 'Druid\'s Call', 'Enchantment - Aura', '{1}{G}', 'Uncommon', 'https://s.deckbox.org/system/images/mtg/cards/31826.jpg');
INSERT INTO `card` (`id`, `name`, `type`, `cost`, `rarity`, `image_url`) VALUES (19, 'Eternal Witness', 'Creature - Human Shaman', '{1}{G}{G}', 'Uncommon', 'https://s.deckbox.org/system/images/mtg/cards/2016131.jpg');
INSERT INTO `card` (`id`, `name`, `type`, `cost`, `rarity`, `image_url`) VALUES (20, 'Evolving Adaptive', 'Creature - Phyrexian Warrior', '{G}', 'Uncommon', 'https://s.deckbox.org/system/images/mtg/cards/2037319.jpg');
INSERT INTO `card` (`id`, `name`, `type`, `cost`, `rarity`, `image_url`) VALUES (21, 'Exponential Growth', 'Sorcery', '{X}{X}{G}{G}', 'Rare', 'https://s.deckbox.org/system/images/mtg/cards/2018065.jpg');
INSERT INTO `card` (`id`, `name`, `type`, `cost`, `rarity`, `image_url`) VALUES (22, 'Fertile Thicket', 'Land', '', 'Common', 'https://s.deckbox.org/system/images/mtg/cards/401879.jpg');
INSERT INTO `card` (`id`, `name`, `type`, `cost`, `rarity`, `image_url`) VALUES (23, 'Forest', 'Basic Land - Forest', '', 'BasicLand', 'https://s.deckbox.org/system/images/mtg/cards/2016216.jpg');
INSERT INTO `card` (`id`, `name`, `type`, `cost`, `rarity`, `image_url`) VALUES (24, 'Getaway Car', 'Artifact - Vehicle', '{3}', 'Rare', 'https://s.deckbox.org/system/images/mtg/cards/2026684.jpg');
INSERT INTO `card` (`id`, `name`, `type`, `cost`, `rarity`, `image_url`) VALUES (25, 'Ghalta, Primal Hunger', 'Legendary Creature - Elder Dinosaur', '{10}{G}{G}', 'Rare', 'https://s.deckbox.org/system/images/mtg/cards/439787.jpg');
INSERT INTO `card` (`id`, `name`, `type`, `cost`, `rarity`, `image_url`) VALUES (26, 'Gigantosaurus', 'Creature - Dinosaur', '{G}{G}{G}{G}{G}', 'Rare', 'https://s.deckbox.org/system/images/mtg/cards/447321.jpg');
INSERT INTO `card` (`id`, `name`, `type`, `cost`, `rarity`, `image_url`) VALUES (27, 'Goreclaw, Terror of Qal Sisma', 'Legendary Creature - Bear', '{3}{G}', 'Rare', 'https://s.deckbox.org/system/images/mtg/cards/447322.jpg');
INSERT INTO `card` (`id`, `name`, `type`, `cost`, `rarity`, `image_url`) VALUES (28, 'Green Sun\'s Twilight', 'Sorcery', '{X}{G}', 'Rare', 'https://s.deckbox.org/system/images/mtg/cards/2037321.jpg');
INSERT INTO `card` (`id`, `name`, `type`, `cost`, `rarity`, `image_url`) VALUES (29, 'Grothama, All-Devouring', 'Legendary Creature - Wurm', '{3}{G}{G}', 'MythicRare', 'https://s.deckbox.org/system/images/mtg/cards/446039.jpg');
INSERT INTO `card` (`id`, `name`, `type`, `cost`, `rarity`, `image_url`) VALUES (30, 'Helm of the Host', 'Legendary Artifact - Equipment', '{4}', 'Rare', 'https://s.deckbox.org/system/images/mtg/cards/443105.jpg');
INSERT INTO `card` (`id`, `name`, `type`, `cost`, `rarity`, `image_url`) VALUES (31, 'Howlpack Piper // Wildsong Howler', 'Creature - Human Werewolf // Creature - Werewolf', '{3}{G}', 'Rare', 'https://s.deckbox.org/system/images/mtg/cards/2023880.jpg');
INSERT INTO `card` (`id`, `name`, `type`, `cost`, `rarity`, `image_url`) VALUES (32, 'Impervious Greatwurm', 'Creature - Wurm', '{7}{G}{G}{G}', 'MythicRare', 'https://s.deckbox.org/system/images/mtg/cards/455613.jpg');
INSERT INTO `card` (`id`, `name`, `type`, `cost`, `rarity`, `image_url`) VALUES (33, 'Inscription of Abundance', 'Instant', '{1}{G}', 'Rare', 'https://s.deckbox.org/system/images/mtg/cards/2014730.jpg');
INSERT INTO `card` (`id`, `name`, `type`, `cost`, `rarity`, `image_url`) VALUES (34, 'Invasion of Ikoria // Zilortha, Apex of Ikoria', 'Battle - Siege // Legendary Creature - Dinosaur', '{X}{G}{G}', 'Rare', 'https://s.deckbox.org/system/images/mtg/cards/2040805.jpg');
INSERT INTO `card` (`id`, `name`, `type`, `cost`, `rarity`, `image_url`) VALUES (35, 'Invasion of Shandalar // Leyline Surge', 'Battle - Siege // Enchantment', '{3}{G}{G}', 'MythicRare', 'https://s.deckbox.org/system/images/mtg/cards/2040811.jpg');
INSERT INTO `card` (`id`, `name`, `type`, `cost`, `rarity`, `image_url`) VALUES (36, 'Invasion of Zendikar // Awakened Skyclave', 'Battle - Siege // Creature - Elemental', '{3}{G}', 'Uncommon', 'https://s.deckbox.org/system/images/mtg/cards/2040813.jpg');
INSERT INTO `card` (`id`, `name`, `type`, `cost`, `rarity`, `image_url`) VALUES (37, 'Llanowar Elves', 'Creature - Elf Druid', '{G}', 'Common', 'https://s.deckbox.org/system/images/mtg/cards/450261.jpg');
INSERT INTO `card` (`id`, `name`, `type`, `cost`, `rarity`, `image_url`) VALUES (38, 'Molimo, Maro-Sorcerer', 'Legendary Creature - Elemental', '{4}{G}{G}{G}', 'Rare', 'https://s.deckbox.org/system/images/mtg/cards/2016136.jpg');
INSERT INTO `card` (`id`, `name`, `type`, `cost`, `rarity`, `image_url`) VALUES (39, 'Mossbridge Troll', 'Creature - Troll', '{5}{G}{G}', 'Rare', 'https://s.deckbox.org/system/images/mtg/cards/146021.jpg');
INSERT INTO `card` (`id`, `name`, `type`, `cost`, `rarity`, `image_url`) VALUES (40, 'Obscuring Haze', 'Instant', '{2}{G}', 'Rare', 'https://s.deckbox.org/system/images/mtg/cards/2012058.jpg');
INSERT INTO `card` (`id`, `name`, `type`, `cost`, `rarity`, `image_url`) VALUES (41, 'Perennial Behemoth', 'Artifact Creature - Beast', '{5}', 'Rare', 'https://s.deckbox.org/system/images/mtg/cards/2033545.jpg');
INSERT INTO `card` (`id`, `name`, `type`, `cost`, `rarity`, `image_url`) VALUES (42, 'Psychosis Crawler', 'Artifact Creature - Phyrexian Horror', '{5}', 'Rare', 'https://s.deckbox.org/system/images/mtg/cards/2012245.jpg');
INSERT INTO `card` (`id`, `name`, `type`, `cost`, `rarity`, `image_url`) VALUES (43, 'Realmbreaker, the Invasion Tree', 'Legendary Artifact', '{3}', 'Rare', 'https://s.deckbox.org/system/images/mtg/cards/2040898.jpg');
INSERT INTO `card` (`id`, `name`, `type`, `cost`, `rarity`, `image_url`) VALUES (44, 'Reliquary Tower', 'Land', '', 'Uncommon', 'https://s.deckbox.org/system/images/mtg/cards/2016194.jpg');
INSERT INTO `card` (`id`, `name`, `type`, `cost`, `rarity`, `image_url`) VALUES (45, 'Rishkar\'s Expertise', 'Sorcery', '{4}{G}{G}', 'Rare', 'https://s.deckbox.org/system/images/mtg/cards/423790.jpg');
INSERT INTO `card` (`id`, `name`, `type`, `cost`, `rarity`, `image_url`) VALUES (46, 'Sakura-Tribe Elder', 'Creature - Snake Shaman', '{1}{G}', 'Common', 'https://s.deckbox.org/system/images/mtg/cards/2012184.jpg');
INSERT INTO `card` (`id`, `name`, `type`, `cost`, `rarity`, `image_url`) VALUES (47, 'Sanctum of Eternity', 'Land', '', 'Rare', 'https://s.deckbox.org/system/images/mtg/cards/470605.jpg');
INSERT INTO `card` (`id`, `name`, `type`, `cost`, `rarity`, `image_url`) VALUES (48, 'Sandwurm Convergence', 'Enchantment', '{6}{G}{G}', 'Rare', 'https://s.deckbox.org/system/images/mtg/cards/426885.jpg');
INSERT INTO `card` (`id`, `name`, `type`, `cost`, `rarity`, `image_url`) VALUES (49, 'Shigeki, Jukai Visionary', 'Legendary Enchantment Creature - Snake Druid', '{1}{G}', 'Rare', 'https://s.deckbox.org/system/images/mtg/cards/2025698.jpg');
INSERT INTO `card` (`id`, `name`, `type`, `cost`, `rarity`, `image_url`) VALUES (50, 'Siege Behemoth', 'Creature - Beast', '{5}{G}{G}', 'Rare', 'https://s.deckbox.org/system/images/mtg/cards/389670.jpg');
INSERT INTO `card` (`id`, `name`, `type`, `cost`, `rarity`, `image_url`) VALUES (51, 'Silverback Elder', 'Creature - Ape Shaman', '{2}{G}{G}{G}', 'MythicRare', 'https://s.deckbox.org/system/images/mtg/cards/2030574.jpg');
INSERT INTO `card` (`id`, `name`, `type`, `cost`, `rarity`, `image_url`) VALUES (52, 'Sol Ring', 'Artifact', '{1}', 'Uncommon', 'https://s.deckbox.org/system/images/mtg/cards/2016178.jpg');
INSERT INTO `card` (`id`, `name`, `type`, `cost`, `rarity`, `image_url`) VALUES (53, 'Spearbreaker Behemoth', 'Creature - Beast', '{5}{G}{G}', 'Rare', 'https://s.deckbox.org/system/images/mtg/cards/174916.jpg');
INSERT INTO `card` (`id`, `name`, `type`, `cost`, `rarity`, `image_url`) VALUES (54, 'Splendid Reclamation', 'Sorcery', '{3}{G}', 'Rare', 'https://s.deckbox.org/system/images/mtg/cards/414474.jpg');
INSERT INTO `card` (`id`, `name`, `type`, `cost`, `rarity`, `image_url`) VALUES (55, 'Stuffy Doll', 'Artifact Creature - Construct', '{5}', 'Rare', 'https://s.deckbox.org/system/images/mtg/cards/279711.jpg');
INSERT INTO `card` (`id`, `name`, `type`, `cost`, `rarity`, `image_url`) VALUES (56, 'Tamiyo\'s Safekeeping', 'Instant', '{G}', 'Common', 'https://s.deckbox.org/system/images/mtg/cards/2025704.jpg');
INSERT INTO `card` (`id`, `name`, `type`, `cost`, `rarity`, `image_url`) VALUES (57, 'Tandem Takedown', 'Instant', '{1}{G}{G}', 'Uncommon', 'https://s.deckbox.org/system/images/mtg/cards/2040829.jpg');
INSERT INTO `card` (`id`, `name`, `type`, `cost`, `rarity`, `image_url`) VALUES (58, 'Temur Sabertooth', 'Creature - Cat', '{2}{G}{G}', 'Uncommon', 'https://s.deckbox.org/system/images/mtg/cards/433091.jpg');
INSERT INTO `card` (`id`, `name`, `type`, `cost`, `rarity`, `image_url`) VALUES (59, 'Thorn Mammoth', 'Creature - Elephant', '{5}{G}{G}', 'Rare', 'https://s.deckbox.org/system/images/mtg/cards/2005563.jpg');
INSERT INTO `card` (`id`, `name`, `type`, `cost`, `rarity`, `image_url`) VALUES (60, 'Thunderfoot Baloth', 'Creature - Beast', '{4}{G}{G}', 'Rare', 'https://s.deckbox.org/system/images/mtg/cards/420789.jpg');
INSERT INTO `card` (`id`, `name`, `type`, `cost`, `rarity`, `image_url`) VALUES (61, 'Topiary Stomper', 'Creature - Plant Dinosaur', '{1}{G}{G}', 'Rare', 'https://s.deckbox.org/system/images/mtg/cards/2026607.jpg');
INSERT INTO `card` (`id`, `name`, `type`, `cost`, `rarity`, `image_url`) VALUES (62, 'Traverse the Outlands', 'Sorcery', '{4}{G}', 'Rare', 'https://s.deckbox.org/system/images/mtg/cards/433275.jpg');
INSERT INTO `card` (`id`, `name`, `type`, `cost`, `rarity`, `image_url`) VALUES (63, 'Unnatural Growth', 'Enchantment', '{1}{G}{G}{G}{G}', 'Rare', 'https://s.deckbox.org/system/images/mtg/cards/2022538.jpg');
INSERT INTO `card` (`id`, `name`, `type`, `cost`, `rarity`, `image_url`) VALUES (64, 'Vastwood Surge', 'Sorcery', '{3}{G}', 'Uncommon', 'https://s.deckbox.org/system/images/mtg/cards/2014766.jpg');
INSERT INTO `card` (`id`, `name`, `type`, `cost`, `rarity`, `image_url`) VALUES (65, 'Verdant Rebirth', 'Instant', '{1}{G}', 'Uncommon', 'https://s.deckbox.org/system/images/mtg/cards/435368.jpg');
INSERT INTO `card` (`id`, `name`, `type`, `cost`, `rarity`, `image_url`) VALUES (66, 'Verdant Sun\'s Avatar', 'Creature - Dinosaur Avatar', '{5}{G}{G}', 'Rare', 'https://s.deckbox.org/system/images/mtg/cards/2016145.jpg');
INSERT INTO `card` (`id`, `name`, `type`, `cost`, `rarity`, `image_url`) VALUES (67, 'Vigor', 'Creature - Elemental Incarnation', '{3}{G}{G}{G}', 'Rare', 'https://s.deckbox.org/system/images/mtg/cards/446183.jpg');
INSERT INTO `card` (`id`, `name`, `type`, `cost`, `rarity`, `image_url`) VALUES (68, 'Vorinclex // The Grand Evolution', 'Legendary Creature - Phyrexian Praetor // Enchantment - Saga', '{3}{G}{G}', 'MythicRare', 'https://s.deckbox.org/system/images/mtg/cards/2040834.jpg');
INSERT INTO `card` (`id`, `name`, `type`, `cost`, `rarity`, `image_url`) VALUES (69, 'Witch\'s Clinic', 'Land', '', 'Rare', 'https://s.deckbox.org/system/images/mtg/cards/2018524.jpg');
INSERT INTO `card` (`id`, `name`, `type`, `cost`, `rarity`, `image_url`) VALUES (70, 'Wood Elves', 'Creature - Elf Scout', '{2}{G}', 'Common', 'https://s.deckbox.org/system/images/mtg/cards/405454.jpg');
INSERT INTO `card` (`id`, `name`, `type`, `cost`, `rarity`, `image_url`) VALUES (71, 'Zopandrel, Hunger Dominus', 'Legendary Creature - Phyrexian Horror', '{5}{G}{G}', 'MythicRare', 'https://s.deckbox.org/system/images/mtg/cards/2037347.jpg');
INSERT INTO `card` (`id`, `name`, `type`, `cost`, `rarity`, `image_url`) VALUES (72, 'Ao, the Dawn Sky', 'Legendary Creature - Dragon Spirit', '{3}{W}{W}', 'MythicRare', 'https://s.deckbox.org/system/images/mtg/cards/2025475.jpg');
INSERT INTO `card` (`id`, `name`, `type`, `cost`, `rarity`, `image_url`) VALUES (73, 'Auriok Champion', 'Creature - Human Cleric', '{W}{W}', 'Rare', 'https://s.deckbox.org/system/images/mtg/cards/2000396.jpg');
INSERT INTO `card` (`id`, `name`, `type`, `cost`, `rarity`, `image_url`) VALUES (74, 'Austere Command', 'Sorcery', '{4}{W}{W}', 'Rare', 'https://s.deckbox.org/system/images/mtg/cards/2015718.jpg');
INSERT INTO `card` (`id`, `name`, `type`, `cost`, `rarity`, `image_url`) VALUES (75, 'Authority of the Consuls', 'Enchantment', '{W}', 'Rare', 'https://s.deckbox.org/system/images/mtg/cards/417578.jpg');
INSERT INTO `card` (`id`, `name`, `type`, `cost`, `rarity`, `image_url`) VALUES (76, 'Baneslayer Angel', 'Creature - Angel', '{3}{W}{W}', 'MythicRare', 'https://s.deckbox.org/system/images/mtg/cards/401633.jpg');
INSERT INTO `card` (`id`, `name`, `type`, `cost`, `rarity`, `image_url`) VALUES (77, 'Basri Ket', 'Legendary Planeswalker - Basri', '{1}{W}{W}', 'MythicRare', 'https://s.deckbox.org/system/images/mtg/cards/2012453.jpg');
INSERT INTO `card` (`id`, `name`, `type`, `cost`, `rarity`, `image_url`) VALUES (78, 'Castle Ardenvale', 'Land', '', 'Rare', 'https://s.deckbox.org/system/images/mtg/cards/2005478.jpg');
INSERT INTO `card` (`id`, `name`, `type`, `cost`, `rarity`, `image_url`) VALUES (79, 'Daxos, Blessed by the Sun', 'Legendary Enchantment Creature - Demigod', '{W}{W}', 'Uncommon', 'https://s.deckbox.org/system/images/mtg/cards/476260.jpg');
INSERT INTO `card` (`id`, `name`, `type`, `cost`, `rarity`, `image_url`) VALUES (80, 'Day of Judgment', 'Sorcery', '{2}{W}{W}', 'Rare', 'https://s.deckbox.org/system/images/mtg/cards/220139.jpg');
INSERT INTO `card` (`id`, `name`, `type`, `cost`, `rarity`, `image_url`) VALUES (81, 'Eiganjo, Seat of the Empire', 'Legendary Land', '', 'Rare', 'https://s.deckbox.org/system/images/mtg/cards/2025764.jpg');
INSERT INTO `card` (`id`, `name`, `type`, `cost`, `rarity`, `image_url`) VALUES (82, 'Flawless Maneuver', 'Instant', '{2}{W}', 'Rare', 'https://s.deckbox.org/system/images/mtg/cards/2012023.jpg');
INSERT INTO `card` (`id`, `name`, `type`, `cost`, `rarity`, `image_url`) VALUES (83, 'Frontline Medic', 'Creature - Human Cleric', '{2}{W}', 'Rare', 'https://s.deckbox.org/system/images/mtg/cards/2012086.jpg');
INSERT INTO `card` (`id`, `name`, `type`, `cost`, `rarity`, `image_url`) VALUES (84, 'Fumigate', 'Sorcery', '{3}{W}{W}', 'Rare', 'https://s.deckbox.org/system/images/mtg/cards/417588.jpg');
INSERT INTO `card` (`id`, `name`, `type`, `cost`, `rarity`, `image_url`) VALUES (85, 'Grateful Apparition', 'Creature - Spirit', '{1}{W}', 'Uncommon', 'https://s.deckbox.org/system/images/mtg/cards/460944.jpg');
INSERT INTO `card` (`id`, `name`, `type`, `cost`, `rarity`, `image_url`) VALUES (86, 'Heliod, God of the Sun', 'Legendary Enchantment Creature - God', '{3}{W}', 'MythicRare', 'https://s.deckbox.org/system/images/mtg/cards/373524.jpg');
INSERT INTO `card` (`id`, `name`, `type`, `cost`, `rarity`, `image_url`) VALUES (87, 'Heliod, Sun-Crowned', 'Legendary Enchantment Creature - God', '{2}{W}', 'MythicRare', 'https://s.deckbox.org/system/images/mtg/cards/476269.jpg');
INSERT INTO `card` (`id`, `name`, `type`, `cost`, `rarity`, `image_url`) VALUES (88, 'Hour of Revelation', 'Sorcery', '{3}{W}{W}{W}', 'Rare', 'https://s.deckbox.org/system/images/mtg/cards/430704.jpg');
INSERT INTO `card` (`id`, `name`, `type`, `cost`, `rarity`, `image_url`) VALUES (89, 'Karn\'s Bastion', 'Land', '', 'Rare', 'https://s.deckbox.org/system/images/mtg/cards/461175.jpg');
INSERT INTO `card` (`id`, `name`, `type`, `cost`, `rarity`, `image_url`) VALUES (90, 'Knight of the White Orchid', 'Creature - Human Knight', '{W}{W}', 'Rare', 'https://s.deckbox.org/system/images/mtg/cards/2012090.jpg');
INSERT INTO `card` (`id`, `name`, `type`, `cost`, `rarity`, `image_url`) VALUES (91, 'Linden, the Steadfast Queen', 'Legendary Creature - Human Noble', '{W}{W}{W}', 'Rare', 'https://s.deckbox.org/system/images/mtg/cards/2005260.jpg');
INSERT INTO `card` (`id`, `name`, `type`, `cost`, `rarity`, `image_url`) VALUES (92, 'Luminous Broodmoth', 'Creature - Insect', '{2}{W}{W}', 'MythicRare', 'https://s.deckbox.org/system/images/mtg/cards/2011542.jpg');
INSERT INTO `card` (`id`, `name`, `type`, `cost`, `rarity`, `image_url`) VALUES (93, 'Lunarch Veteran // Luminous Phantom', 'Creature - Human Cleric // Creature - Spirit Cleric', '{W}', 'Common', 'https://s.deckbox.org/system/images/mtg/cards/2022324.jpg');
INSERT INTO `card` (`id`, `name`, `type`, `cost`, `rarity`, `image_url`) VALUES (94, 'Magus of the Disk', 'Creature - Human Wizard', '{2}{W}{W}', 'Rare', 'https://s.deckbox.org/system/images/mtg/cards/2012091.jpg');
INSERT INTO `card` (`id`, `name`, `type`, `cost`, `rarity`, `image_url`) VALUES (95, 'Mangara, the Diplomat', 'Legendary Creature - Human Cleric', '{3}{W}', 'MythicRare', 'https://s.deckbox.org/system/images/mtg/cards/2012473.jpg');
INSERT INTO `card` (`id`, `name`, `type`, `cost`, `rarity`, `image_url`) VALUES (96, 'Marble Diamond', 'Artifact', '{2}', 'Common', 'https://s.deckbox.org/system/images/mtg/cards/2016029.jpg');
INSERT INTO `card` (`id`, `name`, `type`, `cost`, `rarity`, `image_url`) VALUES (97, 'Mutavault', 'Land', '', 'Rare', 'https://s.deckbox.org/system/images/mtg/cards/370733.jpg');
INSERT INTO `card` (`id`, `name`, `type`, `cost`, `rarity`, `image_url`) VALUES (98, 'Pearl Medallion', 'Artifact', '{2}', 'Rare', 'https://s.deckbox.org/system/images/mtg/cards/4620.jpg');
INSERT INTO `card` (`id`, `name`, `type`, `cost`, `rarity`, `image_url`) VALUES (99, 'Plains', 'Basic Land - Plains', '', 'BasicLand', 'https://s.deckbox.org/system/images/mtg/cards/2016210.jpg');
INSERT INTO `card` (`id`, `name`, `type`, `cost`, `rarity`, `image_url`) VALUES (100, 'Resplendent Angel', 'Creature - Angel', '{1}{W}{W}', 'MythicRare', 'https://s.deckbox.org/system/images/mtg/cards/447170.jpg');
INSERT INTO `card` (`id`, `name`, `type`, `cost`, `rarity`, `image_url`) VALUES (101, 'Selfless Spirit', 'Creature - Spirit Cleric', '{1}{W}', 'Rare', 'https://s.deckbox.org/system/images/mtg/cards/414332.jpg');
INSERT INTO `card` (`id`, `name`, `type`, `cost`, `rarity`, `image_url`) VALUES (102, 'Shadowspear', 'Legendary Artifact - Equipment', '{1}', 'Rare', 'https://s.deckbox.org/system/images/mtg/cards/476487.jpg');
INSERT INTO `card` (`id`, `name`, `type`, `cost`, `rarity`, `image_url`) VALUES (103, 'Soul Warden', 'Creature - Human Cleric', '{W}', 'Common', 'https://s.deckbox.org/system/images/mtg/cards/425849.jpg');
INSERT INTO `card` (`id`, `name`, `type`, `cost`, `rarity`, `image_url`) VALUES (104, 'Soul\'s Attendant', 'Creature - Human Cleric', '{W}', 'Common', 'https://s.deckbox.org/system/images/mtg/cards/193499.jpg');
INSERT INTO `card` (`id`, `name`, `type`, `cost`, `rarity`, `image_url`) VALUES (105, 'Speaker of the Heavens', 'Creature - Human Cleric', '{W}', 'Rare', 'https://s.deckbox.org/system/images/mtg/cards/2012484.jpg');
INSERT INTO `card` (`id`, `name`, `type`, `cost`, `rarity`, `image_url`) VALUES (106, 'Taranika, Akroan Veteran', 'Legendary Creature - Human Soldier', '{1}{W}{W}', 'Rare', 'https://s.deckbox.org/system/images/mtg/cards/476290.jpg');
INSERT INTO `card` (`id`, `name`, `type`, `cost`, `rarity`, `image_url`) VALUES (107, 'Teferi\'s Protection', 'Instant', '{2}{W}', 'Rare', 'https://s.deckbox.org/system/images/mtg/cards/433249.jpg');
INSERT INTO `card` (`id`, `name`, `type`, `cost`, `rarity`, `image_url`) VALUES (108, 'The Book of Exalted Deeds', 'Legendary Artifact', '{W}{W}{W}', 'MythicRare', 'https://s.deckbox.org/system/images/mtg/cards/2020542.jpg');
INSERT INTO `card` (`id`, `name`, `type`, `cost`, `rarity`, `image_url`) VALUES (109, 'The Wandering Emperor', 'Legendary Planeswalker', '{2}{W}{W}', 'MythicRare', 'https://s.deckbox.org/system/images/mtg/cards/2025520.jpg');
INSERT INTO `card` (`id`, `name`, `type`, `cost`, `rarity`, `image_url`) VALUES (110, 'Voice of the Blessed', 'Creature - Spirit Cleric', '{W}{W}', 'Rare', 'https://s.deckbox.org/system/images/mtg/cards/2023690.jpg');
INSERT INTO `card` (`id`, `name`, `type`, `cost`, `rarity`, `image_url`) VALUES (111, 'White Sun\'s Twilight', 'Sorcery', '{X}{W}{W}', 'Rare', 'https://s.deckbox.org/system/images/mtg/cards/2037190.jpg');
INSERT INTO `card` (`id`, `name`, `type`, `cost`, `rarity`, `image_url`) VALUES (112, 'Wrath of God', 'Sorcery', '{2}{W}{W}', 'Rare', 'https://s.deckbox.org/system/images/mtg/cards/129808.jpg');
INSERT INTO `card` (`id`, `name`, `type`, `cost`, `rarity`, `image_url`) VALUES (113, 'Arcane Signet', 'Artifact', '{2}', 'Uncommon', 'https://s.deckbox.org/system/images/mtg/cards/2016003.jpg');
INSERT INTO `card` (`id`, `name`, `type`, `cost`, `rarity`, `image_url`) VALUES (114, 'Atarka, World Render', 'Legendary Creature - Dragon', '{5}{R}{G}', 'Rare', 'https://s.deckbox.org/system/images/mtg/cards/433093.jpg');
INSERT INTO `card` (`id`, `name`, `type`, `cost`, `rarity`, `image_url`) VALUES (115, 'Banefire', 'Sorcery', '{X}{R}', 'Rare', 'https://s.deckbox.org/system/images/mtg/cards/447266.jpg');
INSERT INTO `card` (`id`, `name`, `type`, `cost`, `rarity`, `image_url`) VALUES (116, 'Binding the Old Gods', 'Enchantment - Saga', '{2}{B}{G}', 'Uncommon', 'https://s.deckbox.org/system/images/mtg/cards/2017003.jpg');
INSERT INTO `card` (`id`, `name`, `type`, `cost`, `rarity`, `image_url`) VALUES (117, 'Blackcleave Cliffs', 'Land', '', 'Rare', 'https://s.deckbox.org/system/images/mtg/cards/209401.jpg');
INSERT INTO `card` (`id`, `name`, `type`, `cost`, `rarity`, `image_url`) VALUES (118, 'Blightning', 'Sorcery', '{1}{B}{R}', 'Uncommon', 'https://s.deckbox.org/system/images/mtg/cards/442187.jpg');
INSERT INTO `card` (`id`, `name`, `type`, `cost`, `rarity`, `image_url`) VALUES (119, 'Breath of Darigaaz', 'Sorcery', '{1}{R}', 'Uncommon', 'https://s.deckbox.org/system/images/mtg/cards/446824.jpg');
INSERT INTO `card` (`id`, `name`, `type`, `cost`, `rarity`, `image_url`) VALUES (120, 'Broodmate Dragon', 'Creature - Dragon', '{3}{B}{R}{G}', 'Rare', 'https://s.deckbox.org/system/images/mtg/cards/433097.jpg');
INSERT INTO `card` (`id`, `name`, `type`, `cost`, `rarity`, `image_url`) VALUES (121, 'Chromatic Lantern', 'Artifact', '{3}', 'Rare', 'https://s.deckbox.org/system/images/mtg/cards/452983.jpg');
INSERT INTO `card` (`id`, `name`, `type`, `cost`, `rarity`, `image_url`) VALUES (123, 'Civic Wayfinder', 'Creature - Elf Druid Warrior', '{2}{G}', 'Common', 'https://s.deckbox.org/system/images/mtg/cards/413703.jpg');
INSERT INTO `card` (`id`, `name`, `type`, `cost`, `rarity`, `image_url`) VALUES (124, 'Command Tower', 'Land', '', 'Common', 'https://s.deckbox.org/system/images/mtg/cards/2016056.jpg');
INSERT INTO `card` (`id`, `name`, `type`, `cost`, `rarity`, `image_url`) VALUES (125, 'Commander\'s Sphere', 'Artifact', '{3}', 'Common', 'https://s.deckbox.org/system/images/mtg/cards/2016012.jpg');
INSERT INTO `card` (`id`, `name`, `type`, `cost`, `rarity`, `image_url`) VALUES (126, 'Copperline Gorge', 'Land', '', 'Rare', 'https://s.deckbox.org/system/images/mtg/cards/209408.jpg');
INSERT INTO `card` (`id`, `name`, `type`, `cost`, `rarity`, `image_url`) VALUES (127, 'Crucible of Fire', 'Enchantment', '{3}{R}', 'Rare', 'https://s.deckbox.org/system/images/mtg/cards/2000509.jpg');
INSERT INTO `card` (`id`, `name`, `type`, `cost`, `rarity`, `image_url`) VALUES (128, 'Cultivate', 'Sorcery', '{2}{G}', 'Common', 'https://s.deckbox.org/system/images/mtg/cards/2016130.jpg');
INSERT INTO `card` (`id`, `name`, `type`, `cost`, `rarity`, `image_url`) VALUES (129, 'Diabolic Tutor', 'Sorcery', '{2}{B}{B}', 'Uncommon', 'https://s.deckbox.org/system/images/mtg/cards/417648.jpg');
INSERT INTO `card` (`id`, `name`, `type`, `cost`, `rarity`, `image_url`) VALUES (130, 'Dragon Broodmother', 'Creature - Dragon', '{2}{R}{R}{R}{G}', 'MythicRare', 'https://s.deckbox.org/system/images/mtg/cards/189648.jpg');
INSERT INTO `card` (`id`, `name`, `type`, `cost`, `rarity`, `image_url`) VALUES (131, 'Dragon Tempest', 'Enchantment', '{1}{R}', 'Uncommon', 'https://s.deckbox.org/system/images/mtg/cards/2000512.jpg');
INSERT INTO `card` (`id`, `name`, `type`, `cost`, `rarity`, `image_url`) VALUES (132, 'Dragon\'s Fire', 'Instant', '{1}{R}', 'Common', 'https://s.deckbox.org/system/images/mtg/cards/2020677.jpg');
INSERT INTO `card` (`id`, `name`, `type`, `cost`, `rarity`, `image_url`) VALUES (133, 'Dragon\'s Herald', 'Creature - Goblin Shaman', '{R}', 'Uncommon', 'https://s.deckbox.org/system/images/mtg/cards/175239.jpg');
INSERT INTO `card` (`id`, `name`, `type`, `cost`, `rarity`, `image_url`) VALUES (134, 'Dragon\'s Hoard', 'Artifact', '{3}', 'Rare', 'https://s.deckbox.org/system/images/mtg/cards/447369.jpg');
INSERT INTO `card` (`id`, `name`, `type`, `cost`, `rarity`, `image_url`) VALUES (135, 'Dragonlord Atarka', 'Legendary Creature - Elder Dragon', '{5}{R}{G}', 'MythicRare', 'https://s.deckbox.org/system/images/mtg/cards/394546.jpg');
INSERT INTO `card` (`id`, `name`, `type`, `cost`, `rarity`, `image_url`) VALUES (136, 'Dragonlord\'s Servant', 'Creature - Goblin Shaman', '{1}{R}', 'Common', 'https://s.deckbox.org/system/images/mtg/cards/2000513.jpg');
INSERT INTO `card` (`id`, `name`, `type`, `cost`, `rarity`, `image_url`) VALUES (137, 'Dragonmaster Outcast', 'Creature - Human Shaman', '{R}', 'MythicRare', 'https://s.deckbox.org/system/images/mtg/cards/470685.jpg');
INSERT INTO `card` (`id`, `name`, `type`, `cost`, `rarity`, `image_url`) VALUES (138, 'Dragonskull Summit', 'Land', '', 'Rare', 'https://s.deckbox.org/system/images/mtg/cards/435413.jpg');
INSERT INTO `card` (`id`, `name`, `type`, `cost`, `rarity`, `image_url`) VALUES (139, 'Explore', 'Sorcery', '{1}{G}', 'Common', 'https://s.deckbox.org/system/images/mtg/cards/2016132.jpg');
INSERT INTO `card` (`id`, `name`, `type`, `cost`, `rarity`, `image_url`) VALUES (140, 'Explosive Impact', 'Instant', '{5}{R}', 'Common', 'https://s.deckbox.org/system/images/mtg/cards/265393.jpg');
INSERT INTO `card` (`id`, `name`, `type`, `cost`, `rarity`, `image_url`) VALUES (141, 'Explosive Vegetation', 'Sorcery', '{3}{G}', 'Uncommon', 'https://s.deckbox.org/system/images/mtg/cards/451099.jpg');
INSERT INTO `card` (`id`, `name`, `type`, `cost`, `rarity`, `image_url`) VALUES (142, 'Fervor', 'Enchantment', '{2}{R}', 'Rare', 'https://s.deckbox.org/system/images/mtg/cards/279709.jpg');
INSERT INTO `card` (`id`, `name`, `type`, `cost`, `rarity`, `image_url`) VALUES (143, 'Flameblast Dragon', 'Creature - Dragon', '{4}{R}{R}', 'Rare', 'https://s.deckbox.org/system/images/mtg/cards/451078.jpg');
INSERT INTO `card` (`id`, `name`, `type`, `cost`, `rarity`, `image_url`) VALUES (144, 'Forest', 'Basic Land - Forest', '', 'BasicLand', 'https://s.deckbox.org/system/images/mtg/cards/2016216.jpg');
INSERT INTO `card` (`id`, `name`, `type`, `cost`, `rarity`, `image_url`) VALUES (145, 'Gilded Lotus', 'Artifact', '{5}', 'Rare', 'https://s.deckbox.org/system/images/mtg/cards/443103.jpg');
INSERT INTO `card` (`id`, `name`, `type`, `cost`, `rarity`, `image_url`) VALUES (146, 'Godtracker of Jund', 'Creature - Elf Shaman', '{1}{R}{G}', 'Common', 'https://s.deckbox.org/system/images/mtg/cards/183994.jpg');
INSERT INTO `card` (`id`, `name`, `type`, `cost`, `rarity`, `image_url`) VALUES (147, 'Golgari Rot Farm', 'Land', '', 'Uncommon', 'https://s.deckbox.org/system/images/mtg/cards/2012274.jpg');
INSERT INTO `card` (`id`, `name`, `type`, `cost`, `rarity`, `image_url`) VALUES (148, 'Gruul Turf', 'Land', '', 'Uncommon', 'https://s.deckbox.org/system/images/mtg/cards/2012276.jpg');
INSERT INTO `card` (`id`, `name`, `type`, `cost`, `rarity`, `image_url`) VALUES (149, 'Harbinger of the Hunt', 'Creature - Dragon', '{3}{R}{G}', 'Rare', 'https://s.deckbox.org/system/images/mtg/cards/394591.jpg');
INSERT INTO `card` (`id`, `name`, `type`, `cost`, `rarity`, `image_url`) VALUES (150, 'Hellkite Hatchling', 'Creature - Dragon', '{2}{R}{G}', 'Uncommon', 'https://s.deckbox.org/system/images/mtg/cards/189146.jpg');
INSERT INTO `card` (`id`, `name`, `type`, `cost`, `rarity`, `image_url`) VALUES (151, 'Hellkite Overlord', 'Creature - Dragon', '{4}{B}{R}{R}{G}', 'MythicRare', 'https://s.deckbox.org/system/images/mtg/cards/175057.jpg');
INSERT INTO `card` (`id`, `name`, `type`, `cost`, `rarity`, `image_url`) VALUES (152, 'Hoarding Dragon', 'Creature - Dragon', '{3}{R}{R}', 'Uncommon', 'https://s.deckbox.org/system/images/mtg/cards/2000521.jpg');
INSERT INTO `card` (`id`, `name`, `type`, `cost`, `rarity`, `image_url`) VALUES (153, 'Incinerate', 'Instant', '{1}{R}', 'Common', 'https://s.deckbox.org/system/images/mtg/cards/234075.jpg');
INSERT INTO `card` (`id`, `name`, `type`, `cost`, `rarity`, `image_url`) VALUES (154, 'Jund Charm', 'Instant', '{B}{R}{G}', 'Uncommon', 'https://s.deckbox.org/system/images/mtg/cards/137900.jpg');
INSERT INTO `card` (`id`, `name`, `type`, `cost`, `rarity`, `image_url`) VALUES (155, 'Jund Hackblade', 'Creature - Goblin Berserker', '{BG}{R}', 'Common', 'https://s.deckbox.org/system/images/mtg/cards/188973.jpg');
INSERT INTO `card` (`id`, `name`, `type`, `cost`, `rarity`, `image_url`) VALUES (156, 'Jund Panorama', 'Land', '', 'Common', 'https://s.deckbox.org/system/images/mtg/cards/451213.jpg');
INSERT INTO `card` (`id`, `name`, `type`, `cost`, `rarity`, `image_url`) VALUES (157, 'Jungle Hollow', 'Land', '', 'Common', 'https://s.deckbox.org/system/images/mtg/cards/2011770.jpg');
INSERT INTO `card` (`id`, `name`, `type`, `cost`, `rarity`, `image_url`) VALUES (158, 'Karrthus, Tyrant of Jund', 'Legendary Creature - Dragon', '{4}{B}{R}{G}', 'MythicRare', 'https://s.deckbox.org/system/images/mtg/cards/180587.jpg');
INSERT INTO `card` (`id`, `name`, `type`, `cost`, `rarity`, `image_url`) VALUES (159, 'Kazandu Refuge', 'Land', '', 'Uncommon', 'https://s.deckbox.org/system/images/mtg/cards/470802.jpg');
INSERT INTO `card` (`id`, `name`, `type`, `cost`, `rarity`, `image_url`) VALUES (160, 'Lava Axe', 'Sorcery', '{4}{R}', 'Common', 'https://s.deckbox.org/system/images/mtg/cards/447286.jpg');
INSERT INTO `card` (`id`, `name`, `type`, `cost`, `rarity`, `image_url`) VALUES (161, 'Lavalanche', 'Sorcery', '{X}{B}{R}{G}', 'Rare', 'https://s.deckbox.org/system/images/mtg/cards/451139.jpg');
INSERT INTO `card` (`id`, `name`, `type`, `cost`, `rarity`, `image_url`) VALUES (162, 'Leyline Prowler', 'Creature - Nightmare Beast', '{1}{B}{G}', 'Uncommon', 'https://s.deckbox.org/system/images/mtg/cards/461129.jpg');
INSERT INTO `card` (`id`, `name`, `type`, `cost`, `rarity`, `image_url`) VALUES (163, 'Mountain', 'Basic Land - Mountain', '', 'BasicLand', 'https://s.deckbox.org/system/images/mtg/cards/2016214.jpg');
INSERT INTO `card` (`id`, `name`, `type`, `cost`, `rarity`, `image_url`) VALUES (164, 'Murder', 'Instant', '{1}{B}{B}', 'Common', 'https://s.deckbox.org/system/images/mtg/cards/2015840.jpg');
INSERT INTO `card` (`id`, `name`, `type`, `cost`, `rarity`, `image_url`) VALUES (165, 'Naturalize', 'Instant', '{1}{G}', 'Common', 'https://s.deckbox.org/system/images/mtg/cards/447326.jpg');
INSERT INTO `card` (`id`, `name`, `type`, `cost`, `rarity`, `image_url`) VALUES (166, 'Obelisk of Jund', 'Artifact', '{3}', 'Common', 'https://s.deckbox.org/system/images/mtg/cards/174892.jpg');
INSERT INTO `card` (`id`, `name`, `type`, `cost`, `rarity`, `image_url`) VALUES (167, 'Owlbear Shepherd', 'Creature - Goblin Druid', '{2}{G}', 'Uncommon', 'https://s.deckbox.org/system/images/mtg/cards/2028376.jpg');
INSERT INTO `card` (`id`, `name`, `type`, `cost`, `rarity`, `image_url`) VALUES (168, 'Putrefy', 'Instant', '{1}{B}{G}', 'Uncommon', 'https://s.deckbox.org/system/images/mtg/cards/2012225.jpg');
INSERT INTO `card` (`id`, `name`, `type`, `cost`, `rarity`, `image_url`) VALUES (169, 'Rakdos Carnarium', 'Land', '', 'Common', 'https://s.deckbox.org/system/images/mtg/cards/2012297.jpg');
INSERT INTO `card` (`id`, `name`, `type`, `cost`, `rarity`, `image_url`) VALUES (170, 'Rampant Growth', 'Sorcery', '{1}{G}', 'Common', 'https://s.deckbox.org/system/images/mtg/cards/2016138.jpg');
INSERT INTO `card` (`id`, `name`, `type`, `cost`, `rarity`, `image_url`) VALUES (171, 'Red Dragon', 'Creature - Dragon', '{4}{R}{R}', 'Uncommon', 'https://s.deckbox.org/system/images/mtg/cards/2020698.jpg');
INSERT INTO `card` (`id`, `name`, `type`, `cost`, `rarity`, `image_url`) VALUES (172, 'Resounding Thunder', 'Instant', '{2}{R}', 'Common', 'https://s.deckbox.org/system/images/mtg/cards/175043.jpg');
INSERT INTO `card` (`id`, `name`, `type`, `cost`, `rarity`, `image_url`) VALUES (173, 'Rivaz of the Claw', 'Legendary Creature - Viashino Warlock', '{1}{B}{R}', 'Rare', 'https://s.deckbox.org/system/images/mtg/cards/2030612.jpg');
INSERT INTO `card` (`id`, `name`, `type`, `cost`, `rarity`, `image_url`) VALUES (174, 'Riveteers Overlook', 'Land', '', 'Common', 'https://s.deckbox.org/system/images/mtg/cards/2026702.jpg');
INSERT INTO `card` (`id`, `name`, `type`, `cost`, `rarity`, `image_url`) VALUES (175, 'Sarkhan the Mad', 'Legendary Planeswalker - Sarkhan', '{3}{B}{R}', 'MythicRare', 'https://s.deckbox.org/system/images/mtg/cards/193659.jpg');
INSERT INTO `card` (`id`, `name`, `type`, `cost`, `rarity`, `image_url`) VALUES (176, 'Sarkhan Vol', 'Legendary Planeswalker - Sarkhan', '{2}{R}{G}', 'MythicRare', 'https://s.deckbox.org/system/images/mtg/cards/174983.jpg');
INSERT INTO `card` (`id`, `name`, `type`, `cost`, `rarity`, `image_url`) VALUES (177, 'Sarkhan\'s Rage', 'Instant', '{4}{R}', 'Common', 'https://s.deckbox.org/system/images/mtg/cards/394676.jpg');
INSERT INTO `card` (`id`, `name`, `type`, `cost`, `rarity`, `image_url`) VALUES (178, 'Savage Lands', 'Land', '', 'Uncommon', 'https://s.deckbox.org/system/images/mtg/cards/451230.jpg');
INSERT INTO `card` (`id`, `name`, `type`, `cost`, `rarity`, `image_url`) VALUES (179, 'Savage Ventmaw', 'Creature - Dragon', '{4}{R}{G}', 'Uncommon', 'https://s.deckbox.org/system/images/mtg/cards/446197.jpg');
INSERT INTO `card` (`id`, `name`, `type`, `cost`, `rarity`, `image_url`) VALUES (180, 'Shivan Devastator', 'Creature - Dragon Hydra', '{X}{R}', 'MythicRare', 'https://s.deckbox.org/system/images/mtg/cards/2030540.jpg');
INSERT INTO `card` (`id`, `name`, `type`, `cost`, `rarity`, `image_url`) VALUES (181, 'Shivan Dragon', 'Creature - Dragon', '{4}{R}{R}', 'Rare', 'https://s.deckbox.org/system/images/mtg/cards/469888.jpg');
INSERT INTO `card` (`id`, `name`, `type`, `cost`, `rarity`, `image_url`) VALUES (182, 'Spit Flame', 'Instant', '{2}{R}', 'Rare', 'https://s.deckbox.org/system/images/mtg/cards/447296.jpg');
INSERT INTO `card` (`id`, `name`, `type`, `cost`, `rarity`, `image_url`) VALUES (183, 'Swamp', 'Basic Land - Swamp', '', 'BasicLand', 'https://s.deckbox.org/system/images/mtg/cards/2011787.jpg');
INSERT INTO `card` (`id`, `name`, `type`, `cost`, `rarity`, `image_url`) VALUES (184, 'Terminate', 'Instant', '{B}{R}', 'Uncommon', 'https://s.deckbox.org/system/images/mtg/cards/2012228.jpg');
INSERT INTO `card` (`id`, `name`, `type`, `cost`, `rarity`, `image_url`) VALUES (185, 'Traveler\'s Amulet', 'Artifact', '{1}', 'Common', 'https://s.deckbox.org/system/images/mtg/cards/476491.jpg');
INSERT INTO `card` (`id`, `name`, `type`, `cost`, `rarity`, `image_url`) VALUES (186, 'Unlicensed Disintegration', 'Instant', '{1}{B}{R}', 'Uncommon', 'https://s.deckbox.org/system/images/mtg/cards/417760.jpg');
INSERT INTO `card` (`id`, `name`, `type`, `cost`, `rarity`, `image_url`) VALUES (187, 'Violent Ultimatum', 'Sorcery', '{B}{B}{R}{R}{R}{G}{G}', 'Rare', 'https://s.deckbox.org/system/images/mtg/cards/175135.jpg');
INSERT INTO `card` (`id`, `name`, `type`, `cost`, `rarity`, `image_url`) VALUES (188, 'Wrathful Red Dragon', 'Creature - Dragon', '{3}{R}{R}', 'Rare', 'https://s.deckbox.org/system/images/mtg/cards/2028336.jpg');

COMMIT;


-- -----------------------------------------------------
-- Data for table `user`
-- -----------------------------------------------------
START TRANSACTION;
USE `cardsdb`;
INSERT INTO `user` (`id`, `first_name`, `last_name`, `username`, `password`, `email`, `image_url`, `balance`) VALUES (1, 'Firsticus', 'Inserticus', 'user', 'user', 'email@gmail', NULL, 23.19);
INSERT INTO `user` (`id`, `first_name`, `last_name`, `username`, `password`, `email`, `image_url`, `balance`) VALUES (2, 'Secondus', 'Inserticus', 'user1', 'user1', 'anotheremail@gmail', NULL, 71.29);
INSERT INTO `user` (`id`, `first_name`, `last_name`, `username`, `password`, `email`, `image_url`, `balance`) VALUES (3, 'thirdus', 'inserticus', 'user2', 'user2', 'emailsfordays@gmail.com', NULL, 1042);
INSERT INTO `user` (`id`, `first_name`, `last_name`, `username`, `password`, `email`, `image_url`, `balance`) VALUES (0, 'dfg', 'dfg', 'dfg', 'dfg', NULL, NULL, NULL);

COMMIT;


-- -----------------------------------------------------
-- Data for table `card_condition`
-- -----------------------------------------------------
START TRANSACTION;
USE `cardsdb`;
INSERT INTO `card_condition` (`id`, `grade`) VALUES (1, 'PSA 1');
INSERT INTO `card_condition` (`id`, `grade`) VALUES (2, 'PSA 2');
INSERT INTO `card_condition` (`id`, `grade`) VALUES (3, 'PSA 3');
INSERT INTO `card_condition` (`id`, `grade`) VALUES (4, 'PSA 4');
INSERT INTO `card_condition` (`id`, `grade`) VALUES (5, 'PSA 5');
INSERT INTO `card_condition` (`id`, `grade`) VALUES (6, 'PSA 6');
INSERT INTO `card_condition` (`id`, `grade`) VALUES (7, 'PSA 7');
INSERT INTO `card_condition` (`id`, `grade`) VALUES (8, 'PSA 8');
INSERT INTO `card_condition` (`id`, `grade`) VALUES (9, 'PSA 9');

COMMIT;


-- -----------------------------------------------------
-- Data for table `purchase`
-- -----------------------------------------------------
START TRANSACTION;
USE `cardsdb`;
INSERT INTO `purchase` (`id`, `amount`, `payment_date`, `user_id`) VALUES (1, 2.06, '2023-10-02', 1);
INSERT INTO `purchase` (`id`, `amount`, `payment_date`, `user_id`) VALUES (2, 0.27, '2023-05-05', 2);
INSERT INTO `purchase` (`id`, `amount`, `payment_date`, `user_id`) VALUES (3, 1.36, '2023-04-05', 3);

COMMIT;


-- -----------------------------------------------------
-- Data for table `inventory_item`
-- -----------------------------------------------------
START TRANSACTION;
USE `cardsdb`;
INSERT INTO `inventory_item` (`id`, `price`, `card_id`, `card_condition_id`, `purchase_id`) VALUES (1, 0.19, 1, 9, 1);
INSERT INTO `inventory_item` (`id`, `price`, `card_id`, `card_condition_id`, `purchase_id`) VALUES (2, 0.07, 1, 5, 1);
INSERT INTO `inventory_item` (`id`, `price`, `card_id`, `card_condition_id`, `purchase_id`) VALUES (3, 0.12, 1, 8, NULL);
INSERT INTO `inventory_item` (`id`, `price`, `card_id`, `card_condition_id`, `purchase_id`) VALUES (4, 1.53, 2, 8, 1);
INSERT INTO `inventory_item` (`id`, `price`, `card_id`, `card_condition_id`, `purchase_id`) VALUES (5, 0.25, 2, 9, NULL);
INSERT INTO `inventory_item` (`id`, `price`, `card_id`, `card_condition_id`, `purchase_id`) VALUES (6, 0.01, 2, 1, 2);
INSERT INTO `inventory_item` (`id`, `price`, `card_id`, `card_condition_id`, `purchase_id`) VALUES (7, 0.26, 2, 8, 2);
INSERT INTO `inventory_item` (`id`, `price`, `card_id`, `card_condition_id`, `purchase_id`) VALUES (8, 0.31, 2, 9, NULL);
INSERT INTO `inventory_item` (`id`, `price`, `card_id`, `card_condition_id`, `purchase_id`) VALUES (9, 0.16, 3, 1, 3);
INSERT INTO `inventory_item` (`id`, `price`, `card_id`, `card_condition_id`, `purchase_id`) VALUES (10, 1.06, 3, 8, 3);
INSERT INTO `inventory_item` (`id`, `price`, `card_id`, `card_condition_id`, `purchase_id`) VALUES (11, 3.20, 4, 9, NULL);
INSERT INTO `inventory_item` (`id`, `price`, `card_id`, `card_condition_id`, `purchase_id`) VALUES (12, 11.00, 5, 9, NULL);
INSERT INTO `inventory_item` (`id`, `price`, `card_id`, `card_condition_id`, `purchase_id`) VALUES (13, 0.19, 5, 1, NULL);
INSERT INTO `inventory_item` (`id`, `price`, `card_id`, `card_condition_id`, `purchase_id`) VALUES (14, 0.52, 6, 9, NULL);
INSERT INTO `inventory_item` (`id`, `price`, `card_id`, `card_condition_id`, `purchase_id`) VALUES (15, 0.27, 6, 8, 1);
INSERT INTO `inventory_item` (`id`, `price`, `card_id`, `card_condition_id`, `purchase_id`) VALUES (16, 3.75, 7, 9, NULL);
INSERT INTO `inventory_item` (`id`, `price`, `card_id`, `card_condition_id`, `purchase_id`) VALUES (17, 0.29, 7, 1, 3);
INSERT INTO `inventory_item` (`id`, `price`, `card_id`, `card_condition_id`, `purchase_id`) VALUES (18, 2.41, 7, 8, NULL);
INSERT INTO `inventory_item` (`id`, `price`, `card_id`, `card_condition_id`, `purchase_id`) VALUES (19, 2.19, 8, 9, NULL);
INSERT INTO `inventory_item` (`id`, `price`, `card_id`, `card_condition_id`, `purchase_id`) VALUES (20, 0.10, 10, 9, NULL);
INSERT INTO `inventory_item` (`id`, `price`, `card_id`, `card_condition_id`, `purchase_id`) VALUES (21, 0.24, 11, 9, NULL);
INSERT INTO `inventory_item` (`id`, `price`, `card_id`, `card_condition_id`, `purchase_id`) VALUES (22, 0.09, 12, 9, NULL);
INSERT INTO `inventory_item` (`id`, `price`, `card_id`, `card_condition_id`, `purchase_id`) VALUES (23, 0.09, 13, 9, NULL);
INSERT INTO `inventory_item` (`id`, `price`, `card_id`, `card_condition_id`, `purchase_id`) VALUES (24, 0.13, 14, 9, NULL);
INSERT INTO `inventory_item` (`id`, `price`, `card_id`, `card_condition_id`, `purchase_id`) VALUES (25, 4.36, 15, 9, NULL);
INSERT INTO `inventory_item` (`id`, `price`, `card_id`, `card_condition_id`, `purchase_id`) VALUES (26, 3.54, 16, 9, NULL);
INSERT INTO `inventory_item` (`id`, `price`, `card_id`, `card_condition_id`, `purchase_id`) VALUES (27, 2.23, 17, 9, NULL);
INSERT INTO `inventory_item` (`id`, `price`, `card_id`, `card_condition_id`, `purchase_id`) VALUES (28, 0.42, 18, 9, NULL);
INSERT INTO `inventory_item` (`id`, `price`, `card_id`, `card_condition_id`, `purchase_id`) VALUES (29, 5.68, 19, 9, NULL);
INSERT INTO `inventory_item` (`id`, `price`, `card_id`, `card_condition_id`, `purchase_id`) VALUES (30, 6.31, 20, 9, NULL);
INSERT INTO `inventory_item` (`id`, `price`, `card_id`, `card_condition_id`, `purchase_id`) VALUES (31, 1.13, 21, 9, NULL);
INSERT INTO `inventory_item` (`id`, `price`, `card_id`, `card_condition_id`, `purchase_id`) VALUES (32, 1.82, 22, 9, NULL);
INSERT INTO `inventory_item` (`id`, `price`, `card_id`, `card_condition_id`, `purchase_id`) VALUES (33, 0.32, 23, 8, NULL);
INSERT INTO `inventory_item` (`id`, `price`, `card_id`, `card_condition_id`, `purchase_id`) VALUES (34, 13.64, 24, 9, NULL);
INSERT INTO `inventory_item` (`id`, `price`, `card_id`, `card_condition_id`, `purchase_id`) VALUES (35, 2.99, 25, 7, NULL);
INSERT INTO `inventory_item` (`id`, `price`, `card_id`, `card_condition_id`, `purchase_id`) VALUES (36, 0.21, 26, 6, NULL);
INSERT INTO `inventory_item` (`id`, `price`, `card_id`, `card_condition_id`, `purchase_id`) VALUES (37, 0.76, 27, 9, NULL);
INSERT INTO `inventory_item` (`id`, `price`, `card_id`, `card_condition_id`, `purchase_id`) VALUES (38, 0.17, 28, 8, NULL);
INSERT INTO `inventory_item` (`id`, `price`, `card_id`, `card_condition_id`, `purchase_id`) VALUES (39, 2.51, 29, 9, NULL);
INSERT INTO `inventory_item` (`id`, `price`, `card_id`, `card_condition_id`, `purchase_id`) VALUES (40, 4.34, 30, 7, NULL);
INSERT INTO `inventory_item` (`id`, `price`, `card_id`, `card_condition_id`, `purchase_id`) VALUES (41, 0.65, 31, 6, NULL);
INSERT INTO `inventory_item` (`id`, `price`, `card_id`, `card_condition_id`, `purchase_id`) VALUES (42, 0.35, 32, 9, NULL);
INSERT INTO `inventory_item` (`id`, `price`, `card_id`, `card_condition_id`, `purchase_id`) VALUES (43, 0.59, 33, 9, NULL);
INSERT INTO `inventory_item` (`id`, `price`, `card_id`, `card_condition_id`, `purchase_id`) VALUES (44, 4.24, 34, 9, NULL);
INSERT INTO `inventory_item` (`id`, `price`, `card_id`, `card_condition_id`, `purchase_id`) VALUES (45, 4.61, 35, 9, NULL);
INSERT INTO `inventory_item` (`id`, `price`, `card_id`, `card_condition_id`, `purchase_id`) VALUES (46, 1.23, 36, 5, NULL);
INSERT INTO `inventory_item` (`id`, `price`, `card_id`, `card_condition_id`, `purchase_id`) VALUES (47, 4.04, 37, 7, NULL);
INSERT INTO `inventory_item` (`id`, `price`, `card_id`, `card_condition_id`, `purchase_id`) VALUES (48, 0.40, 38, 8, NULL);
INSERT INTO `inventory_item` (`id`, `price`, `card_id`, `card_condition_id`, `purchase_id`) VALUES (49, 0.40, 39, 9, NULL);
INSERT INTO `inventory_item` (`id`, `price`, `card_id`, `card_condition_id`, `purchase_id`) VALUES (50, 1.98, 40, 6, NULL);
INSERT INTO `inventory_item` (`id`, `price`, `card_id`, `card_condition_id`, `purchase_id`) VALUES (51, 6.83, 41, 9, NULL);
INSERT INTO `inventory_item` (`id`, `price`, `card_id`, `card_condition_id`, `purchase_id`) VALUES (52, 1.49, 42, 8, NULL);
INSERT INTO `inventory_item` (`id`, `price`, `card_id`, `card_condition_id`, `purchase_id`) VALUES (53, 0.42, 43, 7, NULL);
INSERT INTO `inventory_item` (`id`, `price`, `card_id`, `card_condition_id`, `purchase_id`) VALUES (54, 1.21, 44, 8, NULL);
INSERT INTO `inventory_item` (`id`, `price`, `card_id`, `card_condition_id`, `purchase_id`) VALUES (55, 1.20, 45, 9, NULL);
INSERT INTO `inventory_item` (`id`, `price`, `card_id`, `card_condition_id`, `purchase_id`) VALUES (56, 1.01, 46, 7, NULL);
INSERT INTO `inventory_item` (`id`, `price`, `card_id`, `card_condition_id`, `purchase_id`) VALUES (57, 0.03, 47, 8, NULL);
INSERT INTO `inventory_item` (`id`, `price`, `card_id`, `card_condition_id`, `purchase_id`) VALUES (58, 1.30, 48, 9, NULL);
INSERT INTO `inventory_item` (`id`, `price`, `card_id`, `card_condition_id`, `purchase_id`) VALUES (59, 1.08, 49, 9, NULL);
INSERT INTO `inventory_item` (`id`, `price`, `card_id`, `card_condition_id`, `purchase_id`) VALUES (60, 0.97, 50, 9, NULL);
INSERT INTO `inventory_item` (`id`, `price`, `card_id`, `card_condition_id`, `purchase_id`) VALUES (61, 1.46, 51, 9, NULL);
INSERT INTO `inventory_item` (`id`, `price`, `card_id`, `card_condition_id`, `purchase_id`) VALUES (62, 1.52, 52, 8, NULL);
INSERT INTO `inventory_item` (`id`, `price`, `card_id`, `card_condition_id`, `purchase_id`) VALUES (63, 5.77, 53, 9, NULL);
INSERT INTO `inventory_item` (`id`, `price`, `card_id`, `card_condition_id`, `purchase_id`) VALUES (64, 0.17, 54, 9, NULL);
INSERT INTO `inventory_item` (`id`, `price`, `card_id`, `card_condition_id`, `purchase_id`) VALUES (65, 0.23, 55, 8, NULL);
INSERT INTO `inventory_item` (`id`, `price`, `card_id`, `card_condition_id`, `purchase_id`) VALUES (66, 0.27, 56, 7, NULL);
INSERT INTO `inventory_item` (`id`, `price`, `card_id`, `card_condition_id`, `purchase_id`) VALUES (67, 12.14, 57, 8, NULL);
INSERT INTO `inventory_item` (`id`, `price`, `card_id`, `card_condition_id`, `purchase_id`) VALUES (68, 8.55, 58, 9, NULL);
INSERT INTO `inventory_item` (`id`, `price`, `card_id`, `card_condition_id`, `purchase_id`) VALUES (69, 8.43, 59, 9, NULL);
INSERT INTO `inventory_item` (`id`, `price`, `card_id`, `card_condition_id`, `purchase_id`) VALUES (70, 0.50, 60, 9, NULL);
INSERT INTO `inventory_item` (`id`, `price`, `card_id`, `card_condition_id`, `purchase_id`) VALUES (71, 5.91, 61, 9, NULL);

COMMIT;


-- -----------------------------------------------------
-- Data for table `user_deckbuilder`
-- -----------------------------------------------------
START TRANSACTION;
USE `cardsdb`;
INSERT INTO `user_deckbuilder` (`card_id`, `user_id`) VALUES (1, 1);
INSERT INTO `user_deckbuilder` (`card_id`, `user_id`) VALUES (2, 1);

COMMIT;

