import Calendar.GUI;

import javax.swing.*;
import java.awt.*;

public class Main {

    public static void main(String[] args) {

        GUI gui = new GUI("Lista08");
        gui.pack();
        gui.setSize(new Dimension(800, 800));
        gui.setLocationRelativeTo(null);
        gui.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);

        gui.setVisible(true);

    }
}
