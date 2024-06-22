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