package obliczenia;

public class Op1Arg extends Wyrazenie {

    protected final Wyrazenie x;

    public Op1Arg (Wyrazenie arg1) {
        if (arg1==null) throw new IllegalArgumentException();
        x = arg1;
    }

    @Override
    public double oblicz() throws Exception {
        return x.oblicz();
    }
}
