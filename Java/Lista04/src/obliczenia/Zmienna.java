package obliczenia;

import java.util.HashMap;

/**
 * Zmienna
 */
public class Zmienna extends Wyrazenie {

    public static final HashMap zmienne = new HashMap<String, Double>();
    public final String x;

    public Zmienna(String x) {
        this.x = x;
    }


    /**
     * Oblicza wyrazenie dla podanej klasy
     * @return Wynik wyrazenia
     */
    @Override
    public double oblicz() throws Exception {
        try{
            return (double) zmienne.get(this.x);
        }
        catch (Exception e){
            System.out.println(e.getMessage());
            throw new Exception("Nie zdefiniowana zmienna");
        }
    }

    /**
     *
     * @return Reprezentacja wyrazenia
     */
    @Override
    public String toString() {
        return x;
    }
}
