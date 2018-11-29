package Grafika;

import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;

public class ToolBarListener  implements ActionListener {

    private Picture picture;

    public ToolBarListener(Picture picture) {
        this.picture = picture;
    }


    @Override
    public void actionPerformed(ActionEvent actionEvent) {
        String command = actionEvent.getActionCommand();
        System.out.println(command);
        switch (command){
            case "Open":
                picture.OpenFile();
                break;
            case "Save":
                break;
            case "ZoomIn":
                break;
            case "ZoomOut":
                break;
        }
    }
}
