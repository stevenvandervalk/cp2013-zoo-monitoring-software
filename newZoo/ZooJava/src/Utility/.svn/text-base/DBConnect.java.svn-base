/*
 * DBConnect
 * 
 * Iteration #01
 * 
 * CP2013 - Zoo Monitor
 * Licensed under the New BSD License.
 * 
 * Authors: Chris Ford, Tate Fuller, Karl Mohring.
 */

package Utility;

/**
 * Contains the class needed to connect to a SQLite database.
 * @author jc231781
 */
import java.awt.HeadlessException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import javax.swing.JOptionPane;

/**
 * Provides connectivity to the Zoo SQLite database. 
 * @author CP2013 Group
 */
public class DBConnect {
    Connection dbConnection;

    /**
     * Get the current database connection to the Zoo database.
     * @return Connection to database.
     */
    public Connection getDbConnection() {
        return dbConnection;
    }

    /**
     * Establish a connection to the Zoo database file.
     */
    public DBConnect(String directory) {
        try {
            Class.forName("org.sqlite.JDBC");
            dbConnection = DriverManager.getConnection("jdbc:sqlite:savedZoos/" + directory + "/development.sqlite3");


        } catch (ClassNotFoundException | SQLException | HeadlessException e) {
            JOptionPane.showMessageDialog(null, "Error connecting to Database: \n" + e, "alert", JOptionPane.ERROR_MESSAGE);


        }
    }
}