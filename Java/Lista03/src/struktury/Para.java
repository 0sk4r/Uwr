package struktury;

import java.util.Objects;

/**
 * Klasa reprezentujaca pary: {klucz, wartosc}
 */

public class Para {
    public final String klucz;
    private double wartosc;

    /**
     * Funkcja zwraca wartosc pary
     * @return
     */
    public double getWartosc() {
        return wartosc;
    }

    /**
     * Funkcja przyjmuje wartosc double i ustawia ja dla danej pary
     * @param wartosc double
     */
    public void setWartosc(double wartosc) {
        this.wartosc = wartosc;
    }

    public Para(String klucz, double wartosc) throws Exception {
        if(!klucz.isEmpty() && klucz != null) {
            this.klucz = klucz;
            this.setWartosc(wartosc);
        }
        else {
            throw new Exception("Klucz jest null lub pusty");
        }
    }

    /**
     * Zmienia obiekt na czytelną forme stringa
     * @return
     */
    @Override
    public String toString() {
        return "Para{" +
                "klucz='" + klucz + '\'' +
                ", wartosc=" + wartosc +
                '}';
    }

    /**
     * Sprawdza czy dwie pary są równe
     * @param p
     * @return
     */
    public boolean equals(Para p) {
        if(p == null) return  false;
        return Objects.equals(this.klucz, p.klucz);
    }
}
