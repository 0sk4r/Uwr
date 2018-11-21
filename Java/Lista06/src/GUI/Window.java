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
    private Canvas LabirynthCanvas;

    private WindowListener frameList = new WindowAdapter()
    {
        @Override
        public void windowClosing (WindowEvent ev)
        {
            Window.this.dispose();
        }
    };


    public Window(int size, int width, int height)
    {
        super("Labirynth");
        setSize(size, size);
        setLocation(500, 500);
        addWindowListener(frameList);
        LabirynthCanvas=new LabirynthCanvas(this, size, width,height);
        add(LabirynthCanvas);
        setVisible(true);
    }
}