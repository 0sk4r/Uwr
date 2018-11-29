package Grafika;

import javax.swing.*;
import java.awt.*;

public class Window extends JFrame {

        private ToolBar tool;
//        private InfoBar info;
        private Picture picture;
        public JDesktopPane desktop;

    public Window() {
        super("Paint");
        picture = new Picture();
        desktop=new JDesktopPane();
//        menu=new MenuBar(this);
        tool=new ToolBar(this, picture);
        add();
        settings();

    }

    private void add() {
        setLayout(new BorderLayout());
//        setJMenuBar(menu);
        add(tool, BorderLayout.NORTH);
        add(desktop);
    }

    private  void settings(){
        setDefaultCloseOperation(javax.swing.WindowConstants.EXIT_ON_CLOSE);
        setLocation(80, 80);
        setSize(800, 500);
        setResizable(true);
        setVisible(true);
    }

    public void close(){
        this.dispose();
    }

    public JDesktopPane getDesktop() {
        return desktop;
    }
    }
