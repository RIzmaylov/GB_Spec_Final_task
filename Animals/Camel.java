package Animals;

import java.util.List;

public class Camel extends PackAnimal {
    public Camel(String name, List<String> command) {
        super(name, command);
    }

    @Override
    public String toString() {
        return "Camel";
    }
}
