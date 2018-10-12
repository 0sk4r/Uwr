import geometria.*;

public class Main {

    public static void main(String[] args) {

        Punkt punkt1 = new Punkt(1,1);
        Wektor wektor1 = new Wektor(-2,3);
        Prosta prosta1 = new Prosta(1,1,0);

        System.out.println(punkt1);
        System.out.println("Przesuwamy " + punkt1 + " o " + wektor1);
        punkt1.przesun(wektor1);
        System.out.println(punkt1);

        System.out.println("Odbijamy " + punkt1 + " wzgledem " + prosta1);
        punkt1.odbij(prosta1);
        System.out.println(punkt1);

        try{
            Odcinek odcinek1 = new Odcinek(new Punkt(1,1), new Punkt(1,1));
            System.out.println("Utworzono odcinek z identycznych pkt");
        }
        catch (Exception e){
            System.out.println(e.getMessage());
        }

        try {
            Odcinek odcinek2 = new Odcinek(new Punkt(1, 1), new Punkt(1, -1));
            System.out.println(odcinek2);
        }
        catch (Exception e){
            System.out.println(e.getMessage());
        }

        try {
            Trojkat trojkat1 = new Trojkat(new Punkt(-1,-1), new Punkt(1,1), new Punkt(2,2));
        }
        catch (Exception e){
            System.out.println(e.getMessage());
        }

        Wektor wektor3 = new Wektor(1,2);
        Wektor wektor2 = new Wektor(3,1);

        System.out.println("Suma wektorow to: " + Wektor.Dodaj(wektor2,wektor3));

        Prosta prosta2 = new Prosta(1,1,0);
        Prosta prosta3 = new Prosta(-1,1,0);
        Prosta prosta4 = prosta2.przesun(new Wektor(0,1));

        System.out.println("Prosta przesunieta: " + prosta4);
        System.out.println("Czy prosta2 i prosta4 są równoległe: " + Prosta.czyRownolegla(prosta2,prosta4));
        System.out.println("Czy prosta2 i prosta3 są równoległe: " + Prosta.czyRownolegla(prosta2,prosta3));

        System.out.println("Czy prosta2 i prosta4 są prostopadle: " + Prosta.czyProstopadla(prosta2,prosta4));
        System.out.println("Czy prosta2 i prosta3 są prostopadle: " + Prosta.czyProstopadla(prosta2,prosta3));

        System.out.println("Punkt przeciecia: " + Prosta.punktPrzeciecia(prosta2,prosta3));
    }
}
