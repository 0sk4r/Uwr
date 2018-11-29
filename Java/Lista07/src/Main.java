import Grafika.*;

import javax.swing.*;
import java.awt.*;
import java.awt.image.BufferedImage;

public class Main {

    public static Engine engine;

    public static void main(String[] args) {

        engine = Engine.getInstance();
        EventQueue.invokeLater(() -> {
            GUI gui = new GUI(engine);
            engine.setImage(new BufferedImage(500, 500, BufferedImage.TYPE_INT_RGB));

            gui.pack();
            gui.setSize(1200, 800);
            gui.setLocationRelativeTo(null);
            gui.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);

            gui.setVisible(true);

        });

    }
}
