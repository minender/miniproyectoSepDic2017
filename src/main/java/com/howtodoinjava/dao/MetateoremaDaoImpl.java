/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.howtodoinjava.dao;

import com.howtodoinjava.entity.Metateorema;
import java.util.List;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

/**
 *
 * @author miguel
 */

@Repository
public class MetateoremaDaoImpl implements MetateoremaDAO {
        
    
        @Autowired
        private SessionFactory sessionFactory;
	
	@Override
	public void addMetateorema(Metateorema metateorema) {
		this.sessionFactory.getCurrentSession().save(metateorema);
	}
        
        
	@Override
	public void deleteMetateorema(int id) {
            Metateorema metateorema = (Metateorema )sessionFactory.getCurrentSession().load(
                                Metateorema.class, id);
            if (null != metateorema) {
                    this.sessionFactory.getCurrentSession().delete(metateorema);
            }
	}
        
        @Override
	public Metateorema getMetateorema(int id){
            return (Metateorema)this.sessionFactory.getCurrentSession().get(Metateorema.class,id);
        }
        
        
	@Override
	public List<Metateorema> getAllMetateoremas() {
//            Aqui hay q colocar un select distinct
            return this.sessionFactory.getCurrentSession().createQuery("FROM Metateorema").list();
	}
        
	@Override
        public Metateorema getMetateoremaByEnunciados(String enunciado){
            
            String sql="FROM Metateorema WHERE enunciado = :enunciado";
            List<Metateorema> list = this.sessionFactory.getCurrentSession().createQuery(sql).setParameter("enunciado",enunciado).list();
           
            if(list.isEmpty()) {
                return null;
            } else {
                return list.get(0);
            }
        }

}
