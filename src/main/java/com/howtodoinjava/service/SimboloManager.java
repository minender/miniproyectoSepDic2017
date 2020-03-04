/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.howtodoinjava.service;

import com.howtodoinjava.entity.Simbolo;
import com.howtodoinjava.entity.Solucion;
import java.util.List;

/**
 *
 * @author jt
 */
public interface SimboloManager {
    
    
    public Simbolo addSimbolo(Simbolo Simbolo);
    
    public void updateSimbolo(Simbolo Simbolo);
    
    public void deleteSimbolo(int id);
    
    public Simbolo getSimbolo(int id);
    
    public List<Simbolo> getAllSimbolo();
    
}
