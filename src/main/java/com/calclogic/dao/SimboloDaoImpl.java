package com.calclogic.dao;

import com.calclogic.entity.Simbolo;
import com.calclogic.entity.Simbolo;
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
 * have to do with the table "Simbolo".
 *
 * That table has all the operators and constants along with 
 * their respective LaTeX notations.
 *
 * @author jt
 */
@Repository
public class SimboloDaoImpl implements SimboloDAO {
    
    @Autowired
    private SessionFactory sessionFactory;
    
    /** 
     * Adds a new symbol (Simbolo object) to the table.
     * This query is made using standard Hibernate library functions.
     * @param Simbolo The new symbol to be added.
     * @return Nothing.
     */
    @Override   
    @Transactional
    public void addSimbolo(Simbolo Simbolo){
        this.sessionFactory.getCurrentSession().save(Simbolo);
    }
    
    /**
     * This method let us Update the entry that corresponds to a symbol
     * already stored. For example, to update the code that creates it.
     * This query is made using standard Hibernate library functions.
     * @param Simbolo Is the Predicado object to be updated.
     * @return Nothing.
     */ 
    @Override   
    @Transactional
    public void updateSimbolo(Simbolo Simbolo){
        this.sessionFactory.getCurrentSession().update(Simbolo);
    }
    
    /**
     * Deletes one of the symbols of the table.
     * This query is made using standard Hibernate library functions.
     * @param id Is the principal key of the symbol to delete.
     * @return Nothing.
     */ 
    @Override
    @Transactional
    public void deleteSimbolo(int id){
        Simbolo Simbolo = (Simbolo) sessionFactory.getCurrentSession().load(
				Simbolo.class, id);
        if (null != Simbolo) {
        	this.sessionFactory.getCurrentSession().delete(Simbolo);
        }
    }
    
    /**
     * Method to get a Symbol object by its principal key.
     * This query is made using standard Hibernate library functions.
     * @param id Is the principal key of the Symbol object.
     */ 
    @Override
    @Transactional
    public Simbolo getSimbolo(int id){
        return (Simbolo)this.sessionFactory.getCurrentSession().get(Simbolo.class,id);
    }
    
    /**
     * Method to get a list of all the entries of the table.
     * This query is made using classic SQL.
     */  
    @Override
    @Transactional
    public List<Simbolo> getAllSimbolo(){
        return this.sessionFactory.getCurrentSession().createQuery("FROM Simbolo WHERE  id >= 1 ORDER BY id").list();
    }
}