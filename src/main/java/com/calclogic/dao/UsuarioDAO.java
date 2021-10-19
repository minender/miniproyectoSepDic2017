package com.calclogic.dao;

import java.util.List;
import com.calclogic.entity.Usuario;

/**
 * This interface is the API of the database queries that 
 * have to do with the table "Usuario". 
 *
 * That table has all the users who have registered in the system,
 * including their logins, encrypted passwords and a boolean that
 * indicates if the user activated the "automatic substitution".
 */
public interface UsuarioDAO {

    /** 
     * Adds a new user to the table.
     * @param usuario The new usuario to be added.
     * @return Nothing.
     */
    public void addUsuario(Usuario usuario);

    /**
     * Updates one of the users of the table.
     * @param usuario Is the user to be updated.
     * @return Nothing.
     */ 
    public void updateUsuario(Usuario usuario);

    /**
     * Deletes one of the users of the table.
     * @param usuarioId Is the principal key of the user to delete.
     * @return Nothing.
     */ 
    public void deleteUsuario(Integer usuarioId);
    
    /**
     * Method to get a list of all the entries of the table (all the users).
     */
    public List<Usuario> getAllUsuarios();

    /**
     * Method to get a specific user.
     * @param login Is the string with which the user logs in, and that we use to filter the search.
     */
    public Usuario getUsuario(String login);

    /**
     * Method to get a list of all entries of the table that represent students, that is,
     * users that are not administrators.
     */
    public List<Usuario> getStudents();
}
