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

public class GUI extends JFrame {
    private JTabbedPane calendarTabbedPane;
    private JPanel rootPanel;
    private JPanel monthsInYearTab;
    private JPanel monthsTab;
    private JList nextMonth;
    private JList currMonth;
    private JList prevMonth;
    private JSpinner yearSpinner;
    private JSlider monthSlider;
    private JToolBar toolbar;
    private JPanel yearPanel;

    private GregorianCalendar calendar;

    private MonthGUI months[];

    public GUI(String title) throws HeadlessException {
        super(title);
        setContentPane(rootPanel);

        calendar = (GregorianCalendar) GregorianCalendar.getInstance();
        yearSpinner.setValue(calendar.getTime().getYear() + 1900);
        monthSlider.setValue(calendar.getTime().getMonth() + 1);


        months = new MonthGUI[12];

        initYearPanel();

        registerListeners();

        updateGUI();
    }

    private void createUIComponents() {

        yearPanel = new JPanel(new GridLayout(3, 4, 5, 5));
        prevMonth = new JList(new MonthListModel());
        currMonth = new JList(new MonthListModel());
        nextMonth = new JList(new MonthListModel());

        prevMonth.setCellRenderer(new MonthCellRenderer());
        currMonth.setCellRenderer(new MonthCellRenderer());
        nextMonth.setCellRenderer(new MonthCellRenderer());

        prevMonth.setBorder(BorderFactory.createLineBorder(Color.DARK_GRAY, 2));
        currMonth.setBorder(BorderFactory.createLineBorder(Color.DARK_GRAY, 2));
        nextMonth.setBorder(BorderFactory.createLineBorder(Color.DARK_GRAY, 2));

        yearSpinner = new JSpinner(new SpinnerNumberModel(1, 1, null, 1));
    }

    private void registerListeners() {
        // spinner change listener
        yearSpinner.addChangeListener(e -> {
            if ((int) yearSpinner.getValue() < 1)
                return;
            calendar.set(Calendar.YEAR, (int) yearSpinner.getValue());
            updateGUI();
        });

        monthSlider.addChangeListener(e -> {
            calendar.set(Calendar.MONTH, monthSlider.getValue() - 1);
            updateGUI();
        });

        prevMonth.addMouseListener(new MouseAdapter() {
            @Override
            public void mousePressed(MouseEvent e) {
                if (calendar.get(Calendar.YEAR) == 1 && calendar.get(Calendar.MONTH) == Calendar.JANUARY)
                    return;
                calendar.add(Calendar.MONTH, -1);
                updateGUI();
            }
        });

        nextMonth.addMouseListener(new MouseAdapter() {
            @Override
            public void mouseReleased(MouseEvent e) {
                calendar.add(Calendar.MONTH, 1);
                updateGUI();
            }
        });
    }

    private void initYearPanel() {
        Date date = calendar.getTime();

        calendar.set(calendar.get(Calendar.YEAR), Calendar.JANUARY, 1);

        for (int i = 0; i < 12; i++) {
            months[i] = new MonthGUI(calendar, this);
            yearPanel.add(months[i]);
            calendar.add(Calendar.MONTH, 1);
        }

        calendar.setTime(date);
    }

    private void updateYearPanel() {
        Date date = calendar.getTime();

        calendar.set(calendar.get(Calendar.YEAR), Calendar.JANUARY, 1);

        for (MonthGUI month : months) {
            month.updateMonthUI(calendar);
            calendar.add(Calendar.MONTH, 1);
        }

        calendar.setTime(date);
    }

    private void updateMonthLists() {
        Date now = calendar.getTime();
        ((MonthListModel) currMonth.getModel()).changeDate(now);

        if (now.getYear() + 1900 != 1 || now.getMonth() != 0) {
            now.setMonth(now.getMonth() - 1);
            ((MonthListModel) prevMonth.getModel()).changeDate(now);
        } else
            ((MonthListModel) prevMonth.getModel()).changeDate(null);

        if (now.getYear() != 1 || now.getMonth() != 1)
            now.setMonth(now.getMonth() + 1);

        now.setMonth(now.getMonth() + 1);
        ((MonthListModel) nextMonth.getModel()).changeDate(now);

    }

    public void updateGUI() {
        updateYearPanel();
        updateMonthLists();

        calendarTabbedPane.setTitleAt(0, "" + yearSpinner.getValue());
        calendarTabbedPane.setTitleAt(1, new SimpleDateFormat("MMMM", Locale.ENGLISH).format(calendar.getTime()));
        yearSpinner.setValue(calendar.get(Calendar.YEAR));
        monthSlider.setValue(calendar.get(Calendar.MONTH) + 1);

    }

    public void switchTab(int i) {
        calendarTabbedPane.setSelectedIndex(i);
    }

    class MonthCellRenderer extends JLabel implements ListCellRenderer {
        public MonthCellRenderer() {
            setHorizontalAlignment(CENTER);
        }

        @Override
        public Component getListCellRendererComponent(JList list, Object value, int index, boolean isSelected, boolean cellHasFocus) {
            String string = (String) value;
            if (string.contains("Sun"))
                setForeground(Color.RED);
            else
                setForeground(Color.BLACK);
            setText(string);
            return this;
        }
    }

}
