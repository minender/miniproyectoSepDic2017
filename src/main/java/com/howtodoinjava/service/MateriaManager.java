/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.howtodoinjava.service;

import com.howtodoinjava.entity.Materia;
import java.util.List;

/**
 *
 * @author federico
 */
public interface MateriaManager {
    
    public void addMateria(Materia materia);
    
    public void deleteMateria(int id);
    
    public Materia getMateria(int id);
    
    public List<Materia> getAllMaterias();
    
}
