/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.calclogic.service;

import com.calclogic.entity.PureCombsTheorem;
import com.calclogic.lambdacalculo.Term;
import java.util.List;

/**
 *
 * @author feder
 */
public interface PureCombsTheoremManager {

    /** 
     * Adds a new theorem to the table.
     * @param teorema The new theorem to be added.
     * @return Nothing.
     */
    public PureCombsTheorem addPureCombsTheorem(PureCombsTheorem teorema);

    /** 
     * Updates theorem on the table.
     * @param teorema The new theorem to be added.
     * @return Nothing.
     */    
    public PureCombsTheorem updatePureCombsTheorem(PureCombsTheorem teorema);
    
    /**
     * Deletes one of the theorems of the table.
     * @param id Is the principal key of the theorem to delete.
     * @return Nothing.
     */ 
    public void deletePureCombsTheorem(int id);
    
	/**
     * Method to get a theorem by its principal key.
	 * If it exists, it parses the string associated with the object.
     * @param id Is the principal key of the theorem.
     */
    public PureCombsTheorem getPureCombsTheorem(int id);
    
    /**
     * Method to get a list of all the entries of the table (all the theorems),
	 * and parsing them in order to be used.
     */
    public List<PureCombsTheorem> getAllPureCombsTheorem();
    
    /**
     * Method to get a theorem that corresponds to a statement, and then parsing it.
     * @param enunciado Is the statement used to filter the search.
     */
    public PureCombsTheorem getTeoremaByEnunciado(String enunciado);
}
