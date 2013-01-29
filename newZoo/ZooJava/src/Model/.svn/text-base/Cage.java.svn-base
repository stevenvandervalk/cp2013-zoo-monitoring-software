/*
 * Cage
 * 
 * Iteration #1
 * 
 * CP2013 - Zoo Monitor
 * Licensed under the New BSD License.
 * 
 * Authors: Chris Ford, Tate Fuller, Karl Mohring.
 */
package Model;

import java.util.LinkedHashMap;

public class Cage {

    public static final String[] CAGE_TYPES = {"Marine", "Glass", "Open", "Mesh"};
    public static final double MIN_CAGE_AREA = 5.0;
    public static final double LONGITUDE_MAX = 59.0;
    public static final double LONGITUDE_MIN = 0.0;
    public static final double LATITUDE_MAX = 74;
    public static final double LATITUDE_MIN = 0.0;
    private int id;
    private double size;
    private String type;
    private String name;
    private double latitude;
    private double longitude;
    private boolean humanInCage;
    private String animalName;
    private String dateLastFed;
    private String dateLastCleaned;
    private String imageFile;
    private String lights;
    private String minimized;
    private String hungry;
    private String needCleaning;

    /**
     * Create a new cage.
     *
     * @param id The ID number of the cage.
     */
    public Cage(int cageID) {
        this.id = cageID;
        this.entrances = new LinkedHashMap();
        this.size = MIN_CAGE_AREA;
    }

    public String getMinimized() {
        return minimized;
    }

    public void setMinimized(String minimized) {
        this.minimized = minimized;
    }

    public String getHungry() {
        return hungry;
    }

    public void setHungry(String hungry) {
        this.hungry = hungry;
    }

    public String getLights() {
        return lights;
    }

    public void setLights(String lights) {
        this.lights = lights;
    }

    public String getNeedCleaning() {
        return needCleaning;
    }

    public void setNeedCleaning(String needCleaning) {
        this.needCleaning = needCleaning;
    }
    private LinkedHashMap<Integer, Entrance> entrances;

    public void setImageFile(String newFile) {
        this.imageFile = newFile;
    }

    public String getImageFile() {
        return imageFile;
    }

    /**
     * Get the last-cleaned date of the cage.
     *
     * @return Date of last clean.
     */
    public String getDateLastCleaned() {
        return dateLastCleaned;
    }

    /**
     * Set the date of the cage's last clean.
     *
     * @param dateLastCleaned Date of last clean.
     */
    public void setDateLastCleaned(String dateLastCleaned) {
        this.dateLastCleaned = dateLastCleaned;
    }

    /**
     * Get the cage's most recent feeding time.
     *
     * @return Date of most recent feed.
     */
    public String getDateLastFed() {
        return dateLastFed;
    }

    /**
     * Set the cages most recent feeding time.
     *
     * @param dateLastFed Date of most recent feed.
     */
    public void setDateLastFed(String dateLastFed) {
        this.dateLastFed = dateLastFed;
    }

    /**
     * Get the current cages entrances.
     *
     * @return Map of the current cages entrances.
     */
    public LinkedHashMap<Integer, Entrance> getEntrances() {
        return entrances;
    }

    /**
     * Set the current cages entrances.
     *
     * @param entrances Map of the current cages entrances.
     */
    public void setEntrances(LinkedHashMap<Integer, Entrance> entrances) {
        this.entrances = entrances;
    }

    /**
     *
     *
     * /**
     * Get the cage's unique identifier.
     *
     * @return Unique identifier of cage.
     */
    public int getId() {
        return id;
    }

    /**
     * Get the latitudinal position of the cage.
     *
     * @return Latitudinal position of cage.
     */
    public double getLatitude() {
        return latitude;
    }

    /**
     * Set the latitudinal position of the cage. The latitudinal position must
     * be between the allowed boundaries, or an exception is thrown.
     *
     * @param latitude Latitudinal position of the cage.
     */
    public void setLatitude(double latitude) {
        if (latitude >= LATITUDE_MIN && latitude <= LATITUDE_MAX) {
            this.latitude = latitude;
        } else {
            throw new IllegalArgumentException("Latitude out of bounds.");
        }
    }

    /**
     * Get the longitudinal position of the cage.
     *
     * @return Longitudinal position of cage.
     */
    public double getLongitude() {
        return longitude;
    }

    /**
     * Set the longitudinal position of the cage. The longitudinal position must
     * be between the allowed boundaries, or an exception is thrown.
     *
     * @param longitude Longitudinal position of the cage.
     */
    public void setLongitude(double longitude) {
        if (longitude >= LONGITUDE_MIN && longitude <= LONGITUDE_MAX) {
            this.longitude = longitude;
        } else {
            throw new IllegalArgumentException("Longitude out of bounds.");
        }
    }

    /**
     * Get the name of the current cage.
     *
     * @return Name of the cage.
     */
    public String getName() {
        return name;
    }

    /**
     * Set the name of the current cage.
     *
     * @param name Name of the cage.
     */
    public void setName(String name) {
        this.name = name;
    }

    /**
     * Get the area of the cage.
     *
     * @return Area value of the cage in m².
     */
    public double getSize() {
        return size;
    }

    /**
     * Set the floor area value of the cage. The floor area must be greater than
     * the set minimum, otherwise an exception is thrown.
     *
     * @param cageSize Area value of the cage in m².
     */
    public void setSize(double cageSize) {
        if (cageSize >= MIN_CAGE_AREA) {
            this.size = cageSize;
        } else {
            throw new IllegalArgumentException("Cage area below minimum allowed area.");
        }
    }

    /**
     * Get the construction category of the current cage.
     *
     * @return The category of the cage.
     */
    public String getType() {
        return type;
    }

    /**
     * Set the construction category of the cage.
     *
     * @param cageType The category of the cage.
     */
    public void setType(String cageType) {
        this.type = cageType;
    }

    /**
     * Check if the current cage has a specified entrance.
     *
     * @param entranceID Unique identifier of specified entrance.
     * @return True if the specified entrance belongs to the current cage.
     */
    public boolean hasEntrance(int entranceID) {
        return entrances.containsKey(entranceID);
    }

    /**
     * Add a specified entrance to the current cage. Any entrances with the same
     * ID number will be overwritten.
     *
     * @param entranceID Unique identifier of the specified entrance.
     */
    public void addEntrance(int entranceID) {
        Entrance newEntrance = new Entrance(entranceID);
        entrances.put(entranceID, newEntrance);
    }

    /**
     * Remove a specified entrance from the current cage.
     *
     * @param entranceID Unique identifier of the specified entrance.
     */
    public void removeEntrance(int entranceID) {
        entrances.remove(entranceID);
    }
}