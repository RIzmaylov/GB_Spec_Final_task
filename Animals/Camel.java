package Animals;

import java.util.ArrayList;
import java.util.List;

public class Camel extends PackAnimal {
    public Camel(String name, ArrayList<String> command) {
        super(name, command);
    }

    @Override
    public String toString() {
        return "Camel";
    }
}
