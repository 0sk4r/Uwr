package obliczenia;

public class Maksimum extends Op2Arg {
    public Maksimum(Wyrazenie a1, Wyrazenie a2) {
        super(a1, a2);
    }

    @Override
    public double oblicz() throws Exception {

        return Math.max(x.oblicz(),y.oblicz());
    }

    /**
     *
     * @return Reprezentacja wyrazenia
     */
    @Override
    public String toString() {
        return "max("+x+" ,"+y+")";
    }
}
