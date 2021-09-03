package com.calclogic.service;

import com.calclogic.entity.Metateorema;
import java.util.List;

/**
 * This interface is the use of the "MetateoremaDAO" 
 * api in this application.
 *
 * >>> Unused for the moment.
 *
 * @author miguel
 */
public interface MetateoremaManager {
    
    /** 
     * Adds a new object entry to the table only if an equivalent one has not been added yet,
     * and if so then returns again the object.
     * Otherwise, it returns the equivalent object that was previously added.
     * @param metateorema The new matatheorem to be added.
     */
    public Metateorema addMetateorema(Metateorema metateorema);

    /**
     * Deletes one of the metatheorems of the table.
     * @param id Is the principal key of the metatheorem to delete.
     * @return Nothing.
     */ 
    public void deleteMetateorema(int id);
    
    /**
     * Method to get a metatheorem by its principal key.
     * If it exists, it first deserializes the term of the metatheorem.
     * @param id Is the principal key of the metatheorem.
     */   
    public Metateorema getMetateorema(int id);
   
    /**
     * Method to get a list of all the entries of the table (all the metatheorems).
     */
    public List<Metateorema> getAllMetateoremas();
    
    /**
     * Method to get a metatheorem that corresponds to a statement.
     * @param enunciado Is the statement used to filter the search.
     */
    public Metateorema getMetateoremaByEnunciados(String enunciado); 
}
