/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package Controller;

import Model.Cage;
import Model.Door;
import Model.Entrance;
import java.util.LinkedHashMap;

/**
 *
 * @author leenix
 */
public abstract class IDataStore {
    abstract LinkedHashMap<Integer, Cage> pullCages();
    abstract LinkedHashMap<Integer, Entrance> pullEntrances(int cageID);
    abstract LinkedHashMap<Integer, Door> pullDoors(int entranceID);
    abstract void pushDoor();
    
}
