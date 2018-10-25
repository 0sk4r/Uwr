package obliczenia;

/**
 * Odwrotność liczby
 */
public class Odwrotnosc extends Op1Arg {

    /** Oblicza wyrażenie dla podanej klasy
     * @return Odwrotność liczby
     */
    //@Override
    public double oblicz() throws Exception {
        if (x.oblicz()==0) throw new IllegalArgumentException("Dzielenie przez zero");
        return 1/x.oblicz();
    }

    public Odwrotnosc(Wyrazenie x) {
        super(x);
    }

    /**
     *
     * @return Reprezentacja odwrotności
     */
    @Override
    public String toString() {
        return "(1/"+x+")";
    }

}
