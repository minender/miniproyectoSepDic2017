/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.howtodoinjava.dao;

import com.howtodoinjava.entity.Materia;
import java.util.List;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;

/**
 *
 * @author federico
 */
public class MateriaDaoImpl implements MateriaDAO{

    @Autowired
    private SessionFactory sessionFactory;
    
    
    @Override   
    public void addMateria(Materia materia){
        this.sessionFactory.getCurrentSession().save(materia);
    }
    
    @Override
    public void deleteMateria(int id) {
        Materia materia = (Materia) sessionFactory.getCurrentSession().load(
                            Materia.class, id);
        if (null != materia) {
            this.sessionFactory.getCurrentSession().delete(materia);
        }
    }
    
    @Override
    public Materia getMateria(int id){
        return (Materia)this.sessionFactory.getCurrentSession().get(Materia.class, id);
    }
    
    @Override
    public List<Materia> getAllMaterias(){
        return this.sessionFactory.getCurrentSession().createQuery("FROM Materia").list();
    }
    
}
