import java.io.Serializable;

public class Ksiazka implements Serializable
{
    public String Tytul, autor;
    public int wydanie;

    public Ksiazka(String T, String a, int w)
    {
        Tytul = T; autor = a; wydanie = w;
    }

    public Ksiazka() { this("Tytul", "Autor", 11111); }

    public String toString()
    {
        return Tytul + "\n" + autor + "\n" + Integer.toString(wydanie);
    }
}