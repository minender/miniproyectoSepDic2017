package com.calclogic.service;

import com.calclogic.dao.CategoriaDAO;
import com.calclogic.entity.Categoria;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

/**
 * This class has the implementation of "CategoriaManager" queries.
 *
 * @author miguel
 */
@Service
public class CategoriaManagerImpl implements CategoriaManager {
       
    @Autowired
    private CategoriaDAO categoriaDAO;
    
    /** 
     * Adds a new Categoria object to the system.
     * @param categoria The new category to add.
     * @return Nothing.
     */
    @Override
    @Transactional
    public void addCategoria(Categoria categoria){
        categoriaDAO.addCategoria(categoria);
    }

    /**
     * Deletes one of the Categoria objects of the system.
     * @param id Is the principal key of the category to delete.
     * @return Nothing.
     */ 
    @Override
    @Transactional
    public void deleteCategoria(int id){
        categoriaDAO.deleteCategoria(id);
    }
    
    /**
     * Method to get a category by its principal key.
     * @param id Is the principal key of the category.
     */    
    @Override
    @Transactional
    public Categoria getCategoria(int id){
        return categoriaDAO.getCategoria(id);
    }
    
    /**
     * Method to get a list of all categories available in the system.
     */   
    @Override
    @Transactional
    public List<Categoria> getAllCategorias(){
        return categoriaDAO.getAllCategorias();
    }
}
