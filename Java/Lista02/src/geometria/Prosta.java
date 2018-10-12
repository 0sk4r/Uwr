package geometria;

public final class Prosta {

    public final double a,b,c;

    public Prosta(double a, double b, double c){
        this.a = a;
        this.b = b;
        this.c = c;
    }

    public Prosta przesun(Wektor v){

        double c = this.c + v.dy;
        c += this.a * -v.dx;

        return new Prosta(this.a, this.b, c);
    }

    public static Boolean czyRownolegla(Prosta p1, Prosta p2){
        return p1.a == p2.a;
    }

    public static Boolean czyProstopadla(Prosta p1, Prosta p2){
        return p1.a * p2.a == -1;
    }

    public static Punkt punktPrzeciecia(Prosta p1, Prosta p2){

        double delta = p1.a  * p2.b - p2.a * p1.b;

        double x = (p2.b * p1.c - p1.b * p2.c) /delta;
        double y = (p1.a * p2.c - p2.a * p1.c) /delta;

        return new Punkt(-x,-y);
    }


    @Override
    public String toString() {
        return "Prosta Ax:" + this.a + " By:" + this.b + " C:" + this.c;
    }
}
