/*
 * CageUIDbQuery
 * 
 * Iteration #01
 * 
 * CP2013 - Zoo Monitor
 * Licensed under the New BSD License.
 * 
 * Authors: Chris Ford, Tate Fuller, Karl Mohring.
 */
package Controller;

import Utility.DBConnect;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.TimeZone;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 * Provide the necessary query methods for the CageUI to interact with the
 * database.
 *
 * @author jc231722
 */
public class ZMSUIQuery {

    private static Connection con;
    private Statement statement;

    /**
     * Provides the CageUI with its necessary methods to interact with the
     * database.
     *
     * @throws SQLException
     */
    public ZMSUIQuery(String loadedZoo) {

        DBConnect connection = new DBConnect(loadedZoo);
        con = connection.getDbConnection();
        try {
            statement = con.createStatement();
        } catch (SQLException ex) {
            System.out.println(ex);
        }
    }

    /**
     * Get the cage information presently in the database.
     *
     * @return Set of results containing the cage information.
     */
    public ResultSet getCages() {
        try {

            String sql = "SELECT * FROM cages";
            ResultSet rs = statement.executeQuery(sql);
            System.out.println("got cages");
            return rs;
        } catch (SQLException e) {
            System.out.println("failed getting cages" + e);
            return null;
        }
    }

    /**
     * Get the entrance information of a specified cage.
     *
     * @param cageID Unique identifier of the associated cage.
     * @return Set of results containing the cage's entrance information.
     */
    public ResultSet getEntrances(int cageID) {
        try {

            String sql = "SELECT * FROM entrances WHERE cage_id='" + cageID + "'";
            ResultSet rs = statement.executeQuery(sql);
            System.out.println("got entrances");
            return rs;
        } catch (SQLException e) {
            System.out.println("failed getting entrances " + e);
            return null;
        }
    }

    /**
     * Get the door information of a specified entrance.
     *
     * @param entranceID Unique identifier of the associated entrance.
     * @return Set the results containing the entrance's door information.
     */
    public ResultSet getDoors(int entranceID) {
        try {
            String sql = "SELECT * FROM doors WHERE entrance_id='" + entranceID + "'";
            ResultSet rs = statement.executeQuery(sql);
            System.out.println("got doors");
            return rs;
        } catch (SQLException e) {
            System.out.println("failed getting doors " + e);
            return null;
        }
    }

    public int updateDoor(int doorId, String open, String locked) {
        try {
            String sql = "UPDATE doors SET open = '" + open + "', locked = '" + locked + "' WHERE id='" + doorId + "'";
            // update doors set open="false", locked="false" where id=6;
            System.out.println(sql);
            int updateQuery = statement.executeUpdate(sql);
            System.out.println("door updated");
            return updateQuery;

        } catch (Exception e) {
            System.out.println("Failed to update door " + e);
            return 0;
        }
    }

    public ResultSet getEmployees() {
        try {

            String sql = "SELECT * FROM employees";
            ResultSet rs = statement.executeQuery(sql);
            System.out.println("got employees");
            return rs;
        } catch (SQLException e) {
            System.out.println("failed getting employees " + e);
            return null;
        }
    }

    public ResultSet getAnimals() {
        try {

            String sql = "SELECT * FROM animals";
            ResultSet rs = statement.executeQuery(sql);
            System.out.println("got animals");
            return rs;
        } catch (SQLException e) {
            System.out.println("failed getting employees " + e);
            return null;
        }
    }

    public void deleteCage(int cageId) {
        String sql = "DELETE FROM cages WHERE id = '" + cageId + "'";
        try {
            statement.executeUpdate(sql);
        } catch (SQLException ex) {
            System.out.println("Failed to delete cage" + ex);
        }
    }

    public void deleteEntrance(int cageId) {
        String sql = "DELETE FROM entrances WHERE cage_id = '" + cageId + "'";
        try {
            statement.executeUpdate(sql);
        } catch (SQLException ex) {
            System.out.println("Failed to delete entrance(s)" + ex);
        }
    }

