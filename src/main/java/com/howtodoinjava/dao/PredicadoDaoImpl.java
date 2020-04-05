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
    public void updatePredicado(Predicado pre) {
        this.sessionFactory.getCurrentSession().update(pre);
    }
    
    @Override
    @Transactional
    public Predicado getPredicado(PredicadoId id){
        return (Predicado)this.sessionFactory.getCurrentSession().get(Predicado.class,id);
    }
    
    @Override
    @Transactional
    public Predicado getPredicado(String username, String comb) {
        String sql="FROM Predicado WHERE predicado = :comb and id.login = :username";
            List<Predicado> list= this.sessionFactory.getCurrentSession().createQuery(sql).setParameter("comb",comb).setParameter("username", username).list();
            if(list.isEmpty())
                return null;
            else
                return list.get(0);
    }
    
    @Override
    @Transactional
    public List<Predicado> getAllPredicadosByUser(String userLogin){
        return this.sessionFactory.getCurrentSession().createQuery("FROM Predicado WHERE usuario.login = :userLogin").setParameter("userLogin",userLogin).list();
    }
    
    
}
