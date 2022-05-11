package com.calclogic.dao;

import com.calclogic.entity.Metateorema;
import java.util.List;

/**
 * This interface is the API of the database queries that 
 * have to do with the table "Metateorema". 
 *
 * >>> Unused for the moment.
 *
 * @author miguel
 */
public interface MetateoremaDAO {
    
    /** 
     * Adds a new metatheorem to the table.
     * @param metateorema The new matatheorem to be added.
     * @return Nothing.
     */
    public void addMetateorema(Metateorema metateorema);
    
    /**
     * Deletes one of the metatheorems of the table.
     * @param id Is the principal key of the metatheorem to delete.
     * @return Nothing.
     */ 
    public void deleteMetateorema(int id);
    
    /**
     * Method to get a metatheorem by its principal key.
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
