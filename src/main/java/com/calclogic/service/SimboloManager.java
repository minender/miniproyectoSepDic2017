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
    
    public int getVarBinaryOpId();
    
    public String propFunAppSym();
    
    public String termFunAppSym();
    
    public Simbolo getVarBinaryOp();
    
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
    
    public List<Simbolo> getAllSimboloByTeoria(int teoriaid);
    
    /**
     * Method to get a list of all transitive symbols. 
     */
    public List<Simbolo> getAllTransitiveOps();
    
    /**
     * Method to check if exists a proof of the transitivity of c_{id}
     * @param id Is the primary key of the Simbolo object.
     * @return character 'e' if exists transitivity proof of c_{id},
     *         character 'i' if exists definition p op q = q this p and transitivity proof of 'this'
     *         character 's' if exists definition p this q = q op p and transitivity proof of 'this'
     *         character 'n' otherwise
     */
    public String isTransitiveOp(int op);
    
    /**
     * Method to check if exists a proof of the transitivity of c_{id}
     * @param id Is the primary key of the Simbolo object.
     * @return character 'yc_{id'}' if exists theorem p c_{id'} q = q c_{id} p,
     *         character 'sc_{id'}' if exists theorem p c_{id} q = q c_{id'} p,
     *         character 'n' otherwise
     */
    public String isSymetric(int id);
    
    public boolean isSymmetAssociaBinaOpWithIdentity(int id);
    
    public boolean isIdentityOfOp(int identId, int opId);
}
