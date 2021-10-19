package com.calclogic.dao;

import com.calclogic.entity.Solucion;
import java.util.List;

/**
 * This interface is the API of the database queries that 
 * have to do with the table "Solucion". 
 *
 * The entries of that table has the solutions (or attempted solutions)
 * to the demonstrations of theorems.
 *
 * @author miguel
 */
public interface SolucionDAO {
    
    /** 
     * Adds a new Solucion object to the table.
     * @param solucion The new Solucion object to be added.
     * @return Nothing.
     */
    public void addSolucion(Solucion solucion);
    
    /**
     * Updates one of the Solucion objects of the table.
     * @param solucion Is the Solucion object to be updated.
     * @return Nothing.
     */ 
    public void updateSolucion(Solucion solucion);
    
    /**
     * Deletes one of the Solucion objects of the table.
     * @param id Is the principal key of the Solucion object to delete.
     * @return Nothing.
     */ 
    public void deleteSolucion(int id);
    
    /**
     * Method to get a Solucion object by its principal key.
     * @param id Is the principal key of the Solucion object.
     */ 
    public Solucion getSolucion(int id);
    
    /**
     * Method to get a list of all the entries of the table that correspond 
     * to solutions of demonstrations using axioms.
     * @param resuelveId Is the identifier of the Resuelve object used to filter the search.
     */
    public List<Solucion> solutionsWithAxiom(int idTeo);
    
    /**
     * Method to get a list of all the entries of the table that correspond 
     * to a specific Resuelve object.
     * @param resuelveId Is the identifier of the Resuelve object used to filter the search.
     */
    public List<Solucion> getAllSolucionesByResuelve(int resuelveId);
    
    /**
     * Method to get a list of the identifiers of all the entries of the table 
     * that correspond to a specific Resuelve object.
     * @param resuelveId Is the identifier of the Resuelve object used to filter the search.
     */
    public List<Integer> getAllSolucionesIdByResuelve(int resuelveId);
  
    /**
     * Method to get a list of the identifiers of all the entries of the table 
     * that correspond to a specific Resuelve object, and that refer to an incomplete solution.
     * @param resuelveId Is the identifier of the Resuelve object used to filter the search.
     */  
    public List<Integer> getIncompleteSolucionIdByResuelve(int resuelveId);
}
