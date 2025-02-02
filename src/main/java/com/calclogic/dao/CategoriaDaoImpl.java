package com.calclogic.dao;

import com.calclogic.entity.Categoria;
import com.calclogic.entity.Teoria;
import java.util.List;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;

/**
 * This class has the implementation of the database queries that 
 * have to do with the table "Categoria". 
 *
 * @author miguel
 */
public class CategoriaDaoImpl implements CategoriaDAO {
    
    @Autowired
    private SessionFactory sessionFactory;
    
    /** 
	 * Adds a new Categoria to the system.
	 * This query is made using standard Hibernate library functions.
	 * @param categoria The new category to add.
	 * @return Nothing.
	 */
    @Override   
    public void addCategoria(Categoria categoria){
        this.sessionFactory.getCurrentSession().save(categoria);
    }
    
	/**
	 * Deletes one of the Categoria objects of the system.
	 * This query is made using standard Hibernate library functions.
	 * @param id Is the principal key of the category to delete.
	 * @return Nothing.
	 */
    @Override
    public void deleteCategoria(int id) {
        Categoria categoria = (Categoria) sessionFactory.getCurrentSession().load(
                            Categoria.class, id);
        if (null != categoria) {
            this.sessionFactory.getCurrentSession().delete(categoria);
        }
    }
    
	/**
	 * Method to get a category by its principal key.
	 * This query is made using standard Hibernate library functions.
	 * @param id Is the principal key of the category.
	 */
    @Override
    public Categoria getCategoria(int id){
        return (Categoria)this.sessionFactory.getCurrentSession().get(Categoria.class, id);
    }
    
	/**
	 * Method to get a list of all categories available in the system.
	 * This query is made using HQL (Hibernate Query Language).
	 */
    @Override
    public List<Categoria> getAllCategorias(){
        return this.sessionFactory.getCurrentSession().createQuery("FROM Categoria order by id").list();
    }
    
    @Override
    public List<Categoria> getAllCategoriasByTeoria(Teoria teoria){
        //return this.sessionFactory.getCurrentSession().createQuery("FROM Categoria order by id").list();
        return this.sessionFactory.getCurrentSession().createQuery("FROM Categoria WHERE teoriaid = :teoriaId OR EXISTS (SELECT i.id.padre FROM Incluye i WHERE i.id.padre.id = teoriaid AND i.id.hijo.id = :teoriaId) order by id").setParameter("teoriaId", teoria.getId()).list();
    }
}
