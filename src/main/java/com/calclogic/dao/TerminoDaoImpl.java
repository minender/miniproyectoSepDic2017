package com.calclogic.dao;

import com.calclogic.entity.Termino;
import com.calclogic.entity.TerminoId;
import java.util.List;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

/**
 * This class has the implementation of the database queries that 
 * have to do with the table "Termino".
 *
 * That table has all the terms that have been added to the
 * application, indicating their respective owner users.
 *
 * @author federico
 */
@Repository
public class TerminoDaoImpl implements TerminoDAO{
        
    @Autowired
    private SessionFactory sessionFactory;
   
    /** 
     * Adds a new term to the table.
     * This query is made using standard Hibernate library functions.
     * @param termino The new term to be added.
     * @return Nothing.
     */ 
    @Override
    public void addTermino(Termino termino) {  
        this.sessionFactory.getCurrentSession().save(termino);
    }

    /**
     * Deletes one of the terms of the table.
     * This query is made using standard Hibernate library functions.
     * @param id Is the principal key of the term to delete.
     * @return Nothing.
     */
    @Override
    public void deleteTermino(TerminoId id) {
        Termino termino = (Termino) sessionFactory.getCurrentSession().load(
                Termino.class, id);
        if (null != id) {
            this.sessionFactory.getCurrentSession().delete(termino);
        }
    }

    /**
     * Method to get a term by its principal key.
     * This query is made using standard Hibernate library functions.
     * @param id Is the principal key of the term.
     */
    @SuppressWarnings("unchecked")
    @Override
    public Termino getTermino(TerminoId id){
        return (Termino)this.sessionFactory.getCurrentSession().get(Termino.class,id);
    }

    /**
     * Method to get a list of all the entries of the table (all the terms).
     * This query is made using HQL (Hibernate Query Language).
     */
    @SuppressWarnings("unchecked")
    @Override
    public List<Termino> getAllTerminos() {
        return this.sessionFactory.getCurrentSession().createQuery("FROM Termino").list();
    }

    /**
     * Method to get a list of all the entries of the table that correspond to a specific user.
     * This query is made using HQL (Hibernate Query Language).
     * @param username Is the string with which the user logs in, and that we use to filter the search.
     */
    @SuppressWarnings("unchecked")
    @Override
    public List<Termino> getAllTerminos(String username) 
        {
        return this.sessionFactory.getCurrentSession().createQuery("FROM Termino WHERE usuario.login = :username").setParameter("username",username).list();
    }

    /**
     * Method to get a list of all the entries of the table that correspond to a specific user,
     * and that have a specific "combinador" attribute.
     * This query is made using HQL (Hibernate Query Language).
     * @param username Is the string with which the user logs in, and that we use to filter the search.
     * @param comb Is the "combinador" attribute used to filter the search.
     */
    @SuppressWarnings("unchecked")
    @Override
    public Termino getCombinador(String username, String comb){
        String sql="FROM Termino WHERE combinador = :comb and id.login = :username";
        List<Termino> list= this.sessionFactory.getCurrentSession().createQuery(sql).setParameter("comb",comb).setParameter("username", username).list();
        if(list.isEmpty())
            return null;
        else
            return list.get(0);
    }
   
    /**
     * Method to get a list of all the entries of the table that correspond to a specific user,
     * and in which that user has made public the term.
     * This query is made using HQL (Hibernate Query Language).
     * @param username Is the string with which the user logs in, and that we use to filter the search.
     */     
    @SuppressWarnings("unchecked")
    @Override
    public List<Termino> getAllPublicaciones(String username){
        String publico="publico";
        return this.sessionFactory.getCurrentSession().createQuery("select ter FROM Termino ter, Publicacion publ WHERE publ.id.login = :username AND publ.id.alias = ter.id.alias AND ter.usuario.login = :publico").setParameter("username",username).setParameter("publico",publico).list();
    }
}
