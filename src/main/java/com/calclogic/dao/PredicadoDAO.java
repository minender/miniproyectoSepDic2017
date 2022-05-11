package com.calclogic.dao;

import com.calclogic.entity.Predicado;
import com.calclogic.entity.PredicadoId;
import java.util.List;

/**
 * This interface is the API of the database queries that 
 * have to do with the table "Predicado". 
 *
 * That table has the abbreviations that each user has added.
 *
 * @author miguel
 */
public interface PredicadoDAO {
    
    /** 
     * Adds a new Predicado object to the table.
     * @param predicado The new Predicado object to be added.
     * @return Nothing.
     */
    public void addPredicado(Predicado predicado);
    
    /**
     * Deletes one of the Predicado objects of the table.
     * @param id Is the principal key of the Predicado object to delete.
     * @return Nothing.
     */ 
    public void deletePredicado(PredicadoId id);
    
    /**
     * Updates one of the Predicado objects of the table.
     * @param pre Is the Predicado object to be updated.
     * @return Nothing.
     */ 
    public void updatePredicado(Predicado pre);
    
    /**
     * Method to get a Predicado object by its principal key.
     * @param id Is the principal key of the Predicado object.
     */
    public Predicado getPredicado(PredicadoId id);
    
    /**
     * Method to get a Predicado object that corresponds to
     * a specific user and that have a specific string.
     * @param username Is the string with which the user logs in, and that we use to filter the search.
     * @param comb Represents the predicate with which we filter the search.
     */
    public Predicado getPredicado(String username, String comb);
    
    /**
     * Method to get a list of all the entries of the table that correspond to a specific user.
     * @param userLogin Is the string with which the user logs in, and that we use to filter the search.
     */
    public List<Predicado> getAllPredicadosByUser(String userLogin);
    
}
