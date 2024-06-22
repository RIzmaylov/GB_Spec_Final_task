package Animals;

import java.util.List;

public class Dog extends Pet {
    public Dog(String name, List<String> command) {
        super(name, command);
    }

    @Override
    public String toString() {
        return "Dog";
    }
}