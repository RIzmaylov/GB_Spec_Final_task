package Animals;

import java.util.ArrayList;
import java.util.List;

public abstract class Pet extends Animal {
    public Pet(String name, ArrayList<String> commands) {
        super(name, commands);
    }
}