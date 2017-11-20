/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.howtodoinjava.dao;

import com.howtodoinjava.entity.Solucion;
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
public class SolucionDaoImpl implements SolucionDAO{
    
    @Autowired
    private SessionFactory sessionFactory;
    
    
    @Override   
    @Transactional
    public void addSolucion(Solucion solucion){
        this.sessionFactory.getCurrentSession().save(solucion);
    }
    
    
    @Override   
    @Transactional
    public void updateSolucion(Solucion solucion){
        this.sessionFactory.getCurrentSession().update(solucion);
    }
    
    @Override
    @Transactional
    public void deleteSolucion(int id){
        Solucion solucion = (Solucion) sessionFactory.getCurrentSession().load(
				Solucion.class, id);
        if (null != solucion) {
        	this.sessionFactory.getCurrentSession().delete(solucion);
        }
    } // Si es la unica solucion, debe definirse como "Blank"
    
    @Override
    @Transactional
    public Solucion getSolucion(int id){
        return (Solucion)this.sessionFactory.getCurrentSession().get(Solucion.class,id);
    }
    
    @Override
    @Transactional
    public List<Solucion> getAllSolucionesByResuelve(int resuelveId){
        return this.sessionFactory.getCurrentSession().createQuery("FROM Solucion WHERE resuelve.id = :resuelveId").setParameter("resuelveId",resuelveId).list();
    }
    
    @Override
    @Transactional
    public List<Integer> getAllSolucionesIdByResuelve(int resuelveId){
        return this.sessionFactory.getCurrentSession().createQuery("Select id FROM Solucion WHERE resuelveid = :resuelveId and resuelto = 't' ").setParameter("resuelveId",resuelveId).list();
    }
    
}
