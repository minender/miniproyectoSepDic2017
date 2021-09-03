package com.calclogic.service;

import com.calclogic.dao.MateriaDAO;
import com.calclogic.entity.Materia;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.transaction.annotation.Transactional;

/**
 * This class has the implementation of "MateriaManager" queries.
 *
 * @author federico
 */
public class MateriaManagerImpl implements MateriaManager{
    
    @Autowired
    private MateriaDAO materiaDAO;
   
    /** 
     * Adds a new subject to the table.
     * @param materia The new Materia object to be added.
     * @return Nothing.
     */ 
    @Override
    @Transactional
    public void addMateria(Materia materia){
        materiaDAO.addMateria(materia);
    }
   
    /**
     * Deletes one of the subjects of the table.
     * @param id Is the principal key of the subject to delete.
     * @return Nothing.
     */  
    @Override
    @Transactional
    public void deleteMateria(int id){
        materiaDAO.deleteMateria(id);
    }
    
    /**
     * Method to get a subject by its principal key.
     * @param id Is the principal key of the subject.
     */  
    @Override
    @Transactional
    public Materia getMateria(int id){
        return materiaDAO.getMateria(id);
    }
    
    /**
     * Method to get a list of all the entries of the table (all the subjects).
     */ 
    @Override
    @Transactional
    public List<Materia> getAllMaterias(){
        return materiaDAO.getAllMaterias();
    }  
}
