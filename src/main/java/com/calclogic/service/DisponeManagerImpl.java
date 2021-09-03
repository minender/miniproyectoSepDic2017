package com.calclogic.service;

import com.calclogic.dao.DisponeDAO;
import com.calclogic.entity.Dispone;
import com.calclogic.entity.Metateorema;
import com.calclogic.lambdacalculo.Term;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.SerializationUtils;

/**
 * This class has the implementation of "DisponeManager" queries.
 *
 * @author miguel
 */
@Service
public class DisponeManagerImpl implements DisponeManager {
       
    @Autowired
    private DisponeDAO disponeDAO;
    
    /** 
     * Adds a new object entry to the table only if an equivalent one has not been added yet,
     * and if so then returns again the object.
     * Otherwise, it returns the equivalent object that was previously added.
     * @param dispone The new Dispone object to add.
     */
    @Override
    @Transactional
    public Dispone addDispone(Dispone dispone){
        
        Dispone res = this.getDisponeByUserAndMetateorema(dispone.getUsuario().getLogin(),dispone.getMetateorema().getId());
        if (res != null){
            return res;
        }
        disponeDAO.addDispone(dispone);
        return dispone;
    }

    /**
     * Deletes one of the entries of the table.
     * @param id Is the principal key of the entry to delete.
     * @return Nothing.
     */   
    @Override
    @Transactional
    public void deleteDispone(int id){
        disponeDAO.deleteDispone(id);
    }
   
    /**
     * Method to get a Dispone object by its principal key.
     * @param id Is the principal key of the Dispone object.
     */ 
    @Override
    @Transactional
    public Dispone getDispone(int id){
        return disponeDAO.getDispone(id);
    }
    
    /**
     * Method to get a list of all the entries of the table.
     */
    @Override
    @Transactional
    public List<Dispone> getAllDispone(){
        return disponeDAO.getAllDispone();
    }
    
    /**
     * Method to get a list of all the entries of the table that correspond to a specific user.
     * @param userLogin Is the string with which the user logs in, and that we use to filter the search.
     */
    @Override
    @Transactional
    public List<Dispone> getAllDisponeByUser(String userLogin){
        return disponeDAO.getAllDisponeByUser(userLogin);
    }

    /**
     * Method to get a list of all the entries of the table that correspond to a specific metatheorem.
     * @param meateoremaID Is the principal key of the Metateorema table, with which we filter the search.
     */
    @Override
    @Transactional
    public List<Dispone> getDisponeByMetateorema(int metateoremaID){
        return disponeDAO.getDisponeByMetateorema(metateoremaID);
    }
    
    /**
     * Method to get the entry of the table that relates a user with a metatheorem, using the principal 
     * key of the metatheorem.
     *
     * @param userLogin Is the string with which the user logs in, and that we use to filter the search.
     * @param meateoremaID Is the principal key of the Metateorema table, with which we filter the search.
     */ 
    @Override
    @Transactional
    public Dispone getDisponeByUserAndMetateorema(String userLogin,int metateoremaID){
        return disponeDAO.getDisponeByUserAndMetaeorema(userLogin, metateoremaID);
    }
    
    /**
     * Method to get the entry of the table that relates a user with a metatheorem, using the string
     * that represents to the metatheorem.
     *
     * @param userLogin Is the string with which the user logs in, and that we use to filter the search.
     * @param meateorema Is the string that represents the metatheorem, with which we filter the search.
     */
    @Override
    @Transactional
    public Dispone getDisponeByUserAndMetaeorema(String userLogin, String metateorema){
        return disponeDAO.getDisponeByUserAndMetaeorema(userLogin, metateorema);
    }

    /**
     * Method to get the entry of the table that relates a user with a metatheorem, using the number
     * of the metatheorem. If it exists, it first deserializes the term of the metatheorem.
     *
     * @param userLogin Is the string with which the user logs in, and that we use to filter the search.
     * @param metateoNum Is the number of the metatheorem, with which we filter the search.
     */  
    @Override
    @Transactional
    public Dispone getDisponeByUserAndTeoNum(String userLogin,String metateoNum)
    {
        Dispone dispone = disponeDAO.getDisponeByUserAndTeoNum(userLogin, metateoNum);
        if (dispone != null) {
            Metateorema teo = dispone.getMetateorema();
            teo.setTeoTerm((Term) SerializationUtils.deserialize(teo.getMetateoserializado()));
            dispone.setMetateorema(teo);
        }
        return dispone;
    }
}
