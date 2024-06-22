import Animals.*;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

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
