
/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.calclogic.service;

import com.calclogic.dao.SimboloDAO;
import com.calclogic.dao.SolucionDAO;
import com.calclogic.entity.Simbolo;
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
public class SimboloManagerImpl implements SimboloManager {
       
    @Autowired
    private SimboloDAO SimboloDAO;
    private int propFunApp;
    private int termFunApp;
    
    public int getPropFunApp() {
        return propFunApp;
    }
    
    public int getTermFunApp() {
        return termFunApp;
    }
    
    public String propFunAppSym() {
        return "c_{"+ propFunApp +"}";
    }
    
    public String termFunAppSym() {
        return "c_{"+ termFunApp +"}";
    }
    
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

    public void setPropFunApp(int propFunApp) {
        this.propFunApp = propFunApp;
    }
    
    public void setTermFunApp(int termFunApp) {
        this.termFunApp = termFunApp;
    }
    
}
