package com.calclogic.service;

import com.calclogic.entity.Resuelve;
import com.calclogic.entity.Teorema;
import com.calclogic.lambdacalculo.Term;
import java.util.List;

/**
 * This interface is the use of the "TeoremaDAO" 
 * API in this application.
 *
 * @author miguel
 */
public interface TeoremaManager {
    
    /** 
     * Adds a new theorem to the table.
     * @param teorema The new theorem to be added.
     * @return Nothing.
     */
    public Teorema addTeorema(Teorema teorema);

    /** 
     * Updates theorem on the table.
     * @param teorema The new theorem to be added.
     * @return Nothing.
     */    
    public Teorema updateTeorema(int id, String username, String statement, Term teoterm, String vars);
    
    /**
     * Deletes one of the theorems of the table.
     * @param id Is the principal key of the theorem to delete.
     * @return Nothing.
     */ 
    public boolean deleteTeorema(int id, String username);
    
	/**
     * Method to get a theorem by its principal key.
	 * If it exists, it parses the string associated with the object.
     * @param id Is the principal key of the theorem.
     */
    public Teorema getTeorema(int id, SimboloManager s);
    
    /**
     * Method to get a list of all the entries of the table (all the theorems),
	 * and parsing them in order to be used.
     */
    public List<Teorema> getAllTeoremas();
    
    /**
     * Method to get a theorem that corresponds to a statement, and then parsing it.
     * @param enunciado Is the statement used to filter the search.
     */
    public Teorema getTeoremaByEnunciados(String enunciado);
    
    /**
     * Method to get a list of theorems that correspond 
	 * to a list of Resuelve objects, and then parsing them.
     * @param resList Is the list of Resuelve objects used to filter the search.
     */
    public List<Teorema> getTeoremaByResuelveList(List<Resuelve> resList);
   
    /**
     * Method to get a list of theorems that corresponds to a specific category.
     * @param categoriaId Is the principal key of the category (Categoria object).
     */
    public List<Teorema> getTeoremasByCategoria(int categoriaId);
}
