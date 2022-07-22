package com.calclogic.service;

import com.calclogic.entity.Solucion;
import com.calclogic.lambdacalculo.PasoInferencia;
import com.calclogic.lambdacalculo.Term;
import java.util.List;
import java.util.HashMap;

/**
 * This interface is the use of the "SolucionDAO" 
 * API in this application.
 *
 * @author miguel
 */
public interface SolucionManager {
    
    /** 
     * Adds a new Solucion object to the table, but it is only if all previous ones
	 * for the same theorem where already completed. It is not possible to work in new solutions
     * if there is an incomplete one.
     * @param sol The new Solucion object to be added.
     * @return Nothing.
     */	
    public void addSolucion(Solucion solucion);

    //public void addPaso(int solucionId, PasoInferencia paso);
    
    /**
     * Updates one of the Solucion objects of the table, and makes that the new part
	 * has the structure established in this application.
     * @param solucionId Is the principal key of the Solucion object to be updated
	 * @param typedTerm Is the Term object that will be added to the demonstration.
     * @return Nothing.
     */   
    public void updateSolucion(int solucionId, Term typedTerm);
    
    /**
     * Updates one of the Solucion objects of the table.
     * @param sol Is the Solucion object to be updated.
     * @return Nothing.
     */   
    public void updateSolucion(Solucion solucion);
    
    /**
     * Deletes one of the Solucion objects of the table.
     * @param id Is the principal key of the Solucion object to delete.
     * @return Nothing.
     */ 
    public boolean deleteSolucion(int id, String username);

    /**
     * Method to get a Solucion object by its principal key.
     * @param id Is the principal key of the Solucion object.
     */ 
    public Solucion getSolucion(int id, String user);
    
    /**
     * Method to get a list of all the entries of the table that correspond 
     * to a specific Resuelve object.
     * @param resuelveId Is the identifier of the Resuelve object used to filter the search.
     */
    public List<Solucion> getAllSolucionesByResuelve(int resuelveId);
    
    /**
     * Method to get a list of the identifiers of all the entries of the table 
     * that correspond to a specific Resuelve object, including the incomplete solutions.
     * @param resuelveId Is the identifier of the Resuelve object used to filter the search.
	 * @return listaSoluciones A HashMap that relates the solutions names with their id's.
     */
    public HashMap<String,Integer> getAllSolucionesIdByResuelve(int resuelveId);
    
}