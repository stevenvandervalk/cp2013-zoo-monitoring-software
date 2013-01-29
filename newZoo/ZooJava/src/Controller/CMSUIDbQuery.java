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
public class CMSUIDbQuery {

    private static Connection con;
    private Statement statement;

    /**
     * Provides the CageUI with its necessary methods to interact with the
     * database.
     *
     * @throws SQLException
     */
    public CMSUIDbQuery(String loadedZoo) throws SQLException {

        DBConnect connection = new DBConnect(loadedZoo);
        con = connection.getDbConnection();
        statement = con.createStatement();
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

    /**
     * Set the cage's 'date last fed' to the current time.
     *
     * @param cageID Unique identifier of th associated cage.
     */
    public void feedCage(int cageID) {
        try {
            String currentTime = getTime();
            String sqlStatement = "UPDATE cages SET date_last_fed = '" + currentTime + "' WHERE id = '" + cageID + "'";
            statement.executeUpdate(sqlStatement);
        } catch (SQLException e) {
            System.out.println("Last feeding time not set");
        }
    }

    /**
     * Set the cage's 'date last cleaned' to the current time.
     *
     * @param cageID Unique identifier of the associated cage.
     */
    public void cleanCage(int cageID) {
        try {
            String currentTime = getTime();
            String sqlStatement = "UPDATE cages SET date_last_cleaned = '" + currentTime + "' WHERE id = '" + cageID + "'";
            statement.executeUpdate(sqlStatement);
        } catch (SQLException e) {
            System.out.println("Last cleaning time not set");
        }
    }

    /**
     * Get the current time of the user's system.
     *
     * @return The current time and date.
     */
    public String getTime() {
        SimpleDateFormat dateFormatGmt = new SimpleDateFormat("yyyy-MMM-dd HH:mm:ss");
        dateFormatGmt.setTimeZone(TimeZone.getTimeZone("GMT+10:00"));
        String formattedDate = dateFormatGmt.format(new Date());
        System.out.println(formattedDate);
        return formattedDate;
    }

    /**
     * Get the date of the last feeding for the specified cage.
     *
     * @param cageID Unique identifier of the associated cage.
     * @return The most recent feeding time of the cage.
     */
    public String getLastFed(int cageID) {
        try {
            String sqlStatement = "SELECT date_last_fed FROM cages WHERE id = '" + cageID + "'";
            //String returnedDate = statement.execute(sqlStatement);
            SimpleDateFormat dateFormatGmt = new SimpleDateFormat("yyyy-MMM-dd HH:mm:ss");
            dateFormatGmt.setTimeZone(TimeZone.getTimeZone("GMT+10:00"));
            System.out.println(statement.executeQuery(sqlStatement).getType() + "Last fed get type()");
            System.out.println(statement.executeQuery(sqlStatement).toString() + " last fed getstring()");
            String formattedDate = dateFormatGmt.format(new Date());

            return formattedDate;
        } catch (SQLException ex) {
            System.out.println("Could not select the last cleaning time");
            return null;
        }

    }

    /**
     * Get the date of the last clean for the specified cage.
     *
     * @param cageID Unique identifier of the associated cage.
     * @return The most recent cleaning time of the cage.
     */
    public String getLastCleaned(int cageID) {

        try {
            String sqlStatement = "SELECT date_last_cleaned FROM cages WHERE id = '" + cageID + "'";
            //String returnedDate = statement.execute(sqlStatement);
            SimpleDateFormat dateFormatGmt = new SimpleDateFormat("yyyy-MMM-dd HH:mm:ss");
            dateFormatGmt.setTimeZone(TimeZone.getTimeZone("GMT+10:00"));
            System.out.println(statement.executeQuery(sqlStatement).getType() + "lastCleaned getType");

            System.out.println(statement.executeQuery(sqlStatement).toString() + "lastCleaned etstring()");
            String formattedDate = dateFormatGmt.format(new Date());

            return formattedDate;
        } catch (SQLException ex) {
            System.out.println("Could not select the last cleaning time");
            return null;
        }

    }

    /**
     * Get whether or not there is a human present in a specified cage.
     *
     * @param cageID Unique identifier of the associated cage.
     * @return True if a human is present in the cage.
     */
    public ResultSet isHumanInside(int cageID) {

        try {
            String sqlStatement = "SELECT human_present FROM cages WHERE id = '" + cageID + "'";
            ResultSet rs = statement.executeQuery(sqlStatement);
            return rs;

        } catch (SQLException ex) {
            System.out.println("Couldn't determine if a human is inside");
            return null;
        }
    }

    /**
     * Get the open status of all doors for a specified cage.
     *
     * @param cageID Unique identifier of the associated cage.
     * @return Set of results for the door's status.
     */
    public ResultSet getAllDoorStates(int cageID) {

        try {
            String sql = "SELECT open from doors where entrance_id IN (SELECT id FROM entrance where cage_id = '" + cageID + "')";
            ResultSet rs = statement.executeQuery(sql);
//            while (rs.next()){
//                System.out.println(rs.getString("open"));
//            }
//            System.out.println("");
            return rs;

        } catch (SQLException e) {
            System.out.println("Couldn't determine if door is open");
            return null;
        }
    }

    /**
     * Check the open status of a specified door from the database.
     *
     * @param doorID Unique identifier of the associated door.
     * @return True if the door is open.
     */
    public Boolean isDoorOpen(int doorID) {
        try {
            String sqlStatment = "SELECT open FROM doors WHERE id = '" + doorID + "'";
            ResultSet rs = statement.executeQuery(sqlStatment);
            while (rs.next()) {
                switch (rs.getString("open")) {
                    case "true":
                        return true;
                    case "false":
                        return false;
                }
            }
            return null;

        } catch (SQLException ex) {
            Logger.getLogger(CMSUIDbQuery.class.getName()).log(Level.SEVERE, null, ex);
            return null;
        }
    }

    /**
     * Set the open status of a specified door.
     *
     * @param doorID Unique identifier of the associated door.
     * @param state New open status of door. True if the door is open.
     */
    public void setDoorOpen(int doorID, String state) {
        try {
            String sqlStatement = "UPDATE doors SET open = '" + state + "' WHERE id = '" + doorID + "'";
            statement.executeUpdate(sqlStatement);

        } catch (SQLException ex) {
            System.out.println("Failed changing door state");
        }
    }

    /**
     * Set whether or not there is a human present inside a specified cage.
     *
     * @param cageID Unique identifier of the associated cage.
     * @param state New 'human present' status of the cage.
     */
    public void setHumanInside(int cageID, String state) {
        try {
            String sqlStatement = "UPDATE cages SET human_present = '" + state + "' WHERE id = '" + cageID + "'";
            statement.executeUpdate(sqlStatement);

        } catch (SQLException ex) {
            System.out.println("Failed changing human state");
        }
    }

    /**
     * Enable party mode. Opens all doors for all cages.
     */
    public void enablePartyMode() {
        try {
            String sqlStatement = "UPDATE doors SET open = 'true'";
            statement.executeUpdate(sqlStatement);
            System.out.println("DOORS ARE OPEN!");
        } catch (SQLException ex) {
            System.out.println("Party mode activation failed");
        }
    }

    /**
     * Disables party mode. Closes all doors for all cages.
     */
    public void disablePartyMode() {
        try {
            String sqlStatement = "UPDATE doors SET open = 'false'";
            statement.executeUpdate(sqlStatement);
            System.out.println("DOORS ARE Closed ... :(");
        } catch (SQLException ex) {
            System.out.println("Party mode deactivation failed");
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

    public void updateLights(int cageID, String state) {
        try {
            String sqlStatement = "UPDATE cages SET lightsOn = '" + state + "' WHERE id = '" + cageID + "'";
            System.out.println(sqlStatement);
            statement.executeUpdate(sqlStatement);

        } catch (SQLException ex) {
            System.out.println("Failed changing lights state");
        }
    }

    public void updateHungry(int cageID, String state) {
        try {
            String sqlStatement = "UPDATE cages SET hungry = '" + state + "' WHERE id = '" + cageID + "'";
            System.out.println(sqlStatement);
            statement.executeUpdate(sqlStatement);

        } catch (SQLException ex) {
            System.out.println("Failed changing hungry state");
        }
    }

    public void updateNeedClean(int cageID, String state) {
        try {
            String sqlStatement = "UPDATE cages SET needCleaning = '" + state + "' WHERE id = '" + cageID + "'";
            System.out.println(sqlStatement);
            statement.executeUpdate(sqlStatement);

        } catch (SQLException ex) {
            System.out.println("Failed changing needCleaning state");
        }
    }

    public void putEmployeeInCage(int employeeId, int state) {
        try {
            String sqlStatement = "UPDATE employees SET cage_id = '" + state + "' WHERE employee_id = '" + employeeId + "'";
            System.out.println(sqlStatement);
            statement.executeUpdate(sqlStatement);

        } catch (SQLException ex) {
            System.out.println("Failed putting employee in cage");
        }
    }

    public void takeEmployeeOutOfCage(int employeeId) {
        try {
            String sqlStatement = "UPDATE employees SET cage_id = '' WHERE employee_id = '" + employeeId + "'";
            System.out.println(sqlStatement);
            statement.executeUpdate(sqlStatement);

        } catch (SQLException ex) {
            System.out.println("Failed taking employee out of cage");
        }
    }

    public void putAnimalInCage(int animalId, int state) {
        try {
            String sqlStatement = "UPDATE animals SET cage_id = '" + state + "' WHERE id = '" + animalId + "'";
            System.out.println(sqlStatement);
            statement.executeUpdate(sqlStatement);

        } catch (SQLException ex) {
            System.out.println("Failed putting animal in cage");
        }
    }

    public void takeAnimalOutOfCage(int animalId) {
        try {
            String sqlStatement = "UPDATE animals SET cage_id = '' WHERE id = '" + animalId + "'";
            System.out.println(sqlStatement);
            statement.executeUpdate(sqlStatement);

        } catch (SQLException ex) {
            System.out.println("Failed taking animal out of cage");
        }
    }

    public void addNewDoor(int entranceID) {
        try {
            String sql = "INSERT INTO doors (locked, open, entrance_id) VALUES('false', 'false', '" + entranceID + "')";
            statement.executeUpdate(sql);
        } catch (SQLException ex) {
            System.out.println("Failed to insert new doors");
        }
    }

    public void addNewEntrance(int cageID) {
        try {
            String sql = "INSERT INTO entrances (cage_id) VALUES ('" + cageID + "')";
            statement.executeUpdate(sql);
        } catch (SQLException ex) {
            System.out.println("Failed to insert new entrances");
        }
    }

    public void deleteEntrance(int entranceID) {
        try {
            String sql = "DELETE FROM entrances Where id = '" + entranceID + "'";
            statement.executeUpdate(sql);
        } catch (SQLException ex) {
            System.out.println("Entrance was not deleted");
        }
    }

    public void deleteDoor(int doorID) {
        try {
            String sql = "DELETE FROM doors Where id = '" + doorID + "'";
            statement.executeUpdate(sql);
        } catch (SQLException ex) {
            System.out.println("door was not deleted " + ex);
        }
    }

    public ResultSet getCage(int id) {
        try {
            String sqlStatement = "SELECT * FROM cages WHERE id = '" + id + "'";
            ResultSet rs = statement.executeQuery(sqlStatement);
            return rs;

        } catch (SQLException ex) {
            System.out.println("didnt get single cage");
            return null;
        }
    }
}
