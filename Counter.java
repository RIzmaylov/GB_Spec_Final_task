public class Counter implements AutoCloseable {
    private static int count;

    public void increment() {
        count++;
    }

    @Override
    public void close() throws Exception {
        if (count < 0) {
            throw new Exception();
        }
    }
}
