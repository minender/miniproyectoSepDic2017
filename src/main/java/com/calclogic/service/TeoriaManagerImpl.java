
/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.calclogic.service;

import com.calclogic.dao.TeoriaDAO;
import com.calclogic.dao.SolucionDAO;
import com.calclogic.entity.Teoria;
import com.calclogic.entity.Solucion;
import com.calclogic.entity.Teorema;
import com.calclogic.lambdacalculo.Term;
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
