/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package View;

import Controller.ZMSUIQuery;
import Model.*;
import Utility.PopClickListener;
import java.awt.BorderLayout;
import java.awt.Dimension;
import java.awt.GridLayout;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.awt.event.MouseAdapter;
import java.awt.event.MouseEvent;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.LinkedHashMap;
import javax.imageio.ImageIO;
import javax.swing.*;

/**
 *
 * @author Leenix
 */
public class ZMSUI extends JFrame {

    public static final String MAP_FILE_LOCATION = "Map.jpg";
    public static final String NIGHT_MAP_FILE_LOCATION = "NightMap.jpg";
    private BufferedImage zooDayMap;
    private BufferedImage zooNightMap;
    private PopClickListener popListener;
    private ZooPopupMenu popup;
    private boolean isNight;
    private JPanel buttonPanel;
    private ZMSUIQuery query;
    private ZMSUIQuery query2;
    private ZMSUIQuery query3;
    public LinkedHashMap<Integer, Cage> cages;
    private LinkedHashMap<Integer, Employee> employees;
    private LinkedHashMap<Integer, Animal> animals;
    private String directoryOfZoo;
    private Timer poller;

    /**
     * Creates new form ZMSUI
     */
    public ZMSUI(String loadedZoo) {

        directoryOfZoo = loadedZoo;
        query = new ZMSUIQuery(directoryOfZoo);
        query2 = new ZMSUIQuery(directoryOfZoo);
        query3 = new ZMSUIQuery(directoryOfZoo);
        
        isNight = false;
        cages = new LinkedHashMap();
        employees = new LinkedHashMap<>();
        animals = new LinkedHashMap<>();
        popup = new ZooPopupMenu();
        popListener = new PopClickListener(popup);
        buttonPanel = new JPanel();

        poller = new Timer(5000, new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                refresh();
            }
        });
        poller.start();

        populateEmployees();
        populateAnimals();

        loadMapImageFiles();
        initComponents();
        populateCageMap();
        drawCagePanels();

        setVisible(true);
    }

    private void drawCagePanels() {

        for (final Cage cage : cages.values()) {

            final CagePanel cagePanel = new CagePanel(cage, directoryOfZoo);
            double xLoc = cage.getLatitude() / 90 * 814;
            double yLoc = cage.getLongitude() / 90 * 1020;
            mapArea.add(cagePanel, new org.netbeans.lib.awtextra.AbsoluteConstraints((int) xLoc, (int) yLoc, -1, -1));

            cagePanel.checkHuman(employees);

            LinkedHashMap<Integer, Entrance> entrances = cage.getEntrances();
            cagePanel.checkDoors(entrances);

            cagePanel.checkHungry();
            cagePanel.checkNeedCleaning();
            if (isNight) {
                cagePanel.checkLights();
            }

            cagePanel.setCagePanelColours();
            cagePanel.setUpSizes();

            cagePanel.getEditButtonLabel().addMouseListener(new MouseAdapter() {
                @Override
                public void mouseClicked(MouseEvent me) {
                    CageEditPanel editor = new CageEditPanel(cage, directoryOfZoo, animals);

                    String oldName = "";
                    String oldLat = "";
                    String oldLong = "";
                    String oldSize = "";

                    for (JTextField tf : editor.fieldList) {

                        if (tf.getName().equals("Cage Name")) {
                            oldName = tf.getText();
                        }
                        if (tf.getName().equals("Latitude")) {
                            oldLat = tf.getText();
                        }
                        if (tf.getName().equals("Longitude")) {
                            oldLong = tf.getText();
                        }
                        if (tf.getName().equals("Size (sq. m)")) {
                            oldSize = tf.getText();
                        }
                    }
                    int result = JOptionPane.showConfirmDialog(null, editor, "Edit | " + cage.getName(), JOptionPane.OK_CANCEL_OPTION, JOptionPane.PLAIN_MESSAGE);

                    if (result == JOptionPane.OK_OPTION) {

                        String nameToSave = "";
                        String latToSave = "";
                        String longToSave = "";
                        String sizeToSave = "";

                        for (JTextField tf : editor.fieldList) {
                            switch (tf.getName()) {
                                case "Cage Name":
                                    cage.setName(tf.getText());
                                    nameToSave = tf.getText();
                                    break;
                                case "Latitude":
                                    cage.setLatitude(Double.parseDouble(tf.getText()));
                                    latToSave = tf.getText();
                                    break;
                                case "Longitude":
                                    cage.setLongitude(Double.parseDouble(tf.getText()));
                                    longToSave = tf.getText();
                                    break;
                                case "Size (sq. m)":
                                    cage.setSize(Double.parseDouble(tf.getText()));
                                    sizeToSave = tf.getText();
                                    break;
                            }
                        }
                        query.saveCage(cage.getId(), nameToSave, latToSave, longToSave, sizeToSave, editor.getCageTypeBox().getSelectedItem().toString());
                        cagePanel.getCageName().setText(nameToSave);

                        refresh();


                    } else if (result == JOptionPane.CANCEL_OPTION || result == JOptionPane.CLOSED_OPTION) {

                        for (JTextField tf : editor.fieldList) {
                            switch (tf.getName()) {
                                case "Cage Name":
                                    tf.setText(oldName);
                                    cage.setName(oldName);
                                    break;
                                case "Latitude":
                                    tf.setText(oldLat);
                                    cage.setLatitude(Double.parseDouble(oldLat));
                                    break;
                                case "Longitude":
                                    tf.setText(oldLong);
                                    cage.setLongitude(Double.parseDouble(oldLong));
                                    break;
                                case "Size (sq. m)":
                                    tf.setText(oldSize);
                                    cage.setSize(Double.parseDouble(oldSize));
                                    break;
                            }
                        }
                    }
                }
            });

            cagePanel.getDeleteButtonLabel().addMouseListener(new MouseAdapter() {
                @Override
                public void mouseClicked(MouseEvent me) {

                    int confirm = JOptionPane.showConfirmDialog(null, "Are you sure you want to delete " + cage.getName() + "?", "Warning!", JOptionPane.WARNING_MESSAGE, JOptionPane.YES_NO_OPTION);
                    if (confirm == JOptionPane.OK_OPTION) {
                        for (Entrance entrance : cage.getEntrances().values()) {
                            for (Door door : entrance.getDoors().values()) {
                                query.deleteDoor(entrance.getId());
                            }
                            query.deleteEntrance(cage.getId());
                        }
                        query.deleteCage(cage.getId());
                        refresh();
                    }
                }
            });

            cagePanel.getMinimiseButtonLabel().addMouseListener(new MouseAdapter() {
                @Override
                public void mouseClicked(MouseEvent me) {
                    System.out.println("clicked the button");
                    cagePanel.toggleSize();
                    refresh();
                }
            });

            cagePanel.getMonitorButtonLabel().addMouseListener(new MouseAdapter() {
                @Override
                public void mouseClicked(MouseEvent me) {

                    JOptionPane.showMessageDialog(null, new CageMonitorPanel(cage, directoryOfZoo, employees, animals), "Monitor | " + cage.getName(), JOptionPane.PLAIN_MESSAGE);


                }
            });

        }
    }

    private void populateEmployees() {
        ResultSet employeesRs = query.getEmployees();
        try {
            while (employeesRs.next()) {
                Employee employee = new Employee(employeesRs.getString("name"), employeesRs.getInt("employee_id"), cages.get(employeesRs.getInt("cage_id")));
                employees.put(employee.getId(), employee);
            }

        } catch (SQLException ex) {
            System.out.println(ex);
        }
    }

    private void populateAnimals() {
        ResultSet animalsRs = query.getAnimals();
        try {
            while (animalsRs.next()) {
                Animal animal = new Animal(animalsRs.getString("name"), animalsRs.getInt("id"), cages.get(animalsRs.getInt("cage_id")), animalsRs.getString("avatar"));
                animals.put(animal.getId(), animal);
            }

        } catch (SQLException ex) {
            System.out.println(ex);
        }
    }

    private void refresh() {

        System.out.println("refresh called");
        mapArea.removeAll();
        mapArea.repaint();
        
        cages.clear();
        employees.clear();
        animals.clear();
        
        populateCageMap();
        populateEmployees();
        populateAnimals();
        
        popup.addEmployeeMessageMenuItems();
        popup.addEmployeeDeleteMenuItems();
        popup.addAnimalsDeleteMenuItems();
        
        drawCagePanels();
        mapArea.revalidate();
    }

    private void populateCageMap() {
        try {
            ResultSet cagesRs = query.getCages();
            while (cagesRs.next()) {
                Cage cage = extractCageData(cagesRs);

                cages.put(cage.getId(), cage);
                ResultSet entranceRs = query2.getEntrances(cage.getId());

                while (entranceRs.next()) {
                    Entrance entrance = new Entrance(entranceRs.getInt("id"));
                    cage.getEntrances().put(entrance.getId(), entrance);
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
            }
        } catch (SQLException ex) {
            System.out.println(ex);
        }
    }

    /**
     * This method is called from within the constructor to initialize the form.
     * WARNING: Do NOT modify this code. The content of this method is always
     * regenerated by the Form Editor.
     */
    @SuppressWarnings("unchecked")
    // <editor-fold defaultstate="collapsed" desc="Generated Code">//GEN-BEGIN:initComponents
    private void initComponents() {

        mapArea = new Utility.ImagePanel();
        jMenuBar2 = new javax.swing.JMenuBar();
        jMenu3 = new javax.swing.JMenu();
        loadMenuItem = new javax.swing.JMenuItem();
        quitMenuItem = new javax.swing.JMenuItem();
        jMenu4 = new javax.swing.JMenu();
        toggleNightMenuItem = new javax.swing.JMenuItem();
        jMenuItem1 = new javax.swing.JMenuItem();
        jMenuItem2 = new javax.swing.JMenuItem();

        setDefaultCloseOperation(javax.swing.WindowConstants.EXIT_ON_CLOSE);
        setTitle("Zoo Monitor - " + directoryOfZoo);
        setMinimumSize(new java.awt.Dimension(800, 800));
        setResizable(false);
        getContentPane().setLayout(new org.netbeans.lib.awtextra.AbsoluteLayout());

        mapArea.setBackground(new java.awt.Color(255, 255, 255));
        mapArea.setPreferredSize(new java.awt.Dimension(800, 800));
        mapArea.setLayout(new org.netbeans.lib.awtextra.AbsoluteLayout());
        getContentPane().add(mapArea, new org.netbeans.lib.awtextra.AbsoluteConstraints(0, 0, -1, 800));
        mapArea.setImage(zooDayMap);
        mapArea.setSize(new Dimension(this.getPreferredSize().width, getPreferredSize().height));
        mapArea.fitImage();
        mapArea.revalidate();

        mapArea.addMouseListener(popListener);
        mapArea.getAccessibleContext().setAccessibleName("");

        jMenu3.setText("File");

        loadMenuItem.setText("Load/Create Zoo");
        loadMenuItem.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                loadMenuItemActionPerformed(evt);
            }
        });
        jMenu3.add(loadMenuItem);

        quitMenuItem.setText("Quit");
        quitMenuItem.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                quitMenuItemActionPerformed(evt);
            }
        });
        jMenu3.add(quitMenuItem);

        jMenuBar2.add(jMenu3);

        jMenu4.setText("Edit");

        toggleNightMenuItem.setText("Toggle Day/Night");
        toggleNightMenuItem.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                toggleNightMenuItemActionPerformed(evt);
            }
        });
        jMenu4.add(toggleNightMenuItem);

        jMenuItem1.setText("Lock all Doors");
        jMenuItem1.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                jMenuItem1ActionPerformed(evt);
            }
        });
        jMenu4.add(jMenuItem1);

        jMenuItem2.setText("Unlock all Doors");
        jMenuItem2.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                jMenuItem2ActionPerformed(evt);
            }
        });
        jMenu4.add(jMenuItem2);

        jMenuBar2.add(jMenu4);

        setJMenuBar(jMenuBar2);

        pack();
    }// </editor-fold>//GEN-END:initComponents

    private void quitMenuItemActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_quitMenuItemActionPerformed
        System.exit(1);
    }//GEN-LAST:event_quitMenuItemActionPerformed

