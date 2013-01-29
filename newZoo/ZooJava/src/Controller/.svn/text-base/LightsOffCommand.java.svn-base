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
public class LightsOffCommand implements Command{
    private Cage cage;
    private CMSUIDbQuery query;
    
    public LightsOffCommand(Cage cage, String loadedZoo){
        try {
            this.query = new CMSUIDbQuery(loadedZoo);
            this.cage = cage;
        } catch (SQLException ex) {
            System.out.println(ex);
        }
    }

    @Override
    public void execute() {
        cage.setLights("false");
        query.updateLights(cage.getId(), cage.getLights());
    }
    
}
