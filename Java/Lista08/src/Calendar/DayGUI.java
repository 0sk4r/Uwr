package Calendar;

import javax.swing.*;
import java.awt.*;

public class DayGUI extends JPanel {
    JLabel number;
    JLabel name;

    String week[] = {"Pon", "Wt", "Sr", "Czw", "Pia", "Sob", "Nied"};

    public DayGUI(int day) {
        super();

        this.setLayout(new BoxLayout(this, BoxLayout.Y_AXIS));

        if (day == 6)
            this.setBackground(Color.RED);

        number = new JLabel("#");
        number.setFont(new Font(Font.SANS_SERIF, Font.BOLD, 20));
        number.setAlignmentX(Component.CENTER_ALIGNMENT);


        name = new JLabel(week[day]);
        name.setFont(new Font(Font.SANS_SERIF, Font.BOLD, 10));
        name.setAlignmentX(Component.CENTER_ALIGNMENT);

        this.add(number);
        this.add(name);
    }

    public void setNumber(int number) {
        this.number.setText("" + number);
    }
}
