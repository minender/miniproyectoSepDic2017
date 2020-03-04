/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.howtodoinjava.dao;

import com.howtodoinjava.entity.Simbolo;
import com.howtodoinjava.entity.Simbolo;
import com.howtodoinjava.entity.Teorema;
import com.howtodoinjava.lambdacalculo.Term;
import java.util.List;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.SerializationUtils;

/**
 *
 * @author jt
 */
@Repository
public class SimboloDaoImpl implements SimboloDAO {
    
    @Autowired
    private SessionFactory sessionFactory;
    
    
    @Override   
    @Transactional
    public void addSimbolo(Simbolo Simbolo){
        this.sessionFactory.getCurrentSession().save(Simbolo);
    }
    
    @Override   
    @Transactional
    public void updateSimbolo(Simbolo Simbolo){
        this.sessionFactory.getCurrentSession().update(Simbolo);
    }
    
    @Override
    @Transactional
    public void deleteSimbolo(int id){
        Simbolo Simbolo = (Simbolo) sessionFactory.getCurrentSession().load(
				Simbolo.class, id);
        if (null != Simbolo) {
        	this.sessionFactory.getCurrentSession().delete(Simbolo);
        }
    }
    
    @Override
    @Transactional
    public Simbolo getSimbolo(int id){
        return (Simbolo)this.sessionFactory.getCurrentSession().get(Simbolo.class,id);
    }
    
    
    @Override
    @Transactional
    public List<Simbolo> getAllSimbolo(){
        return this.sessionFactory.getCurrentSession().createQuery("FROM Simbolo").list();
    }
}