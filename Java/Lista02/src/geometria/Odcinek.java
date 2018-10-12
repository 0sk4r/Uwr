package geometria;

public class Odcinek {

    private Punkt p1, p2;

    public Odcinek(Punkt p1, Punkt p2) throws Exception {

        if (p1.equals(p2)){
            throw new Exception("Podano te same pkt");
        }
        else {
            this.p1 = p1;
            this.p2 = p2;
        }
    }

    public void przesun(Wektor v){
        this.p1.przesun(v);
        this.p1.przesun(v);
    }

    public void obroc(Punkt p, double kat){
        this.p1.obroc(p,kat);
        this.p2.obroc(p, kat);
    }

    public void odbij(Prosta p){
        this.p1.odbij(p);
        this.p2.odbij(p);
    }

    @Override
    public String toString() {
        return "Odcinek: " + this.p1 + this.p2;
    }
}
