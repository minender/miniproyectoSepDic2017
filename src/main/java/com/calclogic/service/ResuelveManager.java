/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.calclogic.service;

import com.calclogic.entity.Resuelve;
import com.calclogic.entity.Solucion;
import java.util.List;

/**
 *
 * @author miguel
 */
public interface ResuelveManager {
    
    
    public Resuelve addResuelve(Resuelve resuelve);
    
    public void updateResuelve(Resuelve resuelve);
    
    public void deleteResuelve(int id);
    
    public Resuelve getResuelve(int id);
    
    public List<Resuelve> getAllResuelve();
    
    public List<Resuelve> getAllResuelveByUser(String userLogin);
    
    public List<Resuelve> getAllResuelveByUserWithSol(String userLogin);
    
    public List<Resuelve> getAllResuelveByUserResuelto(String userLogin);

    public List<Resuelve> getResuelveByTeorema(int teoremaID);
    
    public Resuelve getResuelveByUserAndTeorema(String userLogin,String teo);
    
    public Resuelve getResuelveByUserAndTeorema(String userLogin,int teoremaID);
    
    public Resuelve getResuelveByUserAndTeoNum(String userLogin,String teoNum);
    
}
