package com.calclogic.dao;

import com.calclogic.entity.Predicado;
import com.calclogic.entity.PredicadoId;
import java.util.List;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

/**
 * This class has the implementation of the database queries that 
 * have to do with the table "Predicado".
 *
 * That table has the abbreviations that each user has added.
 *
 * @author miguel
 */
@Repository
public class PredicadoDaoImpl implements PredicadoDAO{
    
    @Autowired
    private SessionFactory sessionFactory;
    
    /** 
     * Adds a new Predicado object to the table.
     * This query is made using standard Hibernate library functions.
     * @param predicado The new Predicado object to be added.
     * @return Nothing.
     */  
    @Override   
    @Transactional
    public void addPredicado(Predicado predicado){
        this.sessionFactory.getCurrentSession().save(predicado);
    }
    
    /**
     * Deletes one of the Predicado objects of the table.
     * This query is made using standard Hibernate library functions.
     * @param id Is the principal key of the Predicado object to delete.
     * @return Nothing.
     */ 
    @Override
    @Transactional
    public void deletePredicado(PredicadoId id){
        Predicado predicado = (Predicado) sessionFactory.getCurrentSession().load(
				Predicado.class, id);
        if (null != predicado) {
        	this.sessionFactory.getCurrentSession().delete(predicado);
        }
    }
    
    /**
     * Updates one of the Predicado objects of the table.
     * This query is made using standard Hibernate library functions.
     * @param pre Is the Predicado object to be updated.
     * @return Nothing.
     */ 
    @Override
    @Transactional
    public void updatePredicado(Predicado pre) {
        this.sessionFactory.getCurrentSession().update(pre);
    }
    
    /**
     * Method to get a Predicado object by its principal key.
     * @param id Is the principal key of the Predicado object.
     */
    @Override
    @Transactional
    public Predicado getPredicado(PredicadoId id){
        return (Predicado)this.sessionFactory.getCurrentSession().get(Predicado.class,id);
    }
    
    /**
     * Method to get a Predicado object that corresponds to
     * a specific user and that have a specific string.
     * This query is made using HQL (Hibernate Query Language).
     * @param username Is the string with which the user logs in, and that we use to filter the search.
     * @param comb Represents the predicate with which we filter the search.
     */
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
    
    /**
     * Method to get a list of all the entries of the table that correspond to a specific user.
     * This query is made using HQL (Hibernate Query Language).
     * @param userLogin Is the string with which the user logs in, and that we use to filter the search.
     */
    @Override
    @Transactional
    public List<Predicado> getAllPredicadosByUser(String userLogin){
        return this.sessionFactory.getCurrentSession().createQuery("FROM Predicado WHERE usuario.login = :userLogin").setParameter("userLogin",userLogin).list();
    }
    
    
}
