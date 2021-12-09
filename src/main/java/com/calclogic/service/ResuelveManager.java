package com.calclogic.service;

import com.calclogic.entity.Resuelve;
import com.calclogic.entity.Solucion;
import java.util.List;

/**
 * This interface is the use of the "ResuelveDAO" 
 * API in this application.
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
    
    /**
     * Method to get a list of all the entries of the table that correspond to a specific user, and also
	 * establishes for each one if it is an axiom or not.
     * @param userLogin Is the string with which the user logs in, and that we use to filter the search.
     */
    public List<Resuelve> getAllResuelveByUserWithSol(String userLogin);
    
    public List<Resuelve> getAllResuelveByUserOrAdminWithSol(String userLogin);
    
    /**
     * Method to get a list of all the theorems of a specific user that are axioms
     * or that were demonstrated without the use of the theorem that is passed as
     * an argument.
     * @param userLogin Is the string with which the user logs in, and that we use to filter the search.
     * @param teoNum Is the number of the theorem, used to filter the search.
     */
    public List<Resuelve> getAllResuelveByUserWithSolWithoutAxiom(String userLogin,String teoNum);
    
    public List<Resuelve> getAllResuelveByUserOrAdminWithSolWithoutAxiom(String userLogin,String teoNum);
    
    /**
     * Method to get a list of all the entries of the table that correspond to a specific user
     * having solved the demonstration of a theorem.
     * @param userLogin Is the string with which the user logs in, and that we use to filter the search.
     */
    public List<Resuelve> getAllResuelveByUserResuelto(String userLogin);
    
    public List<Resuelve> getAllResuelveByUserOrAdminResuelto(String userLogin);

    /**
     * Method to get a list of all the entries of the table that correspond 
     * to a specific theorem (Teorema object).
     * @param teoremaID Is the principal key of the theorem used to filter the search.
     */
    public List<Resuelve> getResuelveByTeorema(int teoremaID);
    
    /**
     * Method to get an entry that relates a user with a theorem, 
     * using the statement of the theorem.
     * @param userLogin Is the string with which the user logs in, and that we use to filter the search.
     * @param teo Is the statement of the theorem used to filter the search.
     */
    public Resuelve getResuelveByUserAndTeorema(String userLogin,String teo);
    
    /**
     * Method to get an entry that relates a user with a theorem, 
     * using the identifier of the theorem.
     * @param userLogin Is the string with which the user logs in, and that we use to filter the search.
     * @param teoremaID Is the principal key of the theorem used to filter the search.
     */
    public Resuelve getResuelveByUserAndTeorema(String userLogin,int teoremaID);
    
    /**
     * Method to get an entry that relates a user with a theorem, 
     * using the number of the theorem.
	 * If it exists, it parses the string associated with the object.
     * @param userLogin Is the string with which the user logs in, and that we use to filter the search.
     * @param teoNum Is the number of the theorem used to filter the search.
     */
    public Resuelve getResuelveByUserAndTeoNum(String userLogin,String teoNum);
    
}
