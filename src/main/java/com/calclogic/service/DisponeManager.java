/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.calclogic.service;

import com.calclogic.entity.Dispone;
import java.util.List;

/**
 * This interface is the use of the "DisponeDAO" 
 * API in this application.
 * 
 * @author miguel
 */
public interface DisponeManager {
    
    /** 
     * Adds a new object entry to the table only if an equivalent one has not been added yet,
     * and if so then returns again the object.
     * Otherwise, it returns the equivalent object that was previously added.
     * @param dispone The new Dispone object to add.
     */
    public Dispone addDispone(Dispone dispone);
    
    /**
     * Deletes one of the entries of the table.
     * @param id Is the principal key of the entry to delete.
     * @return Nothing.
     */
    public void deleteDispone(int id);

    /**
     * Method to get a Dispone object by its principal key.
     * @param id Is the principal key of the Dispone object.
     */
    public Dispone getDispone(int id);
    
    /**
     * Method to get a list of all the entries of the table.
     */
    public List<Dispone> getAllDispone();
    
    /**
     * Method to get a list of all the entries of the table that correspond to a specific user.
     * @param userLogin Is the string with which the user logs in, and that we use to filter the search.
     */
    public List<Dispone> getAllDisponeByUser(String userLogin);
    
//
//    public List<Dispone> getDisponeByUser(String userLogin);
//

    /**
     * Method to get a list of all the entries of the table that correspond to a specific metatheorem.
     * @param meateoremaID Is the principal key of the Metateorema table, with which we filter the search.
     */
    public List<Dispone> getDisponeByMetateorema(int metateoremaID);

    /**
     * Method to get the entry of the table that relates a user with a metatheorem, using the principal 
     * key of the metatheorem.
     *
     * @param userLogin Is the string with which the user logs in, and that we use to filter the search.
     * @param meateoremaID Is the principal key of the Metateorema table, with which we filter the search.
     */     
    public Dispone getDisponeByUserAndMetateorema(String userLogin,int metateoremaID);

    /**
     * Method to get the entry of the table that relates a user with a metatheorem, using the string
     * that represents to the metatheorem.
     *
     * @param userLogin Is the string with which the user logs in, and that we use to filter the search.
     * @param meateorema Is the string that represents the metatheorem, with which we filter the search.
     */
    public Dispone getDisponeByUserAndMetaeorema(String userLogin, String metateorema);
    
    /**
     * Method to get the entry of the table that relates a user with a metatheorem, using the number
     * of the metatheorem. If it exists, it first deserializes the term of the metatheorem.
     *
     * @param userLogin Is the string with which the user logs in, and that we use to filter the search.
     * @param metateoNum Is the number of the metatheorem, with which we filter the search.
     */
    public Dispone getDisponeByUserAndTeoNum(String userLogin,String metateoNum);
}
