package Grafika;

import javax.imageio.ImageIO;
import javax.swing.*;
import javax.swing.filechooser.FileNameExtensionFilter;
import java.awt.*;
import java.awt.event.MouseAdapter;
import java.awt.event.MouseEvent;
import java.awt.event.MouseMotionAdapter;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;

public class GUI extends JFrame {
    private PictureController pictureController;

    private JList<MyColor> colorPaletteLeft;
    private JPanel rootPanel;
    private JPanel sidemenu;
    private JPanel canvas;
    private JLabel footer;
    private JButton fileButton;
    private JButton zoomInButton;
    private JButton zoomOutButton;
    private JButton upButton;
    private JButton downButton;
    private JButton leftButton;
    private JButton rightButton;
    private JButton colorButtonLeft;
    private JToolBar toolbar;
    private JScrollPane canvasScroll;
    private JScrollPane colorPaletteScroll;
    private JSplitPane split;
    private JButton newImageButton;
    private JButton saveButton;
    private JList<MyColor> colorPaletteRight;
    private JButton colorButtonRight;
    private JFileChooser fileChooser;
    private DefaultListModel<MyColor> colorPaletteList;


    public GUI() {
        super("Paint");

        this.pictureController = PictureController.getInstance();

        this.fileChooser = new JFileChooser();
        this.fileChooser.addChoosableFileFilter(new FileNameExtensionFilter("jpg", "jpg"));
        this.fileChooser.addChoosableFileFilter(new FileNameExtensionFilter("png", "png"));
        this.fileChooser.addChoosableFileFilter(new FileNameExtensionFilter("bmp", "bmp"));

        setContentPane(rootPanel);

        addControlers();
        updateUI();
        updateLabel();
    }

    private void createUIComponents() {


        colorPaletteList = new DefaultListModel<MyColor>();
        colorPaletteList.addElement(new MyColor("BLACK", Color.BLACK));
        colorPaletteList.addElement(new MyColor("BLUE", Color.BLUE));
        colorPaletteList.addElement(new MyColor("CYAN", Color.CYAN));
        colorPaletteList.addElement(new MyColor("GRAY", Color.GRAY));
        colorPaletteList.addElement(new MyColor("DARK GRAY", Color.DARK_GRAY));
        colorPaletteList.addElement(new MyColor("GREEN", Color.GREEN));
        colorPaletteList.addElement(new MyColor("LIGHT GRAY", Color.LIGHT_GRAY));
        colorPaletteList.addElement(new MyColor("MAGENTA", Color.MAGENTA));
        colorPaletteList.addElement(new MyColor("ORANGE", Color.ORANGE));
        colorPaletteList.addElement(new MyColor("PINK", Color.PINK));
        colorPaletteList.addElement(new MyColor("RED", Color.RED));
        colorPaletteList.addElement(new MyColor("WHITE", Color.WHITE));
        colorPaletteList.addElement(new MyColor("YELLOW", Color.YELLOW));

        colorPaletteLeft = new JList<MyColor>(colorPaletteList);
        colorPaletteRight = new JList<>(colorPaletteList);

        // canvas
        canvas = new JPanel() {
            @Override
            protected void paintComponent(Graphics g) {

                Graphics2D g2 = (Graphics2D) g;
                super.paintComponent(g2);
                BufferedImage img = pictureController.getImage();
                if (img != null) {
                    g2.drawImage(img, pictureController.getTransformation(), this);
                    updateCanvasViewport();
                }

            }
        };
    }

