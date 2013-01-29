/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package Utility;

import java.awt.event.MouseAdapter;
import java.awt.event.MouseEvent;
import javax.swing.JPopupMenu;

/**
 *
 * @author leenix
 */
public class PopClickListener extends MouseAdapter {

    JPopupMenu popup;
    int xPosition;
    int yPosition;

    public PopClickListener(JPopupMenu menu) {
        popup = menu;
    }

    @Override
    public void mouseReleased(MouseEvent e) {
        if (e.isPopupTrigger()) {
            doPop(e);
        }
    }
    
    @Override
    public void mousePressed(MouseEvent e) {
        if (e.isPopupTrigger()) {
            doPop(e);
        }
    }

    private void doPop(MouseEvent e) {
        xPosition = e.getX();
        yPosition = e.getY();
        popup.show(e.getComponent(), xPosition, yPosition);
    }

    public int getX() {
        return xPosition;
    }

    public int getY() {
        return yPosition;
    }
}

