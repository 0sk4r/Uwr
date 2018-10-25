package obliczenia;

/**
 * Cosinus
 */
public class Cos extends Op1Arg {
    public Cos(Wyrazenie arg1) {
        super(arg1);
    }

    /**
     * Oblicza wyrazenie dla podanej klasy
     * @return Wynik wyrazenia
     */
    @Override
    public double oblicz() throws Exception {
        return Math.cos(x.oblicz());
    }

    /**
     *
     * @return Reprezentacja wyrazenia
     */
    @Override
    public String toString() {
        return "cos("+x+")";
    }
}
