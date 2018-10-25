package obliczenia;

/**
 * Wybór minimum
 */
public class Minimum extends Op2Arg {

    public Minimum(Wyrazenie a1, Wyrazenie a2) {
        super(a1, a2);
    }

    /**
     * Oblicza wyrazenie dla podanej klasy
     * @return Wynik wyrazenia
     */
    @Override
    public double oblicz() throws Exception {
        return Math.min(x.oblicz(),y.oblicz());
    }

    /**
     *
     * @return Reprezentacja wyrazenia
     */
    @Override
    public String toString() {
        return "min("+x+" , "+y+")";
    }


}
