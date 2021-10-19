package com.calclogic.dao;

import com.calclogic.entity.Resuelve;
import java.util.List;

/**
 * This interface is the API of the database queries that 
 * have to do with the table "Resuelve". 
 *
 * That table implements the relation between the users and the
 * theorems, indicating if the user has solved their respective
 * demonstrations or not.
 *
 * @author miguel
 */
public interface ResuelveDAO {
    
    /** 
     * Adds a new Resuelve object to the table.
     * @param resuelve The new Resuelve object to be added.
     * @return Nothing.
     */
    public void addResuelve(Resuelve resuelve);
    
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
     * Method to get a list of all the theorems of a specific user that are axioms
     * or that were demonstrated without the use of the theorem that is passed as
     * an argument.
     * @param userLogin Is the string with which the user logs in, and that we use to filter the search.
     * @param teoNum Is the number of the theorem, used to filter the search.
     */
    public List<Resuelve> getAllResuelveByUserWithoutAxiom(String userLogin, String teoNum);
    
    /**
     * Method to get a list of all the entries of the table that correspond to a specific user
     * having solved the demonstration of a theorem.
     * @param userLogin Is the string with which the user logs in, and that we use to filter the search.
     */
    public List<Resuelve> getAllResuelveByUserResuelto(String userLogin);

    /**
     * Method to get a list of all the entries of the table that correspond 
     * to a specific theorem (Teorema object).
     * @param teoremaID Is the principal key of the theorem used to filter the search.
     */
    public List<Resuelve> getResuelveByTeorema(int teoremaID);

    /**
     * Method to get an entry that relates a user with a theorem, 
     * using the identifier of the theorem.
     * @param userLogin Is the string with which the user logs in, and that we use to filter the search.
     * @param teoremaID Is the principal key of the theorem used to filter the search.
     */
    public Resuelve getResuelveByUserAndTeorema(String userLogin,int teoremaID);
    
    /**
     * Method to get an entry that relates a user with a theorem, 
     * using the statement of the theorem.
     * @param userLogin Is the string with which the user logs in, and that we use to filter the search.
     * @param teo Is the statement of the theorem used to filter the search.
     */
    public Resuelve getResuelveByUserAndTeorema(String userLogin,String teo);

    /**
     * Method to get an entry that relates a user with a theorem, 
     * using the number of the theorem.
     * @param userLogin Is the string with which the user logs in, and that we use to filter the search.
     * @param teoNum Is the number of the theorem used to filter the search.
     */
    public Resuelve getResuelveByUserAndTeoNum(String userLogin,String teoNum);
    
    /**
     * Method to get a list of all the entries of the table that correspond to a
     * specific category (Categoria object),
     * @param categoriaId Is the principal key of the category used to filter the search.
     */
    public List<Resuelve> getResuelveByCategoria(int categoriaId);
}
