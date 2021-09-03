package com.calclogic.dao;

import com.calclogic.entity.Dispone;
import java.util.List;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

/**
 * This class has the implementation of the database queries that 
 * have to do with the table "Dispone". 
 *
 * That table implements the relation between the users and
 * the metatheorems that they have.
 *
 * @author miguel
 */
@Repository
public class DisponeDaoImpl implements DisponeDAO {

    @Autowired
    private SessionFactory sessionFactory;

    /** 
     * Adds a new entry to the table.
     * This query is made using standard Hibernate library functions.
     * @param dispone The new Dispone object to add.
     * @return Nothing.
     */
    @Override
    @Transactional
    public void addDispone(Dispone dispone) {
        this.sessionFactory.getCurrentSession().save(dispone);
    }

    /**
     * Deletes one of the entries of the table.
     * This query is made using standard Hibernate library functions.
     * @param id Is the principal key of the entry to delete.
     * @return Nothing.
     */
    @Override
    @Transactional
    public void deleteDispone(int id) {
        Dispone dispone = (Dispone) sessionFactory.getCurrentSession().load(
                Dispone.class, id);
        if (null != dispone) {
            this.sessionFactory.getCurrentSession().delete(dispone);
        }
    }

    /**
     * Method to get a Dispone object by its principal key.
     * This query is made using standard Hibernate library functions.
     * @param id Is the principal key of the Dispone object.
     */
    @Override
    @Transactional
    public Dispone getDispone(int id) {
//        Dispone r = new Dispone((Dispone)this.sessionFactory.getCurrentSession().get(Dispone.class,id));
//        return r; 
        return (Dispone) this.sessionFactory.getCurrentSession().get(Dispone.class, id);
    }

    /**
     * Method to get a list of all the entries of the table.
     * This query is made using HQL (Hibernate Query Language).
     */
    @Override
    @Transactional
    public List<Dispone> getAllDispone() {
        return this.sessionFactory.getCurrentSession().createQuery("FROM Dispone").list();
    }

    /**
     * Method to get a list of all the entries of the table that correspond to a specific user.
     * This query is made using HQL (Hibernate Query Language).
     * @param userLogin Is the string with which the user logs in, and that we use to filter the search.
     */
    @Override
    @Transactional
    public List<Dispone> getAllDisponeByUser(String userLogin) {
        return this.sessionFactory.getCurrentSession().createQuery("FROM Dispone WHERE usuario.login = :userLogin").setParameter("userLogin", userLogin).list();
    }

    /**
     * Method to get a list of all the entries of the table that correspond to a specific metatheorem.
     * This query is made using HQL (Hibernate Query Language).
     * @param meateoremaID Is the principal key of the Metateorema table, with which we filter the search.
     */
    @Override
    @Transactional
    public List<Dispone> getDisponeByMetateorema(int metateoremaID) {
        return this.sessionFactory.getCurrentSession().createQuery("FROM Dispone WHERE metateorema.id = :metateoremaID").setParameter("metateoremaID", metateoremaID).list();
    }

    /**
     * Method to get the entry of the table that relates a user with a metatheorem, using the principal 
     * key of the metatheorem.
     * This query is made using HQL (Hibernate Query Language).
     * @param userLogin Is the string with which the user logs in, and that we use to filter the search.
     * @param meateoremaID Is the principal key of the Metateorema table, with which we filter the search.
     */
    @Override
    @Transactional
    public Dispone getDisponeByUserAndMetaeorema(String userLogin, int metateoremaID) {

        String sql = "FROM Dispone WHERE metateorema.id = :metateoremaID AND usuario.login = :userLogin";
        List<Dispone> list = this.sessionFactory.getCurrentSession().createQuery(sql).setParameter("metateoremaID", metateoremaID).setParameter("userLogin", userLogin).list();

        if (list.isEmpty()) {
            return null;
        } else {
            return list.get(0);
        }
    }
    
    /**
     * Method to get the entry of the table that relates a user with a metatheorem, using the string
     * that represents to the metatheorem.
     * This query is made using HQL (Hibernate Query Language).
     * @param userLogin Is the string with which the user logs in, and that we use to filter the search.
     * @param meateorema Is the string that represents the metatheorem, with which we filter the search.
     */
    @Override
    @Transactional
    public Dispone getDisponeByUserAndMetaeorema(String userLogin, String metateorema){
        String sql = "FROM Dispone WHERE metateorema.enunciado = :metateorema AND usuario.login = :userLogin";
        List<Dispone> list = this.sessionFactory.getCurrentSession().createQuery(sql).setParameter("metateorema", metateorema).setParameter("userLogin", userLogin).list();

        if (list.isEmpty()) {
            return null;
        } else {
            return list.get(0);
        }
    }
    
    /**
     * Method to get the entry of the table that relates a user with a metatheorem, using the number
     * of the metatheorem.
     * This query is made using HQL (Hibernate Query Language).
     * @param userLogin Is the string with which the user logs in, and that we use to filter the search.
     * @param metateoNum Is the number of the metatheorem, with which we filter the search.
     */
    @Override
    @Transactional
    public Dispone getDisponeByUserAndTeoNum(String userLogin,String metateoNum){
        String sql = "FROM Dispone WHERE numerometateorema = :metateoNum AND usuario.login = :userLogin";
        List<Dispone> list = this.sessionFactory.getCurrentSession().createQuery(sql).setParameter("metateoNum",metateoNum).setParameter("userLogin",userLogin).list();
    
        if (list.isEmpty()) {
            return null;
        } else {
            return list.get(0);
        }
    }    
}
