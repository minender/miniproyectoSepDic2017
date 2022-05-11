package com.calclogic.dao;
import com.calclogic.entity.Simbolo;
import java.util.List;

/**
 * This interface is the API of the database queries that 
 * have to do with the table "Simbolo". 
 *
 * That table has all the operators and constants along with 
 * their respective LaTeX notations.
 *
 * @author jt
 */
public interface SimboloDAO {
    
    /** 
     * Adds a new symbol (Simbolo object) to the table.
     * @param Simbolo The new symbol to be added.
     * @return Nothing.
     */
    public void addSimbolo(Simbolo Simbolo);
    
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
    public void deleteSimbolo(int id);
    
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