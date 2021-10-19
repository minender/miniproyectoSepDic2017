package com.calclogic.service;

import com.calclogic.entity.Predicado;
import com.calclogic.entity.PredicadoId;
import java.util.List;

/**
 * This interface is the use of the "PredicadoDAO" 
 * API in this application.
 * 
 * @author miguel
 */
public interface PredicadoManager {

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
     * Method to change the alias of one of the Predicado objects of the table.
     * @param anterior Is the previous principal key of the Predicado object.
     * @param nuevo Is the new principal key of the Predicado object.
     * @return Nothing.
     */   
    public void modificarAlias(PredicadoId anterior, PredicadoId nuevo);
    
    /**
     * Method to get a Predicado object by its principal key.
     * If it exists, it parses the string associated with the object.
     * @param id Is the principal key of the Predicado object.
     */
    public Predicado getPredicado(PredicadoId id);
    
    /**
     * Method to get a Predicado object that corresponds to a specific user and that have a specific string.
     * If it exists, it parses the string associated with the object.
     * If it does not exist, this tries to find the predicate among the admin's theorems.
     * @param username Is the string with which the user logs in, and that we use to filter the search.
     * @param comb Represents the predicate with which we filter the search.
     */
    public Predicado getPredicado(String username, String comb);

    /**
     * Method to get a list of all the entries of the table that correspond to a specific user.
     * It also parses all of them.
     * @param userLogin Is the string with which the user logs in, and that we use to filter the search.
     */   
    public List<Predicado> getAllPredicadosByUser(String userLogin);
}




