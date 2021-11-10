package com.calclogic.dao;

import com.calclogic.controller.PerfilController;
import com.calclogic.entity.Teorema;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

/**
 * This class has the implementation of the database queries that 
 * have to do with the table "Teorema".
 *
 * That table has all the theorems that have been added to the
 * application.
 *
 * @author miguel
 */
@Repository
public class TeoremaDaoImpl implements TeoremaDAO {

    @Autowired
    private SessionFactory sessionFactory;

    /** 
     * Adds a new theorem to the table.
     * This query is made using standard Hibernate library functions.
     * @param teorema The new theorem to be added.
     * @return Nothing.
     */
    @Override
    public void addTeorema(Teorema teorema) {

        this.sessionFactory.getCurrentSession().save(teorema);

    }

    /**
     * Deletes one of the theorems of the table.
     * This query is made using standard Hibernate library functions.
     * @param id Is the principal key of the theorem to delete.
     * @return Nothing.
     */ 
    @Override
    public void deleteTeorema(int id) {
        Teorema teorema = (Teorema) sessionFactory.getCurrentSession().load(
                Teorema.class, id);
        if (null != teorema) {
            this.sessionFactory.getCurrentSession().delete(teorema);
        }
    }

    /**
     * Method to get a theorem by its principal key.
     * This query is made using standard Hibernate library functions.
     * @param id Is the principal key of the theorem.
     */
    @Override
    public Teorema getTeorema(int id) {
        return (Teorema) this.sessionFactory.getCurrentSession().get(Teorema.class, id);
    }

    /**
     * Method to get a list of all the entries of the table (all the theorems).
     * This query is made using HQL (Hibernate Query Language).
     */
    @Override
    public List<Teorema> getAllTeoremas() {
        // Aqui hay q colocar un select distinct
        return this.sessionFactory.getCurrentSession().createQuery("FROM Teorema").list();
    }

    /**
     * Method to get a theorem that corresponds to a statement.
     * This query is made using HQL (Hibernate Query Language).
     * @param enunciado Is the statement used to filter the search.
     */
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
