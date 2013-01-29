/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package View;

import Controller.CMSUIDbQuery;
import Controller.CleanOffCommand;
import Controller.CleanOnCommand;
import Controller.HungryOffCommand;
import Controller.HungryOnCommand;
import Controller.LightsOffCommand;
import Controller.LightsOnCommand;
import Model.Animal;
import Model.Cage;
import Model.Door;
import Model.Employee;
import Model.Entrance;
import Utility.ImagePanel;
import java.awt.BorderLayout;
import java.awt.Color;
import java.awt.Dimension;
import java.awt.Font;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.awt.event.MouseAdapter;
import java.awt.event.MouseEvent;
import java.io.IOException;
import java.sql.SQLException;
import java.util.LinkedHashMap;
import javax.swing.*;

/**
 *
 * @author Chris
 */
public class SensorsPopup extends JPanel {

    private CMSUIDbQuery query;
    private JPanel outerPanel;
    private JPanel titlePanel;
    private JLabel title;
    private ImagePanel animalPanel;
    private LinkedHashMap<Integer, Entrance> entrances;
    private String CLOSED_IMAGE = "CLOSED.jpg";
    private String OPEN_IMAGE = "OPEN.jpg";
    private String LOCKED_IMAGE = "LOCKED.jpg";
    private JPanel sensors;
    private JLabel lights;
    private ImageIcon lightsOn;
    private ImageIcon lightsOff;
    private JLabel hungry;
    private ImageIcon hungryOn;
    private ImageIcon hungryOff;
    private JLabel needClean;
    private ImageIcon needCleanOn;
    private ImageIcon needCleanOff;
    private Cage cage;
    private boolean isLightOn;
    private boolean isHungry;
    private boolean isCleanNeeded;
    private LinkedHashMap<Integer, Employee> employees;
    private LinkedHashMap<Integer, Animal> animals;
    private JMenuBar employeeBar;
    private JMenu employeesInside;
    private JMenuBar animalBar;
    private JMenu animalsInside;
    private LightsOnCommand lightOnCommand;
    private LightsOffCommand lightOffCommand;
    private HungryOnCommand hungryOnCommand;
    private HungryOffCommand hungryOffCommand;
    private CleanOnCommand cleanOnCommand;
    private CleanOffCommand cleanOffCommand;

    public SensorsPopup(String filename, final Cage cage, String loadedZoo, LinkedHashMap<Integer, Employee> employeesMap, LinkedHashMap<Integer, Animal> animalsMap) {
        this.cage = cage;
        this.employees = employeesMap;
        this.animals = animalsMap;
        this.lightOnCommand = new LightsOnCommand(cage, loadedZoo);
        this.lightOffCommand = new LightsOffCommand(cage, loadedZoo);
        this.hungryOnCommand = new HungryOnCommand(cage, loadedZoo);
        this.hungryOffCommand = new HungryOffCommand(cage, loadedZoo);
        this.cleanOnCommand = new CleanOnCommand(cage, loadedZoo);
        this.cleanOffCommand = new CleanOffCommand(cage, loadedZoo);

        try {
            query = new CMSUIDbQuery(loadedZoo);
        } catch (SQLException ex) {
            System.out.println(ex);
        }





        outerPanel = new JPanel(new BorderLayout());
        outerPanel.setPreferredSize(new Dimension(400, 400));
        titlePanel = new JPanel();
        title = new JLabel(cage.getName());
        title.setForeground(Color.white);
        titlePanel.setBackground(Color.orange);
        titlePanel.setSize(new Dimension(400, 100));
        animalPanel = new ImagePanel();
        add(outerPanel);
        sensors = new JPanel();
        outerPanel.add(titlePanel, BorderLayout.NORTH);
        titlePanel.add(title);
        outerPanel.add(animalPanel, BorderLayout.CENTER);
        outerPanel.add(sensors, BorderLayout.SOUTH);

        setLightFlag(cage);
        setHungryFlag(cage);
        setCleaningFlag(cage);


        lights = new JLabel();
        lightsOn = new ImageIcon("bulbOn.jpg");
        lightsOff = new ImageIcon("bulbOff.jpg");
        sensors.add(lights);

        hungry = new JLabel();
        hungryOn = new ImageIcon("hungryOn.jpg");
        hungryOff = new ImageIcon("hungryOff.jpg");
        sensors.add(hungry);

        needClean = new JLabel();
        needCleanOn = new ImageIcon("cleanOn.jpg");
        needCleanOff = new ImageIcon("cleanOff.jpg");
        sensors.add(needClean);


        setupEmployeesSensor();
        setupAnimalSensor();


        try {
            animalPanel.setImage("lion.jpg");
            animalPanel.setPreferredSize(new Dimension(400, 400));
            animalPanel.fitImage();

        } catch (IOException e) {
            System.out.println(e);
        }

        entrances = cage.getEntrances();
        draw();
        setupSensors();
    }

