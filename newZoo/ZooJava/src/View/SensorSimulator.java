/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package View;

import java.awt.GridLayout;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.io.File;
import javax.swing.*;

/**
 *
 * @author jc231781
 */
public class SensorSimulator extends JFrame {

    private JPanel zoosPanel;
    private JScrollPane pane;
    private static final int WINDOW_HEIGHT = 600;
    private static final int WINDOW_WIDTH = 600;
    private JMenuBar bar;
    private JMenu options;
    private JMenuItem refresh;

    public SensorSimulator() {

        bar = new JMenuBar();
        options = new JMenu("Options");
        refresh = new JMenuItem("Refresh");
                
        
        setJMenuBar(bar);
        bar.add(options);
        options.add(refresh);



        File rootDir = new File("savedZoos");
        final String[] zoos = rootDir.list();
        zoosPanel = new JPanel(new GridLayout(zoos.length, 3, 5, 5));
        pane = new JScrollPane(zoosPanel);
        //add(zoosPanel);
        add(pane);
        drawZoos(zoos);

        refresh.addActionListener(new ActionListener() {

            @Override
            public void actionPerformed(ActionEvent e) {
                zoosPanel.removeAll();
                drawZoos(zoos);
                zoosPanel.revalidate();
            }
        });

    }

    private void drawZoos(String[] zoos) {
        for (String zooName : zoos) {
            if (!zooName.contains(".")) {
                ZooSimulatorPanel zooPanel = new ZooSimulatorPanel(zooName);
                zoosPanel.add(zooPanel);
            }
        }
    }

    public static void main(String[] args) {
        SensorSimulator sim = new SensorSimulator();
        sim.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        sim.setSize(WINDOW_WIDTH, WINDOW_HEIGHT);
        sim.setLocation(100, 100);
        sim.setVisible(true);
        sim.setTitle("Sensor Simulator");
    }
}