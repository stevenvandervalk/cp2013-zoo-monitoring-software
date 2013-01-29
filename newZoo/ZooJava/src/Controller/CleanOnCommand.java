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
public class CleanOnCommand implements Command{
    private Cage cage;
    private CMSUIDbQuery query;
    
    public CleanOnCommand(Cage cage, String loadedZoo){
        try {
            this.query = new CMSUIDbQuery(loadedZoo);
            this.cage = cage;
        } catch (SQLException ex) {
            System.out.println(ex);
        }
    }

    @Override
    public void execute() {
        System.out.println("offcommandexecuted");
        cage.setNeedCleaning("true");
        query.updateNeedClean(cage.getId(), cage.getNeedCleaning());
    }
    
}
