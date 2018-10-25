package obliczenia;

/**
 * Operator 2 argumentowy
 */
public class Op2Arg extends  Op1Arg {

    protected final Wyrazenie y;

    public Op2Arg (Wyrazenie a1, Wyrazenie a2) {
        super(a1);
        if (a2==null) throw new IllegalArgumentException();
        y = a2;
    }
}
