# create a container with a volume in WSL2
# sudo docker run --name mysqldb -p 3306:3306 -v /var/lib/as/:/var/lib/mysql -e MYSQL_ALLOW_EMPTY_PASSWORD=yes -d mysql

# connect to mysql and run as root user
# create databases
CREATE DATABASE as_dev;
CREATE DATABASE as_prod;

# create database service accounts (for db installed localy)
CREATE USER 'as_dev_user'@'localhost' IDENTIFIED BY 'as';
CREATE USER 'as_prod_user'@'localhost' IDENTIFIED BY 'as';
CREATE USER 'as_dev_user'@'%' IDENTIFIED BY 'as';
CREATE USER 'as_prod_user'@'%' IDENTIFIED BY 'as';

# database grants (for db installed localy)
GRANT SELECT ON as_dev.* to 'as_dev_user'@'localhost';
GRANT INSERT ON as_dev.* to 'as_dev_user'@'localhost';
GRANT DELETE ON as_dev.* to 'as_dev_user'@'localhost';
GRANT UPDATE ON as_dev.* to 'as_dev_user'@'localhost';
GRANT SELECT ON as_prod.* to 'as_prod_user'@'localhost';
GRANT INSERT ON as_prod.* to 'as_prod_user'@'localhost';
GRANT DELETE ON as_prod.* to 'as_prod_user'@'localhost';
GRANT UPDATE ON as_prod.* to 'as_prod_user'@'localhost';
GRANT SELECT ON as_dev.* to 'as_dev_user'@'%';
GRANT INSERT ON as_dev.* to 'as_dev_user'@'%';
GRANT DELETE ON as_dev.* to 'as_dev_user'@'%';
GRANT UPDATE ON as_dev.* to 'as_dev_user'@'%';
GRANT SELECT ON as_prod.* to 'as_prod_user'@'%';
GRANT INSERT ON as_prod.* to 'as_prod_user'@'%';
GRANT DELETE ON as_prod.* to 'as_prod_user'@'%';
GRANT UPDATE ON as_prod.* to 'as_prod_user'@'%';

FLUSH PRIVILEGES;

# create database service accounts (for db installed in a docker container)
CREATE USER 'as_dev_user'@'172.17.0.1' IDENTIFIED BY 'as';
CREATE USER 'as_prod_user'@'172.17.0.1' IDENTIFIED BY 'as';

# database grants (for db installed in a docker container)
GRANT SELECT ON as_dev.* to 'as_dev_user'@'172.17.0.1';
GRANT INSERT ON as_dev.* to 'as_dev_user'@'172.17.0.1';
GRANT DELETE ON as_dev.* to 'as_dev_user'@'172.17.0.1';
GRANT UPDATE ON as_dev.* to 'as_dev_user'@'172.17.0.1';
GRANT SELECT ON as_prod.* to 'as_prod_user'@'172.17.0.1';
GRANT INSERT ON as_prod.* to 'as_prod_user'@'172.17.0.1';
GRANT DELETE ON as_prod.* to 'as_prod_user'@'172.17.0.1';
GRANT UPDATE ON as_prod.* to 'as_prod_user'@'172.17.0.1';

FLUSH PRIVILEGES;

USE as_dev;
# USE as_prod;

CREATE TABLE IF NOT EXISTS `category` (`id` BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY, `description` VARCHAR(255)) ENGINE=INNODB;
CREATE TABLE IF NOT EXISTS `ingredient` (`id` BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY, `amount` DECIMAL(19,2), `description` VARCHAR(255), `recipe_id` BIGINT, `uom_id` BIGINT) ENGINE=INNODB;
CREATE TABLE IF NOT EXISTS `notes` (`id` BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY, `recipe_notes` LONGTEXT, `recipe_id` BIGINT) ENGINE=INNODB;
CREATE TABLE IF NOT EXISTS `recipe` (`id` BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY, `cook_time` INTEGER, `description` VARCHAR(255), `difficulty` VARCHAR(255),
 directions LONGTEXT, image LONGBLOB, `prep_time` INTEGER, `servings` INTEGER, `source` VARCHAR(255), `url` VARCHAR(255), `notes_id` BIGINT) ENGINE=INNODB;
CREATE TABLE IF NOT EXISTS `recipe_category` (`id` BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY, `category_id` BIGINT NOT NULL, `recipe_id` BIGINT NOT NULL) ENGINE=INNODB;
CREATE TABLE IF NOT EXISTS `unit_of_measure` (`id` BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY, `description` VARCHAR(255)) ENGINE=INNODB;

ALTER TABLE `ingredient` ADD CONSTRAINT FKj0s4ywmqqqw4h5iommigh5yja FOREIGN KEY (`recipe_id`) REFERENCES `recipe` (id);
ALTER TABLE `ingredient` ADD CONSTRAINT FK6iv5l89qmitedn5m2a71kta2t FOREIGN KEY (uom_id) REFERENCES unit_of_measure (id);
ALTER TABLE `notes` ADD CONSTRAINT FKdbfsiv21ocsbt63sd6fg0t3c8 FOREIGN KEY (recipe_id) REFERENCES recipe (id);
ALTER TABLE `recipe` ADD CONSTRAINT FK37al6kcbdasgfnut9xokktie9 FOREIGN KEY (notes_id) REFERENCES notes (id);
ALTER TABLE `recipe_category` ADD CONSTRAINT FKqsi87i8d4qqdehlv2eiwvpwb FOREIGN KEY (category_id) REFERENCES category (id);
ALTER TABLE `recipe_category` ADD CONSTRAINT FKcqlqnvfyarhieewfeayk3v25v FOREIGN KEY (recipe_id) REFERENCES recipe (id);

INSERT INTO `category` (description) VALUES ('American');
INSERT INTO `category` (description) VALUES ('Italian');
INSERT INTO `category` (description) VALUES ('Mexican');
INSERT INTO `category` (description) VALUES ('Fast Food');
INSERT INTO `unit_of_measure` (description) VALUES ('Teaspoon');
INSERT INTO `unit_of_measure` (description) VALUES ('Tablespoon');
INSERT INTO `unit_of_measure` (description) VALUES ('Cup');
INSERT INTO `unit_of_measure` (description) VALUES ('Pinch');
INSERT INTO `unit_of_measure` (description) VALUES ('Ounce');
INSERT INTO `unit_of_measure` (description) VALUES ('Each');
INSERT INTO `unit_of_measure` (description) VALUES ('Dash');
INSERT INTO `unit_of_measure` (description) VALUES ('Pint');