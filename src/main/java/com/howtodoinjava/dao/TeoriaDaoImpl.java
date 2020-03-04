/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.howtodoinjava.dao;

import com.howtodoinjava.entity.Teoria;
import com.howtodoinjava.entity.Teoria;
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
public class TeoriaDaoImpl implements TeoriaDAO {
    
    @Autowired
    private SessionFactory sessionFactory;
    
    
    @Override   
    @Transactional
    public void addTeoria(Teoria Teoria){
        this.sessionFactory.getCurrentSession().save(Teoria);
    }
    
    @Override   
    @Transactional
    public void updateTeoria(Teoria Teoria){
        this.sessionFactory.getCurrentSession().update(Teoria);
    }
    
    @Override
    @Transactional
    public void deleteTeoria(int id){
        Teoria Teoria = (Teoria) sessionFactory.getCurrentSession().load(
				Teoria.class, id);
        if (null != Teoria) {
        	this.sessionFactory.getCurrentSession().delete(Teoria);
        }
    }
    
    @Override
    @Transactional
    public Teoria getTeoria(int id){
        return (Teoria)this.sessionFactory.getCurrentSession().get(Teoria.class,id);
    }
    
    
    @Override
    @Transactional
    public List<Teoria> getAllTeoria(){
        return this.sessionFactory.getCurrentSession().createQuery("FROM Teoria").list();
    }
}