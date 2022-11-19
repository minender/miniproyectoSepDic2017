package com.calclogic.dao;

import com.calclogic.entity.Teoria;
import com.calclogic.entity.Incluye;
import java.util.List;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

@Repository
public class IncluyeDaoImpl implements IncluyeDAO {
    
    @Autowired
    private SessionFactory sessionFactory;
    
    @Override
    @Transactional
    public void addIncluye(Incluye incluye){
        this.sessionFactory.getCurrentSession().save(incluye);
    }
    
    @Override
    @Transactional
    public void deleteIncluye(Incluye incluye) {
        if (null != incluye) {
        	this.sessionFactory.getCurrentSession().delete(incluye);
        }
    }

    public Incluye getIncluye(Teoria padre, Teoria hijo) {
        return (Incluye) this.sessionFactory.getCurrentSession().createQuery("FROM Incluye WHERE padreid = :padreid AND hijoid = :hijoid").setParameter("padreid", padre.getId()).setParameter("hijoid", hijo.getId()).list().get(0);
    }
    
    public List<Incluye> getAllIncluye() {
        return this.sessionFactory.getCurrentSession().createQuery("FROM Incluye").list();
    }
  
    public List<Incluye> getAllIncluyeByPadre(Teoria padre) {
        return this.sessionFactory.getCurrentSession().createQuery("FROM Incluye WHERE padreid = :padreid").setParameter("padreid", padre.getId()).list();
    }
    
    public List<Incluye> geAlltIncluyeByHijo(Teoria hijo) {
        return this.sessionFactory.getCurrentSession().createQuery("FROM Incluye WHERE hijoid = :hijoid").setParameter("hijoid", hijo.getId()).list();
    }
}