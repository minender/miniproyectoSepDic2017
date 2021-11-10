package com.calclogic.service;

import com.calclogic.entity.Publicacion;
import com.calclogic.entity.Termino;
import com.calclogic.entity.TerminoId;
import com.calclogic.entity.Usuario;
import java.util.List;

/**
 * This interface is the use of the "TerminoDAO" 
 * API in this application.
 *
 * @author federico
 */
public interface TerminoManager {
    
    /** 
     * Adds a new term to the table.
     * @param termino The new term to be added.
     * @return Nothing.
     */
    public void addTermino(Termino termino);
	
    /** 
	 * >>> Deprecated, since the Publicacion table must be removed.
     */
    public void addPublicacion(Termino termino,Publicacion publicacion);
	
    /**
     * Deletes one of the terms of the table.
     * @param id Is the principal key of the term to delete.
     * @return Nothing.
     */ 
    public void deleteTermino(TerminoId id);
	
    /** 
	 * >>> Deprecated, since the Publicacion table must be removed.
     */
    public void deletePublicacion(TerminoId id);
	
    /**
     * Updates one of the terms of the table.
	 * It deletes the previous entry and adds a new one.
     * @param termino Is the new term to be added.
     * @return Nothing.
     */ 
    public void modificarTermino(Termino termino);
	
    /**
     * Modifies the alias of a term.
	 * It deletes the previous entry and adds a new one.
     * @param anterior Is principal key of the term that will be deleted.
	 * @param nuevo Is the principal key of the term that will be added.
     * @return Nothing.
     */ 
    public void modificarAlias(TerminoId anterior, TerminoId nuevo);
	
    /**
     * Method that parses returns a term given its principal key
	 * If it does not find it in the table, it tries setting the current login first
	 * as "publico" and then as "admin, just in case it is private.
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
	 * >>> Deprecated, since the Publicacion table must be removed.
     */
    public List<Termino> getAllPublicaciones(String username);
	
    /**
     * Method to get a list of all the entries of the table that correspond to a specific user,
     * and that have a specific "combinador" attribute.
	 * If it does not find it in the table, it tries setting the current login first
	 * as "publico" and then as "admin, just in case it is private.
     * @param username Is the string with which the user logs in, and that we use to filter the search.
     * @param comb Is the "combinador" attribute used to filter the search.
     */
    public Termino getCombinador(String username, String comb);
}