    private void setLightFlag(final Cage cage) {
        switch (cage.getLights()) {
            case "true":
                isLightOn = true;
                break;
            case "false":
                isLightOn = false;
                break;
        }
    }

    private void setupEmployeesSensor() {
        employeeBar = new JMenuBar();
        employeesInside = new JMenu("Employees Inside:");
        employeeBar.add(employeesInside);
        sensors.add(employeeBar);

        for (final Employee e : employees.values()) {
            final JCheckBoxMenuItem employeeMenu = new JCheckBoxMenuItem(e.getName());
            employeesInside.add(employeeMenu);
            if (e.getCage() != null) {
                if (e.getCage().equals(cage)) {
                    employeeMenu.setSelected(true);
                } else if (!e.getCage().equals(cage)) {
                    employeeMenu.setSelected(false);
                }
                
            }
            employeeMenu.addActionListener(new ActionListener() {
                @Override
                public void actionPerformed(ActionEvent ae) {
                    if (employeeMenu.isSelected()) {
                        query.putEmployeeInCage(e.getId(), cage.getId());
                        e.setCage(cage);
                    } else if (!employeeMenu.isSelected()) {
                        query.takeEmployeeOutOfCage(e.getId());
                        e.setCage(null);
                    }
                }
            });
        }
    }

