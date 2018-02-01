/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.howtodoinjava.service;

import com.howtodoinjava.dao.DisponeDAO;
import com.howtodoinjava.entity.Dispone;
import com.howtodoinjava.entity.Metateorema;
import com.howtodoinjava.lambdacalculo.Term;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.SerializationUtils;

/**
 *
 * @author miguel
 */
@Service
public class DisponeManagerImpl implements DisponeManager {
       
    @Autowired
    private DisponeDAO disponeDAO;
    
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
    
    @Override
    @Transactional
    public void deleteDispone(int id){
        disponeDAO.deleteDispone(id);
    }
    
    @Override
    @Transactional
    public Dispone getDispone(int id){
        return disponeDAO.getDispone(id);
    }
    
    @Override
    @Transactional
    public List<Dispone> getAllDispone(){
        return disponeDAO.getAllDispone();
    }
    
    @Override
    @Transactional
    public List<Dispone> getAllDisponeByUser(String userLogin){
        return disponeDAO.getAllDisponeByUser(userLogin);
    }
    
    @Override
    @Transactional
    public List<Dispone> getDisponeByMetateorema(int metateoremaID){
        return disponeDAO.getDisponeByMetateorema(metateoremaID);
    }
    
    @Override
    @Transactional
    public Dispone getDisponeByUserAndMetateorema(String userLogin,int metateoremaID){
        return disponeDAO.getDisponeByUserAndMetaeorema(userLogin, metateoremaID);
    }
    
    @Override
    @Transactional
    public Dispone getDisponeByUserAndMetaeorema(String userLogin, String metateorema){
        return disponeDAO.getDisponeByUserAndMetaeorema(userLogin, metateorema);
    }
    
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
