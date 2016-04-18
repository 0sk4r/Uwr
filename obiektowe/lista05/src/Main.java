import java.util.ArrayList;
import java.util.Collections;

public class Main {
    public static void main(String[] args)
    {
        ArrayList<Stopnie> Wojsko = new ArrayList<Stopnie>();

        Wojsko.add(new Szeregowy("Szeregowy 1"));
        Wojsko.add(new Porucznik("Porucznik 2"));
        Wojsko.add(new Kapral("Kapral 3"));
        Wojsko.add(new Sierzant("Sierzant 4"));

        Collections.sort(Wojsko);

        for(Stopnie zolnierz : Wojsko) System.out.println(zolnierz);

    }
}
