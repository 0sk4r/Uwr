package GUI;

/*
    Copyright (c) November 2010 by PaweĹ Rzechonek
    Aplikacja okienkowa AWT - prezentuje moĹźliwoĹci klasy Canvas
    w przechwytywaniu zdarzeĹ od myszy i od klawiatury.
    Aby przechwytywaÄ zdarzenia od klawiatury trzeba najpierw wywoĹaÄ metodÄ
    setFocusable(true) na obiekcie Canvas.
*/

import java.awt.*;
import java.awt.event.*;

public class Window extends Frame
{
    private Color kolor = Color.BLACK;

    private Canvas LabirynthCanvas;

    private WindowListener frameList = new WindowAdapter()
    {
        @Override
        public void windowClosing (WindowEvent ev)
        {
            Window.this.dispose();
        }
    };


    private void define(int size){
        LabirynthCanvas=new LabirynthCanvas(this,10,10);
    }

    private void add(){
        add(LabirynthCanvas);
    }

    public Canvas getPanel() {
        return LabirynthCanvas;
    }

    public Window()
    {
        super("Labirynth");
        setSize(500, 500);
        setLocation(500, 500);
        addWindowListener(frameList);
        LabirynthCanvas=new LabirynthCanvas(this,10,10);
        add(LabirynthCanvas);
        setVisible(true);
    }
}