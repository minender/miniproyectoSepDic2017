/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.howtodoinjava.dao;
import com.howtodoinjava.entity.Teoria;
import java.util.List;

/**
 *
 * @author jt
 */
public interface TeoriaDAO {
    

    public void addTeoria(Teoria teoria);
    
    public void updateTeoria(Teoria Teoria);
    
    public void deleteTeoria(int id);
    
    public Teoria getTeoria(int id);
    
    public List<Teoria> getAllTeoria();
    

}