private void loadMenuItemActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_loadMenuItemActionPerformed

    this.dispose();
    poller.stop();
    Loader loader = new Loader();
    loader.setVisible(true);
    loader.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
    loader.setSize(400, 600);
    loader.setLocation(400, 200);
    loader.setTitle("Zoo Monitor");

}//GEN-LAST:event_loadMenuItemActionPerformed

    private void toggleNightMenuItemActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_toggleNightMenuItemActionPerformed
        if (isNight) {
            mapArea.setImage(zooDayMap);
            isNight = false;
        } else {
            mapArea.setImage(zooNightMap);
            isNight = true;
        }

        mapArea.fitImage();
        this.repaint();
        refresh();
    }//GEN-LAST:event_toggleNightMenuItemActionPerformed

    private void jMenuItem1ActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_jMenuItem1ActionPerformed
        query.lockAllDoors();
        refresh();
    }//GEN-LAST:event_jMenuItem1ActionPerformed

    private void jMenuItem2ActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_jMenuItem2ActionPerformed
        query.unlockAllDoors();
        refresh();
    }//GEN-LAST:event_jMenuItem2ActionPerformed
    /**
     * @param args the command line arguments
     */
    // Variables declaration - do not modify//GEN-BEGIN:variables
    private javax.swing.JMenu jMenu3;
    private javax.swing.JMenu jMenu4;
    private javax.swing.JMenuBar jMenuBar2;
    private javax.swing.JMenuItem jMenuItem1;
    private javax.swing.JMenuItem jMenuItem2;
    private javax.swing.JMenuItem loadMenuItem;
    private Utility.ImagePanel mapArea;
    private javax.swing.JMenuItem quitMenuItem;
    private javax.swing.JMenuItem toggleNightMenuItem;
    // End of variables declaration//GEN-END:variables
    private JMenuItem addCage;
    private JMenu sendMessage;
    private JMenu deleteEmployee;
    private JMenuItem insertEmployee;
    private JMenu deleteAnimal;
    private JMenuItem insertAnimal;

    /**
     * Load the image files of the zoo map for display.
     */
    private void loadMapImageFiles() {
        try {
            zooDayMap = ImageIO.read(new File(MAP_FILE_LOCATION));
            zooNightMap = ImageIO.read(new File(NIGHT_MAP_FILE_LOCATION));
        } catch (IOException ex) {
        }
    }

    private Cage extractCageData(ResultSet cagesRs) throws SQLException {
        Cage cage = new Cage(cagesRs.getInt("id"));
        cage.setSize(cagesRs.getDouble("size"));
        cage.setType(cagesRs.getString("category"));
        cage.setName(cagesRs.getString("name"));
        cage.setLatitude(cagesRs.getDouble("latitude"));
        cage.setLongitude(cagesRs.getDouble("longitude"));
        cage.setImageFile(cagesRs.getString("imageFile"));
        cage.setHungry(cagesRs.getString("hungry"));
        cage.setNeedCleaning(cagesRs.getString("needcleaning"));
        cage.setLights(cagesRs.getString("lightsOn"));
        cage.setMinimized(cagesRs.getString("minimized"));
        return cage;
    }

    private class ZooPopupMenu extends JPopupMenu {

        public ZooPopupMenu() {

            addCage = new JMenuItem("Add Cage");
            sendMessage = new JMenu("Send Message To");
            deleteEmployee = new JMenu("Remove Employee");
            insertEmployee = new JMenuItem("Create Employee");
            deleteAnimal = new JMenu("Remove Animal");
            insertAnimal = new JMenuItem("Create Animal");

            addCage.addActionListener(new ActionListener() {
                @Override
                public void actionPerformed(ActionEvent ae) {

                    // use to find original lat and long || popListener.getX(), popListener.getY()
                    int latitude = popListener.getX() * 90 / 814;
                    int longitude = popListener.getY() * 90 / 1020;
                    JPanel insertCagePrompts = new JPanel();
                    JLabel name = new JLabel("New Cage Name: ");
                    JLabel type = new JLabel("Type: ");
                    JTextField nameEntry = new JTextField(16);
                    JComboBox<String> typesBox = new JComboBox<>();
                    typesBox.addItem("Marine");
                    typesBox.addItem("Glass");
                    typesBox.addItem("Mesh");
                    typesBox.addItem("Open");


                    insertCagePrompts.add(name);
                    insertCagePrompts.add(nameEntry);
                    insertCagePrompts.add(type);
                    insertCagePrompts.add(typesBox);


                    int result = JOptionPane.showConfirmDialog(null, insertCagePrompts, "Insert New Cage", JOptionPane.OK_CANCEL_OPTION, JOptionPane.QUESTION_MESSAGE);
                    if (result == JOptionPane.OK_OPTION && !nameEntry.getText().equals("")) {
                        System.out.println("name was entered: " + nameEntry.getText());

                        if (latitude > 74 || longitude > 59) {
                            JOptionPane.showMessageDialog(null, "Cage Location Out of Bounds", "Error!", JOptionPane.ERROR_MESSAGE);
                        } else {

                            query.insertCage(nameEntry.getText(), latitude, longitude, typesBox.getSelectedItem().toString());
                            refresh();
                        }
                    }

                }
            });


            add(addCage);
            add(sendMessage);
            add(insertAnimal);
            add(insertEmployee);
            add(deleteAnimal);
            add(deleteEmployee);

            addEmployeeMessageMenuItems();
            addEmployeeDeleteMenuItems();
            addAnimalsDeleteMenuItems();

            insertEmployee.addActionListener(new ActionListener() {
                @Override
                public void actionPerformed(ActionEvent e) {
                    String result = JOptionPane.showInputDialog(null, "Enter new Employee's name", "Insert New Employee", JOptionPane.QUESTION_MESSAGE);
                    if (result != null) {
                        System.out.println("name was entered: " + result);
                        query.insertEmployee(result);
                        refresh();
                    }
                }
            });

            insertAnimal.addActionListener(new ActionListener() {
                @Override
                public void actionPerformed(ActionEvent e) {
                    JPanel newAnimalCreator = new JPanel(new BorderLayout());
                    JPanel bottomPanel = new JPanel();
                    JLabel nameEnterLabel = new JLabel("Enter name: ");
                    JTextField nameEntry = new JTextField(24);
                    JPanel avatars = new JPanel(new GridLayout(13, 13));
                    File rootDir = new File("animalAvatars");
                    final String[] avatarImages = rootDir.list();
                    System.out.println(Arrays.deepToString(avatarImages));
                    ButtonGroup group = new ButtonGroup();
                    ArrayList<JRadioButtonMenuItem> items = new ArrayList<>();
                    for (String imageFileName : avatarImages) {
                        if (imageFileName.endsWith(".gif")) {
                            ImageIcon image = new ImageIcon("animalAvatars/" + imageFileName);
                            JRadioButtonMenuItem avatarButton = new JRadioButtonMenuItem(image);
                            items.add(avatarButton);
                            group.add(avatarButton);
                            avatars.add(avatarButton);
                        }

                    }
                    newAnimalCreator.add(avatars, BorderLayout.NORTH);
                    bottomPanel.add(nameEnterLabel);
                    bottomPanel.add(nameEntry);
                    newAnimalCreator.add(bottomPanel, BorderLayout.SOUTH);
                    int result = JOptionPane.showConfirmDialog(null, newAnimalCreator, "Insert New Animal", JOptionPane.OK_CANCEL_OPTION, JOptionPane.PLAIN_MESSAGE);
                    if (result == JOptionPane.OK_OPTION) {

                        if (nameEntry.getText().equals("") || group.getSelection() == null) {

                            JOptionPane.showMessageDialog(null, "Must enter a name and choose an avatar.", "Error", JOptionPane.ERROR_MESSAGE);
                        } else {
                            String avatarFileName = "";
                            for (JRadioButtonMenuItem item : items) {
                                if (item.isSelected()) {
                                    avatarFileName = item.getIcon().toString().substring(14);
                                }
                            }
                            query.insertAnimal(nameEntry.getText(), avatarFileName);
                            refresh();
                        }
                    }

                }
            });
        }

        private void addEmployeeMessageMenuItems() {
            sendMessage.removeAll();
            for (final Employee employee : employees.values()) {
                JMenuItem item = new JMenuItem(employee.getName());

                item.addActionListener(new ActionListener() {
                    @Override
                    public void actionPerformed(ActionEvent ae) {
                        String messageToSend = JOptionPane.showInputDialog(null, "Send message to " + employee.getName(), "Sending Message", JOptionPane.YES_NO_CANCEL_OPTION);

                        if (messageToSend != null) {
                            query.sendMessage(messageToSend, employee.getId());
                        }

                    }
                });

                sendMessage.add(item);
            }

        }

        private void addEmployeeDeleteMenuItems() {
            deleteEmployee.removeAll();
            for (final Employee employee : employees.values()) {
                JMenuItem item = new JMenuItem(employee.getName());

                item.addActionListener(new ActionListener() {
                    @Override
                    public void actionPerformed(ActionEvent ae) {
                        int result = JOptionPane.showConfirmDialog(null, "Are you sure you want to delete " + employee.getName(), "Warning!", JOptionPane.WARNING_MESSAGE);
                        if (result == JOptionPane.OK_OPTION) {
                            query.deleteEmployee(employee.getId());
                            refresh();
                        }

                    }
                });

                deleteEmployee.add(item);
            }

        }

        private void addAnimalsDeleteMenuItems() {
            deleteAnimal.removeAll();
            for (final Animal animal : animals.values()) {
                JMenuItem item = new JMenuItem(animal.getName());

                item.addActionListener(new ActionListener() {
                    @Override
                    public void actionPerformed(ActionEvent ae) {
                        int result = JOptionPane.showConfirmDialog(null, "Are you sure you want to delete " + animal.getName(), "Warning!", JOptionPane.WARNING_MESSAGE);
                        if (result == JOptionPane.OK_OPTION) {
                            query.deleteAnimal(animal.getId());
                            refresh();
                        }

                    }
                });

                deleteAnimal.add(item);
            }
        }
    }
}
