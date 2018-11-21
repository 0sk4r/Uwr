package GUI;

import Labyrinth.Labyrinth;
import Labyrinth.DIR;

import javax.imageio.ImageIO;
import java.awt.*;
import java.awt.event.KeyAdapter;
import java.awt.event.KeyEvent;
import java.awt.event.KeyListener;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import java.util.Random;

public class LabirynthCanvas extends Canvas {

    private Labyrinth lab;
    private Window window;
    private int width, height, windowSize, cellSize;
    private int playerX = 0, playerY=0;
    private int playerIMGX, playerIMGY;
    private BufferedImage player;

    public LabirynthCanvas(Window window, int windowSize, int width, int height){
        this.window = window;
        this.height = height;
        this.width = width;
        this.windowSize = windowSize;
        this.cellSize = (windowSize - 20) / (height + 2);
        addKeyListener(keyList);
        lab = new Labyrinth(width, height);

        try{
            player = ImageIO.read(new File("src/player.png"));
        }
        catch (IOException e) {
            System.out.println(e.getMessage());
        }

        generateStartLocation();
    }

    private KeyListener keyList = new KeyAdapter()
    {
        @Override
        public void keyPressed (KeyEvent ev)
        {
            System.out.println(playerX);
            System.out.println(playerY);
            switch (ev.getKeyCode())
            {
                case KeyEvent.VK_UP:
                    System.out.println("Góra");
                    if(!lab.cells[playerY][playerX].top) movePlayer(DIR.UP);
                    break;
                case KeyEvent.VK_DOWN:
                    System.out.println("Dół");
                    if(!lab.cells[playerY][playerX].bottom) movePlayer(DIR.DOWN);
                    break;
                case KeyEvent.VK_LEFT:
                    System.out.println("Lewo");
                    if(!lab.cells[playerY][playerX].left) movePlayer(DIR.LEFT);
                    break;
                case KeyEvent.VK_RIGHT:
                    System.out.println("Prawo");
                    if(!lab.cells[playerY][playerX].right) movePlayer(DIR.RIGHT);

            }
        }
    };

    private void generateStartLocation(){
        Random generator = new Random();
        int side = generator.nextInt(4);
        System.out.println(side);
        switch (side){
            case 0:
                playerY = 0;
                playerIMGY = cellSize;
                playerX = generator.nextInt(width);
                playerIMGX = (playerX + 1) * cellSize;
                break;
            case 1:
                playerX = width;
                playerIMGX = cellSize * playerX;
                playerY = generator.nextInt(height);
                playerIMGY = (playerY + 1) * cellSize;
                break;
            case 2:
                playerY = height;
                playerIMGY = cellSize * playerY;
                playerX = generator.nextInt(width);
                playerIMGX = (playerX + 1) * cellSize;
                break;
            case 3:
                playerX = 0;
                playerIMGX = cellSize;
                playerY = generator.nextInt(height);
                playerIMGY = (playerY + 1) * cellSize;
                break;

        }
    }

    public void paint(Graphics graphics){
        //(0,0) cordinates
        int x =cellSize, y = cellSize * height;

        for(int i = 0; i < height; i++){
            for(int j = 0; j < width; j++){
                if(lab.cells[i][j].left){
                    graphics.drawLine(x,y,x,y+cellSize);
                }
                if(lab.cells[i][j].right){
                    graphics.drawLine(x+cellSize,y,x+cellSize,y+cellSize);
                }
                if(lab.cells[i][j].bottom){
                    graphics.drawLine(x,y+cellSize,x+cellSize,y+cellSize);
                }
                if(lab.cells[i][j].top){
                    graphics.drawLine(x,y,x+cellSize,y);
                }

                x = x + cellSize;
            }
            x = cellSize;
            y = y - cellSize;
        }

        graphics.drawImage(player,playerIMGX, playerIMGY,cellSize,cellSize, this);
    }

    public void movePlayer(DIR direction){
        playerX += direction.dx;
        playerY += direction.dy;

        playerIMGX += direction.dx * cellSize;
        playerIMGY -= direction.dy * cellSize;

        repaint();
    }


}
