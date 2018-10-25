package obliczenia;

public class Logarytmowanie extends Op2Arg {
    public Logarytmowanie(Wyrazenie a1, Wyrazenie a2) {
        super(a1, a2);
    }

    /**
     * Oblicza wyrazenie dla podanej klasy
     * @return Wynik wyrazenia
     */
    @Override
    public double oblicz() throws Exception {
        double y_1 = Math.log(x.oblicz());
        double x_1 = Math.log(y.oblicz());
        if (y_1 == 0) throw new IllegalArgumentException("Dzielenie przez zero");
        return x_1 / y_1;
    }

    /**
     *
     * @return Reprezentacja wyrazenia
     */
    @Override
    public String toString() {
        return "log("+y+","+x+")";
    }
}
