package geometria;

import static java.lang.Math.cos;

public class Punkt {

    private double x, y;

    public Punkt (double x, double y)
    {
        this.x = x;
        this.y = y;
    }


    public Punkt ()
    {
        this(0,0);
    }

    public void przesun(Wektor v){
        this.x += v.dx;
        this.y += v.dy;
    }

    public void obroc(Punkt p, double kat){
        double x = Math.cos(Math.toRadians(kat)) + (this.x - p.x) - Math.sin(Math.toRadians(kat)) * (this.y - p.y) + p.x;
        double y = Math.sin(Math.toRadians(kat)) * (this.x - p.x) + Math.cos(Math.toRadians(kat)) * (this.y - p.y) + p.y;

        this.x = x;
        this.y = y;
    }
    public String toString ()
    {
        return "("+x+", "+y+")";
    }


}
