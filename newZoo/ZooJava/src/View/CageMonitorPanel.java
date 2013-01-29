/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package View;

import Controller.ZMSUIQuery;
import Model.*;
import Utility.ImagePanel;
import java.awt.BorderLayout;
import java.awt.Color;
import java.awt.Dimension;
import java.awt.Font;
import java.awt.GridBagLayout;
import java.awt.GridLayout;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.io.IOException;
import java.util.LinkedHashMap;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.swing.*;
import org.omg.CORBA.INITIALIZE;

/**
 *
 * @author Chris
 */
public class CageMonitorPanel extends CagePopup {

    private ZMSUIQuery query;
    private LinkedHashMap<Integer, Employee> employees;
    private LinkedHashMap<Integer, Animal> animals;
    private JPanel upperLowerDisplay;
    private JPanel lowerDisplay;
    private ImagePanel lowerLowerDisplay;
    private JTextField categoryField;
    private String CLOSED_IMAGE = "CLOSED.jpg";
    private String OPEN_IMAGE = "OPEN.jpg";
    private String LOCKED_IMAGE = "LOCKED.jpg";

    public CageMonitorPanel(Cage cage, String directory, LinkedHashMap<Integer, Employee> employees, LinkedHashMap<Integer, Animal> animals) {
        super(cage);
        fieldPanel.setLayout(new GridLayout(CagePopup.NUM_FIELDS + 2, 2));
        query = new ZMSUIQuery(directory);
        this.employees = employees;
        this.animals = animals;

        upperLowerDisplay = new JPanel(new BorderLayout());
        lowerDisplay = new JPanel(new BorderLayout());
        lowerLowerDisplay = new ImagePanel();
        try {
            lowerLowerDisplay.setImage("lion.jpg");
            lowerLowerDisplay.setPreferredSize(new Dimension(400, 400));
            lowerLowerDisplay.fitImage();
        } catch (IOException ex) {
            System.out.println(ex);
        }




        add(lowerDisplay, BorderLayout.SOUTH);
        lowerDisplay.add(upperLowerDisplay, BorderLayout.NORTH);
        lowerDisplay.add(lowerLowerDisplay, BorderLayout.SOUTH);

        displayLights();
        displayEmployees();
        displayAnimals();
        displayDoors();

    }

    @Override
    protected void initialiseFields() {
        super.initialiseFields();

        categoryField = new JTextField(cage.getType());
        categoryField.setName("Category");
        fieldList.add(categoryField);
    }

    @Override
    protected void drawFields() {
        super.drawFields();
        super.lockFields();
    }

    private void displayEmployees() {
        JPanel employeeDisplay = new JPanel();
        upperLowerDisplay.add(employeeDisplay, BorderLayout.NORTH);

        JLabel heading = new JLabel("Employees in this cage: ");
        employeeDisplay.add(heading);
        int count = 0;
        for (Employee e : employees.values()) {
            if (e.getCage() != null) {
                if (e.getCage().equals(cage)) {
                    ++count;
                    JLabel employeeLabel = new JLabel(e.getName() + ".");
                    employeeDisplay.add(employeeLabel);
                }
            }
        }
        employeeDisplay.setPreferredSize(new Dimension(150, 50 + (count * 5)));
    }

    private void displayAnimals() {
        JPanel animalDisplay = new JPanel();

        upperLowerDisplay.add(animalDisplay, BorderLayout.CENTER);
        JLabel heading = new JLabel("Animals in this cage: ");
        animalDisplay.add(heading);
        int count = 0;
        for (Animal a : animals.values()) {
            if (a.getCage() != null) {
                if (a.getCage().equals(cage)) {
                    ++count;
                    JLabel animalLabel = new JLabel(a.getName(), a.getAvatar(), SwingConstants.CENTER);
                    animalDisplay.add(animalLabel);
                }
            }
        }
        animalDisplay.setPreferredSize(new Dimension(150, 50 + (count * 10)));
    }

