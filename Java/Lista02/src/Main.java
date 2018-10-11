import geometria.*;

public class Main {

    public static void main(String[] args) {

        Punkt p1 = new Punkt(1,1);
        Wektor w1 = new Wektor(2,-2);
        Wektor w2 = new Wektor(5, 4);

        Wektor w3 = Wektor.Dodaj(w1,w2);

        p1.przesun(w3);

        System.out.println(w3);
        System.out.println(p1);

        Prosta prosta = new Prosta(1,1,1);

        System.out.println(prosta);

        Prosta prosta2 = prosta.przesun(new Wektor(0,1));

        System.out.println(prosta2);

        Prosta prosta3 = new Prosta(-2,1,-3);
        Prosta prosta4 = new Prosta(2,1,-7);

        System.out.println(Prosta.punktPrzeciecia(prosta3, prosta4));

        Punkt p2 = new Punkt(0,0);
        p2.obroc(new Punkt(1,0), 90);

        System.out.println(p2);
    }
}
