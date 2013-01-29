/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package Controller;

import Model.Cage;
import java.sql.SQLException;

/**
 *
 * @author Chris
 */
public class CleanOffCommand implements Command{
    private Cage cage;
    private CMSUIDbQuery query;
    
    public CleanOffCommand(Cage cage, String loadedZoo){
        try {
            this.query = new CMSUIDbQuery(loadedZoo);
            this.cage = cage;
        } catch (SQLException ex) {
            System.out.println(ex);
        }
    }

    @Override
    public void execute() {
        cage.setNeedCleaning("false");
        query.updateNeedClean(cage.getId(), cage.getNeedCleaning());
    }
    
}
