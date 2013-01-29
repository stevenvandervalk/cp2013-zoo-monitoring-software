package Model;

import static org.junit.Assert.assertEquals;
import org.junit.Test;

/**
 * Test class for the 'CP2013 Zoo Monitor v1' Entrance class.
 * @author Leenix
 */
public class EntranceTest {

    private Entrance testEntrance;
    private final int testID = 1;

    /**
     * Create a new instance of the Entrance class for testing.
     */
    public EntranceTest() {
        testEntrance = new Entrance(testID);
    }
    
    /**
     * Ensure a door can be successfully added to an Entrance.
     */
    @Test
    public void testAddDoor(){
        testEntrance.addDoor(testID);
        boolean result = testEntrance.hasDoor(testID);
        
        assertEquals(true, result);
    }
    
    /**
     * Ensure a door can be successfully removed from an Entrance.
     */
    @Test
    public void testRemoveDoor(){
        testEntrance.addDoor(testID);
        testEntrance.removeDoor(testID);
        
        boolean result = testEntrance.hasDoor(testID);
        
        assertEquals(false, result);
    }
}
