/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package View;

import Controller.CMSUIDbQuery;
import Model.Animal;
import Model.Cage;
import Model.Door;
import Model.Entrance;
import Utility.ImagePanel;
import java.awt.*;
import java.awt.event.*;
import java.io.IOException;
import java.sql.SQLException;
import java.awt.event.ItemEvent;
import java.awt.event.ItemListener;
import java.sql.ResultSet;
import java.util.LinkedHashMap;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.swing.*;

/**
 *
 * @author Leenix
 */
public class CageEditPanel extends CagePopup {

    private CMSUIDbQuery query1;
    private CMSUIDbQuery query2;
    private CMSUIDbQuery query3;
    private LinkedHashMap<Integer, Entrance> entrances;
    private String CLOSED_IMAGE = "CLOSED.jpg";
    private String OPEN_IMAGE = "OPEN.jpg";
    private String LOCKED_IMAGE = "LOCKED.jpg";
    private JComboBox cageTypeBox;
    private JPanel lowerDisplay;
    private ImagePanel lowerLowerDisplay;
    private JPanel upperLowerDisplay;
    private JMenuBar animalBar;
    private JMenu animalsInside;
    private LinkedHashMap<Integer, Animal> animals;

    //
    public CageEditPanel(Cage cage, String directory, LinkedHashMap<Integer, Animal> animals) {
        super(cage);
        
        this.animals = animals;
        try {
            query1 = new CMSUIDbQuery(directory);
            query2 = new CMSUIDbQuery(directory);
            query3 = new CMSUIDbQuery(directory);
        } catch (SQLException ex) {
            System.out.println(ex);
        }
        fieldPanel.setLayout(new GridLayout(CagePopup.NUM_FIELDS + 1, 2));
        addCageTypeBox();

       
                
        upperLowerDisplay = new JPanel(new BorderLayout());
        lowerDisplay = new JPanel(new BorderLayout());
        lowerLowerDisplay = new ImagePanel();
        add(lowerDisplay, BorderLayout.SOUTH);
        lowerDisplay.add(upperLowerDisplay, BorderLayout.NORTH);
        lowerDisplay.add(lowerLowerDisplay, BorderLayout.SOUTH);
        try {
            lowerLowerDisplay.setImage("lion.jpg");
            lowerLowerDisplay.setPreferredSize(new Dimension(500, 400));
            lowerLowerDisplay.fitImage();
        } catch (IOException ex) {
            System.out.println(ex);
        }
        setupAnimalSensor();
        displayEntrancesAndDoors();

    }

    private void setupAnimalSensor() {
        animalBar = new JMenuBar();
        animalsInside = new JMenu("Animals Inside:");
        animalBar.add(animalsInside);
        upperLowerDisplay.add(animalBar);

        for (final Animal a : animals.values()) {
            final JCheckBoxMenuItem animalMenu = new JCheckBoxMenuItem(a.getName());
            animalsInside.add(animalMenu);
            if (a.getCage() != null) {
                if (a.getCage().equals(cage)) {
                    animalMenu.setSelected(true);
                } else if (!a.getCage().equals(cage)) {
                    animalMenu.setSelected(false);
                }
            }
            animalMenu.addActionListener(new ActionListener() {
                @Override
                public void actionPerformed(ActionEvent ae) {
                    if (animalMenu.isSelected()) {
                        query1.putAnimalInCage(a.getId(), cage.getId());
                        a.setCage(cage);
                    } else if (!animalMenu.isSelected()) {
                        query1.takeAnimalOutOfCage(a.getId());
                        a.setCage(null);
                    }
                }
            });
        }
    }

    @Override
    protected void drawFields() {
        addFieldListeners();
        super.drawFields();
        super.unlockFields();
    }

