import java.util.Hashtable;

public class Main
{
    public static void main(String[] args)
    {
        Hashtable<String, Integer> Zmienne = new Hashtable<String, Integer>();
        Zmienne.put("x",5);
        System.out.println("x = " + Zmienne.get("x"));
        Zmienne.put("y",3);
        System.out.println("y = " + Zmienne.get("y"));

        Wyrazenie napis = new Pomnoz(new Stala(2), new Zmienna("x",Zmienne));
        napis = new Dodaj(new Stala(7), napis);
        napis = new Odejmij(napis, new Zmienna("y",Zmienne));
        napis = new Podziel(napis, new Stala(2));
        System.out.println(napis.toString() + " = " + napis.Oblicz());
    }
}