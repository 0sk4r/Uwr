package Labyrinth;

import java.util.Arrays;
import java.util.Collections;

public class Labyrinth {

    private int width, height;
    public Cell[][] cells;

    public Labyrinth(int width, int height){

        this.width = width;
        this.height = height;
        this.cells = new Cell[width][height];

        initLabyrinth(width, height);

        generateLabyrinth(0,0);
        display();

    }

    private void initLabyrinth(int width, int height){
        for(int y=0; y<height; y++){
            for(int x=0; x<width; x++){
                cells[y][x] = new Cell();
            }
        }

    }

    private void generateLabyrinth(int cx, int cy){
        DIR[] dirs = DIR.values();
        Collections.shuffle(Arrays.asList(dirs));
        cells[cx][cy].visited = true;


        for (DIR dir : dirs) {
            int nx = cx + dir.dx;
            int ny = cy + dir.dy;

            if (((nx >= 0) && (nx < this.width)) && ((ny >=0) && (ny < this.height)) && (!cells[nx][ny].visited)) {
                if(dir == DIR.UP){
                    cells[cx][cy].top = false;
                    cells[nx][ny].bottom = false;
                }
                else if(dir == DIR.DOWN){
                    cells[cx][cy].bottom = false;
                    cells[nx][ny].top = false;
                }
                else if(dir == DIR.LEFT){
                    cells[cx][cy].left = false;
                    cells[nx][ny].right = false;
                }
                else if(dir == DIR.RIGHT){
                    cells[cx][cy].right = false;
                    cells[nx][ny].left = false;
                }
                generateLabyrinth(nx, ny);
            }
        }
    }

    private enum DIR {
        UP(0,1), DOWN(0,-1), LEFT(-1,0), RIGHT(1,0);

        private final int dx;
        private final int dy;

        DIR(int dx, int dy) {
            this.dx = dx;
            this.dy = dy;
        }
    }

    private void display() {
        for (int i = 0; i < height; i++) {
            // draw the north edge
            for (int j = 0; j < width; j++) {
                System.out.print((cells[j][i].top) ? "+---" : "+   ");
            }
            System.out.println("+");
            // draw the west edge
            for (int j = 0; j < width; j++) {
                System.out.print((cells[j][i].left) ? "|   " : "    ");
            }
            System.out.println("|");
        }
        // draw the bottom line
        for (int j = 0; j < width; j++) {
            System.out.print("+---");
        }
        System.out.println("+");
    }

}
