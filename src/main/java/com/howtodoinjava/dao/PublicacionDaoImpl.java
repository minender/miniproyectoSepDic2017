/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.howtodoinjava.dao;

import com.howtodoinjava.entity.Publicacion;
import com.howtodoinjava.entity.PublicacionId;
import java.util.List;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

/**
 *
 * @author federico
 */
@Repository
public class PublicacionDaoImpl implements PublicacionDAO{

    @Autowired
    private SessionFactory sessionFactory;
    
    @Override
    public void addPublicacion(Publicacion publicacion) {
        this.sessionFactory.getCurrentSession().save(publicacion);
    }

    @Override
    public void deletePublicacion(PublicacionId id) {
        Publicacion publicacion = (Publicacion) sessionFactory.getCurrentSession().load(
				Publicacion.class, id);
        if (null != id) {
        	this.sessionFactory.getCurrentSession().delete(publicacion);
        }
    }

    @SuppressWarnings("unchecked")
    @Override
    public Publicacion getPublicacion(PublicacionId id) {
        return (Publicacion)this.sessionFactory.getCurrentSession().get(Publicacion.class,id);
    }

    @SuppressWarnings("unchecked")
    @Override
    public List<Publicacion> getAllPublicaciones() {
        return this.sessionFactory.getCurrentSession().createQuery("FROM Publicaciones").list();
    }

    @SuppressWarnings("unchecked")
    @Override
    public List<Publicacion> getAllPublicaciones(String username) {
        return this.sessionFactory.getCurrentSession().createQuery("FROM Publicaciones WHERE usuario.login = :username").setParameter("username",username).list();
    }
    
}
