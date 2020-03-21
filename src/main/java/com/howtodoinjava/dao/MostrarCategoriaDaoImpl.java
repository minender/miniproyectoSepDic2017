/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.howtodoinjava.dao;

import com.howtodoinjava.entity.Categoria;
import com.howtodoinjava.entity.MostrarCategoria;
import com.howtodoinjava.entity.Usuario;
import java.util.List;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

/**
 *
 * @author jt
 */
@Repository
public class MostrarCategoriaDaoImpl implements MostrarCategoriaDAO {
    
    @Autowired
    private SessionFactory sessionFactory;
    
    
    @Override   
    @Transactional
    public void addMostrarCategoria(MostrarCategoria MostrarCategoria){
        this.sessionFactory.getCurrentSession().save(MostrarCategoria);
    }
    
    @Override   
    @Transactional
    public void updateMostrarCategoria(MostrarCategoria MostrarCategoria){
        this.sessionFactory.getCurrentSession().update(MostrarCategoria);
    }
    
    @Override
    @Transactional
    public void deleteMostrarCategoria(int id){
        MostrarCategoria MostrarCategoria = (MostrarCategoria) sessionFactory.getCurrentSession().load(
				MostrarCategoria.class, id);
        if (null != MostrarCategoria) {
        	this.sessionFactory.getCurrentSession().delete(MostrarCategoria);
        }
    }
    
    @Override
    @Transactional
    public MostrarCategoria getMostrarCategoria(int id){
        return (MostrarCategoria)this.sessionFactory.getCurrentSession().get(MostrarCategoria.class,id);
    }
    
    
    @Override
    @Transactional
    public List<MostrarCategoria> getAllMostrarCategorias(){
        return this.sessionFactory.getCurrentSession().createQuery("FROM MostrarCategoria").list();
    }
    
    @Override
    @Transactional
    public List<MostrarCategoria> getAllMostrarCategoriasByUsuario(Usuario usuario){
        return this.sessionFactory.getCurrentSession().createQuery("FROM MostrarCategoria WHERE usuariologin = :usuariologin ORDER BY categoriaid").setParameter("usuariologin",usuario.getLogin()).list();
    }
    
    @Override
    @Transactional
    public MostrarCategoria getMostrarCategoriaByCategoriaAndUsuario(Categoria categoria,Usuario usuario){
        return (MostrarCategoria)this.sessionFactory.getCurrentSession().createQuery("FROM MostrarCategoria WHERE usuariologin = :usuariologin AND categoriaid = :categoriaid ORDER BY categoriaid").setParameter("usuariologin", usuario.getLogin()).setParameter("categoriaid",categoria.getId()).list().get(0);
    }
    


}