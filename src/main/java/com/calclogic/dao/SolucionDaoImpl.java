package com.calclogic.dao;

import com.calclogic.entity.Solucion;
import com.calclogic.entity.Teorema;
import java.util.ArrayList;
import java.util.List;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

/**
 * This class has the implementation of the database queries that 
 * have to do with the table "Solucion".
 *
 * The entries of that table has the solutions (or attempted solutions)
 * to the demonstrations of theorems.
 *
 * @author miguel
 */

@Repository
public class SolucionDaoImpl implements SolucionDAO{
    
    @Autowired
    private SessionFactory sessionFactory;
    
    /** 
     * Adds a new Solucion object to the table.
     * This query is made using standard Hibernate library functions.
     * @param solucion The new Solucion object to be added.
     * @return Nothing.
     */  
    @Override   
    @Transactional
    public void addSolucion(Solucion solucion){
        this.sessionFactory.getCurrentSession().save(solucion);
    }
    
    /**
     * Updates one of the Solucion objects of the table.
     * This query is made using standard Hibernate library functions.
     * @param solucion Is the Solucion object to be updated.
     * @return Nothing.
     */   
    @Override   
    @Transactional
    public void updateSolucion(Solucion solucion){
        this.sessionFactory.getCurrentSession().update(solucion);
    }

    /**
     * Deletes one of the Solucion objects of the table.
     * This query is made using standard Hibernate library functions.
     * @param id Is the principal key of the Solucion object to delete.
     * @return Nothing.
     */  
    @Override
    @Transactional
    public void deleteSolucion(int id){
        Solucion solucion = (Solucion) sessionFactory.getCurrentSession().load(
				Solucion.class, id);
        if (null != solucion) {
        	this.sessionFactory.getCurrentSession().delete(solucion);
        }
    } // Si es la unica solucion, debe definirse como "Blank"
    
    /**
     * Method to get a Solucion object by its principal key.
     * This query is made using standard Hibernate library functions.
     * @param id Is the principal key of the Solucion object.
     */ 
    @Override
    @Transactional
    public Solucion getSolucion(int id){
        return (Solucion)this.sessionFactory.getCurrentSession().get(Solucion.class,id);
    }
    
    /**
     * Method to get a list of all the entries of the table that correspond 
     * to solutions of demonstrations using axioms.
     * This query is made using HQL (Hibernate Query Language).
     * @param resuelveId Is the identifier of the Resuelve object used to filter the search.
     */
    @Override
    @Transactional
    public List<Solucion> solutionsWithAxiom(int idTeo){
        return this.sessionFactory.getCurrentSession()
                .createQuery("SELECT s FROM Solucion s, Teorema t WHERE t.id = :idTeo AND s.demostracion LIKE '%A^{' || t.enunciado || '}%'").setParameter("idTeo",idTeo).list();
    }
    
    /**
     * Method to get a list of all the entries of the table that correspond 
     * to a specific Resuelve object.
     * This query is made using HQL (Hibernate Query Language).
     * @param resuelveId Is the identifier of the Resuelve object used to filter the search.
     */
    @Override
    @Transactional
    public List<Solucion> getAllSolucionesByResuelve(int resuelveId){
        return this.sessionFactory.getCurrentSession().createQuery("FROM Solucion WHERE resuelve.id = :resuelveId").setParameter("resuelveId",resuelveId).list();
    }
    
    @Override
    @Transactional
    public List<Solucion> getAllSolucionesWithTeorema(List<Teorema> teoremas){
        if (teoremas.size() == 0) {
            return new ArrayList<Solucion>();
        }
        String statements = "";
        for (Teorema t: teoremas) {
            String dem = t.getEnunciado();
            String statement = "demostracion LIKE '%A^{" + dem + "}%'";
            if (statements == "") {
                statements = statement;
            }
            else {
                statements = statements + " OR " + statement;
            }
        }
        String queryStr = "FROM Solucion WHERE " + statements;
        //System.out.println(queryStr);
        return this.sessionFactory.getCurrentSession().createQuery(queryStr).list();
    }
    
    /**
     * Method to get a list of the identifiers of all the entries of the table 
     * that correspond to a specific Resuelve object.
     * This query is made using HQL (Hibernate Query Language).
     * @param resuelveId Is the identifier of the Resuelve object used to filter the search.
     */
    @Override
    @Transactional
    public List<Integer> getAllSolucionesIdByResuelve(int resuelveId){
        return this.sessionFactory.getCurrentSession().createQuery("Select id FROM Solucion WHERE resuelveid = :resuelveId and resuelto = 't' ORDER BY id").setParameter("resuelveId",resuelveId).list();
    }
    
    /**
     * Method to get a list of the identifiers of all the entries of the table 
     * that correspond to a specific Resuelve object, and that refer to an incomplete solution.
     * This query is made using HQL (Hibernate Query Language).
     * @param resuelveId Is the identifier of the Resuelve object used to filter the search.
     */  
    @Override
    @Transactional
    public List<Integer> getIncompleteSolucionIdByResuelve(int resuelveId){
        return this.sessionFactory.getCurrentSession().createQuery("Select id FROM Solucion WHERE resuelveid = :resuelveId and resuelto = 'f' ").setParameter("resuelveId",resuelveId).list();
    }
}
