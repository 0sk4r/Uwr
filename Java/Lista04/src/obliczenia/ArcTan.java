package obliczenia;

/**
 * Arctangens
 */
public class ArcTan extends Op1Arg {
    public ArcTan(Wyrazenie arg1) {
        super(arg1);
    }

    /**
     * Oblicza wyrazenie dla podanej klasy
     * @return Wynik wyrazenia
     */
    @Override
    public double oblicz() throws Exception {
        return Math.atan(x.oblicz());
    }

    /**
     * @return Reprezentacja wyrazenia
     */
    @Override
    public String toString() {
        return "arctag("+x+")";
    }
}
