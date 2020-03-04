/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.howtodoinjava.service;

import com.howtodoinjava.entity.Teoria;
import com.howtodoinjava.entity.Solucion;
import java.util.List;

/**
 *
 * @author jt
 */
public interface TeoriaManager {
    
    
    public Teoria addTeoria(Teoria Teoria);
    
    public void updateTeoria(Teoria Teoria);
    
    public void deleteTeoria(int id);
    
    public Teoria getTeoria(int id);
    
    public List<Teoria> getAllTeoria();
    
}
