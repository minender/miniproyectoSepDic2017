/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.howtodoinjava.service;

import com.howtodoinjava.entity.Dispone;
import java.util.List;

/**
 *
 * @author miguel
 */
public interface DisponeManager {
    
    
    public Dispone addDispone(Dispone dispone);
    
    public void deleteDispone(int id);
    
    public Dispone getDispone(int id);
    
    public List<Dispone> getAllDispone();
    
    public List<Dispone> getAllDisponeByUser(String userLogin);
    
//
//    public List<Dispone> getDisponeByUser(String userLogin);
//
    public List<Dispone> getDisponeByMetateorema(int metateoremaID);
        
    public Dispone getDisponeByUserAndMetateorema(String userLogin,int metateoremaID);
    
    public Dispone getDisponeByUserAndMetaeorema(String userLogin, String metateorema);
    
    public Dispone getDisponeByUserAndTeoNum(String userLogin,String metateoNum);
}
