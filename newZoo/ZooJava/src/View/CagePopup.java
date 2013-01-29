/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package View;

import Model.Cage;
import java.awt.BorderLayout;
import java.awt.Dimension;
import java.awt.GridLayout;
import java.util.ArrayList;
import javax.swing.JFrame;
import javax.swing.JLabel;
import javax.swing.JPanel;
import javax.swing.JTextField;

/**
 *
 * @author Leenix
 */
public class CagePopup extends JPanel {

    public static int FIELD_WIDTH = 60;
    public static int NUM_FIELDS = 4;
    protected Cage cage;
    protected ArrayList<JTextField> fieldList;
    protected JPanel fieldPanel;
    protected JTextField nameField;
    protected JTextField latitudeField;
    protected JTextField longitudeField;
    protected JTextField sizeField;

    public CagePopup(Cage cage) {
        fieldList = new ArrayList<>();
        fieldPanel = new JPanel();
        this.cage = cage;
        setLayout(new BorderLayout());

        fieldPanel.setLayout(new GridLayout(NUM_FIELDS, 2));
        add(fieldPanel, BorderLayout.CENTER);
        initialiseFields();
        drawFields();
        //populateFields();
    }

    protected void initialiseFields() {
        nameField = new JTextField(cage.getName());
        nameField.setName("Cage Name");
        fieldList.add(nameField);

        sizeField = new JTextField("" + cage.getSize());
        sizeField.setName("Size (sq. m)");
        fieldList.add(sizeField);

        longitudeField = new JTextField("" + cage.getLongitude());
        longitudeField.setName("Longitude");
        fieldList.add(longitudeField);

        latitudeField = new JTextField("" + cage.getLatitude());
        latitudeField.setName("Latitude");
        fieldList.add(latitudeField);
    }

    protected void drawFields() {
        for (JTextField tf : fieldList) {
            fieldPanel.add(new JLabel(tf.getName()));
            fieldPanel.add(tf);
        }
    }

    public static void main(String[] args) {
        JFrame j = new JFrame();
        j.setSize(new Dimension(250, 300));
        CagePopup c = new CagePopup(new Cage(1));
        j.add(c);
        j.setVisible(true);
    }

    /**
     * Set all fields to be non-editable.
     */
    protected void lockFields() {
        for (JTextField tf : fieldList) {
            tf.setEditable(false);
        }
    }

    /**
     * Set all fields to be editable except for the cage ID.
     */
    protected void unlockFields() {
        for (JTextField tf : fieldList) {
            tf.setEditable(true);
        }
    }
}
