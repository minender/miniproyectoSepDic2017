
/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.calclogic.service;

import com.calclogic.dao.SimboloDAO;
import com.calclogic.entity.Simbolo;
import java.util.ArrayList;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

/**
 *
 * @author jt
 */
@Service
public class SimboloManagerImpl implements SimboloManager {
       
    // @Autowired
    private SimboloDAO simboloDAO;
    private int propFunApp;
    private int termFunApp;
    Simbolo[] symbolsCache;
    
    @Autowired
    public SimboloManagerImpl(SimboloDAO simboloDAO) {
        this.simboloDAO = simboloDAO;
        List<Simbolo> l = simboloDAO.getAllSimbolo();
        symbolsCache = new Simbolo[l.size()];
        for (int i=0; i < l.size(); i++)
            symbolsCache[i] = l.get(i);
    }
    
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
    public Simbolo addSimbolo(Simbolo simbolo){
        simboloDAO.addSimbolo(simbolo);
        List<Simbolo> l = simboloDAO.getAllSimbolo();
        symbolsCache = new Simbolo[l.size()];
        for (int i=0; i < l.size(); i++)
            symbolsCache[i] = l.get(i);
        return simbolo;
    }
    
    
    @Override   
    @Transactional
    public void updateSimbolo(Simbolo simbolo){
        int id = simbolo.getId()-1;
        if (0 < id && id <= symbolsCache.length) {
            symbolsCache[id] = simbolo;
        }
        simboloDAO.updateSimbolo(simbolo);
    }
    
    @Override
    @Transactional
    public void deleteSimbolo(int id){
        simboloDAO.deleteSimbolo(id);
    }
    
    @Override
    @Transactional
    public Simbolo getSimbolo(int id){
        if (0 < id && id <= symbolsCache.length)
            return symbolsCache[id-1];
        else
            return null;
    }
    
    @Override
    @Transactional
    public List<Simbolo> getAllSimbolo(){
        List<Simbolo> list = new ArrayList<Simbolo>();
        for (int i= 0; i < symbolsCache.length; i++)
            if (i >= 9)
            list.add(symbolsCache[i]);
        return list;
    }

    public void setPropFunApp(int propFunApp) {
        this.propFunApp = propFunApp;
    }
    
    public void setTermFunApp(int termFunApp) {
        this.termFunApp = termFunApp;
    }
    
}
