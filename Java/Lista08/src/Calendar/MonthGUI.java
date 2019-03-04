package Calendar;

import javax.swing.*;
import java.awt.*;
import java.awt.event.MouseAdapter;
import java.awt.event.MouseEvent;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.Locale;

public class MonthGUI extends JPanel {
    GUI gui;
    JLabel name;
    JPanel dayCell;
    Date date;

    public MonthGUI(GregorianCalendar calendar, GUI parent) {
        super();
        this.gui = parent;
        this.setLayout(new BoxLayout(this, BoxLayout.Y_AXIS));
        this.setBorder(BorderFactory.createLineBorder(Color.DARK_GRAY, 2));
        this.setBackground(Color.GRAY);
        date = calendar.getTime();

        name = new JLabel(new SimpleDateFormat("MMMM", Locale.ENGLISH).format(calendar.getTime()));
        name.setAlignmentX(Component.CENTER_ALIGNMENT);

        dayCell = new JPanel(new GridLayout(6, 7, 2, 2));

        for (int i = 0; i < 6 * 7; i++) {
            DayGUI day = new DayGUI(i % 7);
            dayCell.add(day);
        }

        updateMonthUI(calendar);

        this.add(name);
        this.add(dayCell);

        this.addMouseListener(new MouseAdapter() {
            @Override
            public void mouseClicked(MouseEvent e) {
                calendar.set(Calendar.MONTH, date.getMonth());
                gui.updateGUI();
                gui.switchTab(1);
            }
        });
    }

    public void updateMonthUI(GregorianCalendar calendar) {
        for (int i = 0; i < 42; i++)
            dayCell.getComponent(i).setVisible(false);

        Date original = calendar.getTime();

        int iterator = (calendar.get(Calendar.DAY_OF_WEEK) + 5) % 7;
        while (calendar.get(Calendar.MONTH) == original.getMonth()) {
            dayCell.getComponent(iterator).setVisible(true);
            ((DayGUI) dayCell.getComponent(iterator)).setNumber(calendar.get(Calendar.DAY_OF_MONTH));
            calendar.add(Calendar.DAY_OF_MONTH, 1);
            iterator++;
        }

        calendar.setTime(original);
    }
}