    private void displayDoors() {
        for (Entrance entrance : cage.getEntrances().values()) {
            JPanel entrancePanel = new JPanel();
            JLabel entranceLabel = new JLabel("Entrance:");
            entranceLabel.setForeground(Color.WHITE);
            entrancePanel.setBackground(new Color(0, 0, 0, 80));
            entrancePanel.add(entranceLabel);
            lowerLowerDisplay.add(entrancePanel);
            final LinkedHashMap<Integer, Door> doors = entrance.getDoors();
            for (Door door : doors.values()) {

                try {
                    final int doorId = door.getId();
                    JPanel doorPanel = new JPanel(new BorderLayout());
                    ImagePanel picturePanel = new ImagePanel();
                    picturePanel.setLayout(new BorderLayout());
                    if (door.isOpen()) {
                        picturePanel.setImage(OPEN_IMAGE);
                    } else if (!door.isOpen()) {
                        if (door.isLocked()) {
                            picturePanel.setImage(LOCKED_IMAGE);
                        } else {
                            picturePanel.setImage(CLOSED_IMAGE);
                        }
                    }
                    picturePanel.setPreferredSize(new Dimension(134, 123));


                    JButton lockButton = new JButton();
                    lockButton.setFont(new Font("Arial", 0, 10));
                    lockButton.setSize(new Dimension(67, 100));

//                    JButton openCloseButton = new JButton();
//                    openCloseButton.setFont(new Font("Arial", 0, 10));
//                    openCloseButton.setSize(new Dimension(67, 100));

                    if (door.isOpen()) {
                        lockButton.setEnabled(false);
                    }
//                    } else if (!door.isOpen()) {
//                        openCloseButton.setText("Open");
//                        lockButton.setText("Lock");
                    if (door.isLocked()) {
                        lockButton.setText("Unlock");
                    } else if (!door.isLocked()) {
                        lockButton.setText("Lock");
                    }
//                            openCloseButton.setEnabled(false);
//                        } else if (!door.isLocked()) {
//                            lockButton.setText("Lock");
//                            openCloseButton.setText("Open");
//                        }



                    JPanel buttonPanel = new JPanel(new BorderLayout());
                    buttonPanel.setBackground(new Color(0, 0, 0, 0));
//                    buttonPanel.add(openCloseButton, BorderLayout.WEST);
                    buttonPanel.add(lockButton, BorderLayout.CENTER);


                    doorPanel.add(buttonPanel, BorderLayout.SOUTH);
                    doorPanel.add(picturePanel, BorderLayout.NORTH);
                    doorPanel.setBackground(new Color(0, 0, 0, 0));

                    entrancePanel.add(doorPanel);


//                    openCloseButton.addActionListener(new ActionListener() {
//                        @Override
//                        public void actionPerformed(ActionEvent ae) {
//                            Door door = doors.get(doorId);
//                            if (door.isOpen()) {
//                                door.close();
//
//                            } else if (!door.isOpen()) {
//                                door.open();
//                            }
//                            refresh();
//                            updateDoor(door);
//                        }
//                    });


                    lockButton.addActionListener(new ActionListener() {
                        @Override
                        public void actionPerformed(ActionEvent ae) {
                            Door door = doors.get(doorId);
                            if (door.isLocked()) {
                                door.unlock();
                            } else if (!door.isLocked()) {
                                door.lock();
                            }
                            refresh();
                            updateDoor(door);
                        }
                    });


                } catch (IOException ex) {
                    System.out.println(ex);
                }
            }
        }
    }

    private void refresh() {
        lowerLowerDisplay.removeAll();
        lowerLowerDisplay.revalidate();
        displayDoors();
    }

    private void updateDoor(Door door) {
        String open = "false";
        String locked = "false";
        if (door.isOpen()) {
            open = "true";
        }
        if (door.isLocked()) {
            locked = "true";
        }
        query.updateDoor(door.getId(), open, locked);
    }

    private void displayLights() {
        ImageIcon lightOn = new ImageIcon("bulbOn.jpg");
        ImageIcon lightOff = new ImageIcon("bulbOff.jpg");

        
        JLabel lightLabel = new JLabel();
        lightLabel.setHorizontalAlignment(SwingConstants.CENTER);
        lowerDisplay.setBackground(Color.WHITE);
        lowerDisplay.add(lightLabel, BorderLayout.CENTER);
        switch (cage.getLights()) {
            case "true":
                lightLabel.setIcon(lightOn);
                lightLabel.setText("Lights are on");
                break;
            case "false":
                lightLabel.setIcon(lightOff);
                lightLabel.setText("Lights are off");
                break;
        }
    }
}
