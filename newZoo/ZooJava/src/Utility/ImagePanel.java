/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package Utility;

import java.awt.Component;
import java.awt.Dimension;
import java.awt.Graphics;
import java.awt.Image;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.imageio.ImageIO;
import javax.swing.Icon;
import javax.swing.JPanel;

/**
 *
 * @author Leenix
 */
public class ImagePanel extends JPanel {

    private Image originalImage;
    private Image image;

    public ImagePanel() {
    }

    /**
     * Set the image that the panel will display.
     *
     * @param imagePath File path of the image.
     * @throws IOException File is not found or is inaccessible.
     */
    public void setImage(String imagePath) throws IOException {
        this.originalImage = ImageIO.read(new File(imagePath));
        this.image = originalImage;
    }

    /**
     * Set the image that the panel will display.
     *
     * @param image Object of image to be displayed.
     */
    public void setImage(Image image) {
        this.originalImage = image;
        this.image = originalImage;
    }

    public void resizeToImage() {
        int height = image.getHeight(null);
        int width = image.getWidth(null);

        this.setSize(width, height);
        this.setPreferredSize(new Dimension(width, height));
        this.revalidate();
    }

    public void fitImage() {
        Dimension dimension = this.getPreferredSize();
        this.image = originalImage.getScaledInstance((int) dimension.getWidth(), (int) dimension.getHeight(), 0);
    }

    @Override
    public void paintComponent(Graphics g) {
        super.paintComponent(g);
        g.drawImage(image, 0, 0, null);
    }

    
}