    private void setupAnimalSensor() {
        animalBar = new JMenuBar();
        animalsInside = new JMenu("Animals Inside:");
        animalBar.add(animalsInside);
        sensors.add(animalBar);

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
                        query.putAnimalInCage(a.getId(), cage.getId());
                        a.setCage(cage);
                    } else if (!animalMenu.isSelected()) {
                        query.takeAnimalOutOfCage(a.getId());
                        a.setCage(null);
                    }
                }
            });
        }
    }

    private void setupSensors() {

        if (isLightOn) {
            lights.setIcon(lightsOn);
            lights.setToolTipText("Lights On");
        } else if (!isLightOn) {
            lights.setIcon(lightsOff);
            lights.setToolTipText("Lights Off");
        }

        lights.addMouseListener(new MouseAdapter() {
            @Override
            public void mouseClicked(MouseEvent me) {
                if (isLightOn) {
                    lightOffCommand.execute();
                    setLightFlag(cage);
                    lights.setIcon(lightsOff);
                    lights.setToolTipText("Lights Off");
                } else if (!isLightOn) {
                    lightOnCommand.execute();
                    setLightFlag(cage);
                    lights.setIcon(lightsOn);
                    lights.setToolTipText("Lights On");
                }
            }
        });

        if (isHungry) {
            hungry.setIcon(hungryOn);
            hungry.setToolTipText("Animal hungry");
        } else if (!isHungry) {
            hungry.setIcon(hungryOff);
            hungry.setToolTipText("Animal not hungry");
        }

        hungry.addMouseListener(new MouseAdapter() {
            @Override
            public void mouseClicked(MouseEvent me) {
                if (isHungry) {
                    hungryOffCommand.execute();
                    setHungryFlag(cage);
                    hungry.setIcon(hungryOff);
                    hungry.setToolTipText("Animal not hungry");
                } else if (!isHungry) {
                    hungryOnCommand.execute();
                    setHungryFlag(cage);
                    hungry.setIcon(hungryOn);
                    hungry.setToolTipText("Animal hungry");
                }
            }
        });


        if (isCleanNeeded) {
            needClean.setIcon(needCleanOn);
            needClean.setToolTipText("Cage needs cleaning");
        } else if (!isCleanNeeded) {
            needClean.setIcon(needCleanOff);
            needClean.setToolTipText("Cage does not need cleaning");
        }

        needClean.addMouseListener(new MouseAdapter() {
            @Override
            public void mouseClicked(MouseEvent me) {
                if (isCleanNeeded) {
                    cleanOffCommand.execute();
                    setCleaningFlag(cage);
                    needClean.setIcon(needCleanOff);
                    needClean.setToolTipText("Cage does not need cleaning");
                } else if (!isCleanNeeded) {
                    cleanOnCommand.execute();
                    setCleaningFlag(cage);
                    needClean.setIcon(needCleanOn);
                    needClean.setToolTipText("Cage needs cleaning");
                }
            }
        });







    }

    private void draw() {
        for (Entrance entrance : entrances.values()) {
            JPanel entrancePanel = new JPanel();
            JLabel entranceLabel = new JLabel("Entrance:");
            entranceLabel.setForeground(Color.WHITE);
            entrancePanel.setBackground(new Color(0, 0, 0, 80));
            entrancePanel.add(entranceLabel);
            animalPanel.add(entrancePanel);
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

                    JButton openCloseButton = new JButton();
                    openCloseButton.setFont(new Font("Arial", 0, 10));
                    openCloseButton.setSize(new Dimension(67, 100));

                    if (door.isOpen()) {
                        openCloseButton.setText("Close");
                        lockButton.setText("Lock");
                        lockButton.setEnabled(false);
                    } else if (!door.isOpen()) {
                        openCloseButton.setText("Open");
                        lockButton.setText("Lock");
                        if (door.isLocked()) {
                            lockButton.setText("Unlock");
                            openCloseButton.setEnabled(false);
                        } else if (!door.isLocked()) {
                            lockButton.setText("Lock");
                            openCloseButton.setText("Open");


                        }

                    }


                    JPanel buttonPanel = new JPanel(new BorderLayout());
                    buttonPanel.setBackground(new Color(0, 0, 0, 0));
                    buttonPanel.add(openCloseButton, BorderLayout.WEST);
                    buttonPanel.add(lockButton, BorderLayout.EAST);


                    doorPanel.add(buttonPanel, BorderLayout.SOUTH);
                    doorPanel.add(picturePanel, BorderLayout.NORTH);
                    doorPanel.setBackground(new Color(0, 0, 0, 0));

                    entrancePanel.add(doorPanel);


                    openCloseButton.addActionListener(new ActionListener() {
                        @Override
                        public void actionPerformed(ActionEvent ae) {
                            Door door = doors.get(doorId);
                            if (door.isOpen()) {
                                door.close();

                            } else if (!door.isOpen()) {
                                door.open();
                            }
                            refresh();
                            updateDoor(door);
                        }
                    });


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

    private void refresh() {
        animalPanel.removeAll();
        animalPanel.revalidate();
        draw();
    }

    private void setHungryFlag(final Cage cage) {
        switch (cage.getHungry()) {
            case "true":
                isHungry = true;
                break;
            case "false":
                isHungry = false;
                break;
        }
    }

    private void setCleaningFlag(final Cage cage) {
        switch (cage.getNeedCleaning()) {
            case "true":
                isCleanNeeded = true;
                break;
            case "false":
                isCleanNeeded = false;
                break;
        }
    }
}
