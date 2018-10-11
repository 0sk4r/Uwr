package geometria;

public class Wektor {

    public final double dx, dy;

    public Wektor(double dx, double dy){
        this.dx = dx;
        this.dy = dy;
    }

    public static Wektor Dodaj( Wektor v1, Wektor v2){

        double dx = v1.dx + v2.dx;
        double dy = v1.dy + v2.dy;

        return new Wektor(dx,dy);

    }

    public String toString() {
        return "(" + dx + "," + dy + ")";
    }
}
