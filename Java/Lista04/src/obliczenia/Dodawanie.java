package obliczenia;

/**
 * Dodawanie wyrażeń
 */
public class Dodawanie extends Op2Arg {

    public Dodawanie(Wyrazenie a1, Wyrazenie a2) {
        super(a1, a2);
    }


    /**
     * Oblicza wyrazenie dla podanej klasy
     * @return Wynik wyrazenia
     */
    @Override
    public double oblicz() throws Exception {
        return x.oblicz()+y.oblicz();
    }

    /**
     *
     * @return Reprezentacja wyrazenia
     */
    @Override
    public String toString() {
        return "("+x+"+"+y+")";
    }
}
