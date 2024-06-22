package Animals;

import java.util.List;

public class Hamster extends Pet {
    public Hamster(String name, List<String> command) {
        super(name, command);
    }

    @Override
    public String toString() {
        return "Hamster";
    }
}
