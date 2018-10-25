import obliczenia.*;

import java.util.HashMap;

public class Main {

    public static void main(String[] args) {

        Zmienna.zmienne.put("x",2.0);
        Zmienna.zmienne.put("y",3.0);
//        3+5
        Obliczalny w1 = new Dodawanie(new Liczba(3), new Liczba(5));
//        2+x*7
        Obliczalny w2 = new Dodawanie(new Liczba(2), new Mnozenie(new Zmienna("x"), new Liczba(7)));
//        (3*11-1)/(7+5)
        Obliczalny w3 = new Dzielenie(new Odejmowanie(new Mnozenie(new Liczba(3), new Liczba(11)), new Liczba(1)),
                                        new Dodawanie(new Liczba(7), new Liczba(5)));
//        arctan(((x+13)*x)/2)
        Obliczalny w4 = new ArcTan(new Dzielenie(new Mnozenie(new Dodawanie(new Zmienna("x"), new Liczba(13)), new Zmienna("x")),new Liczba(2)));

//        pow(2,5)+x*log(2,y)
        Obliczalny w5 = new Dodawanie(new Potegowanie(new Liczba(2),new Liczba(5)), new Mnozenie(new Zmienna("x"), new Logarytmowanie(new Liczba(2), new Zmienna("y"))));

        try {
            System.out.println(w1);
            System.out.println(w1.oblicz());
        } catch (Exception e) {
            e.printStackTrace();
        }

        try {
            System.out.println(w2);
            System.out.println(w2.oblicz());
        } catch (Exception e) {
            e.printStackTrace();
        }
        try {
            System.out.println(w3);
            System.out.println(w3.oblicz());
        } catch (Exception e) {
            e.printStackTrace();
        }
        try {
            System.out.println(w4);
            System.out.println(w4.oblicz());
        } catch (Exception e) {
            e.printStackTrace();
        }
        try {
            System.out.println(w5);
            System.out.println(w5.oblicz());
        } catch (Exception e) {
            e.printStackTrace();
        }




    }
}
