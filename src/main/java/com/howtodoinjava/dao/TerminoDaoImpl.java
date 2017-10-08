/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.howtodoinjava.dao;

import com.howtodoinjava.entity.Termino;
import com.howtodoinjava.entity.TerminoId;
import java.util.List;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

/**
 *
 * @author federico
 */
@Repository
public class TerminoDaoImpl implements TerminoDAO{
        
        @Autowired
        private SessionFactory sessionFactory;
	
	@Override
	public void addTermino(Termino termino) {
           
		this.sessionFactory.getCurrentSession().save(termino);
	}
        
        @SuppressWarnings("unchecked")
        @Override
	public Termino getTermino(TerminoId id){
            return (Termino)this.sessionFactory.getCurrentSession().get(Termino.class,id);
        }

	@Override
	public void deleteTermino(TerminoId id) {
		Termino termino = (Termino) sessionFactory.getCurrentSession().load(
				Termino.class, id);
        if (null != id) {
        	this.sessionFactory.getCurrentSession().delete(termino);
        }
	}
        
        @SuppressWarnings("unchecked")
	@Override
        public Termino getCombinador(String username, String comb)
        {
            String sql="FROM Termino WHERE combinador = :comb and id.login = :username";
            List<Termino> list= this.sessionFactory.getCurrentSession().createQuery(sql).setParameter("comb",comb).setParameter("username", username).list();
            if(list.isEmpty())
                return null;
            else
                return list.get(0);
        }
        
        @SuppressWarnings("unchecked")
	@Override
	public List<Termino> getAllTerminos() {
		return this.sessionFactory.getCurrentSession().createQuery("FROM Termino").list();
	}
        
        @SuppressWarnings("unchecked")
	@Override
	public List<Termino> getAllTerminos(String username) 
        {
		return this.sessionFactory.getCurrentSession().createQuery("FROM Termino WHERE usuario.login = :username").setParameter("username",username).list();
	}
        
        @SuppressWarnings("unchecked")
	@Override
        public List<Termino> getAllPublicaciones(String username)
        {
                String publico="publico";
                return this.sessionFactory.getCurrentSession().createQuery("select ter FROM Termino ter, Publicacion publ WHERE publ.id.login = :username AND publ.id.alias = ter.id.alias AND ter.usuario.login = :publico").setParameter("username",username).setParameter("publico",publico).list();
        }
}
