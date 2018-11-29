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
    private PictureControler pictureControler;

    private JList colorPaletteLeft;
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
    private JList colorPaletteRight;
    private JButton colorButtonRight;
    private JFileChooser fileChooser;
    private DefaultListModel colorPaletteList;


    public GUI(PictureControler pictureControler) {
        super("Paint");

        this.pictureControler = pictureControler;
        this.fileChooser = new JFileChooser();
        this.fileChooser.addChoosableFileFilter(new FileNameExtensionFilter("Image Files", "jpg", "png", "bmp"));

        setContentPane(rootPanel);

        addControlers();
        updateUI();
        updateLabel();
    }

    private void createUIComponents() {


        colorPaletteList = new DefaultListModel();
        colorPaletteList.addElement(new ColorItem("BLACK", Color.BLACK));
        colorPaletteList.addElement(new ColorItem("BLUE", Color.BLUE));
        colorPaletteList.addElement(new ColorItem("CYAN", Color.CYAN));
        colorPaletteList.addElement(new ColorItem("GRAY", Color.GRAY));
        colorPaletteList.addElement(new ColorItem("DARK GRAY", Color.DARK_GRAY));
        colorPaletteList.addElement(new ColorItem("GREEN", Color.GREEN));
        colorPaletteList.addElement(new ColorItem("LIGHT GRAY", Color.LIGHT_GRAY));
        colorPaletteList.addElement(new ColorItem("MAGENTA", Color.MAGENTA));
        colorPaletteList.addElement(new ColorItem("ORANGE", Color.ORANGE));
        colorPaletteList.addElement(new ColorItem("PINK", Color.PINK));
        colorPaletteList.addElement(new ColorItem("RED", Color.RED));
        colorPaletteList.addElement(new ColorItem("WHITE", Color.WHITE));
        colorPaletteList.addElement(new ColorItem("YELLOW", Color.YELLOW));

        colorPaletteLeft = new JList(colorPaletteList);
        colorPaletteRight = new JList(colorPaletteList);

        // canvas
        canvas = new JPanel() {
            @Override
            protected void paintComponent(Graphics g) {

                Graphics2D g2 = (Graphics2D) g;
                super.paintComponent(g2);
                BufferedImage img = pictureControler.getImage();
                if (img != null) {
                    g2.drawImage(img, pictureControler.getTransformation(), this);
                    updateCanvasViewport();
                }

            }
        };
    }

    private void addControlers() {

        // Open file
        fileButton.addActionListener(e -> {
            if (fileChooser.showOpenDialog(null) == JFileChooser.APPROVE_OPTION) {
                pictureControler.setFile(fileChooser.getSelectedFile());
                updateCanvasViewport();
                updateUI();
                updateLabel();
                repaint();
            }
        });


        //Save File
        saveButton.addActionListener(e -> {
            File saveFile;
            if (fileChooser.showSaveDialog(null) == JFileChooser.APPROVE_OPTION) {
                saveFile = fileChooser.getSelectedFile();
                try {
                    ImageIO.write(pictureControler.getImage(), "png", saveFile.getAbsoluteFile());
                } catch (IOException e1) {
                    e1.printStackTrace();
                }
            }
        });


        //Zoom action
        zoomInButton.addActionListener(e -> {
            JScrollBar vertical = canvasScroll.getVerticalScrollBar();
            JScrollBar horizontal = canvasScroll.getHorizontalScrollBar();

            vertical.setValue((int) (vertical.getValue() / pictureControler.getTransformation().getScaleX()));
            horizontal.setValue((int) (horizontal.getValue() / pictureControler.getTransformation().getScaleY()));

            pictureControler.zoomIn();

            vertical.setValue((int) (vertical.getValue() * pictureControler.getTransformation().getScaleX()));
            horizontal.setValue((int) (horizontal.getValue() * pictureControler.getTransformation().getScaleY()));
            canvas.repaint();
            updateCanvasViewport();
            updateLabel();
        });

        zoomOutButton.addActionListener(e -> {
            JScrollBar vertical = canvasScroll.getVerticalScrollBar();
            JScrollBar horizontal = canvasScroll.getHorizontalScrollBar();

            vertical.setValue((int) (vertical.getValue() / pictureControler.getTransformation().getScaleX()));
            horizontal.setValue((int) (horizontal.getValue() / pictureControler.getTransformation().getScaleY()));

            pictureControler.zoomOut();

            vertical.setValue((int) (vertical.getValue() * pictureControler.getTransformation().getScaleX()));
            horizontal.setValue((int) (horizontal.getValue() * pictureControler.getTransformation().getScaleY()));
            canvas.repaint();
            updateCanvasViewport();
            updateLabel();
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
                Color color = ((ColorItem) colorPaletteLeft.getSelectedValue()).color;
                pictureControler.setLeftColor(color);
            }
            updateUI();
        });

        colorPaletteRight.addListSelectionListener(e -> {
            if (colorPaletteRight.getSelectedValue() != null) {
                Color color = ((ColorItem) colorPaletteRight.getSelectedValue()).color;
                pictureControler.setRightColor(color);
            }
            updateUI();
        });

        // Color button
        colorButtonLeft.addActionListener(e -> {
            Color selected = JColorChooser.showDialog(null, "Select color", pictureControler.getLeftColor());
            if (selected != null) {
                pictureControler.setLeftColor(selected);
                colorPaletteLeft.clearSelection();
            }
            updateUI();
        });

        colorButtonRight.addActionListener(e -> {
            Color selected = JColorChooser.showDialog(null, "Select color", pictureControler.getRightColor());
            if (selected != null) {
                pictureControler.setRightColor(selected);
                colorPaletteRight.clearSelection();
            }
            updateUI();
        });


        // Mouse
        canvas.addMouseMotionListener(new MouseMotionAdapter() {
            @Override
            public void mouseMoved(MouseEvent e) {
                if (e.getSource() == canvas) {
                    Point mouse = pictureControler.toImageCoordinates(e.getPoint());
                    if (mouse.x < pictureControler.getImage().getWidth() && mouse.y < pictureControler.getImage().getHeight()) {
                        pictureControler.setLastMousePos(pictureControler.toImageCoordinates(e.getPoint()));
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
                if (pictureControler.getImage() == null || e.getSource() != canvas)
                    return;
                if (e.getButton() == MouseEvent.BUTTON1)
                    pictureControler.draw(e.getPoint(), pictureControler.getLeftColor());
                else
                    pictureControler.draw(e.getPoint(), pictureControler.getRightColor());
                canvas.repaint();
            }
        });


        canvas.addMouseMotionListener(new MouseMotionAdapter() {
            @Override
            public void mouseDragged(MouseEvent e) {
                if (pictureControler.getImage() == null || e.getSource() != canvas)
                    return;
                if (SwingUtilities.isLeftMouseButton(e))
                    pictureControler.draw(e.getPoint(), pictureControler.getLeftColor());
                else
                    pictureControler.draw(e.getPoint(), pictureControler.getRightColor());
                canvas.repaint();
            }

        });
    }

    private void updateUI() {

        colorButtonLeft.setBackground(pictureControler.getLeftColor());
        colorButtonRight.setBackground(pictureControler.getRightColor());
    }

    private void updateCanvasViewport() {
        BufferedImage img = pictureControler.getImage();
        if (img != null)
            canvas.setPreferredSize(
                    new Dimension(
                            (int) (img.getWidth() * pictureControler.getTransformation().getScaleX()),
                            (int) (img.getHeight() * pictureControler.getTransformation().getScaleY())
                    )
            );
        canvas.revalidate();
        canvasScroll.updateUI();
    }

    private void updateLabel() {
        footer.setText(
                "x: " + pictureControler.getLastMousePos().x +
                        ", y: " + pictureControler.getLastMousePos().y);
    }

    private class ColorItem {
        String name;
        Color color;

        public ColorItem(String name, Color color) {
            this.name = name;
            this.color = color;
        }

        @Override
        public String toString() {
            return name;
        }
    }
}
