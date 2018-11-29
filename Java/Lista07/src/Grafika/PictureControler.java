package Grafika;

import javax.imageio.ImageIO;
import java.awt.*;
import java.awt.geom.AffineTransform;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;

public class PictureControler {

    private static final double ZOOM_MAX = 8;
    private static PictureControler ourInstance = new PictureControler();
    private Color leftColor, rightColor;
    private File file;
    private BufferedImage image;
    private double zoom = 1.0;
    private Point lastMousePos = new Point(0, 0);
    private AffineTransform transformation = new AffineTransform();

    private PictureControler() {
        leftColor = Color.BLACK;
        rightColor = Color.WHITE;
    }

    public static PictureControler getInstance() {
        return ourInstance;
    }


    public Color getLeftColor() {
        return leftColor;
    }

    public void setLeftColor(Color color) {
        this.leftColor = color;
    }

    public File getFile() {
        return file;
    }

    public void setFile(File file) {
        this.file = file;
        try {
            setImage(ImageIO.read(file));
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    public BufferedImage getImage() {
        return image;
    }

    public void setImage(BufferedImage image) {
        this.image = image;
    }

    public void zoomIn() {
        if (zoom < ZOOM_MAX) {
            transformation.scale(1f / zoom, 1f / zoom);
            if (zoom >= 1.0)
                zoom += 1.0;
            else
                zoom = 1.0 / (1.0 / zoom - 1.0);
            transformation.scale(zoom, zoom);
        }
    }

    public void zoomOut() {
        if (zoom > 1.0) {
            transformation.scale(1f / zoom, 1f / zoom);
            if (zoom > 1)
                zoom -= 1.0;
            else
                zoom = 1.0 / (1.0 / zoom + 1.0);
            transformation.scale(zoom, zoom);
        }

    }

    public Point toImageCoordinates(Point p) {
        return new Point((int) (p.x / transformation.getScaleX()), (int) (p.y / transformation.getScaleX()));
    }

    public AffineTransform getTransformation() {
        return this.transformation;
    }

    public Point getLastMousePos() {
        return lastMousePos;
    }

    public void setLastMousePos(Point lastMousePos) {
        this.lastMousePos = lastMousePos;
    }


    public void draw(Point pos, Color color) {
        Point p = toImageCoordinates(pos);

        if (p.x < 0 || p.x >= image.getWidth() || p.y < 0 || p.y >= image.getHeight())
            return;
        Graphics2D g2 = (Graphics2D) image.getGraphics();
        g2.setColor(color);

        g2.fillRect(p.x, p.y, 1, 1);
    }

    public Color getRightColor() {
        return rightColor;
    }

    public void setRightColor(Color rightColor) {
        this.rightColor = rightColor;
    }
}
