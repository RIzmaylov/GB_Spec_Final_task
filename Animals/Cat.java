package Animals;

import java.util.ArrayList;
import java.util.List;

public class Cat extends Pet {
    public Cat(String name, ArrayList<String> command) {
        super(name, command);
    }

    @Override
    public String toString() {
        return "Cat";
    }
}