/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.howtodoinjava.dao;

import com.howtodoinjava.entity.Resuelve;
import java.util.List;

/**
 *
 * @author miguel
 */
public interface ResuelveDAO {
    

    public void addResuelve(Resuelve resuelve);
    
    public void updateResuelve(Resuelve resuelve);
    
    public void deleteResuelve(int id);
    
    public Resuelve getResuelve(int id);
    
    public List<Resuelve> getAllResuelve();
    
    public List<Resuelve> getAllResuelveByUser(String userLogin);
    
    public List<Resuelve> getAllResuelveByUserResuelto(String userLogin);

    public List<Resuelve> getResuelveByTeorema(int teoremaID);

    public Resuelve getResuelveByUserAndTeorema(String userLogin,int teoremaID);
    
    public Resuelve getResuelveByUserAndTeorema(String userLogin,String teo);

    public Resuelve getResuelveByUserAndTeoNum(String userLogin,String teoNum);
    
    public List<Resuelve> getResuelveByCategoria(int categoriaId);
}
