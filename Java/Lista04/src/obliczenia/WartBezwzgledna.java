package obliczenia;

/**
 * Wartość bezwzględna wyrażenia
 */
public class WartBezwzgledna extends Op1Arg{

    public WartBezwzgledna(Wyrazenie arg1) {
        super(arg1);
    }

    /**
     * Oblicza wyrazenie dla podanej klasy
     * @return Wynik wyrażenia
     */
    //@Override
    public double oblicz() throws Exception {
        return Math.abs(x.oblicz());
    }

    /**
     *
     * @return Reprezentacja wyrażenia
     */
    @Override
    public String toString() {
        return "(|"+x+"|)";
    }

}
