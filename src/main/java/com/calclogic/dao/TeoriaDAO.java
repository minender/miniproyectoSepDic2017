package com.calclogic.dao;

import com.calclogic.entity.Teoria;
import java.util.List;

/**
 * This interface is the API of the database queries that 
 * have to do with the table "Teoria". 
 *
 * That entries of that table group Simbolo, Teorema and Metateorema
 * objects.
 *
 * @author jt
 */
public interface TeoriaDAO {
    
    /** 
     * Adds a new theory to the table.
     * @param teoria The new theory to be added.
     * @return Nothing.
     */
    public void addTeoria(Teoria teoria);
    
    /**
     * Updates one of the theories of the table.
     * @param Teoria Is the theory to be updated.
     * @return Nothing.
     */ 
    public void updateTeoria(Teoria Teoria);
    
    /**
     * Deletes one of the theories of the table.
     * @param id Is the principal key of the theory to delete.
     * @return Nothing.
     */ 
    public void deleteTeoria(int id);
    
    /**
     * Method to get a theory by its principal key.
     * @param id Is the principal key of the theory.
     */
    public Teoria getTeoria(int id);
    
    /**
     * Method to get a list of all the entries of the table (all the theories).
     */
    public List<Teoria> getAllTeoria();
}