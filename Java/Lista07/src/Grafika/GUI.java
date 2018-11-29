package Grafika;

import javax.imageio.ImageIO;
import javax.swing.*;
import javax.swing.border.Border;
import javax.swing.filechooser.FileFilter;
import javax.swing.filechooser.FileNameExtensionFilter;
import java.awt.*;
import java.awt.event.MouseAdapter;
import java.awt.event.MouseEvent;
import java.awt.event.MouseMotionAdapter;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;

public class GUI extends JFrame {
    private Engine engine;

    private JList colorPalette;
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
    private JButton colorButton;
    private JToolBar toolbar;
    private JScrollPane canvasScroll;
    private JScrollPane colorPaletteScroll;
    private JSplitPane split;
    private JButton zoomResetButton;
    private JButton newImageButton;
    private JButton saveButton;
    private JFileChooser fileChooser;
    private DefaultListModel colorPaletteList;


    public GUI(Engine engine) {
        super("Paint");
        this.engine = engine;
        this.fileChooser = new JFileChooser();
        this.fileChooser.addChoosableFileFilter(new FileNameExtensionFilter("Image Files", "jpg", "png", "bmp"));
        setContentPane(rootPanel);

        addListeners();
        updateStaticElements();
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

        colorPalette = new JList(colorPaletteList);


        // canvas
        canvas = new JPanel() {
            @Override
            protected void paintComponent(Graphics g) {

                Graphics2D g2 = (Graphics2D) g;
                super.paintComponent(g2);
                BufferedImage img = engine.getImage();
                if (img != null) {
                    g2.drawImage(img, engine.getTransformation(), this);
                    updateCanvasViewport();
                }

            }
        };
    }

    private void addListeners() {

        // fileOpenListener
        fileButton.addActionListener(e -> {
            if (fileChooser.showOpenDialog(null) == JFileChooser.APPROVE_OPTION) {
                engine.setFile(fileChooser.getSelectedFile());
                updateCanvasViewport();
                updateStaticElements();
                updateLabel();
                repaint();
            }
        });

        saveButton.addActionListener(e -> {
            File saveFile;
            if (fileChooser.showSaveDialog(null) == JFileChooser.APPROVE_OPTION){
               saveFile = fileChooser.getSelectedFile();
                try {
                    ImageIO.write(engine.getImage(),"png",saveFile.getAbsoluteFile());
                } catch (IOException e1) {
                    e1.printStackTrace();
                }
            }
        });

        // zoomIn listener
        zoomInButton.addActionListener(e -> {
            JScrollBar vertical = canvasScroll.getVerticalScrollBar();
            JScrollBar horizontal = canvasScroll.getHorizontalScrollBar();
            // divide by old scale
            vertical.setValue((int) (vertical.getValue() / engine.getTransformation().getScaleX()));
            horizontal.setValue((int) (horizontal.getValue() / engine.getTransformation().getScaleY()));
            // update scale
            engine.zoomIn();
            // multiply by new scale
            vertical.setValue((int) (vertical.getValue() * engine.getTransformation().getScaleX()));
            horizontal.setValue((int) (horizontal.getValue() * engine.getTransformation().getScaleY()));
            canvas.repaint();
            updateCanvasViewport();
            updateLabel();
        });

        // zoomOut listener
        zoomOutButton.addActionListener(e -> {
            JScrollBar vertical = canvasScroll.getVerticalScrollBar();
            JScrollBar horizontal = canvasScroll.getHorizontalScrollBar();
            // divide by old scale
            vertical.setValue((int) (vertical.getValue() / engine.getTransformation().getScaleX()));
            horizontal.setValue((int) (horizontal.getValue() / engine.getTransformation().getScaleY()));
            // update scale
            engine.zoomOut();
            // multiply by new scale
            vertical.setValue((int) (vertical.getValue() * engine.getTransformation().getScaleX()));
            horizontal.setValue((int) (horizontal.getValue() * engine.getTransformation().getScaleY()));
            canvas.repaint();
            updateCanvasViewport();
            updateLabel();
        });

        // move listeners
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


        // JList color palette listener
        colorPalette.addListSelectionListener(e -> {
            if (colorPalette.getSelectedValue() != null) {
                Color color = ((ColorItem) colorPalette.getSelectedValue()).color;
                engine.setLeftColor(color);
                }
            updateStaticElements();
        });

        // colorButton listener
        colorButton.addActionListener(e -> {
            Color selected = JColorChooser.showDialog(null, "Choose a color", engine.getLeftColor());
            if (selected != null) {
                engine.setLeftColor(selected);
                colorPalette.clearSelection();
                }
            updateStaticElements();
        });

        // canvas mouse info listener
        canvas.addMouseMotionListener(new MouseMotionAdapter() {
            @Override
            public void mouseMoved(MouseEvent e) {
                if (e.getSource() == canvas) {
                    Point mouse = engine.toImageCoordinates(e.getPoint());
                    if (mouse.x < engine.getImage().getWidth() && mouse.y < engine.getImage().getHeight()) {
                        engine.setLastMousePos(engine.toImageCoordinates(e.getPoint()));
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
                if (engine.getImage() == null || e.getSource() != canvas)
                    return;
                if(e.getButton() == MouseEvent.BUTTON1)
                    engine.draw(e.getPoint(), engine.getLeftColor());
                else
                    engine.draw(e.getPoint(), engine.getRightColor());
                canvas.repaint();
            }
        });


        canvas.addMouseMotionListener(new MouseMotionAdapter() {
            @Override
            public void mouseDragged(MouseEvent e) {
                if (engine.getImage() == null || e.getSource() != canvas)
                    return;
                if(SwingUtilities.isLeftMouseButton(e))
                    engine.draw(e.getPoint(), engine.getLeftColor());
                else
                    engine.draw(e.getPoint(), engine.getRightColor());
                canvas.repaint();
            }

        });
    }

    private void updateStaticElements() {
        colorButton.setBackground(engine.getLeftColor());
        }

    private void updateCanvasViewport() {
        BufferedImage img = engine.getImage();
        if (img != null)
            canvas.setPreferredSize(
                    new Dimension(
                            (int) (img.getWidth() * engine.getTransformation().getScaleX()),
                            (int) (img.getHeight() * engine.getTransformation().getScaleY())
                    )
            );
        canvas.revalidate();
        canvasScroll.updateUI();
    }

    private void updateLabel() {
        footer.setText(
                "x: " + engine.getLastMousePos().x +
                        ", y: " + engine.getLastMousePos().y +
                        ", zoom: x" + engine.getTransformation().getScaleX());
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
