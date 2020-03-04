
/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.howtodoinjava.service;

import com.howtodoinjava.dao.SimboloDAO;
import com.howtodoinjava.dao.SolucionDAO;
import com.howtodoinjava.entity.Simbolo;
import com.howtodoinjava.entity.Solucion;
import com.howtodoinjava.entity.Teorema;
import com.howtodoinjava.lambdacalculo.Term;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.SerializationUtils;

/**
 *
 * @author jt
 */
@Service
public class SimboloManagerImpl implements SimboloManager {
       
    @Autowired
    private SimboloDAO SimboloDAO;
    
    
    @Override
    @Transactional
    public Simbolo addSimbolo(Simbolo Simbolo){
        SimboloDAO.addSimbolo(Simbolo);
        return Simbolo;
    }
    
    
    @Override   
    @Transactional
    public void updateSimbolo(Simbolo Simbolo){
        SimboloDAO.updateSimbolo(Simbolo);
    }
    
    @Override
    @Transactional
    public void deleteSimbolo(int id){
        SimboloDAO.deleteSimbolo(id);
    }
    
    @Override
    @Transactional
    public Simbolo getSimbolo(int id){
        return SimboloDAO.getSimbolo(id);
    }
    
    @Override
    @Transactional
    public List<Simbolo> getAllSimbolo(){
        return SimboloDAO.getAllSimbolo();
    }

 
    
}
