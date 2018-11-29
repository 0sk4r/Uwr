package Grafika;

import javax.swing.*;

public class ToolBar extends JToolBar {

    private JButton btnOpen, btnSave, btnZoomIn, btnZoomOut;
    private Picture picture;


    public ToolBar (Window window, Picture picture){
        createButtons();
        setAction();
        this.picture = picture;
    }

    private void createButtons(){
        btnOpen=new JButton("Open");
        btnSave=new JButton("Save");
        btnZoomIn = new JButton("Zoom In");
        btnZoomOut = new JButton("Zoom Out");

        add(btnOpen);
        add(btnSave);
        add(btnZoomIn);
        add(btnZoomOut);
    }

    private void setAction(){
        btnOpen.setActionCommand("Open");
        btnSave.setActionCommand("Save");
        btnZoomIn.setActionCommand("ZoomIn");
        btnZoomOut.setActionCommand("ZoomOut");

        btnOpen.addActionListener(new ToolBarListener(picture));
        btnSave.addActionListener(new ToolBarListener(picture));
        btnZoomIn.addActionListener(new ToolBarListener(picture));
        btnZoomOut.addActionListener(new ToolBarListener(picture));

    }

}
