/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.howtodoinjava.dao;

import com.howtodoinjava.entity.Resuelve;
import com.howtodoinjava.entity.Teorema;
import com.howtodoinjava.lambdacalculo.Term;
import java.util.List;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.SerializationUtils;

/**
 *
 * @author miguel
 */
@Repository
public class ResuelveDaoImpl implements ResuelveDAO {
    
    @Autowired
    private SessionFactory sessionFactory;
    
    
    @Override   
    @Transactional
    public void addResuelve(Resuelve resuelve){
        this.sessionFactory.getCurrentSession().save(resuelve);
    }
    
    @Override   
    @Transactional
    public void updateResuelve(Resuelve resuelve){
        this.sessionFactory.getCurrentSession().update(resuelve);
    }
        
    @Override
    @Transactional
    public void deleteResuelve(int id){
        Resuelve resuelve = (Resuelve) sessionFactory.getCurrentSession().load(
				Resuelve.class, id);
        if (null != resuelve) {
        	this.sessionFactory.getCurrentSession().delete(resuelve);
        }
    }
    
    @Override
    @Transactional
    public Resuelve getResuelve(int id){
        return (Resuelve)this.sessionFactory.getCurrentSession().get(Resuelve.class,id);
    }
    
    
    @Override
    @Transactional
    public List<Resuelve> getAllResuelve(){
        return this.sessionFactory.getCurrentSession().createQuery("FROM Resuelve").list();
    }
    
    @Override
    @Transactional
    public List<Resuelve> getAllResuelveByUser(String userLogin){
        return this.sessionFactory.getCurrentSession().createQuery("FROM Resuelve WHERE usuario.login = :userLogin order by numeroteorema").setParameter("userLogin",userLogin).list();

    }
    @Override
    @Transactional
    public List<Resuelve> getAllResuelveByUserResuelto(String userLogin){
        return this.sessionFactory.getCurrentSession().createQuery("FROM Resuelve WHERE usuario.login = :userLogin AND resuelto = true").setParameter("userLogin",userLogin).list();
    }
    
    @Override
    @Transactional
    public List<Resuelve> getResuelveByTeorema(int teoremaID){
        return this.sessionFactory.getCurrentSession().createQuery("FROM Resuelve WHERE teorema.id = :teoremaID").setParameter("teoremaID",teoremaID).list();
    }
    
    @Override
    @Transactional
    public Resuelve getResuelveByUserAndTeorema(String userLogin,int teoremaID){

        String sql = "FROM Resuelve WHERE teorema.id = :teoremaID AND usuario.login = :userLogin";
        List<Resuelve> list = this.sessionFactory.getCurrentSession().createQuery(sql).setParameter("teoremaID",teoremaID).setParameter("userLogin",userLogin).list();
    
        if (list.isEmpty()) {
            return null;
        } else {
            return list.get(0);
        }
    }
    
    @Override
    @Transactional
    public Resuelve getResuelveByUserAndTeorema(String userLogin,String teo){
        String sql = "FROM Resuelve WHERE teorema.enunciado = :teo AND usuario.login = :userLogin";
        List<Resuelve> list = this.sessionFactory.getCurrentSession().createQuery(sql).setParameter("teo",teo).setParameter("userLogin",userLogin).list();
    
        if (list.isEmpty()) {
            return null;
        } else {
            return list.get(0);
        }
    }
    
    @Override
    @Transactional
    public Resuelve getResuelveByUserAndTeoNum(String userLogin,String teoNum){
        String sql = "FROM Resuelve WHERE numeroteorema = :teoNum AND usuario.login = :userLogin";
        List<Resuelve> list = this.sessionFactory.getCurrentSession().createQuery(sql).setParameter("teoNum",teoNum).setParameter("userLogin",userLogin).list();
    
        if (list.isEmpty()) {
            return null;
        } else {
            return list.get(0);
        }
    }

    @Override
    public List<Resuelve> getResuelveByCategoria(int categoriaId) {
        return this.sessionFactory.getCurrentSession().createQuery("FROM Resuelve WHERE categoria.id = :categoriaId").setParameter("categoriaId", categoriaId).list();
    }
        
}
