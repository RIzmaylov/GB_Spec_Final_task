package Animals;

import java.util.List;

public class Horse extends PackAnimal {
    public Horse(String name, List<String> command) {
        super(name, command);
    }

    @Override
    public String toString() {
        return "Horse";
    }
}