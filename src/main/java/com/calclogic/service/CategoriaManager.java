package com.calclogic.service;

import com.calclogic.entity.Categoria;
import java.util.List;

/**
 * This interface is the use of the "CategoriaDAO" 
 * api in this application.
 *
 * @author miguel
 */
public interface CategoriaManager {
        
    /** 
     * Adds a new Categoria object to the system.
     * @param categoria The new category to add.
     * @return Nothing.
     */
    public void addCategoria(Categoria categoria);
   
    /**
     * Deletes one of the Categoria objects of the system.
     * @param id Is the principal key of the category to delete.
     * @return Nothing.
     */ 
    public void deleteCategoria(int id);

    /**
     * Method to get a category by its principal key.
     * @param id Is the principal key of the category.
     */
    public Categoria getCategoria(int id);

    /**
     * Method to get a list of all categories available in the system.
     */  
    public List<Categoria> getAllCategorias();  
}