    public void deleteDoor(int entranceId) {
        String sql = "DELETE FROM doors WHERE entrance_id = '" + entranceId + "'";
        try {
            statement.executeUpdate(sql);
        } catch (SQLException ex) {
            System.out.println("Failed to delete door(s)" + ex);
        }
    }

    public void sendMessage(String message, int employee_id) {
        String sql = "INSERT INTO messages (employee_id, message) VALUES ('" + employee_id + "', " + message + ")";
        try {
            statement.executeQuery(sql);
        } catch (SQLException ex) {
            System.out.println("Failed ot insert message and employee id into database table 'messages'");
        }
    }

    public int saveCage(int id, String nameToSave, String latToSave, String longToSave, String sizeToSave, String typeToSave) {
        try {
            String sql = "UPDATE cages SET name = '" + nameToSave + "', latitude = '" + latToSave + "', longitude = '" + longToSave + "', size = '" + sizeToSave + "', category = '" + typeToSave + "' WHERE id='" + id + "'";
            // update doors set open="false", locked="false" where id=6;
            System.out.println(sql);
            int updateQuery = statement.executeUpdate(sql);
            System.out.println("cage saved");
            return updateQuery;

        } catch (Exception e) {
            System.out.println("Failed to save cage " + e);
            return 0;
        }
    }

    public void insertEmployee(String name) {
        String sql = "INSERT INTO employees (name) VALUES ('" + name + "')";
        System.out.println(sql);
        try {
            statement.executeQuery(sql);
        } catch (SQLException ex) {
            System.out.println("failed to insert new employee" + ex);
        }
    }

    public void insertCage(String name, int latitude, int longitude, String type) {
        String sql = "INSERT INTO cages (minimized, needcleaning, hungry, lightsOn, imageFile, size, category, name, latitude, longitude) VALUES ('true', 'false', 'false', 'true', '', '5.0', '" + type + "', '" + name + "', '" + latitude + "', '" + longitude + "')";
        System.out.println(sql);
        try {
            statement.executeQuery(sql);
        } catch (SQLException ex) {
            System.out.println("failed to insert new employee" + ex);
        }
    }

    public void deleteEmployee(int id) {
        String sql = "DELETE FROM employees WHERE employee_id = '" + id + "'";
        try {
            statement.executeUpdate(sql);
        } catch (SQLException ex) {
            System.out.println("Failed to delete employee" + ex);
        }
    }

    public void deleteAnimal(int id) {
        String sql = "DELETE FROM animals WHERE id = '" + id + "'";
        try {
            statement.executeUpdate(sql);
        } catch (SQLException ex) {
            System.out.println("Failed to delete animal" + ex);
        }
    }

    public int setCageMinimized(String state, int id) {
        try {
            String sql = "UPDATE cages SET minimized = '" + state + "' WHERE id =" + "'" + id + "'";
            System.out.println(sql);
            int updateQuery = statement.executeUpdate(sql);
            System.out.println("cage minimize updated");
            return updateQuery;

        } catch (Exception e) {
            System.out.println("Failed to update minimize on cage " + e);
            return 0;
        }
    }

    public void insertAnimal(String name, String avatar) {
        String sql = "INSERT INTO animals (name, avatar) VALUES ('" + name + "', '" + avatar + "')";
        System.out.println(sql);
        try {
            statement.executeQuery(sql);
        } catch (SQLException ex) {
            System.out.println("failed to insert new animal" + ex);
        }
    }

    public void lockAllDoors() {
        String sql = "UPDATE doors set locked = 'true'";
        System.out.println(sql);
        try {
            statement.executeQuery(sql);
        } catch (SQLException ex) {
            System.out.println("failed to lock doors" + ex);
        }
    }

    public void unlockAllDoors() {
        String sql = "UPDATE doors set locked = 'false'";
        System.out.println(sql);
        try {
            statement.executeQuery(sql);
        } catch (SQLException ex) {
            System.out.println("failed to unlock doors" + ex);
        }
    }
}
