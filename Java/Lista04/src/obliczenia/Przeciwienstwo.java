package obliczenia;

/**
 * Liczba przeciwna do wyrażenia
 */
public class Przeciwienstwo extends Op1Arg {

    public Przeciwienstwo(Wyrazenie arg1) {
        super(arg1);
    }

    /** Oblicza wartość przeciwną
     * @return Wartość przeciwna
     */
    public double oblicz() throws Exception {
        return -x.oblicz();
    }

    /**
     *
     * @return Reprezentacja liczby przeciwnej
     */
    @Override
    public String toString() {
        return "(-"+x+")";
    }

}
