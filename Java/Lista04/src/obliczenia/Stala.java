package obliczenia;

public class Stala extends Wyrazenie {

    private final double liczba;

    @Override
    public double oblicz() {
        return liczba;
    }

    public Stala(double liczba) {
        this.liczba = liczba;
    }

    @Override
    public String toString() {
        return String.valueOf(liczba);
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        Stala stala = (Stala) o;
        return Double.compare(stala.liczba, liczba) == 0;
    }
}
