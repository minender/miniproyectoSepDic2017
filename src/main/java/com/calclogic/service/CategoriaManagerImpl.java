package com.calclogic.service;

import com.calclogic.dao.CategoriaDAO;
import com.calclogic.entity.Categoria;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

/**
 *
 * @author miguel
 */
@Service
public class CategoriaManagerImpl implements CategoriaManager {
       
    @Autowired
    private CategoriaDAO categoriaDAO;
    
    @Override
    @Transactional
    public void addCategoria(Categoria categoria){
        categoriaDAO.addCategoria(categoria);
    }
    
    @Override
    @Transactional
    public void deleteCategoria(int id){
        categoriaDAO.deleteCategoria(id);
    }
    
    
    @Override
    @Transactional
    public Categoria getCategoria(int id){
        return categoriaDAO.getCategoria(id);
    }
    
    
    @Override
    @Transactional
    public List<Categoria> getAllCategorias(){
        return categoriaDAO.getAllCategorias();
    }
}
