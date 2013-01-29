/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package Model;

/**
 *
 * @author jc231781
 */
public class Employee {
    
    private String name;
    private int id;
    private Cage cage;

    public Employee(String name, int id, Cage cage) {
        this.name = name;
        this.id = id;
        this.cage = cage;
    }

    public Cage getCage() {
        return cage;
    }

    public void setCage(Cage cage) {
        this.cage = cage;
    }


    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }
    
    
}
