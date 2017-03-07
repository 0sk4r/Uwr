public class Main
{

    public static void main(String[] args)
    {
        int[] T = {3,1,15,2,6,9,4};

        MergeSort sort = new MergeSort(T, 0, 7); sort.start();

        try
        {
            sort.join();
        }
        catch(Exception e) {}

        for(int i = 0; i < 7; i++) System.out.println(T[i]);
    }
}