/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package View;

import Controller.ZMSUIQuery;
import Model.Cage;
import Model.Door;
import Model.Employee;
import Model.Entrance;
import java.awt.BorderLayout;
import java.awt.Color;
import java.awt.Dimension;
import java.awt.Font;
import java.awt.GridLayout;
import java.util.LinkedHashMap;
import javax.swing.*;

/**
 *
 * @author Chris
 */
public class CagePanel extends JPanel {

    
    private ZMSUIQuery query;
    private JPanel outerPanel;        
    private JPanel topPanel;
    private JPanel warningPanel;
    private JPanel sidePanel;
    private JLabel minimiseButtonLabel;
    private JLabel deleteButtonLabel;
    private JLabel monitorButtonLabel;
    private JLabel editButtonLabel;
    private JLabel cageName;
    private JLabel doorOpenWarningLabel;
    private JLabel humanInsideWarningLabel;
    private JLabel lightsOffWarningLabel;
    private JLabel hungryWarningLabel;
    private JLabel dirtyWarningLabel;
    private Cage cage;
    private Boolean cageHasProblem;
    private Boolean cageMinimized;
    private static final Color CAGE_GREEN = new Color(0, 255, 0, 80);
    private static final Color CAGE_RED = new Color(255, 0, 0, 80);
    private static final Dimension LARGE_SIZE = new Dimension(120, 120);
    private static final Dimension SMALL_SIZE = new Dimension(15, 15);

    public CagePanel(final Cage cage, final String loadedZoo) {

        query = new ZMSUIQuery(loadedZoo);
        
        cageHasProblem = false;
        
        if (cage.getMinimized().equals("true")){
            cageMinimized = true;
        } else if (cage.getMinimized().equals("false")){
            cageMinimized = false;
        } 
        

        this.cage = cage;

        ImageIcon maximiseIcon = new ImageIcon("maximise.jpg");
        ImageIcon monitorIcon = new ImageIcon("monitor.jpg");
        ImageIcon deleteIcon = new ImageIcon("delete.jpg");
        ImageIcon editIcon = new ImageIcon("edit.jpg");

        outerPanel = new JPanel(new BorderLayout());
        topPanel = new JPanel(new BorderLayout());
        warningPanel = new JPanel(new GridLayout(5, 1));
        sidePanel = new JPanel(new BorderLayout());
        minimiseButtonLabel = new JLabel(maximiseIcon);
        deleteButtonLabel = new JLabel(deleteIcon);
        monitorButtonLabel = new JLabel(monitorIcon);
        editButtonLabel = new JLabel(editIcon);

        doorOpenWarningLabel = new JLabel("DOOR OPEN");
        humanInsideWarningLabel = new JLabel("HUMAN INSIDE");
        lightsOffWarningLabel = new JLabel("LIGHTS OFF");
        hungryWarningLabel = new JLabel("NEEDS FEEDING");
        dirtyWarningLabel = new JLabel("NEEDS CLEANING");

        doorOpenWarningLabel.setForeground(Color.YELLOW);
        humanInsideWarningLabel.setForeground(Color.YELLOW);
        lightsOffWarningLabel.setForeground(Color.YELLOW);
        hungryWarningLabel.setForeground(Color.YELLOW);
        dirtyWarningLabel.setForeground(Color.YELLOW);

//        doorOpenWarningLabel.setBackground(cageRed);
//        humanInsideWarningLabel.setBackground(cageRed);
//        lightsOffWarningLabel.setBackground(cageRed);
//        hungryWarningLabel.setBackground(cageRed);
//        dirtyWarningLabel.setBackground(cageRed);

        doorOpenWarningLabel.setFont(new Font("Arial", 1, 9));
        humanInsideWarningLabel.setFont(new Font("Arial", 1, 9));
        lightsOffWarningLabel.setFont(new Font("Arial", 1, 9));
        hungryWarningLabel.setFont(new Font("Arial", 1, 9));
        dirtyWarningLabel.setFont(new Font("Arial", 1, 9));

        doorOpenWarningLabel.setVisible(false);
        humanInsideWarningLabel.setVisible(false);
        lightsOffWarningLabel.setVisible(false);
        hungryWarningLabel.setVisible(false);
        dirtyWarningLabel.setVisible(false);

        warningPanel.add(doorOpenWarningLabel);
        warningPanel.add(humanInsideWarningLabel);
        warningPanel.add(lightsOffWarningLabel);
        warningPanel.add(hungryWarningLabel);
        warningPanel.add(dirtyWarningLabel);

        cageName = new JLabel(cage.getName());


        outerPanel.setPreferredSize(SMALL_SIZE);
        this.setBackground(new Color(0, 0, 0, 100));


        warningPanel.setBackground(new Color(255, 255, 255, 80));


        outerPanel.add(topPanel, BorderLayout.NORTH);
        outerPanel.add(warningPanel, BorderLayout.WEST);
        outerPanel.add(sidePanel, BorderLayout.EAST);



        topPanel.add(minimiseButtonLabel, BorderLayout.WEST);
        topPanel.add(cageName, BorderLayout.CENTER);
        sidePanel.add(deleteButtonLabel, BorderLayout.NORTH);
        sidePanel.add(editButtonLabel, BorderLayout.CENTER);
        sidePanel.add(monitorButtonLabel, BorderLayout.SOUTH);


        add(outerPanel);
    }

