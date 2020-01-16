/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.howtodoinjava.service;

import com.howtodoinjava.dao.MateriaDAO;
import com.howtodoinjava.entity.Materia;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.transaction.annotation.Transactional;

/**
 *
 * @author federico
 */
public class MateriaManagerImpl implements MateriaManager{
    
    @Autowired
    private MateriaDAO materiaDAO;
    
    @Override
    @Transactional
    public void addMateria(Materia materia){
        materiaDAO.addMateria(materia);
    }
    
    @Override
    @Transactional
    public void deleteMateria(int id){
        materiaDAO.deleteMateria(id);
    }
    
    
    @Override
    @Transactional
    public Materia getMateria(int id){
        return materiaDAO.getMateria(id);
    }
    
    
    @Override
    @Transactional
    public List<Materia> getAllMaterias(){
        return materiaDAO.getAllMaterias();
    }
    
}
