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
    }

    private void initLabyrinth(int width, int height){
        for(int y=0; y<height; y++){
            for(int x=0; x<width; x++){
                cells[y][x] = new Cell();
            }
        }

        cells[height-1][width-1].traget = true;

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
                    cells[cy][cx].top = false;
                    cells[ny][nx].bottom = false;
                }
                else if(dir == DIR.DOWN){
                    cells[cy][cx].bottom = false;
                    cells[ny][nx].top = false;
                }
                else if(dir == DIR.LEFT){
                    cells[cy][cx].left = false;
                    cells[ny][nx].right = false;
                }
                else if(dir == DIR.RIGHT){
                    cells[cy][cx].right = false;
                    cells[ny][nx].left = false;
                }
                generateLabyrinth(nx, ny);
            }
        }
    }

}
