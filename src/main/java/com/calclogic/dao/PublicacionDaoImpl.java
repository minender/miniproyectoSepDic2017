package com.calclogic.dao;

import com.calclogic.entity.Publicacion;
import com.calclogic.entity.PublicacionId;
import java.util.List;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

/**
 * This class has the implementation of the database queries that 
 * have to do with the table "Publicacion".
 *
 * >>> This must be removed.
 *
 * @author federico
 */
@Repository
public class PublicacionDaoImpl implements PublicacionDAO{

    @Autowired
    private SessionFactory sessionFactory;
    
    /** 
     * Adds a new Publicacion object to the table.
     * This query is made using standard Hibernate library functions.
     * @param publicacion The new Predicado object to be added.
     * @return Nothing.
     */
    @Override
    public void addPublicacion(Publicacion publicacion) {
        this.sessionFactory.getCurrentSession().save(publicacion);
    }

    /**
     * Deletes one of the Publicacion objects of the table.
     * This query is made using standard Hibernate library functions.
     * @param id Is the principal key of the Publicacion object to delete.
     * @return Nothing.
     */ 
    @Override
    public void deletePublicacion(PublicacionId id) {
        Publicacion publicacion = (Publicacion) sessionFactory.getCurrentSession().load(
				Publicacion.class, id);
        if (null != id) {
        	this.sessionFactory.getCurrentSession().delete(publicacion);
        }
    }

    /**
     * Method to get a Publicacion object by its principal key.
     * This query is made using standard Hibernate library functions.
     * @param id Is the principal key of the Publicacion object.
     */  
    @SuppressWarnings("unchecked")
    @Override
    public Publicacion getPublicacion(PublicacionId id) {
        return (Publicacion)this.sessionFactory.getCurrentSession().get(Publicacion.class,id);
    }

    /**
     * Method to get a list of all the entries of the table.
     * This query is made using classic SQL.
     */
    @SuppressWarnings("unchecked")
    @Override
    public List<Publicacion> getAllPublicaciones() {
        return this.sessionFactory.getCurrentSession().createQuery("FROM Publicaciones").list();
    }

    /**
     * Method to get a list of all the entries of the table that correspond to a specific user.
     * This query is made using classic SQL.
     * @param username Is the string with which the user logs in, and that we use to filter the search.
     */
    @SuppressWarnings("unchecked")
    @Override
    public List<Publicacion> getAllPublicaciones(String username) {
        return this.sessionFactory.getCurrentSession().createQuery("FROM Publicaciones WHERE usuario.login = :username").setParameter("username",username).list();
    }
    
}
