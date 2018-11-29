import Grafika.*;

import javax.swing.*;

public class Main {

    public static void main(String[] args) {

        GUI gui = new GUI();

        gui.pack();
        gui.setSize(1200, 800);
        gui.setLocationRelativeTo(null);
        gui.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);

        gui.setVisible(true);

    }
}
