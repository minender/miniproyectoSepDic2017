/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.howtodoinjava.dao;


import com.howtodoinjava.entity.Categoria;
import java.util.List;
/**
 *
 * @author miguel
 */
public interface CategoriaDAO {
    
    public void addCategoria(Categoria categoria);
    
    public void deleteCategoria(int id);
    
    public Categoria getCategoria(int id);
    
    public List<Categoria> getAllCategorias();
    
}




