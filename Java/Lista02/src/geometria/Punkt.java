package geometria;

import java.util.Objects;

public class Punkt {

    private double x, y;

    public Punkt(double x, double y) {
        this.x = x;
        this.y = y;
    }


    public Punkt() {
        this(0, 0);
    }

    public void przesun(Wektor v) {
        this.x += v.dx;
        this.y += v.dy;
    }

    public void obroc(Punkt p, double kat) {

        double x = Math.cos(Math.toRadians(kat)) + (this.x - p.x) - Math.sin(Math.toRadians(kat)) * (this.y - p.y) + p.x;
        double y = Math.sin(Math.toRadians(kat)) * (this.x - p.x) + Math.cos(Math.toRadians(kat)) * (this.y - p.y) + p.y;

        this.x = x;
        this.y = y;
    }

    public double getX() {
        return x;
    }

    public double getY() {
        return y;
    }

    public void odbij(Prosta p){
        Prosta prostopadla = new Prosta(-1/p.a, p.b, p.c);
        Punkt przeciecie = Prosta.punktPrzeciecia(p,prostopadla);

        double x = 2 * przeciecie.x - this.x;
        double y = 2 * przeciecie.y - this.y;

        this.x = x;
        this.y = y;
    }

    public boolean equals(Punkt p) {
        return Double.compare(p.getX(), getX()) == 0 &&
                Double.compare(p.getY(), getY()) == 0;
    }
    public String toString() {

        return "Punkt (" + x + ", " + y + ")";
    }


}
