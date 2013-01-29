/*
 * Door
 * 
 * Iteration #01
 * 
 * CP2013 - Zoo Monitor
 * Licensed under the New BSD License.
 * 
 * Authors: Chris Ford, Tate Fuller, Karl Mohring.
 */

package Model;

/**
 * Door class for the CP2013 Zoo Monitoring v1 software.
 * @author CP2013 Group
 */
public class Door {
    private boolean openStatus;
    private boolean lockStatus;
    private int id;
   

    /**
     * Create a new door with the specified ID.
     *
     * @param id Unique identifier for the new door.
     */
    public Door(int id) {
        this.id = id;
        openStatus = false;
    }

    /**
     * Set the door's status to 'open'.
     */
    public void open() {
        this.openStatus = true;
    }

    /**
     * Set the door's status to 'closed'.
     */
    public void close() {
        this.openStatus = false;
    }

    /**
     * Set the door's lock status to 'locked'.
     */
    public void lock() {
        this.lockStatus = true;
    }

    /**
     * Set the door's status to 'closed'.
     */
    public void unlock() {
        this.lockStatus = false;
    }
    
    /**
     * Get the open/closed status of the door.
     * @return True if the door is open.
     */
    public boolean isOpen() {
        return openStatus;
    }
    
        /**
     * Get the open/closed status of the door.
     * @return True if the door is open.
     */
    public boolean isLocked() {
        return lockStatus;
    }

    /**
     * Get the unique identifier of the current door.
     * @return Unique identifier for the current door.
     */
    public int getId() {
        return id;
    }
}
    
    
     
