package com.calclogic.dao;

import com.calclogic.entity.Materia;
import java.util.List;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;

/**
 * This class has the implementation of the database queries that 
 * have to do with the table "Materia". 
 *
 * @author federico
 */
public class MateriaDaoImpl implements MateriaDAO{

    @Autowired
    private SessionFactory sessionFactory;

    /** 
     * Adds a new subject to the table.
     * This query is made using standard Hibernate library functions.
     * @param materia The new Materia object to be added.
     * @return Nothing.
     */
    @Override   
    public void addMateria(Materia materia){
        this.sessionFactory.getCurrentSession().save(materia);
    }
    
    /**
     * Deletes one of the subjects of the table.
     * This query is made using standard Hibernate library functions.
     * @param id Is the principal key of the subject to delete.
     * @return Nothing.
     */ 
    @Override
    public void deleteMateria(int id) {
        Materia materia = (Materia) sessionFactory.getCurrentSession().load(
                            Materia.class, id);
        if (null != materia) {
            this.sessionFactory.getCurrentSession().delete(materia);
        }
    }
    
    /**
     * Method to get a subject by its principal key.
     * This query is made using standard Hibernate library functions.
     * @param id Is the principal key of the subject.
     */
    @Override
    public Materia getMateria(int id){
        return (Materia)this.sessionFactory.getCurrentSession().get(Materia.class, id);
    }
    
    /**
     * Method to get a list of all the entries of the table (all the subjects).
     * This query is made using HQL (Hibernate Query Language).
     */
    @Override
    public List<Materia> getAllMaterias(){
        return this.sessionFactory.getCurrentSession().createQuery("FROM Materia").list();
    }
}