    public JLabel getEditButtonLabel() {
        return editButtonLabel;
    }

    public JLabel getCageName() {
        return cageName;
    }

    public JLabel getDeleteButtonLabel() {
        return deleteButtonLabel;
    }

    public JLabel getMonitorButtonLabel() {
        return monitorButtonLabel;
    }

    public JLabel getMinimiseButtonLabel() {
        return minimiseButtonLabel;
    }

    public void checkHungry() {
        switch (cage.getHungry()) {
            case "true":
                hungryWarningLabel.setVisible(true);
                cageHasProblem = true;
                break;
            case "false":
                hungryWarningLabel.setVisible(false);
                break;
        }
    }

    public void checkNeedCleaning() {
        switch (cage.getNeedCleaning()) {
            case "true":
                dirtyWarningLabel.setVisible(true);
                cageHasProblem = true;
                break;
            case "false":
                dirtyWarningLabel.setVisible(false);
                break;
        }
    }

    public void checkLights() {
        switch (cage.getLights()) {
            case "true":
                lightsOffWarningLabel.setVisible(false);
                break;
            case "false":
                lightsOffWarningLabel.setVisible(true);
                cageHasProblem = true;
                break;
        }
    }

    public void checkHuman(LinkedHashMap<Integer, Employee> employees) {
        Boolean found = false;
        for (Employee employee : employees.values()) {
            if (employee.getCage() != null) {
                if (employee.getCage().getId() == cage.getId()) {
                    found = true;
                }
                if (found) {
                    humanInsideWarningLabel.setVisible(true);
                    cageHasProblem = true;
                } else if (!found) {
                    humanInsideWarningLabel.setVisible(false);
                }
            }
        }
    }

    public void checkDoors(LinkedHashMap<Integer, Entrance> entrances) {
        Boolean found = false;
        for (Entrance entrance : entrances.values()) {
            for (Door door : entrance.getDoors().values()) {
                if (door.isOpen()) {
                    found = true;
                }
            }
        }
        if (found) {
            doorOpenWarningLabel.setVisible(true);
            cageHasProblem = true;
        } else if (!found) {
            doorOpenWarningLabel.setVisible(false);
        }
    }

    public void setCagePanelColours() {
        if (cageHasProblem) {
            topPanel.setBackground(Color.RED);
            outerPanel.setBackground(CAGE_RED);
            sidePanel.setBackground(CAGE_RED);
        } else {
            topPanel.setBackground(Color.GREEN);
            outerPanel.setBackground(CAGE_GREEN);
            sidePanel.setBackground(CAGE_GREEN);
        }



    }

    public void setUpSizes() {
        if (cageMinimized) {
            outerPanel.setPreferredSize(SMALL_SIZE);
        } else if (!cageMinimized) {
            outerPanel.setPreferredSize(LARGE_SIZE);
        }

    }

    void toggleSize() {
        switch (cage.getMinimized()) {
            case "true":
                query.setCageMinimized("false", cage.getId());
                break;
            case "false":
                query.setCageMinimized("true", cage.getId());
                break;
        }
    }
}
