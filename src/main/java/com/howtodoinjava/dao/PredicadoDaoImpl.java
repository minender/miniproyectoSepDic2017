/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.howtodoinjava.dao;

import com.howtodoinjava.entity.Predicado;
import com.howtodoinjava.entity.PredicadoId;
import java.util.List;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

/**
 *
 * @author miguel
 */
@Repository
public class PredicadoDaoImpl implements PredicadoDAO{
    
    @Autowired
    private SessionFactory sessionFactory;
    
    
    @Override   
    @Transactional
    public void addPredicado(Predicado predicado){
        this.sessionFactory.getCurrentSession().save(predicado);
    }
    
    @Override
    @Transactional
    public void deletePredicado(PredicadoId id){
        Predicado predicado = (Predicado) sessionFactory.getCurrentSession().load(
				Predicado.class, id);
        if (null != predicado) {
        	this.sessionFactory.getCurrentSession().delete(predicado);
        }
    }
    
    @Override
    @Transactional
    public Predicado getPredicado(PredicadoId id){
        return (Predicado)this.sessionFactory.getCurrentSession().get(Predicado.class,id);
    }
    
    @Override
    @Transactional
    public List<Predicado> getAllPredicadosByUser(String userLogin){
        return this.sessionFactory.getCurrentSession().createQuery("FROM Predicado WHERE usuario.login = :userLogin").setParameter("userLogin",userLogin).list();
    }
    
    
}
