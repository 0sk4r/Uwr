public abstract class Stopnie implements Comparable<Stopnie>
{
    public String Nazwa;
    public abstract int Stopien();

    public int compareTo(Stopnie st)
    {
        if(st.Stopien() == this.Stopien()) return 0;
        else if(st.Stopien() < this.Stopien()) return 1;
        else return -1;
    }

    public String toString()
    {
        return "Stopien wojskowy " + Nazwa + " poziom " + Stopien() + "\n";
    }

}
