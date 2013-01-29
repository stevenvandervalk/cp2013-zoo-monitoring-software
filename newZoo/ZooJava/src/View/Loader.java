/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package View;

import java.awt.BorderLayout;
import java.awt.Dimension;
import java.awt.GridLayout;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import javax.swing.JButton;
import javax.swing.JFrame;
import javax.swing.JOptionPane;
import javax.swing.JPanel;
import javax.swing.JScrollPane;

/**
 *
 * @author Chris
 */
public class Loader extends JFrame {

    private JPanel zooPanel;
    private int numZoos;
    private JScrollPane pane;
    private JButton newZoo;
    private final static int WINDOW_HEIGHT = 600;
    private final static int WINDOW_WIDTH = 400;
    private File rootDir;

    public Loader() {
        setLayout(new BorderLayout());

        rootDir = new File("savedZoos");
        zooPanel = new JPanel();
        newZoo = new JButton("*****     Create a new Zoo     *****");

        newZoo.addActionListener(new ActionListener() {

            @Override
            public void actionPerformed(ActionEvent e) {
                File rootDir = new File("savedZoos");
                String name = JOptionPane.showInputDialog(null, "Name your zoo: ");
                boolean success = false;
                if (!name.contains(".")) {
                    String path = rootDir + "/" + name;
                    success = (new File(path)).mkdir();
                }
                if (!success) {
                    JOptionPane.showMessageDialog(null, "Invalid Name: Name taken or contains illegal characters.");
                } else if (success) {
                    File file = new File("savedZoos/development.sqlite3");
                    File newFile = new File("savedZoos/" + name + "/development.sqlite3");
                    try {
                        newFile.createNewFile();
                    } catch (IOException ex) {
                        System.out.println(ex);
                    }

                    try {
                        FileOutputStream out;
                        try (FileInputStream in = new FileInputStream(file)) {
                            out = new FileOutputStream(newFile);
                            byte[] buf = new byte[1024];
                            int len;
                            while ((len = in.read(buf)) > 0) {
                                out.write(buf, 0, len);
                            }
                        }
                        out.close();
                    } catch (IOException ex) {
                        System.out.println(ex);
                    }
                    //refreshLoader();
                    openZoo(name);
                }

            }
        });


        pane = new JScrollPane(zooPanel);
        pane.setPreferredSize(new Dimension(WINDOW_WIDTH, WINDOW_HEIGHT - 40));
        add(pane, BorderLayout.NORTH);

        createButtons();
    }

    private void refreshLoader() {
        System.out.println("refresh called");
        zooPanel.removeAll();
        createButtons();
        zooPanel.revalidate();
    }

    private void createButtons() {
        System.out.println("creating");
        String[] zoos = rootDir.list();
        numZoos = zoos.length;
        System.out.println(numZoos);
        zooPanel.setLayout(new GridLayout(numZoos * 50, 1));
        zooPanel.add(newZoo);
        for (String fileName : zoos) {
            System.out.println(fileName);
            //System.out.println(fileName + " LOOK HERE");
            if (!fileName.contains(".")) {
                JPanel zoo = new JPanel();
                final JButton zooButton = new JButton(fileName);
                JButton deleteButton = new JButton("Delete");

                zoo.add(zooButton);
                zoo.add(deleteButton);
                zooPanel.add(zoo);
                System.out.println("made a set");

                zooButton.addActionListener(new ActionListener() {

                    @Override
                    public void actionPerformed(ActionEvent e) {
                        openZoo(zooButton.getText());
                    }
                });

                deleteButton.addActionListener(new ActionListener() {

                    @Override
                    public void actionPerformed(ActionEvent e) {
                        System.out.println("clicked delete");
                        File directory = new File("savedZoos/" + zooButton.getText());
                        for (File file : directory.listFiles()) {
                            if (file.delete()) {
                                System.out.println("file deleted");
                            }
                        }
                        if (directory.delete()) {
                            System.out.println("directory deleted");
                        }
                        refreshLoader();


                    }
                });
            }
        }
    }

    private void openZoo(String zoo) {
        closeLoader();
        ZMSUI zmsui = new ZMSUI(zoo);
    }

    public void closeLoader() {
        this.dispose();
    }

    public static void main(String[] args) {
        Loader loader = new Loader();
        loader.setVisible(true);
        loader.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        loader.setSize(WINDOW_WIDTH, WINDOW_HEIGHT);
        loader.setLocation(400, 200);
        loader.setTitle("Zoo Monitor");

    }
}