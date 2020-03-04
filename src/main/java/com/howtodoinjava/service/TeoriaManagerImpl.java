
/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.howtodoinjava.service;

import com.howtodoinjava.dao.TeoriaDAO;
import com.howtodoinjava.dao.SolucionDAO;
import com.howtodoinjava.entity.Teoria;
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
public class TeoriaManagerImpl implements TeoriaManager {
       
    @Autowired
    private TeoriaDAO TeoriaDAO;
    
    @Autowired
    private SolucionDAO solucionDAO;
    
    @Override
    @Transactional
    public Teoria addTeoria(Teoria Teoria){
        TeoriaDAO.addTeoria(Teoria);
        return Teoria;
    }
    
    
    @Override   
    @Transactional
    public void updateTeoria(Teoria Teoria){
        TeoriaDAO.updateTeoria(Teoria);
    }
    
    @Override
    @Transactional
    public void deleteTeoria(int id){
        TeoriaDAO.deleteTeoria(id);
    }
    
    @Override
    @Transactional
    public Teoria getTeoria(int id){
        return TeoriaDAO.getTeoria(id);
    }
    
    @Override
    @Transactional
    public List<Teoria> getAllTeoria(){
        return TeoriaDAO.getAllTeoria();
    }

 
    
}
