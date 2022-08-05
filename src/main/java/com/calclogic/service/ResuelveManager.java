package com.calclogic.service;

import com.calclogic.entity.Resuelve;
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
     * and if so then returns again the object. Otherwise, it returns the equivalent object that was previously added.
     * @param resuelve The new Resuelve object to be added.
     * @return The added Resuelve object
     */
    public Resuelve addResuelve(Resuelve resuelve);

    /**
     * Updates one of the Resuelve objects of the table.
     * @param resuelve Is the Resuelve object to be updated.
     */  
    public void updateResuelve(Resuelve resuelve);

    /**
     * Deletes one of the Resuelve objects of the table.
     * @param id Is the principal key of the Resuelve object to delete.
     */    
    public void deleteResuelve(int id);

    /**
     * Method to get a Resuelve object by its principal key.
     * @param id Is the principal key of the Resuelve object.
     * @return The Resuelve object.
     */ 
    public Resuelve getResuelve(int id);
    
    /**
     * Method to get a list of all the entries of the table.
     * @return All the Resuelve objects of the database.
     */
    public List<Resuelve> getAllResuelve();

    /**
     * Method to get a list of all the entries of the table that correspond to a specific user.
     * @param userLogin Is the string with which the user logs in, and that we use to filter the search.
     * @return The mentioned list of Resuelve objects.
     */
    public List<Resuelve> getAllResuelveByUser(String userLogin);
    
    /**
     * Method to get a list of all the entries of the table that correspond to a specific user, and also
     * establishes for each one if it is an axiom or not.
     * @param userLogin Is the string with which the user logs in, and that we use to filter the search.
     * @param orAdmin Determines if in the query we must include the Resuelve objects of the admin of the app.
     * @return The mentioned list of Resuelve objects.
     */
    public List<Resuelve> getAllResuelveByUserWithSol(String userLogin, Boolean orAdmin);
    
    /**
     * Method to get a list of all the theorems of a specific user that are axioms
     * or that were demonstrated without the use of the theorem that is passed as
     * an argument.
     * @param userLogin Is the string with which the user logs in, and that we use to filter the search.
     * @param teoNum Is the number of the theorem, used to filter the search.
     * @param orAdmin Determines if in the query we must include the Resuelve objects of the admin of the app.
     * @return The list of the Resuelve objects in which the theorems fulfill the mentioned condition.
     */
    public List<Resuelve> getAllResuelveByUserWithSolWithoutAxiom(String userLogin, String teoNum, Boolean orAdmin);
    
    /**
     * Method to get a list of all the entries of the table that correspond to a specific user
     * having solved the demonstration of a theorem.
     * @param userLogin Is the string with which the user logs in, and that we use to filter the search.
     * @param orAdmin Determines if in the query we must include the Resuelve objects of the admin of the app.
     * @return The mentioned list of Resuelve objects.
     */
    public List<Resuelve> getAllResuelveByUserResuelto(String userLogin, Boolean orAdmin);

    /**
     * Method to get a list of all the entries of the table that correspond 
     * to a specific theorem (Teorema object).
     * @param teoremaID Is the principal key of the theorem used to filter the search.
     * @return The mentioned list of Resuelve objects.
     */
    public List<Resuelve> getResuelveByTeorema(int teoremaID);
    
    /**
     * Method to get an entry that relates a user with a theorem, 
     * using the statement of the theorem.
     * @param userLogin Is the string with which the user logs in, and that we use to filter the search.
     * @param teo Is the statement of the theorem used to filter the search.
     * @param orAdmin Determines if in the query we must include the Resuelve objects of the admin of the app.
     * @return The corresponding Resuelve object
     */
    public Resuelve getResuelveByUserAndTeorema(String userLogin, String teo, Boolean orAdmin);
    
    /**
     * Method to get an entry that relates a user with a theorem, 
     * using the identifier of the theorem.
     * @param userLogin Is the string with which the user logs in, and that we use to filter the search.
     * @param teoremaID Is the principal key of the theorem used to filter the search.
     * @param orAdmin Determines if in the query we must include the Resuelve objects of the admin of the app.
     * @return The corresponding Resuelve object.
     */
    public Resuelve getResuelveByUserAndTeorema(String userLogin, int teoremaID, Boolean orAdmin);

    /**
     * Method to get an entry that relates a user with a theorem, 
     * using the number of the theorem.If it exists, it parses the string associated with the object.
     * @param userLogin Is the string with which the user logs in, and that we use to filter the search.
     * @param teoNum Is the number of the theorem used to filter the search.
     * @param orAdmin Determines if in the query we must include the Resuelve objects of the admin of the app.
     * @return The corresponding Resuelve object.
     */
    public Resuelve getResuelveByUserAndTeoNum(String userLogin, String teoNum, Boolean orAdmin);
    
    public List<Resuelve> getResuelveDependent(String userLogin, List<Resuelve> resuelves);
    
    public List<Resuelve> getResuelveDependentGlobal(List<Resuelve> resuelves);
}
