package GUI;

import Labyrinth.Labyrinth;

import java.awt.*;

public class LabirynthCanvas extends Canvas {

    private Labyrinth lab;
    private Window window;
    private int width, height;

    public LabirynthCanvas(Window window, int width, int height){
        this.window = window;
        this.height = height;
        this.width = width;

        lab = new Labyrinth(width, height);
    }

    public void paint(Graphics graphics){
        int size = 30;

        int x = 10, y = size*height;

        for(int i = 0; i < height; i++){
            for(int j = 0; j < width; j++){
                if(lab.cells[i][j].left){
                    graphics.drawLine(x,y,x,y+size);
                }
                if(lab.cells[i][j].right){
                    graphics.drawLine(x+size,y,x+size,y+size);
                }
                if(lab.cells[i][j].bottom){
                    graphics.drawLine(x,y+size,x+size,y+size);
                }
                if(lab.cells[i][j].top){
                    graphics.drawLine(x,y,x+size,y);
                }

                x = x + size;
            }
            x = 10;
            y = y - size;

        }
    }
}
