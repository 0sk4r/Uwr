package geometria;

public class Trojkat {

    private Punkt punkt1, punkt2, punkt3;

    public Trojkat(Punkt punkt1, Punkt punkt2, Punkt punkt3) throws Exception {

        if (!punkt1.equals(punkt2) && !punkt2.equals(punkt3) && !punkt1.equals(punkt3)) {
            double det = punkt1.getX() * punkt2.getY() + punkt2.getX() * punkt3.getY() + punkt2.getX() * punkt1.getY() - punkt3.getX() * punkt2.getY() - punkt1.getX() * punkt3.getY() - punkt2.getX() * punkt1.getY();
            if (det == 0) {
                this.punkt1 = punkt1;
                this.punkt2 = punkt2;
                this.punkt3 = punkt3;
            } else throw new Exception("Punkty sa wspollinowe");
        } else throw new Exception("Podano te same punkty");
    }

    public void przesun(Wektor v) {
        this.punkt1.przesun(v);
        this.punkt2.przesun(v);
        this.punkt3.przesun(v);
    }

    public void obroc(Punkt p, double kat) {
        this.punkt1.obroc(p, kat);
        this.punkt2.obroc(p, kat);
        this.punkt3.obroc(p, kat);
    }

    public void odbij(Prosta p) {
        this.punkt1.odbij(p);
        this.punkt2.odbij(p);
        this.punkt3.odbij(p);
    }
}

