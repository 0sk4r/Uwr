import java.awt.EventQueue;

import javax.swing.JFrame;

public class Main
{
    public static void main(String[] args)
    {
        String plik  = args[0];
        String klasa = args[1];

        EventQueue.invokeLater(new Runnable() {
            public void run()
            {
                JFrame ex;

                if(klasa == "Ksiazka") ex = new EdytorKsiazki(plik);
                else if(klasa == "Czasopismo") ex = new EdytorCzasopisma(plik);
                else if (klasa == "Wydawnictwociagle") ex = new EdytorWydawnictwaCiaglego(plik);

                ex.setVisible(true);
            }
        });
    }
}