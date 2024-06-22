package Animals;

import java.util.ArrayList;
import java.util.List;

public abstract class Animal {
    protected String name;
    protected List<String> commands;

    public Animal(String name, List<String> commands) {
        this.name = name;
        this.commands = commands;
    }

    public List<String> getCommands() {
        return new ArrayList<>(commands);
    }

    public void addCommand(String command) {
        commands.add(command);
    }

    public String getName() {
        return name;
    }
}
