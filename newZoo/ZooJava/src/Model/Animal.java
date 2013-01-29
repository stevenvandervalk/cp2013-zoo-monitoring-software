/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package Model;

import java.awt.Image;
import javax.swing.ImageIcon;

/**
 *
 * @author jc231781
 */
public class Animal {
    
    private String name;
    private int id;
    private Cage cage;
    private ImageIcon avatar;

    public Animal(String name, int id, Cage cage, String avatarFile) {
        
        this.name = name;
        this.id = id;
        this.cage = cage;
        this.avatar = new ImageIcon("animalAvatars/" + avatarFile);
    }

    public ImageIcon getAvatar() {
        return avatar;
    }

    public void setAvatar(ImageIcon avatar) {
        this.avatar = avatar;
    }

    public Cage getCage() {
        return cage;
    }

    public void setCage(Cage cage) {
        this.cage = cage;
    }


    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }
    
    
}
