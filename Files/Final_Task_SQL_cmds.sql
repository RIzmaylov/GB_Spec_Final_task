DROP Database if exists human_friends;
CREATE DATABASE human_friends;
USE human_friends;

CREATE TABLE `animals` (
	`id` INT(11) NOT NULL AUTO_INCREMENT,
	`type` ENUM('Pets', 'Pack'),
	PRIMARY KEY (`id`)
);

CREATE TABLE `pets` (
	`id` INT(11) NULL,
	`name_animals` TEXT NULL,
	FOREIGN KEY (`id`) REFERENCES `animals` (`id`) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE `pack_animals` (
	`id` INT(11) NULL,
	`name_animals` TEXT NULL,
	FOREIGN KEY (`id`) REFERENCES `animals` (`id`) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE `dogs` (
	`id` INT(11) NULL,
	`name` TEXT NULL,
	`date` DATE NULL,
	`commands` TEXT NULL,
	FOREIGN KEY (`id`) REFERENCES `pets` (`id`) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE `cats` (
	`id` INT(11) NULL,
	`name` TEXT NULL,
	`date` DATE NULL,
	`commands` TEXT NULL,
	FOREIGN KEY (`id`) REFERENCES `pets` (`id`) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE `hamsters` (
	`id` INT(11) NULL,
	`name` TEXT NULL,
	`date` DATE NULL,
	`commands` TEXT NULL,
	FOREIGN KEY (`id`) REFERENCES `pets` (`id`) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE `horses` (
	`id` INT(11) NULL,
	`name` TEXT NULL,
	`date` DATE NULL,
	`commands` TEXT NULL,
	FOREIGN KEY (`id`) REFERENCES `pack_animals` (`id`) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE `camels` (
	`id` INT(11) NULL,
	`name` TEXT NULL,
	`date` DATE NULL,
	`commands` TEXT NULL,
	FOREIGN KEY (`id`) REFERENCES `pack_animals` (`id`) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE `donkeys` (
	`id` INT(11) NULL,
	`name` TEXT NULL,
	`date` DATE NULL,
	`commands` TEXT NULL,
	FOREIGN KEY (`id`) REFERENCES `pack_animals` (`id`) ON UPDATE CASCADE ON DELETE CASCADE
);

INSERT INTO animals (`type`) VALUES ('Pets');
INSERT INTO pets (`id`, `name_animals`) VALUES (LAST_INSERT_ID(), 'Dog');
INSERT INTO dogs (`id`, `name`, `date`, `commands`) VALUES (LAST_INSERT_ID(), 'Fido', '2020-01-01', 'Sit, Stay, Fetch');

INSERT INTO animals (`type`) VALUES ('Pets');
INSERT INTO pets (`id`, `name_animals`) VALUES (LAST_INSERT_ID(), 'Cat');
INSERT INTO cats (`id`, `name`, `date`, `commands`) VALUES (LAST_INSERT_ID(), 'Whiskers', '2019-05-15', 'Sit, Pounce');

INSERT INTO animals (`type`) VALUES ('Pets');
INSERT INTO pets (`id`, `name_animals`) VALUES (LAST_INSERT_ID(), 'Hamster');
INSERT INTO hamsters (`id`, `name`, `date`, `commands`) VALUES (LAST_INSERT_ID(), 'Hammy', '2021-03-10', 'Roll, Hide');

INSERT INTO animals (`type`) VALUES ('Pets');
INSERT INTO pets (`id`, `name_animals`) VALUES (LAST_INSERT_ID(), 'Dog');
INSERT INTO dogs (`id`, `name`, `date`, `commands`) VALUES (LAST_INSERT_ID(), 'Buddy', '2018-12-10', 'Sit, Paw, Bark');

INSERT INTO animals (`type`) VALUES ('Pets');
INSERT INTO pets (`id`, `name_animals`) VALUES (LAST_INSERT_ID(), 'Cat');
INSERT INTO cats (`id`, `name`, `date`, `commands`) VALUES (LAST_INSERT_ID(), 'Smudge', '2020-02-20', 'Sit, Pounce, Scratch');

INSERT INTO animals (`type`) VALUES ('Pets');
INSERT INTO pets (`id`, `name_animals`) VALUES (LAST_INSERT_ID(), 'Hamster');
INSERT INTO hamsters (`id`, `name`, `date`, `commands`) VALUES (LAST_INSERT_ID(), 'Peanut', '2021-08-01', 'Roll, Spin');

INSERT INTO animals (`type`) VALUES ('Pack');
INSERT INTO pack_animals (`id`, `name_animals`) VALUES (LAST_INSERT_ID(), 'Horse');
INSERT INTO horses (`id`, `name`, `date`, `commands`) VALUES (LAST_INSERT_ID(), 'Thunder', '2015-07-21', 'Trot, Canter, Gallop');

INSERT INTO animals (`type`) VALUES ('Pack');
INSERT INTO pack_animals (`id`, `name_animals`) VALUES (LAST_INSERT_ID(), 'Camel');
INSERT INTO camels (`id`, `name`, `date`, `commands`) VALUES (LAST_INSERT_ID(), 'Sandy', '2016-11-03', 'Walk, Carry Load');

INSERT INTO animals (`type`) VALUES ('Pack');
INSERT INTO pack_animals (`id`, `name_animals`) VALUES (LAST_INSERT_ID(), 'Donkey');
INSERT INTO donkeys (`id`, `name`, `date`, `commands`) VALUES (LAST_INSERT_ID(), 'Eeyore', '2017-09-18', 'Walk, Carry Load, Bray');

INSERT INTO animals (`type`) VALUES ('Pack');
INSERT INTO pack_animals (`id`, `name_animals`) VALUES (LAST_INSERT_ID(), 'Horse');
INSERT INTO horses (`id`, `name`, `date`, `commands`) VALUES (LAST_INSERT_ID(), 'Storm', '2014-05-05', 'Trot, Canter');

INSERT INTO animals (`type`) VALUES ('Pack');
INSERT INTO pack_animals (`id`, `name_animals`) VALUES (LAST_INSERT_ID(), 'Camel');
INSERT INTO camels (`id`, `name`, `date`, `commands`) VALUES (LAST_INSERT_ID(), 'Dune', '2018-12-12', 'Walk, Sit');

INSERT INTO animals (`type`) VALUES ('Pack');
INSERT INTO pack_animals (`id`, `name_animals`) VALUES (LAST_INSERT_ID(), 'Donkey');
INSERT INTO donkeys (`id`, `name`, `date`, `commands`) VALUES (LAST_INSERT_ID(), 'Burro', '2019-01-23', 'Walk, Bray, Kick');

DELETE FROM `animals` WHERE id IN (SELECT id FROM `camels`);

SELECT * FROM `horses`
UNION
SELECT * FROM `donkeys`;

CREATE TEMPORARY TABLE `young_animals` (
	`id` INT(11) NOT NULL AUTO_INCREMENT,
	`animal_type` ENUM('dogs', 'cats', 'hamsters', 'horses', 'camels', 'donkeys'),
	`name` TEXT NULL,
	`age_months` DECIMAL(5,2),
	PRIMARY KEY (`id`)
);

INSERT INTO `young_animals` (`animal_type`, `name`, `age_months`)
SELECT animal_type, name, TIMESTAMPDIFF(MONTH,`date`,CURDATE()) AS age_months FROM 
    (SELECT 'dogs' as animal_type, `name`, `date` FROM `dogs`
     UNION ALL SELECT 'cats', `name`, `date` FROM `cats`
     UNION ALL SELECT 'hamsters', `name`, `date` FROM `hamsters`
     UNION ALL SELECT 'horses', `name`, `date` FROM `horses`
     UNION ALL SELECT 'camels', `name`, `date` FROM `camels`
     UNION ALL SELECT 'donkeys', `name`, `date` FROM `donkeys`
    ) AS animals
WHERE `date` BETWEEN DATE_SUB(NOW(), INTERVAL 3 YEAR) AND DATE_SUB(NOW(), INTERVAL 1 YEAR);

SELECT * FROM young_animals;

SELECT 
    animals.id AS animal_id,
    animals.type AS animal_type,
    pets.id AS pets_id,
    pets.name_animals AS pets_name,
    pack_animals.id AS pack_animal_id,
    pack_animals.name_animals AS pack_animal_name,
    dogs.id AS dog_id,
    dogs.name AS dog_name,
    dogs.date AS dog_date,
    dogs.commands AS dog_commands,
    cats.id AS cat_id,
    cats.name AS cat_name,
    cats.date AS cat_date,
    cats.commands AS cat_commands,
    hamsters.id AS hamster_id,
    hamsters.name AS hamster_name,
    hamsters.date AS hamster_date,
    hamsters.commands AS hamster_commands,
    horses.id AS horse_id,
    horses.name AS horse_name,
    horses.date AS horse_date,
    horses.commands AS horse_commands,
    camels.id AS camel_id,
    camels.name AS camel_name,
    camels.date AS camel_date,
    camels.commands AS camel_commands,
    donkeys.id AS donkey_id,
    donkeys.name AS donkey_name,
    donkeys.date AS donkey_date,
    donkeys.commands AS donkey_commands
FROM animals
LEFT JOIN pets ON animals.id = pets.id
LEFT JOIN pack_animals ON animals.id = pack_animals .id
LEFT JOIN dogs ON pets.id = dogs.id
LEFT JOIN cats ON pets.id = cats.id
LEFT JOIN hamsters ON pets.id = hamsters.id
LEFT JOIN horses ON pack_animals.id = horses.id
LEFT JOIN camels ON pack_animals.id = camels.id
LEFT JOIN donkeys ON pack_animals.id = donkeys.id;