import struktury.Para;
import struktury.ZbiorNaTablicy;
import struktury.ZbiorNaTablicyDynamicznej;

/**
 * Lista 03
 * Kurs języka java
 * UWr
 *
 * @author  Oskar Sobczyk
 * @version 1.0
 * @since   2018-20-10
 */
public class Main {
    public static void main(String[] args){

        try{

            ZbiorNaTablicy z1 = new ZbiorNaTablicy(6);
            z1.wstaw(new Para("jeden", 1));
            z1.wstaw(new Para("dwa", 2));
            z1.wstaw(new Para("trzy", 3));
            z1.wstaw(new Para("cztery", 4));
            z1.ustaw(new Para("piec",5));

            Para p = z1.szukaj("jeden");
            System.out.println(p);

            System.out.println("Jest elementow w zbiorze: " + z1.ile());
            System.out.println(z1.czytaj("piec"));
            z1.ustaw(new Para("piec",10));
            System.out.println(z1.czytaj("piec"));
            z1.ustaw(new Para("szesc", 6));
            System.out.println(z1.czytaj("szesc"));
            z1.ustaw(new Para("siedem", 7));

            z1.czysc();
            System.out.println("Jest elementow w zbiorze: " + z1.ile());

        }
        catch (Exception e){
            System.out.println(e.getMessage());
        }

        try{
            ZbiorNaTablicy z2 = new ZbiorNaTablicyDynamicznej(2);
            z2.wstaw(new Para("jeden", 1));
            z2.wstaw(new Para("dwa", 2));
            z2.wstaw(new Para("trzy", 3));
            z2.wstaw(new Para("cztery", 4));

            System.out.println("Ilosc elementow: " + z2.ile());
            System.out.println(z2.czytaj("jeden"));
            System.out.println(z2.szukaj("cztery"));
            z2.ustaw(new Para("jeden",2));
            System.out.println(z2.czytaj("jeden"));
            z2.czysc();
            System.out.println("Ilosc elementow: " + z2.ile());

        }
        catch (Exception e){
            System.out.println(e.getMessage());
        }
    }
}
