package obliczenia;

import java.util.Objects;

public class Liczba extends Wyrazenie {

    private final double liczba;

    public Liczba(double liczba) {
        this.liczba = liczba;
    }

    @Override
    public double oblicz() {
        return liczba;
    }

    @Override
    public String toString() {
        return String.valueOf(liczba);
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        Liczba liczba1 = (Liczba) o;
        return Double.compare(liczba1.liczba, liczba) == 0;
    }
}
