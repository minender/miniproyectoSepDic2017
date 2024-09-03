/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.calclogic.dao;

import com.calclogic.entity.PureCombsTheorem;
import java.util.List;

/**
 *
 * @author feder
 */
public interface PureCombsTheoremDAO {
    
    /** 
     * Adds a new theorem to the table.
     * @param teorema The new theorem to be added.
     * @return Nothing.
     */
    public void addPureCombsTheorem(PureCombsTheorem teorema);
    
    /**
     * Updates one of the Teorema objects of the table.
     * This query is made using standard Hibernate library functions.
     * @param teorema Is the Teorema object to be updated.
     * @return Nothing.
     */   
    public void updatePureCombsTheorem(PureCombsTheorem teorema);
    
    /**
     * Deletes one of the theorems of the table.
     * @param id Is the principal key of the theorem to delete.
     * @return Nothing.
     */ 
    public void deletePureCombsTheorem(int id);
    
    /**
     * Method to get a theorem by its principal key.
     * @param id Is the principal key of the theorem.
     */
    public PureCombsTheorem getPureCombsTheorem(int id);
    
    /**
     * Method to get a list of all the entries of the table (all the theorems).
     */
    public List<PureCombsTheorem> getAllPureCombsTheorem();
    
    /**
     * Method to get a theorem that corresponds to a statement.
     * @param enunciado Is the statement used to filter the search.
     */
    public PureCombsTheorem getTeoremaByEnunciado(String enunciado);
    
}

