/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package Model;

import org.junit.AfterClass;
import org.junit.Test;
import static org.junit.Assert.*;
import org.junit.BeforeClass;

/**
 *
 * @author Leenix
 */
public class DoorTest {
    private int testID = 5;
    Door testDoor = new Door(testID);
    
    public DoorTest() {
        
    }
    
    @Test
    public void testOpenDoor() {
        testDoor.open();
        boolean result = testDoor.isOpen();
        
        assertEquals("true", result);
    }
    
    @Test
    public void testCloseDoor() {
        testDoor.close();
        boolean result = testDoor.isOpen();
        
        assertEquals("false", result);
    }
}
