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
public class HungryOffCommand implements Command{
    private Cage cage;
    private CMSUIDbQuery query;
    
    public HungryOffCommand(Cage cage, String loadedZoo){
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
        cage.setHungry("false");
        query.updateHungry(cage.getId(), cage.getHungry());
    }
    
}
