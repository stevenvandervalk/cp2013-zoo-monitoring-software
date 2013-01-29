///*
// * To change this template, choose Tools | Templates
// * and open the template in the editor.
// */
//package Controller;
//
//import Model.Cage;
//import Model.Door;
//import Model.Entrance;
//import Utility.DBConnect;
//import java.sql.Connection;
//import java.sql.ResultSet;
//import java.sql.SQLException;
//import java.sql.Statement;
//import java.util.ArrayList;
//import java.util.HashMap;
//import java.util.LinkedHashMap;
//import java.util.logging.Level;
//import java.util.logging.Logger;
//import javax.swing.JOptionPane;
//
///**
// *
// * @author leenix
// */
//public class DataStoreSQLite extends IDataStore {
//
//    private static Connection con;
//    private Statement statement;
//
//    public DataStoreSQLite() throws SQLException {
//        DBConnect connection = new DBConnect();
//        con = connection.getDbConnection();
//        statement = con.createStatement();
//    }
//
//    @Override
//    LinkedHashMap<Integer, Cage> pullCages() {
//        LinkedHashMap<Integer, Cage> cageMap = new LinkedHashMap<Integer, Cage>();
//
//        try {
//            String sqlQuery = "SELECT * FROM cage";
//            ResultSet cageSet = statement.executeQuery(sqlQuery);
//
//            while (cageSet.next()) {
//                Cage cage = new Cage(cageSet.getInt("id"));
//                cage.setSize(cageSet.getDouble("size"));
//                cage.setType(cageSet.getString("category"));
//                cage.setName(cageSet.getString("name"));
//                cage.setLatitude(cageSet.getDouble("latitude"));
//                cage.setLongitude(cageSet.getDouble("longitude"));
//                cage.setHumanInCage(cageSet.getBoolean("human_present"));
//                cage.setAnimal(cageSet.getString("animal_name"));
//
//                LinkedHashMap entranceMap = pullEntrances(cage.getId());
//                cage.setEntrances(entranceMap);
//                cageMap.put(cage.getId(), cage);
//            }
//        } catch (Exception e) {
//        }
//
//        return cageMap;
//    }
//
//    public LinkedHashMap<Integer, Entrance> pullEntrances(int cageID) {
//        LinkedHashMap<Integer, Entrance> entranceMap = new LinkedHashMap<Integer, Entrance>();
//
//        try {
//            String sqlQuery = "SELECT * FROM entrance WHERE cage_id='" + cageID + "'";
//            ResultSet entranceSet = statement.executeQuery(sqlQuery);
//
//            while (entranceSet.next()) {
//                Entrance entrance = new Entrance(entranceSet.getInt("id"));
//
//                // Pull door information of the Entrance from the database and add to model.
//                LinkedHashMap doorMap = pullDoors(entrance.getId());
//                entrance.setDoors(doorMap);
//                entranceMap.put(entrance.getId(), entrance);
//            }
//
//        } catch (SQLException ex) {
//            Logger.getLogger(DataStoreSQLite.class
//                    .getName()).log(Level.SEVERE, null, ex);
//        }
//
//        return entranceMap;
//    }
//
//    public LinkedHashMap<Integer, Door> pullDoors(int entranceID) {
//        LinkedHashMap<Integer, Door> doorMap = new LinkedHashMap<Integer, Door>();
//
//        try {
//            String sqlQuery = "SELECT * FROM door WHERE entrance_id='" + entranceID + "'";
//            ResultSet doorSet = statement.executeQuery(sqlQuery);
//
//            // Extract door information from query and put into Door objects.
//            while (doorSet.next()) {
//                Door door = new Door(doorSet.getInt("id"));
//                door.close();
//                doorMap.put(door.getId(), door);
//            }
//
//        } catch (SQLException ex) {
//            Logger.getLogger(DataStoreSQLite.class
//                    .getName()).log(Level.SEVERE, null, ex);
//        }
//
//        return doorMap;
//    }
//
//    @Override
//    void pushDoor() {
//        throw new UnsupportedOperationException("Not supported yet.");
//    }
//}
