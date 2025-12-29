-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema hw2_db
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `hw2_db` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
USE `hw2_db` ;

-- -----------------------------------------------------
-- Table `hw2_db`.`clients`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `hw2_db`.`clients` (
  `client_id` INT NOT NULL AUTO_INCREMENT,
  `client_name` VARCHAR(100) NOT NULL,
  `client_address` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`client_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `hw2_db`.`orders`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `hw2_db`.`orders` (
  `order_id` INT NOT NULL,
  `order_date` DATE NOT NULL,
  `client_id` INT NOT NULL,
  PRIMARY KEY (`order_id`),
  INDEX `fk_orders_client` (`client_id` ASC) VISIBLE,
  CONSTRAINT `fk_orders_client`
    FOREIGN KEY (`client_id`)
    REFERENCES `hw2_db`.`clients` (`client_id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `hw2_db`.`products`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `hw2_db`.`products` (
  `product_id` INT NOT NULL AUTO_INCREMENT,
  `product_name` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`product_id`),
  UNIQUE INDEX `product_name` (`product_name` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `hw2_db`.`orderitems`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `hw2_db`.`orderitems` (
  `order_id` INT NOT NULL,
  `product_id` INT NOT NULL,
  `quantity` INT NOT NULL,
  PRIMARY KEY (`order_id`, `product_id`),
  INDEX `fk_items_product` (`product_id` ASC) VISIBLE,
  CONSTRAINT `fk_items_order`
    FOREIGN KEY (`order_id`)
    REFERENCES `hw2_db`.`orders` (`order_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_items_product`
    FOREIGN KEY (`product_id`)
    REFERENCES `hw2_db`.`products` (`product_id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
