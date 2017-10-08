/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.howtodoinjava.service;

import com.howtodoinjava.dao.PredicadoDAO;
import com.howtodoinjava.entity.Predicado;
import com.howtodoinjava.entity.PredicadoId;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

/**
 *
 * @author miguel
 */
@Service
public class PredicadoManagerImpl implements PredicadoManager {
       
    @Autowired
    private PredicadoDAO predicadoDAO;
    
    
    @Override
    @Transactional
    public void addPredicado(Predicado predicado){
        predicadoDAO.addPredicado(predicado);
    }
    
    @Override
    @Transactional
    public void deletePredicado(PredicadoId id){
        predicadoDAO.deletePredicado(id);
    }
    
    
    @Override
    @Transactional
    public Predicado getPredicado(PredicadoId id){
        return predicadoDAO.getPredicado(id);
    }
    
    
    @Override
    @Transactional
    public List<Predicado> getAllPredicadosByUser(String userLogin){
        return predicadoDAO.getAllPredicadosByUser(userLogin);
    }
}
