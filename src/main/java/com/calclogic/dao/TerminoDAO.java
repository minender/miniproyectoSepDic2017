package com.calclogic.dao;

import com.calclogic.entity.Termino;
import com.calclogic.entity.TerminoId;
import com.calclogic.entity.Usuario;
import java.util.List;


/**
 * This interface is the API of the database queries that 
 * have to do with the table "Termino". 
 *
 * That table has all the terms that have been added to the
 * application.
 *
 * @author federico
 */
public interface TerminoDAO {
    
    /** 
     * Adds a new term to the table.
     * @param termino The new term to be added.
     * @return Nothing.
     */
    public void addTermino(Termino termino);

    /**
     * Deletes one of the terms of the table.
     * @param id Is the principal key of the term to delete.
     * @return Nothing.
     */ 
    public void deleteTermino(TerminoId id);

    /**
     * Method to get a term by its principal key.
     * @param id Is the principal key of the term.
     */
    public Termino getTermino(TerminoId id);

    /**
     * Method to get a list of all the entries of the table (all the terms).
     */
    public List<Termino> getAllTerminos();

    /**
     * Method to get a list of all the entries of the table that correspond to a specific user.
     * @param username Is the string with which the user logs in, and that we use to filter the search.
     */
    public List<Termino> getAllTerminos(String username);

    /**
     * Method to get a list of all the entries of the table that correspond to a specific user,
     * and that have a specific "combinador" attribute.
     * @param username Is the string with which the user logs in, and that we use to filter the search.
     * @param comb Is the "combinador" attribute used to filter the search.
     */
    public Termino getCombinador(String username, String comb);

    /**
     * Method to get a list of all the entries of the table that correspond to a specific user,
     * and in which that user has made public the term.
     * @param username Is the string with which the user logs in, and that we use to filter the search.
     */
    public List<Termino> getAllPublicaciones(String username);
}
