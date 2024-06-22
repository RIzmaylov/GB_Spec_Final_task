package Animals;

import java.util.ArrayList;
import java.util.List;

public class Donkey extends PackAnimal {
    public Donkey(String name, ArrayList<String> command) {
        super(name, command);
    }

    @Override
    public String toString() {
        return "Donkey";
    }
}