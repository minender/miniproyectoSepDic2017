/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.howtodoinjava.dao;
import com.howtodoinjava.entity.Simbolo;
import java.util.List;

/**
 *
 * @author jt
 */
public interface SimboloDAO {
    

    public void addSimbolo(Simbolo Simbolo);
    
    public void updateSimbolo(Simbolo Simbolo);
    
    public void deleteSimbolo(int id);
    
    public Simbolo getSimbolo(int id);
    
    public List<Simbolo> getAllSimbolo();
    

}