    private void addControlers() {

        // Open file
        fileButton.addActionListener(e -> {
            if (fileChooser.showOpenDialog(null) == JFileChooser.APPROVE_OPTION) {
                pictureController.setFile(fileChooser.getSelectedFile());
                updateCanvasViewport();
                updateUI();
                updateLabel();
                repaint();
            }
        });


        //Save File
        saveButton.addActionListener(e -> {
            File saveFile;
            String extension;
            if (fileChooser.showSaveDialog(null) == JFileChooser.APPROVE_OPTION) {
                saveFile = fileChooser.getSelectedFile();
                extension = fileChooser.getFileFilter().getDescription();
                try {
                    ImageIO.write(pictureController.getImage(), extension, saveFile.getAbsoluteFile());
                } catch (IOException e1) {
                    e1.printStackTrace();
                }
            }
        });


        //Zoom action
        zoomInButton.addActionListener(e -> {

            pictureController.zoomIn();

            scaleInterface();
        });

        zoomOutButton.addActionListener(e -> {
            pictureController.zoomOut();

            scaleInterface();
        });


        // Move actions
        upButton.addActionListener(e -> {
            JScrollBar vertical = canvasScroll.getVerticalScrollBar();
            vertical.setValue(vertical.getMinimum());
        });
        downButton.addActionListener(e -> {
            JScrollBar vertical = canvasScroll.getVerticalScrollBar();
            vertical.setValue(vertical.getMaximum());
        });
        leftButton.addActionListener(e -> {
            JScrollBar horizontal = canvasScroll.getHorizontalScrollBar();
            horizontal.setValue(horizontal.getMinimum());
        });
        rightButton.addActionListener(e -> {
            JScrollBar horizontal = canvasScroll.getHorizontalScrollBar();
            horizontal.setValue(horizontal.getMaximum());
        });


        // Color list
        colorPaletteLeft.addListSelectionListener(e -> {
            if (colorPaletteLeft.getSelectedValue() != null) {
                Color color = (colorPaletteLeft.getSelectedValue()).color;
                pictureController.setLeftColor(color);
            }
            updateUI();
        });

        colorPaletteRight.addListSelectionListener( e -> {
            if (colorPaletteRight.getSelectedValue() != null) {
                Color color = (colorPaletteRight.getSelectedValue()).color;
                pictureController.setRightColor(color);
            }
            updateUI();
        });

        // Color button
        colorButtonLeft.addActionListener(e -> {
            Color selected = JColorChooser.showDialog(null, "Select color", pictureController.getLeftColor());
            if (selected != null) {
                pictureController.setLeftColor(selected);
                colorPaletteLeft.clearSelection();
            }
            updateUI();
        });

        colorButtonRight.addActionListener(e -> {
            Color selected = JColorChooser.showDialog(null, "Select color", pictureController.getRightColor());
            if (selected != null) {
                pictureController.setRightColor(selected);
                colorPaletteRight.clearSelection();
            }
            updateUI();
        });


        // Mouse
        canvas.addMouseMotionListener(new MouseMotionAdapter() {
            @Override
            public void mouseMoved(MouseEvent e) {
                if (e.getSource() == canvas) {
                    Point mouse = pictureController.convertToImgCordiantes(e.getPoint());
                    if (mouse.x < pictureController.getImage().getWidth() && mouse.y < pictureController.getImage().getHeight()) {
                        pictureController.setLastMousePos(pictureController.convertToImgCordiantes(e.getPoint()));
                        updateLabel();
                    }
                }
            }

            @Override
            public void mouseDragged(MouseEvent e) {
                mouseMoved(e);
            }
        });

        // canvas drawing
        canvas.addMouseListener(new MouseAdapter() {
            @Override
            public void mouseClicked(MouseEvent e) {
                if (pictureController.getImage() == null || e.getSource() != canvas)
                    return;
                if (e.getButton() == MouseEvent.BUTTON1)
                    pictureController.draw(e.getPoint(), pictureController.getLeftColor());
                else
                    pictureController.draw(e.getPoint(), pictureController.getRightColor());
                canvas.repaint();
            }
        });


        canvas.addMouseMotionListener(new MouseMotionAdapter() {
            @Override
            public void mouseDragged(MouseEvent e) {
                if (pictureController.getImage() == null || e.getSource() != canvas)
                    return;
                if (SwingUtilities.isLeftMouseButton(e))
                    pictureController.draw(e.getPoint(), pictureController.getLeftColor());
                else
                    pictureController.draw(e.getPoint(), pictureController.getRightColor());
                canvas.repaint();
            }

        });
    }

    private void scaleInterface() {
        JScrollBar vertical = canvasScroll.getVerticalScrollBar();
        JScrollBar horizontal = canvasScroll.getHorizontalScrollBar();

        vertical.setValue((int) (vertical.getValue() / pictureController.getTransformation().getScaleX()));
        horizontal.setValue((int) (horizontal.getValue() / pictureController.getTransformation().getScaleY()));

        canvas.repaint();
        updateCanvasViewport();
        updateLabel();
    }

    private void updateUI() {

        colorButtonLeft.setBackground(pictureController.getLeftColor());
        colorButtonRight.setBackground(pictureController.getRightColor());
    }

    private void updateCanvasViewport() {
        BufferedImage img = pictureController.getImage();
        if (img != null)
            canvas.setPreferredSize(
                    new Dimension(
                            (int) (img.getWidth() * pictureController.getTransformation().getScaleX()),
                            (int) (img.getHeight() * pictureController.getTransformation().getScaleY())
                    )
            );
        canvas.revalidate();
        canvasScroll.updateUI();
    }

    private void updateLabel() {
        footer.setText(
                "x: " + pictureController.getLastMousePos().x +
                        ", y: " + pictureController.getLastMousePos().y);
    }

    private class MyColor {
        String name;
        Color color;

        public MyColor(String name, Color color) {
            this.name = name;
            this.color = color;
        }

        @Override
        public String toString() {
            return name;
        }
    }
}
