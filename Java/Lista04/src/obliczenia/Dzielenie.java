package obliczenia;

/**
 * Dzielenie wyrażeń
 */
public class Dzielenie extends Op2Arg {

    public Dzielenie(Wyrazenie a1, Wyrazenie a2) {
        super(a1, a2);
    }

    /**
     * Oblicza wyrazenie dla podanej klasy
     * @return Wynik wyrazenia
     */
    @Override
    public double oblicz() throws Exception {
        double y1 = y.oblicz();
        if (y1==0) throw new  IllegalArgumentException("Dzielenie przez Zero");
        return x.oblicz()/y1;
    }

    /**
     *
     * @return Reprezentacja wyrazenia
     */
    @Override
    public String toString() {
        return "("+x+" / "+y+")";
    }

}
