package com.calclogic.dao;

import com.calclogic.controller.PerfilController;
import com.calclogic.entity.Teorema;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.stereotype.Repository;

/**
 * This class has the implementation of the database queries that 
 * have to do with the table "Teorema".
 *
 * That table has all the theorems that have been added to the
 * application.
 *
 * @author miguel
 */
@Repository
public class TeoremaDaoImpl implements TeoremaDAO {

    @Autowired
    private SessionFactory sessionFactory;

    /** 
     * Adds a new theorem to the table.
     * This query is made using standard Hibernate library functions.
     * @param teorema The new theorem to be added.
     * @return Nothing.
     */
    @Override
    public void addTeorema(Teorema teorema) {

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
    public void updateTeorema(Teorema teorema){
        this.sessionFactory.getCurrentSession().update(teorema);
    }

    /**
     * Deletes one of the theorems of the table.
     * This query is made using standard Hibernate library functions.
     * @param id Is the principal key of the theorem to delete.
     * @return Nothing.
     */ 
    @Override
    @Transactional
    public void deleteTeorema(int id) {
        Teorema teorema = (Teorema) sessionFactory.getCurrentSession().load(
                Teorema.class, id);
        if (null != teorema) {
            this.sessionFactory.getCurrentSession().delete(teorema);
        }
    }

    /**
     * Method to get a theorem by its principal key.
     * This query is made using standard Hibernate library functions.
     * @param id Is the principal key of the theorem.
     */
    @Override
    @Transactional
    public Teorema getTeorema(int id) {
        return (Teorema) this.sessionFactory.getCurrentSession().get(Teorema.class, id);
    }

    /**
     * Method to get a list of all the entries of the table (all the theorems).
     * This query is made using HQL (Hibernate Query Language).
     */
    @Override
    public List<Teorema> getAllTeoremas() {
        // Aqui hay q colocar un select distinct
        return this.sessionFactory.getCurrentSession().createQuery("FROM Teorema").list();
    }

    /**
     * Method to get a theorem that corresponds to a statement.
     * This query is made using HQL (Hibernate Query Language).
     * @param enunciado Is the statement used to filter the search.
     */
    @Override
    @Transactional
    public Teorema getTeoremaByEnunciados(String enunciado) {

        String sql = "FROM Teorema WHERE enunciado = :enunciado";
        List<Teorema> list = this.sessionFactory.getCurrentSession().createQuery(sql).setParameter("enunciado", enunciado).list();

        if (list.isEmpty()) {
            return null;
        } else {
            return list.get(0);
        }
    }
    
    public List<Teorema> getTeoremasByPureCombTheo(int id) {
        String sql = "FROM Teorema t WHERE t.pureCombsTheorem.id = :id";
        return this.sessionFactory.getCurrentSession().createQuery(sql).setParameter("id", id).list();
    }
    
    @Override
    public List<Teorema> getAllTeoremasWithSimbolo(int idSimbolo) {
        return this.sessionFactory.getCurrentSession().createQuery("FROM Teorema WHERE enunciado LIKE '%c_{" + String.valueOf(idSimbolo) + "}%'").list();
    }
    
    public List<String> getAssosiativeSymmetricWithIdentOps() {
        String sql = "SELECT t1.constlist FROM Teorema as t1, Teorema as t2, Teorema as t3, PureCombsTheorem as p1, PureCombsTheorem as p2, PureCombsTheorem as p3 WHERE (p1.statement='= (\\Phi_{(bb,)} \\Phi_{bb} (\\Phi_{bbb} \\Phi_{b})) (\\Phi_{(ccb,)} \\Phi_{bb} \\Phi_{bb} \\Phi_{cbbb})' OR p1.statement='= (\\Phi_{(ccb,)} \\Phi_{bb} \\Phi_{bb} \\Phi_{cbbb}) (\\Phi_{(bb,)} \\Phi_{bb} (\\Phi_{bbb} \\Phi_{b}))') AND t1.pureCombsTheorem.id=p1.id AND p2.statement='= (\\Phi_{b} (\\Phi_{bb} \\Phi_{b})) (\\Phi_{cb} \\Phi_{cb} \\Phi_{cb})' AND t2.pureCombsTheorem.id=p2.id AND (p3.statement='= (\\Phi_{K} (\\Phi_{K} \\Phi_{})) (\\Phi_{bb} \\Phi_{b} \\Phi_{cb})' OR p3.statement='= (\\Phi_{bb} \\Phi_{b} \\Phi_{cb}) (\\Phi_{K} (\\Phi_{K} \\Phi_{}))' OR p3.statement='= (\\Phi_{K} (\\Phi_{K} \\Phi_{})) (\\Phi_{b} (\\Phi_{bb} \\Phi_{b}))' OR p3.statement='= (\\Phi_{b} (\\Phi_{bb} \\Phi_{b})) (\\Phi_{K} (\\Phi_{K} \\Phi_{}))') AND t3.pureCombsTheorem.id=p3.id AND t1.constlist=t2.constlist AND t3.constlist LIKE ('%' || t2.constlist || '%')";
        return this.sessionFactory.getCurrentSession().createQuery(sql).list();
    }
    
    public List<String> getIdentitiesOfOp(int id) {
        String sql = "SELECT t1.constlist FROM Teorema as t1, PureCombsTheorem as p1 WHERE (p1.statement='= (\\Phi_{K} (\\Phi_{K} \\Phi_{})) (\\Phi_{bb} \\Phi_{b} \\Phi_{cb})' OR p1.statement='= (\\Phi_{bb} \\Phi_{b} \\Phi_{cb}) (\\Phi_{K} (\\Phi_{K} \\Phi_{}))' OR p1.statement='= (\\Phi_{K} (\\Phi_{K} \\Phi_{})) (\\Phi_{b} (\\Phi_{bb} \\Phi_{b}))' OR p1.statement='= (\\Phi_{b} (\\Phi_{bb} \\Phi_{b})) (\\Phi_{K} (\\Phi_{K} \\Phi_{}))') AND t1.pureCombsTheorem.id=p1.id AND t1.constlist LIKE '%"+id+"%'";
        return this.sessionFactory.getCurrentSession().createQuery(sql).list();
    }
    
//	@Override
//	public List<Termino> getAllTeoremasByUser(String username)
//        {
//		return this.sessionFactory.getCurrentSession().createQuery("FROM Termino WHERE usuario.login = :username").setParameter("username",username).list();
//	}

//    private static class TeoremaException extends Exception
//    {
//
//        public String alias;
//                
//        public TeoremaException(String ali) 
//        {
//            alias=ali;
//        }
//    }
}
