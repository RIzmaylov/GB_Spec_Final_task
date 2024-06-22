package Animals;

import java.util.ArrayList;

public abstract class Pet extends Animal {
    public Pet(String name, ArrayList<String> commands) {
        super(name, commands);
    }
}