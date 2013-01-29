/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package View;

import Controller.ZMSUIQuery;
import Model.Animal;
import Model.Cage;
import Model.Door;
import Model.Employee;
import Model.Entrance;
import java.awt.BorderLayout;
import java.awt.Color;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.LinkedHashMap;
import javax.swing.*;

/**
 *
 * @author Chris
 */
public class ZooSimulatorPanel extends JPanel {

    private JLabel zooName;
    private ZMSUIQuery query;
    private ZMSUIQuery query2;
    private ZMSUIQuery query3;
    private LinkedHashMap<Integer, Cage> cages;
    private JPanel zooSimPanel;
    private JPanel cagesPanel;
    private LinkedHashMap<Integer, Employee> employees;
    private LinkedHashMap<Integer, Animal> animals;

    public ZooSimulatorPanel(final String zooDirectory) {

        setSize(300, 300);
        animals = new LinkedHashMap<>();
        employees = new LinkedHashMap();
        cages = new LinkedHashMap();
        zooSimPanel = new JPanel(new BorderLayout());
        cagesPanel = new JPanel();
        add(zooSimPanel);
        zooName = new JLabel(zooDirectory);
        cagesPanel.setBackground(Color.white);
        zooSimPanel.add(cagesPanel, BorderLayout.CENTER);
        zooSimPanel.add(zooName, BorderLayout.NORTH);

        query = new ZMSUIQuery(zooDirectory);
        query2 = new ZMSUIQuery(zooDirectory);
        query3 = new ZMSUIQuery(zooDirectory);
        try {
            populateCageMap();
            populateEmployees();
            populateAnimals();
        } catch (SQLException ex) {
            System.out.println(ex);
        }


        for (final Cage cage : cages.values()) {
            JButton button = new JButton(cage.getName());
            cagesPanel.add(button);

            button.addActionListener(new ActionListener() {

                @Override
                public void actionPerformed(ActionEvent e) {
                    makePopup(cage, zooDirectory);


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

    private void makePopup(Cage myCage, String loadedZoo) {
        String imagePath = "SavedZoos/" + loadedZoo + "/" + myCage.getImageFile();
        SensorsPopup displayPanel = new SensorsPopup(imagePath, myCage, loadedZoo, employees, animals);
        JOptionPane.showMessageDialog(null, displayPanel, "CMSUI", JOptionPane.PLAIN_MESSAGE);
    }

    private void populateCageMap() throws SQLException {
        ResultSet cagesRs = query.getCages();
        while (cagesRs.next()) {
            Cage cage = new Cage(cagesRs.getInt("id"));
            cage.setSize(cagesRs.getDouble("size"));
            cage.setType(cagesRs.getString("category"));
            cage.setName(cagesRs.getString("name"));
            cage.setLatitude(cagesRs.getDouble("latitude"));
            cage.setLongitude(cagesRs.getDouble("longitude"));
            cage.setImageFile(cagesRs.getString("imageFile"));
            cage.setLights(cagesRs.getString("lightsOn"));
            cage.setHungry(cagesRs.getString("hungry"));
            cage.setNeedCleaning(cagesRs.getString("needCleaning"));


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
    }
}
