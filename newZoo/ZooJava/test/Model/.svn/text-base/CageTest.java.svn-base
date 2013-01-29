/*
 * CageTest
 * 
 * Iteration #01
 * 
 * CP2013 - Zoo Monitor
 * Licensed under the New BSD License.
 * 
 * Authors: Chris Ford, Tate Fuller, Karl Mohring
 */

package Model;

import static org.junit.Assert.assertEquals;
import org.junit.Test;

/**
 * Contains tests for the Cage class.
 * @author Leenix
 */
public class CageTest {
    private int testID = 1;
    private Cage testCage;
    private double testDelta = 0.0001;

    public CageTest() {
        testCage = new Cage(testID);
    }

    /**
     * Ensure an entrance can be successfully added to a cage.
     */
    @Test
    public void testAddEntrance() {
        testCage.addEntrance(testID);
        boolean result = testCage.hasEntrance(testID);
        assertEquals(true, result);
    }

    /**
     * Ensure an entrance can be successfully removed from a cage.
     */
    @Test
    public void testRemoveEntrance() {
        testCage.addEntrance(testID);
        testCage.removeEntrance(testID);

        boolean result = testCage.hasEntrance(testID);

        assertEquals(false, result);
    }

    /**
     * Ensure a valid cage size can be set properly.
     */
    @Test
    public void testSetSizePass() {
        double testSize = 10;

        testCage.setSize(testSize);
        assertEquals(testSize, testCage.getSize(), testDelta);
    }

    /**
     * Ensure an invalid cage size is not set.
     */
    @Test
    public void testSetSizeFail() {
        double testSize = 4;
        double workingSize = 5;

        // Pre-set the size to a known working value.
        testCage.setSize(workingSize);

        try {
            testCage.setSize(testSize);
        } catch (Exception e) {
        }

        assertEquals(workingSize, testCage.getSize(), testDelta);
    }

    /**
     * Ensure a valid latitudinal position can be set properly.
     */
    @Test
    public void testSetLatitudePass() {
        double testLatitude = -90.0;
        
        testCage.setLatitude(testLatitude);
        assertEquals(testLatitude, testCage.getLatitude(), testDelta);
    }
    
    /**
     * Ensure an invalid latitudinal position is not set.
     */
    @Test
    public void testSetLatitudeFail(){
        double testLatitude = 91;
        double workingLatitude = -90;

        // Pre-set the size to a known working value.
        testCage.setLatitude(workingLatitude);

        try {
            testCage.setLatitude(testLatitude);
        } catch (Exception e) {
        }

        // Latitude value should not have changed from the pre-set value.
        assertEquals(workingLatitude, testCage.getLatitude(), testDelta);
    }
    
    /**
     * Ensure a valid longitudinal position is set properly.
     */
    @Test
    public void testSetLongitudePass() {
        double testLongitude = 180.0;
        
        testCage.setLongitude(testLongitude);
        assertEquals(testLongitude, testCage.getLongitude(), testDelta);
    }
    
    /**
     * Ensure an invalid longitudinal position is not set.
     */
    @Test
    public void testSetLongitudeFail(){
        double testLongitude = -200;
        double workingLongitude = 180;

        // Pre-set the size to a known working value.
        testCage.setLongitude(workingLongitude);

        try {
            testCage.setLongitude(testLongitude);
        } catch (Exception e) {
        }

        // Latitude value should not have changed from the pre-set value.
        assertEquals(workingLongitude, testCage.getLongitude(), testDelta);
        
    }
}
