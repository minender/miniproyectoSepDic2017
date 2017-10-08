/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.howtodoinjava.dao;

import com.howtodoinjava.entity.Categoria;
import java.util.List;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;

/**
 *
 * @author miguel
 */
public class CategoriaDaoImpl implements CategoriaDAO {
    
    @Autowired
    private SessionFactory sessionFactory;
    
    
    @Override   
    public void addCategoria(Categoria categoria){
        this.sessionFactory.getCurrentSession().save(categoria);
    }
    
    @Override
    public void deleteCategoria(int id) {
        Categoria categoria = (Categoria) sessionFactory.getCurrentSession().load(
                            Categoria.class, id);
        if (null != categoria) {
            this.sessionFactory.getCurrentSession().delete(categoria);
        }
    }
    
    @Override
    public Categoria getCategoria(int id){
        return (Categoria)this.sessionFactory.getCurrentSession().get(Categoria.class, id);
    }
    
    @Override
    public List<Categoria> getAllCategorias(){
        return this.sessionFactory.getCurrentSession().createQuery("FROM Categoria").list();
    }
    


}
