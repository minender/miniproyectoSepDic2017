package com.calclogic.service;

import com.calclogic.entity.Simbolo;
import com.calclogic.entity.Solucion;
import java.util.List;

/**
 * This interface is the use of the "SimboloDAO" 
 * API in this application.
 *
 * @author jt
 */
public interface SimboloManager {
    
    public int getPropFunApp();
    
    public int getTermFunApp();
    
    public String propFunAppSym();
    
    public String termFunAppSym();
    
    /** 
     * Adds a new symbol (Simbolo object) to the table.
     * @param Simbolo The new symbol to be added.
     * @return Nothing.
     */
    public Simbolo addSimbolo(Simbolo Simbolo);
    
    /**
     * This method let us update the entry that corresponds to an already 
     * stored symbol. For example, to update the code that creates it.
     * @param Simbolo Is the Simbolo object to be updated.
     * @return Nothing.
     */ 
    public void updateSimbolo(Simbolo Simbolo);
    
    /**
     * Deletes one of the symbols of the table.
     * @param id Is the principal key of the symbol to delete.
     * @return Nothing.
     */ 
    public String deleteSimbolo(int id, String username);
    
    /**
     * Method to get a Simbolo object by its principal key.
     * @param id Is the principal key of the Simbolo object.
     */ 
    public Simbolo getSimbolo(int id);
    
    /**
     * Method to get a list of all the entries of the table.
     */
    public List<Simbolo> getAllSimbolo();

}
