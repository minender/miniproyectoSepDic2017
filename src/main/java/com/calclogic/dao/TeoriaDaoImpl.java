package com.calclogic.dao;

import com.calclogic.entity.Teoria;
import com.calclogic.entity.Teoria;
import com.calclogic.entity.Teorema;
import com.calclogic.lambdacalculo.Term;
import java.util.List;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.SerializationUtils;

/**
 * This class has the implementation of the database queries that 
 * have to do with the table "Teoria".
 *
 * The entries of that table group Simbolo, Teorema and Metateorema
 * objects.
 *
 * @author jt
 */
@Repository
public class TeoriaDaoImpl implements TeoriaDAO {
    
    @Autowired
    private SessionFactory sessionFactory;
    
    /** 
     * Adds a new theory to the table.
     * This query is made using standard Hibernate library functions.
     * @param teoria The new theory to be added.
     * @return Nothing.
     */
    @Override   
    @Transactional
    public void addTeoria(Teoria Teoria){
        this.sessionFactory.getCurrentSession().save(Teoria);
    }
    
    /**
     * Updates one of the theories of the table.
     * This query is made using standard Hibernate library functions.
     * @param Teoria Is the theory to be updated.
     * @return Nothing.
     */ 
    @Override   
    @Transactional
    public void updateTeoria(Teoria Teoria){
        this.sessionFactory.getCurrentSession().update(Teoria);
    }
    
    /**
     * Deletes one of the theories of the table.
     * This query is made using standard Hibernate library functions.
     * @param id Is the principal key of the theory to delete.
     * @return Nothing.
     */ 
    @Override
    @Transactional
    public void deleteTeoria(int id){
        Teoria Teoria = (Teoria) sessionFactory.getCurrentSession().load(
				Teoria.class, id);
        if (null != Teoria) {
        	this.sessionFactory.getCurrentSession().delete(Teoria);
        }
    }
    
    /**
     * Method to get a theory by its principal key.
     * This query is made using standard Hibernate library functions.
     * @param id Is the principal key of the theory.
     */
    @Override
    @Transactional
    public Teoria getTeoria(int id){
        return (Teoria)this.sessionFactory.getCurrentSession().get(Teoria.class,id);
    }
    
    /**
     * Method to get a list of all the entries of the table (all the theories).
     * This query is made using HQL (Hibernate Query Language).
     */  
    @Override
    @Transactional
    public List<Teoria> getAllTeoria(){
        return this.sessionFactory.getCurrentSession().createQuery("FROM Teoria").list();
    }
}