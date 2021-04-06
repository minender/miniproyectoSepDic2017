/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.calclogic.service;

import com.calclogic.entity.Simbolo;
import com.calclogic.entity.Solucion;
import java.util.List;

/**
 *
 * @author jt
 */
public interface SimboloManager {
    
    public int getPropFunApp();
    
    public int getTermFunApp();
    
    public String propFunAppSym();
    
    public String termFunAppSym();
    
    public Simbolo addSimbolo(Simbolo Simbolo);
    
    public void updateSimbolo(Simbolo Simbolo);
    
    public void deleteSimbolo(int id);
    
    public Simbolo getSimbolo(int id);
    
    public List<Simbolo> getAllSimbolo();
    
}
