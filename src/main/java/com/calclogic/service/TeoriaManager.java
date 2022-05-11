package com.calclogic.service;

import com.calclogic.entity.Teoria;
import com.calclogic.entity.Solucion;
import java.util.List;

/**
 * This interface is the use of the "TeoriaDAO" 
 * API in this application.
 *
 * @author jt
 */
public interface TeoriaManager {
    
    /** 
     * Adds a new theory to the table.
     * @param Teoria The new theory to be added.
     * @return Teoria This function returns again the just added theory.
     */
    public Teoria addTeoria(Teoria Teoria);
    
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
