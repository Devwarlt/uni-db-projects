-- Student: Nádio Dib (201918579)
-- Gist: https://gist.github.com/Devwarlt/71dc93159ebb156377676c3315c1f979

-- suppress MySQL warnings, just in case
-- we do receive truncated data, for more
-- details, checkout following reference:
-- https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_sql_notes
SET SESSION sql_notes = 0;

-- disable MySQL Server logs messages
-- about statemetns that are unsafe for
-- statement-based logging, for more detais,
-- checkout following reference:
-- https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_log_warnings
SET SESSION log_warnings = 0;

-- create database `sistema_taxi` it not exists
-- with default char set latin1 and collate
-- latin1_swedish_ci
CREATE DATABASE IF NOT EXISTS `sistema_taxi`
DEFAULT CHARACTER SET latin1
COLLATE latin1_swedish_ci;

USE `sistema_taxi`;

-- create table `cliente_particular` if not exists
CREATE TABLE IF NOT EXISTS `cliente_particular` (
    `id` INT NOT NULL,
    `cpf` VARCHAR(14) NOT NULL,
    PRIMARY KEY (`cpf`)
)  ENGINE=INNODB;

-- create table `cliente_empresa` if not exists
CREATE TABLE IF NOT EXISTS `cliente_empresa` (
    `id` INT NOT NULL,
    `cnpj` VARCHAR(18) NOT NULL,
    PRIMARY KEY (`cnpj`)
)  ENGINE=INNODB;

-- create table `cliente` if not exists
CREATE TABLE IF NOT EXISTS `cliente` (
    `id` INT NOT NULL AUTO_INCREMENT,
    `nome` VARCHAR(128) NOT NULL,
    PRIMARY KEY (`id`)
)  ENGINE=INNODB;

-- create table `corrida` if not exists
CREATE TABLE IF NOT EXISTS `corrida` (
    `id` INT NOT NULL,
    `placa` VARCHAR(8) NOT NULL,
    `data_pedido` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
)  ENGINE=INNODB;

-- create table `taxi` if not exists
CREATE TABLE IF NOT EXISTS `taxi` (
    `placa` VARCHAR(8) NOT NULL,
    `marca` VARCHAR(32) NOT NULL,
    `modelo` VARCHAR(64) NOT NULL,
    `ano_fabricacao` VARCHAR(4) NOT NULL,
    PRIMARY KEY (`placa`)
)  ENGINE=INNODB;

-- alter tables adding constraints for foreign keys declaration
ALTER TABLE `cliente_particular`
    ADD CONSTRAINT `clienter_particular_id_cliente_id`
    FOREIGN KEY (`id`)
    REFERENCES `cliente`(`id`)
    ON DELETE CASCADE;
ALTER TABLE `cliente_empresa`
    ADD CONSTRAINT `clienter_empresa_id_cliente_id`
    FOREIGN KEY (`id`)
    REFERENCES `cliente`(`id`)
    ON DELETE CASCADE;
ALTER TABLE `corrida`
    ADD CONSTRAINT `corrida_id_cliente_id`
    FOREIGN KEY (`id`)
    REFERENCES `cliente`(`id`)
    ON DELETE CASCADE,
    ADD CONSTRAINT `corrida_placa_taxi_placa`
    FOREIGN KEY(`placa`)
    REFERENCES `taxi`(`placa`)
    ON DELETE CASCADE;

-- add some values into table `cliente`
INSERT INTO `cliente` (`nome`) VALUES ('Agatha Benedita Farias');
INSERT INTO `cliente` (`nome`) VALUES ('Márcia Teresinha Galvão');
INSERT INTO `cliente` (`nome`) VALUES ('Kevin Igor Sebastião Barros');
INSERT INTO `cliente` (`nome`) VALUES ('Silvana Natália Alice Araújo');
INSERT INTO `cliente` (`nome`) VALUES ('Otávio Cauê Fernandes');

-- add some values into table `cliente_empresa`
INSERT INTO `cliente_empresa` (`id`, `cnpj`) VALUES ('1', '09.679.620/0001-73');
INSERT INTO `cliente_empresa` (`id`, `cnpj`) VALUES ('3', '37.053.767/0001-99');
INSERT INTO `cliente_empresa` (`id`, `cnpj`) VALUES ('5', '91.006.317/0001-90');

-- add some values into table `cliente_particular`
INSERT INTO `cliente_particular` (`id`, `cpf`) VALUES ('2', '283.722.507-07');
INSERT INTO `cliente_particular` (`id`, `cpf`) VALUES ('4', '647.181.256-69');

-- add some values into table `taxi`
INSERT INTO `taxi` (`placa`, `marca`, `modelo`, `ano_fabricacao`) VALUES ('JKD-4423', 'Troller', 'T-4 4x4 3.2 TGV tdi Cap. R', '2013');
INSERT INTO `taxi` (`placa`, `marca`, `modelo`, `ano_fabricacao`) VALUES ('JKJ-0823', 'Cross Lander', 'CL-244 2.8 132cv 4x4 TB Int. Diesel', '2018');
INSERT INTO `taxi` (`placa`, `marca`, `modelo`, `ano_fabricacao`) VALUES ('JKF-3682', 'Fibravan', 'Buggy Vip 1.8 8V', '2010');
INSERT INTO `taxi` (`placa`, `marca`, `modelo`, `ano_fabricacao`) VALUES ('JKM-3052', 'Rover', 'Mini Cooper 1.3', '2015');

-- add some values into table `corrida`
INSERT INTO `corrida` (`id`, `placa`) VALUES (1, 'JKD-4423');
INSERT INTO `corrida` (`id`, `placa`) VALUES (5, 'JKF-3682');
