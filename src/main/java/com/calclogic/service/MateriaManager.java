package com.calclogic.service;

import com.calclogic.entity.Materia;
import java.util.List;

/**
 * This interface is the use of the "MateriaDAO" 
 * api in this application.
 *
 * @author federico
 */
public interface MateriaManager {

    /** 
     * Adds a new subject to the table.
     * @param materia The new Materia object to be added.
     * @return Nothing.
     */   
    public void addMateria(Materia materia);
   
    /**
     * Deletes one of the subjects of the table.
     * @param id Is the principal key of the subject to delete.
     * @return Nothing.
     */  
    public void deleteMateria(int id);
    
    /**
     * Method to get a subject by its principal key.
     * @param id Is the principal key of the subject.
     */
    public Materia getMateria(int id);
    
    /**
     * Method to get a list of all the entries of the table (all the subjects).
     */
    public List<Materia> getAllMaterias();  
}