    /**
     * Add action listeners to the simple fields to verify inputs and add
     * information to the model.
     */
    private void addFieldListeners() {
        nameField.addFocusListener(new FocusAdapter() {
            @Override
            public void focusLost(FocusEvent e) {
                try {
                    cage.setName(nameField.getText());
                    nameField.setBackground(Color.green);
                } catch (Exception ex) {
                    nameField.setBackground(Color.red);
                    cage.setName("Name");
                    nameField.setText("Name");
                }
            }
        });

        sizeField.addFocusListener(new FocusAdapter() {
            @Override
            public void focusLost(FocusEvent e) {
                try {
                    cage.setSize(Double.parseDouble(sizeField.getText()));
                    sizeField.setBackground(Color.green);
                } catch (Exception ex) {
                    sizeField.setBackground(Color.red);
                    cage.setSize(Cage.MIN_CAGE_AREA);
                    sizeField.setText("" + Cage.MIN_CAGE_AREA);
                }
            }
        });

        longitudeField.addFocusListener(new FocusAdapter() {
            @Override
            public void focusLost(FocusEvent e) {
                try {
                    cage.setLongitude(Double.parseDouble(longitudeField.getText()));
                    longitudeField.setBackground(Color.green);
                } catch (Exception ex) {
                    longitudeField.setBackground(Color.red);
                    cage.setLongitude(Cage.LONGITUDE_MIN);
                    longitudeField.setText("" + Cage.LONGITUDE_MIN);
                }
            }
        });

        latitudeField.addFocusListener(new FocusAdapter() {
            @Override
            public void focusLost(FocusEvent e) {
                try {
                    cage.setLatitude(Double.parseDouble(latitudeField.getText()));
                    latitudeField.setBackground(Color.green);
                } catch (Exception ex) {
                    latitudeField.setBackground(Color.red);
                    cage.setLatitude(Cage.LATITUDE_MIN);
                    latitudeField.setText("" + Cage.LATITUDE_MIN);
                }
            }
        });
    }

    public JComboBox getCageTypeBox() {
        return cageTypeBox;
    }



    private void addCageTypeBox() {
        cageTypeBox = new JComboBox(Cage.CAGE_TYPES);
        cageTypeBox.setSelectedItem(cage.getType());
        cageTypeBox.addItemListener(new ItemListener() {
            @Override
            public void itemStateChanged(ItemEvent e) {
                try {
                    cage.setType(e.getItem().toString());
                    cageTypeBox.setBackground(Color.green);
                } catch (Exception ex) {
                    cageTypeBox.setBackground(Color.red);
                }
            }
        });
        fieldPanel.add(new JLabel("Cage Type"));
        fieldPanel.add(cageTypeBox);
    }

