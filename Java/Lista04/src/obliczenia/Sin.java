package obliczenia;

public class Sin extends Op1Arg {
    public Sin(Wyrazenie arg1) {
        super(arg1);
    }

    /**
     * Oblicza wyrazenie dla podanej klasy
     * @return Wynik wyrażenia
     */
    //@Override
    public double oblicz() throws Exception {
        return Math.sin(x.oblicz());
    }

    /*
    * @return Reprezentacja wyrażeniia
    */
    @Override
    public String toString() {
        return "sin("+x+")";
    }
}
