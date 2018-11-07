package obliczenia;

abstract class Wyrazenie implements Obliczalny {



    /** Metoda mnozaca wyrazenia
     * @param args Ciag wyrazen
     * @return wynik operacji sumowania argumentow
     */
    public static double sumuj (Wyrazenie...args) throws Exception {
        double suma=0f;
        for (Wyrazenie arg : args) {
            suma = suma + arg.oblicz();
        }
        return suma;
    }

    /** Metoda mnozaca wyrazenia
     * @param args Ciag wyrazen
     * @return wynik operacji wymnozenia argumentow
     */
    public static double pomnoz (Wyrazenie...args) throws Exception {
        double suma=0f;
        for (Wyrazenie arg : args) {
            suma = suma * arg.oblicz();
        }
        return suma;
    }

    /**
     * Porównanie obiektów
     * @param o Obiekt do porównania
     * @return  boolowskie true albo false
     */
    @Override
    public boolean equals(Object o) {
        if(this==o) return true;
        if((o==null) || (getClass() != o.getClass())) return false;
        Wyrazenie wyr = (Wyrazenie) o;
        try {
            return oblicz() == wyr.oblicz();
        } catch (Exception e) {
            return false;
        }
    }
}