    private void displayEntrancesAndDoors() {
        for (final Entrance entrance : cage.getEntrances().values()) {
            JPanel entrancePanel = new JPanel();
            JLabel entranceLabel = new JLabel("Entrance:");
            entranceLabel.setForeground(Color.WHITE);
            entrancePanel.setBackground(new Color(0, 0, 0, 80));
            entrancePanel.add(entranceLabel);
            lowerLowerDisplay.add(entrancePanel);
            JButton deleteEntranceButton = new JButton("Delete Entrance");
            entrancePanel.add(deleteEntranceButton);
            deleteEntranceButton.addActionListener(new ActionListener() {
                @Override
                public void actionPerformed(ActionEvent ae) {
                    int result = JOptionPane.showConfirmDialog(null, "Are you sure you want to delete this entrance?", "Warning!", JOptionPane.OK_CANCEL_OPTION, JOptionPane.WARNING_MESSAGE);
                            if (result == JOptionPane.OK_OPTION) {
                    for (Door door : entrance.getDoors().values()) {
                        query1.deleteDoor(door.getId());
                    }
                    query2.deleteEntrance(entrance.getId());
                    refresh();
                }
                }
            });

            final LinkedHashMap<Integer, Door> doors = entrance.getDoors();
            for (final Door door : doors.values()) {

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


                    JButton deleteDoorButton = new JButton("Delete");
                    deleteDoorButton.setFont(new Font("Arial", 0, 10));
                    deleteDoorButton.setSize(new Dimension(67, 100));



                    JPanel buttonPanel = new JPanel(new BorderLayout());
                    buttonPanel.setBackground(new Color(0, 0, 0, 0));
                    buttonPanel.add(deleteDoorButton, BorderLayout.CENTER);


                    doorPanel.add(buttonPanel, BorderLayout.SOUTH);
                    doorPanel.add(picturePanel, BorderLayout.NORTH);
                    doorPanel.setBackground(new Color(0, 0, 0, 0));
                    entrancePanel.add(doorPanel);






                    deleteDoorButton.addActionListener(new ActionListener() {
                        @Override
                        public void actionPerformed(ActionEvent ae) {
                            int result = JOptionPane.showConfirmDialog(null, "Are you sure you want to delete this door?", "Warning!", JOptionPane.OK_CANCEL_OPTION, JOptionPane.WARNING_MESSAGE);
                            if (result == JOptionPane.OK_OPTION) {
                                System.err.println(doorId);
                                //doors.remove(door.getId());
                                query1.deleteDoor(doorId);
                                refresh();
                            }
                        }
                    });


                } catch (IOException ex) {
                    System.out.println(ex);
                }

            }
            JButton newDoorButton = new JButton("Add Door");
            entrancePanel.add(newDoorButton);
            if (entrance.getDoors().size() == 2) {
                newDoorButton.setVisible(false);
            }

            newDoorButton.addActionListener(new ActionListener() {
                @Override
                public void actionPerformed(ActionEvent ae) {
                    query1.addNewDoor(entrance.getId());
                    refresh();
                }
            });
        }
        JButton newEntranceButton = new JButton("Add Entrance");
        lowerLowerDisplay.add(newEntranceButton);
        if (cage.getEntrances().size() == 2) {
            newEntranceButton.setVisible(false);
        }

        newEntranceButton.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent ae) {
                query1.addNewEntrance(cage.getId());
                refresh();
            }
        });
    }

    private void refresh() {
        try {
            lowerLowerDisplay.removeAll();
            lowerLowerDisplay.revalidate();
            lowerLowerDisplay.repaint();
            ResultSet cagesRs = query1.getCage(cage.getId());
            while (cagesRs.next()) {
                Cage newCage = extractCageData(cagesRs);

                ResultSet entranceRs = query2.getEntrances(newCage.getId());

                while (entranceRs.next()) {
                    Entrance entrance = new Entrance(entranceRs.getInt("id"));
                    newCage.getEntrances().put(entrance.getId(), entrance);
                    ResultSet doorsRs = query3.getDoors(entrance.getId());
                    while (doorsRs.next()) {
                        Door door = new Door(doorsRs.getInt("id"));
                        switch (doorsRs.getString("open")) {
                            case "true":
                                door.open();
                                break;
                            case "false":
                                door.close();
                                break;
                        }
                        switch (doorsRs.getString("locked")) {
                            case "true":
                                door.lock();
                                break;
                            case "false":
                                door.unlock();
                                break;
                        }
                        entrance.getDoors().put(door.getId(), door);
                    }
                }
                cage = newCage;
            }

        } catch (SQLException ex) {
            System.out.println(ex);
        }

        displayEntrancesAndDoors();
    }

    private Cage extractCageData(ResultSet cagesRs) throws SQLException {
        Cage newRef = new Cage(cagesRs.getInt("id"));
        newRef.setSize(cagesRs.getDouble("size"));
        newRef.setType(cagesRs.getString("category"));
        newRef.setName(cagesRs.getString("name"));
        newRef.setLatitude(cagesRs.getDouble("latitude"));
        newRef.setLongitude(cagesRs.getDouble("longitude"));
        newRef.setImageFile(cagesRs.getString("imageFile"));
        newRef.setHungry(cagesRs.getString("hungry"));
        newRef.setNeedCleaning(cagesRs.getString("needcleaning"));
        newRef.setLights(cagesRs.getString("lightsOn"));
        newRef.setMinimized(cagesRs.getString("minimized"));
        return newRef;
    }
}
