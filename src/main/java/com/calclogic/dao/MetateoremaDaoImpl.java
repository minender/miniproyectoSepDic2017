package com.calclogic.dao;

import com.calclogic.entity.Metateorema;
import java.util.List;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

/**
 * This class has the implementation of the database queries that 
 * have to do with the table "Metateorema". 
 *
 * >>> Unused for the moment.
 *
 * @author miguel
 */
@Repository
public class MetateoremaDaoImpl implements MetateoremaDAO {
    
    @Autowired
    private SessionFactory sessionFactory;
    
    /** 
     * Adds a new metatheorem to the table.
     * This query is made using standard Hibernate library functions.
     * @param metateorema The new matatheorem to be added.
     * @return Nothing.
     */
    @Override
    public void addMetateorema(Metateorema metateorema) {
        this.sessionFactory.getCurrentSession().save(metateorema);
    }
        
    /**
     * Deletes one of the metatheorems of the table.
     * This query is made using standard Hibernate library functions.
     * @param id Is the principal key of the metatheorem to delete.
     * @return Nothing.
     */   
    @Override
    public void deleteMetateorema(int id) {
            Metateorema metateorema = (Metateorema )sessionFactory.getCurrentSession().load(
                                       Metateorema.class, id);
            if (null != metateorema) {
                this.sessionFactory.getCurrentSession().delete(metateorema);
            }
    }

    /**
     * Method to get a metatheorem by its principal key.
     * This query is made using standard Hibernate library functions.
     * @param id Is the principal key of the metatheorem.
     */  
    @Override
    public Metateorema getMetateorema(int id){
        return (Metateorema)this.sessionFactory.getCurrentSession().get(Metateorema.class,id);
    }
        
    /**
     * Method to get a list of all the entries of the table (all the metatheorems).
     * This query is made using classic SQL.
     */
    @Override
    public List<Metateorema> getAllMetateoremas() {
        // NOTA: Aqui hay que colocar un select distinct
        return this.sessionFactory.getCurrentSession().createQuery("FROM Metateorema").list();
    }
        
    /**
     * Method to get a metatheorem that corresponds to a statement.
     * This query is made using classic SQL.
     * @param enunciado Is the statement used to filter the search.
     */
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
