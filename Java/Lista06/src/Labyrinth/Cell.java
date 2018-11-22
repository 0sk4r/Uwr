package Labyrinth;

public class Cell {

    public boolean left, right, top, bottom;
    public boolean visited;
    public boolean traget;

    public Cell() {
        this.left = true;
        this.right = true;
        this.top = true;
        this.bottom = true;

        this.visited = false;
        this.traget = false;
    }
}
