package com.calclogic.service;

import com.calclogic.entity.Resuelve;
import com.calclogic.entity.Solucion;
import java.util.List;

/**
 * This interface is the use of the "ResuelveDAO" 
 * api in this application.
 * 
 * @author miguel
 */
public interface ResuelveManager {
    
    /** 
     * Adds a new object entry to the table only if an equivalent one has not been added yet,
     * and if so then returns again the object.
     * Otherwise, it returns the equivalent object that was previously added.
     * @param resuelve The new Resuelve object to be added.
     */
    public Resuelve addResuelve(Resuelve resuelve);

    /**
     * Updates one of the Resuelve objects of the table.
     * @param resuelve Is the Resuelve object to be updated.
     * @return Nothing.
     */  
    public void updateResuelve(Resuelve resuelve);

    /**
     * Deletes one of the Resuelve objects of the table.
     * @param id Is the principal key of the Resuelve object to delete.
     * @return Nothing.
     */  
    public void deleteResuelve(int id);

    /**
     * Method to get a Resuelve object by its principal key.
     * @param id Is the principal key of the Resuelve object.
     */ 
    public Resuelve getResuelve(int id);
    
    /**
     * Method to get a list of all the entries of the table.
     */
    public List<Resuelve> getAllResuelve();
    
    /**
     * Method to get a list of all the entries of the table that correspond to a specific user.
     * @param userLogin Is the string with which the user logs in, and that we use to filter the search.
     */
    public List<Resuelve> getAllResuelveByUser(String userLogin);
    
    public List<Resuelve> getAllResuelveByUserWithSol(String userLogin);
    
    public List<Resuelve> getAllResuelveByUserWithSolWithoutAxiom(String userLogin,String teoNum);
    
    public List<Resuelve> getAllResuelveByUserResuelto(String userLogin);

    public List<Resuelve> getResuelveByTeorema(int teoremaID);
    
    public Resuelve getResuelveByUserAndTeorema(String userLogin,String teo);
    
    public Resuelve getResuelveByUserAndTeorema(String userLogin,int teoremaID);
    
    public Resuelve getResuelveByUserAndTeoNum(String userLogin,String teoNum);
    
}
