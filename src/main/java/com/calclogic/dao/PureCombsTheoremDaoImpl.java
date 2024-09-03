/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.calclogic.dao;

import com.calclogic.entity.PureCombsTheorem;
import java.util.List;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

/**
 *
 * @author feder
 */
@Repository
public class PureCombsTheoremDaoImpl implements PureCombsTheoremDAO{
    
    @Autowired
    private SessionFactory sessionFactory;
    
    /** 
     * Adds a new theorem to the table.
     * @param teorema The new theorem to be added.
     * @return Nothing.
     */
    @Override
    @Transactional
    public void addPureCombsTheorem(PureCombsTheorem teorema) {
        this.sessionFactory.getCurrentSession().save(teorema);
    }
    
    /**
     * Updates one of the Teorema objects of the table.
     * This query is made using standard Hibernate library functions.
     * @param teorema Is the Teorema object to be updated.
     * @return Nothing.
     */   
    @Override
    @Transactional
    public void updatePureCombsTheorem(PureCombsTheorem teorema) {
        this.sessionFactory.getCurrentSession().update(teorema);
    }
    
    /**
     * Deletes one of the theorems of the table.
     * @param id Is the principal key of the theorem to delete.
     * @return Nothing.
     */ 
    @Override
    @Transactional
    public void deletePureCombsTheorem(int id) {
        PureCombsTheorem teorema = (PureCombsTheorem) sessionFactory.getCurrentSession().load(
                PureCombsTheorem.class, id);
        if (null != teorema) {
            this.sessionFactory.getCurrentSession().delete(teorema);
        }
    }
    
    /**
     * Method to get a theorem by its principal key.
     * @param id Is the principal key of the theorem.
     */
    @Override
    public PureCombsTheorem getPureCombsTheorem(int id) {
        return (PureCombsTheorem) this.sessionFactory.getCurrentSession().get(PureCombsTheorem.class, id);
    }
    
    /**
     * Method to get a list of all the entries of the table (all the theorems).
     */
    @Override
    public List<PureCombsTheorem> getAllPureCombsTheorem() {
        return this.sessionFactory.getCurrentSession().createQuery("FROM PureCombsTheorem").list();
    }
    
    /**
     * Method to get a theorem that corresponds to a statement.
     * @param enunciado Is the statement used to filter the search.
     */
    @Override
    @Transactional
    public PureCombsTheorem getTeoremaByEnunciado(String statement) {
        String sql = "FROM PureCombsTheorem WHERE statement = :statement";
        List<PureCombsTheorem> list = this.sessionFactory.getCurrentSession().createQuery(sql).setParameter("statement", statement).list();

        if (list.isEmpty()) {
            return null;
        } else {
            return list.get(0);
        }
    }
}
