/*
 * Entrance
 * 
 * Iteration #01
 * 
 * CP2013 - Zoo Monitor
 * License under the New BSD License.
 * 
 * Authors: Chris Ford, Tate Fuller, Karl Mohring.
 */

package Model;

import java.util.LinkedHashMap;

public class Entrance {
    private int id;
    private LinkedHashMap<Integer, Door> doors;

    /**
     * Create a new entrance to a cage.
     * 
     * @param id Unique identifier of the current entrance.
     */
    public Entrance(int id) {
        this.id = id;
        this.doors = new LinkedHashMap();
    }

    /**
     * Get the unique identifier of the current entrance.
     * 
     * @return Unique identifier of the current entrance.
     */
    public int getId() {
        return id;
    }
    
    /**
     * Set the unique identifier of the current entrance.
     * 
     * @param entranceID Unique identifier of the current entrance.
     */
    public void setID(int entranceID){
        this.id = entranceID;
    }

    /**
     * Get the doors that belong to the current entrance.
     * @return Map of the doors belonging to the current entrance.
     */
    public LinkedHashMap<Integer, Door> getDoors() {
        return doors;
    }
    
    /**
     * Set the doors that belong to the current entrance.
     * @param doorMap Map of the Door objects that belong to the current entrance.
     */
    public void setDoors(LinkedHashMap<Integer, Door> doorMap){
        this.doors = doorMap;
    }
    
    /**
     * Check whether or not the current entrance contains a specified door.
     *
     * @param id Unique identifier of the door.
     * @return True if the entrance contains the specified door.
     */
    public boolean hasDoor(int id) {
        return doors.containsKey(id);
    }

    /**
     * Add a door to the current entrance. 
     * Entries with the same door ID are overwritten.
     *
     * @param doorID Unique identifier for the new door.
     */
    public void addDoor(int doorID) {
        Door newDoor = new Door(doorID);
        doors.put(doorID, newDoor);

    }

    /**
     * Remove a specified door from the current entrance.
     *
     * @param doorID Unique identifier of door to be removed.
     */
    public void removeDoor(int doorID) {
        doors.remove(doorID);
    } 
   
}
