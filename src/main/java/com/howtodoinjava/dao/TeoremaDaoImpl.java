/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.howtodoinjava.dao;

import com.howtodoinjava.controller.PerfilController;
import com.howtodoinjava.entity.Teorema;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

/**
 *
 * @author miguel
 */
@Repository
public class TeoremaDaoImpl implements TeoremaDAO {

    @Autowired
    private SessionFactory sessionFactory;

    @Override
    public void addTeorema(Teorema teorema) {

        this.sessionFactory.getCurrentSession().save(teorema);

    }

    @Override
    public void deleteTeorema(int id) {
        Teorema teorema = (Teorema) sessionFactory.getCurrentSession().load(
                Teorema.class, id);
        if (null != teorema) {
            this.sessionFactory.getCurrentSession().delete(teorema);
        }
    }

    @Override
    public Teorema getTeorema(int id) {
        return (Teorema) this.sessionFactory.getCurrentSession().get(Teorema.class, id);
    }

    @Override
    public List<Teorema> getAllTeoremas() {
//            Aqui hay q colocar un select distinct
        return this.sessionFactory.getCurrentSession().createQuery("FROM Teorema").list();
    }

    @Override
    public Teorema getTeoremaByEnunciados(String enunciado) {

        String sql = "FROM Teorema WHERE enunciado = :enunciado";
        List<Teorema> list = this.sessionFactory.getCurrentSession().createQuery(sql).setParameter("enunciado", enunciado).list();

        if (list.isEmpty()) {
            return null;
        } else {
            return list.get(0);
        }
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
