package UIExtrasComboBox;

import javax.swing.*;
import java.awt.*;
import java.util.Vector;

public class SeparatorListCellRenderer implements ListCellRenderer {
    private ListCellRenderer delegate;
    private JPanel separatorPanel = new JPanel(new BorderLayout());
    private JSeparator separator = new JSeparator();
    private Vector<Integer> separatorIndices = new Vector<Integer>();

    public SeparatorListCellRenderer(ListCellRenderer delegate) {
        this.delegate = delegate;
    }

    public void setSeparatorIndices(Vector<Integer> indices) {
        this.separatorIndices = indices;
    }

    @Override
    public Component getListCellRendererComponent(JList list, Object value, int index, boolean isSelected, boolean cellHasFocus) {
        Component component = delegate.getListCellRendererComponent(list, value, index, isSelected, cellHasFocus);
        if (index != -1 && addSeparatorAfter(list, value, index)) {
            separatorPanel.removeAll();
            separatorPanel.add(component, BorderLayout.CENTER);
            separatorPanel.add(separator, BorderLayout.SOUTH);
            return separatorPanel;
        } else {
            return component;
        }
    }

    private boolean addSeparatorAfter(JList list, Object value, int index) {
        return separatorIndices.contains(index);
    }
}
