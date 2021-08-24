package com.calclogic.dao;

import java.util.List;

import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.calclogic.entity.Usuario;

/**
 * This class has the implementation of the database queries that 
 * have to do with the table "Usuario".
 *
 * That table has all the users who have registered in the system,
 * including their logins, encrypted passwords and a boolean that
 * indicates if the user activated the "automatic substitution".
 */
@Repository
public class UsuarioDaoImpl implements UsuarioDAO  {

    @Autowired
    private SessionFactory sessionFactory;
    
    /** 
     * Adds a new user to the table.
     * This query is made using standard Hibernate library functions.
     * @param usuario The new usuario to be added.
     * @return Nothing.
     */
    @Override
    public void addUsuario(Usuario usuario) {
        this.sessionFactory.getCurrentSession().save(usuario);
    }
        
    /**
     * Updates one of the users of the table.
     * This query is made using standard Hibernate library functions.
     * @param usuario Is the user to be updated.
     * @return Nothing.
     */ 
    @Override
    public void updateUsuario(Usuario usuario) {
        this.sessionFactory.getCurrentSession().update(usuario);
    }

    /**
     * Deletes one of the users of the table.
     * This query is made using standard Hibernate library functions.
     * @param usuarioId Is the principal key of the user to delete.
     * @return Nothing.
     */ 
    @Override
    public void deleteUsuario(Integer usuarioId) {
        Usuario usuario = (Usuario) sessionFactory.getCurrentSession().load(
                            Usuario.class, usuarioId);
        if (null != usuario) {
            this.sessionFactory.getCurrentSession().delete(usuario);
        }
    }

    /**
     * Method to get a list of all the entries of the table (all the users).
     * This query is made using classic SQL.
     */
    @SuppressWarnings("unchecked")
    @Override
    public List<Usuario> getAllUsuarios() {
        return this.sessionFactory.getCurrentSession().createQuery("FROM Usuario").list();
    }
     
    /**
     * Method to get a specific user.
     * This query is made using standard Hibernate library functions.
     * @param login Is the string with which the user logs in, and that we use to filter the search.
     */       
    @SuppressWarnings("unchecked")
    @Override
    public Usuario getUsuario(String login){
        return (Usuario)this.sessionFactory.getCurrentSession().get(Usuario.class,login);
    }

    /**
     * Method to get a list of all entries of the table that represent students, that is,
     * users that are not administrators.
     * This query is made using classic SQL.
     */        
    @Override
    public List<Usuario> getStudents(){
        return this.sessionFactory.getCurrentSession().createQuery("FROM Usuario WHERE admin = 'false'").list();
    }
}
