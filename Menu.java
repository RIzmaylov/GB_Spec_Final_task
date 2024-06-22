import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Scanner;

import Animals.Animal;

public class Menu {
    private List<Animal> animals = new ArrayList<>();

    public void start() {
        Scanner scanner = new Scanner(System.in);

        boolean isWorking = true;

        while (isWorking) {
            System.out.println("""
                    Выведите команду:
                    1. Завести новое животное
                    2. Показать список комманд
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

            System.out.println("Введите номер животного из списка, которого хотели бы завести");

            List<String> allAnimalsToCreate = Creator.getAllAnimalsToCreate();

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
            List<String> animalCommands = Arrays.stream(scanner.next().split(",")).toList();

            animals.add(Creator.createAnimal(animalType, animalName, animalCommands));

    }
    
    private void showCommands() {}
    private void addCommand() {}
}
