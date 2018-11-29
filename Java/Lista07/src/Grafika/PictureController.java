package Grafika;

import javax.imageio.ImageIO;
import java.awt.*;
import java.awt.geom.AffineTransform;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;

public class PictureController {

    private static final double ZOOM_MAX = 8;
    private static PictureController ourInstance = new PictureController();
    private Color leftColor, rightColor;
    private File file;
    private BufferedImage image;
    private double zoom = 1.0;
    private Point lastMousePos;
    private AffineTransform transformation = new AffineTransform();

    private PictureController() {
        leftColor = Color.BLACK;
        rightColor = Color.WHITE;
        lastMousePos = new Point(0, 0);
        setImage(new BufferedImage(500, 500, BufferedImage.TYPE_INT_RGB));
    }

    public static PictureController getInstance() {
        return ourInstance;
    }


    public Color getLeftColor() {
        return leftColor;
    }

    public void setLeftColor(Color color) {
        this.leftColor = color;
    }

    public Color getRightColor() {
        return rightColor;
    }

    public void setRightColor(Color rightColor) {
        this.rightColor = rightColor;
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

    public Point convertToImgCordiantes(Point p) {
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
        Point p = convertToImgCordiantes(pos);

        if (p.x < 0 || p.x >= image.getWidth() || p.y < 0 || p.y >= image.getHeight())
            return;

        Graphics2D g2 = (Graphics2D) image.getGraphics();
        g2.setColor(color);

        g2.fillRect(p.x, p.y, 1, 1);
    }
}
