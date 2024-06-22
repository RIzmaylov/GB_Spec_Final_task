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