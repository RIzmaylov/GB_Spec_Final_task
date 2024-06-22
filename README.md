# Итоговая контрольная работа по специализации

1. Используя команду cat в терминале операционной системы Linux, создать
два файла Домашние животные (заполнив файл собаками, кошками,
хомяками) и Вьючные животными заполнив файл Лошадьми, верблюдами и
ослы), а затем объединить их. Просмотреть содержимое созданного файла.
Переименовать файл, дав ему новое имя (Друзья человека).
2. Создать директорию, переместить файл туда.
3. Подключить дополнительный репозиторий MySQL. Установить любой пакет
из этого репозитория.
4. Установить и удалить deb-пакет с помощью dpkg.
5. Выложить историю команд в терминале ubuntu


![Model](https://github.com/RIzmaylov/GB_Spec_Final_task/blob/main/Files/Linux_cmds_history.png)

6. Нарисовать диаграмму, в которой есть класс родительский класс, домашние
животные и вьючные животные, в составы которых в случае домашних
животных войдут классы: собаки, кошки, хомяки, а в класс вьючные животные
войдут: Лошади, верблюды и ослы).

![Model](https://github.com/RIzmaylov/GB_Spec_Final_task/blob/main/Files/Animal_Diagramm.png)

7. В подключенном MySQL репозитории создать базу данных “Друзья человека”
8. Создать таблицы с иерархией из диаграммы в БД

~~~
CREATE DATABASE human_friends;

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
~~~


9. Заполнить низкоуровневые таблицы именами(животных), командами
которые они выполняют и датами рождения


~~~
INSERT INTO animals (`type`) VALUES ('Pets');
INSERT INTO pets (`id`, `name_animals`) VALUES (LAST_INSERT_ID(), 'Dog');
INSERT INTO dogs (`id`, `name`, `date`, `commands`) VALUES (LAST_INSERT_ID(), 'Рей', '2022-06-02', 'Апорт');

INSERT INTO animals (`type`) VALUES ('Pets');
INSERT INTO pets (`id`, `name_animals`) VALUES (LAST_INSERT_ID(), 'Cat');
INSERT INTO cats (`id`, `name`, `date`, `commands`) VALUES (LAST_INSERT_ID(), 'Рыжик', '2020-02-12', 'Лежать');

INSERT INTO animals (`type`) VALUES ('Pets');
INSERT INTO pets (`id`, `name_animals`) VALUES (LAST_INSERT_ID(), 'Hamster');
INSERT INTO hamsters (`id`, `name`, `date`, `commands`) VALUES (LAST_INSERT_ID(), 'Рыжик', '2023-11-21', '');

INSERT INTO animals (`type`) VALUES ('Pack');
INSERT INTO pack_animals (`id`, `name_animals`) VALUES (LAST_INSERT_ID(), 'Horse');
INSERT INTO horses (`id`, `name`, `date`, `commands`) VALUES (LAST_INSERT_ID(), 'Плотва', '2015-01-01', 'Шевелись');

INSERT INTO animals (`type`) VALUES ('Pack');
INSERT INTO pack_animals (`id`, `name_animals`) VALUES (LAST_INSERT_ID(), 'Camel');
INSERT INTO camels (`id`, `name`, `date`, `commands`) VALUES (LAST_INSERT_ID(), 'Горбатый', '2014-12-15', 'Пей');

INSERT INTO animals (`type`) VALUES ('Pack');
INSERT INTO pack_animals (`id`, `name_animals`) VALUES (LAST_INSERT_ID(), 'Donkey');
INSERT INTO donkeys (`id`, `name`, `date`, `commands`) VALUES (LAST_INSERT_ID(), 'Мурка', '2024-02-03', 'Стой');
~~~

10. Удалив из таблицы верблюдов, т.к. верблюдов решили перевезти в другой
питомник на зимовку. Объединить таблицы лошади, и ослы в одну таблицу.

~~~
DELETE FROM `animals` WHERE id IN (SELECT id FROM `camels`);

SELECT * FROM `horses`
UNION
SELECT * FROM `donkeys`
~~~

11.Создать новую таблицу “молодые животные” в которую попадут все
животные старше 1 года, но младше 3 лет и в отдельном столбце с точностью
до месяца подсчитать возраст животных в новой таблице

~~~
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
~~~

12. Объединить все таблицы в одну, при этом сохраняя поля, указывающие на
прошлую принадлежность к старым таблицам.

~~~
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
~~~

13.Создать класс с Инкапсуляцией методов и наследованием по диаграмме.

~~~
package Animals;

import java.util.ArrayList;
import java.util.List;

public abstract class Animal {
    protected String name;
    protected ArrayList<String> commands;

    public Animal(String name, ArrayList<String> commands) {
        this.name = name;
        this.commands = commands;
    }

    public List<String> getCommands() {
        return new ArrayList<>(commands);
    }

    public void addCommand(String command) {
        commands.add(command);
    }

    public String getName() {
        return name;
    }
}
~~~
~~~
package Animals;

import java.util.ArrayList;

public abstract class Pet extends Animal {
    public Pet(String name, ArrayList<String> commands) {
        super(name, commands);
    }
}
~~~
~~~
package Animals;

import java.util.ArrayList;

public abstract class PackAnimal extends Animal {
    public PackAnimal(String name, ArrayList<String> commands) {
        super(name, commands);
    }
}
~~~
~~~
package Animals;

import java.util.ArrayList;

public class Dog extends Pet {
    public Dog(String name, ArrayList<String> command) {
        super(name, command);
    }

    @Override
    public String toString() {
        return "Dog";
    }
}

~~~
~~~

package Animals;

import java.util.ArrayList;

public class Cat extends Pet {
    public Cat(String name, ArrayList<String> command) {
        super(name, command);
    }

    @Override
    public String toString() {
        return "Cat";
    }
}

~~~
~~~

package Animals;

import java.util.ArrayList;

public class Hamster extends Pet {
    public Hamster(String name, ArrayList<String> command) {
        super(name, command);
    }

    @Override
    public String toString() {
        return "Hamster";
    }
}

~~~
~~~

package Animals;

import java.util.ArrayList;

public class Horse extends PackAnimal {
    public Horse(String name, ArrayList<String> command) {
        super(name, command);
    }

    @Override
    public String toString() {
        return "Horse";
    }
}

~~~
~~~

package Animals;

import java.util.ArrayList;

public class Camel extends PackAnimal {
    public Camel(String name, ArrayList<String> command) {
        super(name, command);
    }

    @Override
    public String toString() {
        return "Camel";
    }
}

~~~
~~~

package Animals;

import java.util.ArrayList;

public class Donkey extends PackAnimal {
    public Donkey(String name, ArrayList<String> command) {
        super(name, command);
    }

    @Override
    public String toString() {
        return "Donkey";
    }
}

~~~

14. Написать программу, имитирующую работу реестра домашних животных.
В программе должен быть реализован следующий функционал:


14.1 Завести новое животное

14.2 определять животное в правильный класс

14.3 увидеть список команд, которое выполняет животное

14.4 обучить животное новым командам

14.5 Реализовать навигацию по меню

~~~
import Animals.*;

import java.util.ArrayList;
import java.util.Arrays;

public class Creator {
    private static ArrayList<String> allAnimals = new ArrayList<>(Arrays.asList("Dog", "Cat", "Hamster", "Horse", "Camel", "Donkey"));

    public static Animal createAnimal(int animalType, String name, ArrayList<String> commands) {
        Animal animal = new Dog(name, commands);

        switch (allAnimals.get(animalType)) {
            case "Dog":
                animal = new Dog(name, commands);
                break;
            case "Cat":
                animal = new Cat(name, commands);
                break;
            case "Hamster":
                animal = new Hamster(name, commands);
                break;
            case "Horse":
                animal = new Horse(name, commands);
                break;
            case "Camel":
                animal = new Camel(name, commands);
                break;
            case "Donkey":
                animal = new Donkey(name, commands);
                break;
        }

        return animal;
    }


    public static ArrayList<String> getAllAnimalsToCreate() {
        return new ArrayList<>(allAnimals);
    }
}
~~~
~~~
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Scanner;

import Animals.Animal;

public class Menu {
    private ArrayList<Animal> animals = new ArrayList<>();

    public void start() {
        Scanner scanner = new Scanner(System.in);

        boolean isWorking = true;

        while (isWorking) {
            System.out.println("""
                    Выведите команду:
                    1. Завести новое животное
                    2. Показать список комманд животного
                    3. Обучить команде
                    4. Выход""");

            int userCommand = scanner.nextInt();

            switch (userCommand) {
                case (1):
                    createAnimal();
                    break;
                case (2):
                    showCommands();
                    break;
                case (3):
                    addCommand();
                    break;
                case (4):
                    isWorking = false;
                    break;
            }

        }
    }

    private void createAnimal() {
        Scanner scanner = new Scanner(System.in);
        
        try (Counter counter = new Counter()) {
            System.out.println("Введите номер животного из списка, которого хотели бы завести");

            ArrayList<String> allAnimalsToCreate = Creator.getAllAnimalsToCreate();

            for (int i = 0; i < allAnimalsToCreate.size(); i++) {
                System.out.println(i + " " + allAnimalsToCreate.get(i));
            }

            int animalType = scanner.nextInt();

            if (animalType < 0 || animalType >= allAnimalsToCreate.size()) {
                System.out.println("Выбирете корректный номер из списка");
                return;
            }

            System.out.println("Введите кличку животного");
            String animalName = scanner.next();

            System.out.println("Введите, через запятую, команды, которые знает животное");
            List<String> temp = Arrays.stream(scanner.next().split(",")).toList();
            ArrayList<String> animalCommands = new ArrayList<> (temp);

            animals.add(Creator.createAnimal(animalType, animalName, animalCommands));

            counter.increment();
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }

    }
    
    private void showCommands() {
        Scanner scanner = new Scanner(System.in);

        System.out.println("Выберите животное из списка");

        for (int i = 0; i < animals.size(); i++) {
            System.out.println(i + ". " + animals.get(i) + " " + animals.get(i).getName());
        }

        int userChoice = scanner.nextInt();

        for (String command: animals.get(userChoice).getCommands()) {
            System.out.println(command);
        }
    }
    private void addCommand() {
        Scanner scanner = new Scanner(System.in);

        System.out.println("Выберите животное из списка");

        for (int i = 0; i < animals.size(); i++) {
            System.out.println(i + ". " + animals.get(i) + " " + animals.get(i).getName());
        }

        int userChoice = scanner.nextInt();

        System.out.println("Введите новую команду");

        String newCommand = scanner.next();

        animals.get(userChoice).addCommand(newCommand);
    }
}
~~~

15.Создайте класс Счетчик, у которого есть метод add(), увеличивающий̆
значение внутренней̆int переменной̆на 1 при нажатие “Завести новое
животное” Сделайте так, чтобы с объектом такого типа можно было работать в
блоке try-with-resources. Нужно бросить исключение, если работа с объектом
типа счетчик была не в ресурсном try и/или ресурс остался открыт. Значение
считать в ресурсе try, если при заведения животного заполнены все поля.

~~~
public class Counter implements AutoCloseable {
    private static int count;

    public void increment() {
        count++;
    }

    @Override
    public void close() throws Exception {
        if (count < 0) {
            throw new Exception();
        }
    }
}
~~~


