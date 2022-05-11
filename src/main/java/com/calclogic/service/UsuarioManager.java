package com.calclogic.service;

import com.calclogic.entity.Teorema;
import com.calclogic.entity.Usuario;
import java.util.List;

/**
 * This interface is the use of the "UsuarioDAO" 
 * API in this application.
 */
public interface UsuarioManager {
	
    /** 
     * Adds a new user to the table.
     * @param usuario The new user to be added.
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
     * Method to get a list of all the entries of the table (all the users).
     */
    public List<Usuario> getAllUsuarios();
	
    /**
     * Method to get a specific user.
     * @param login Is the string with which the user logs in, and that we use to filter the search.
     */
    public Usuario getUsuario(String login);
	
    /**
     * Deletes one of the users of the table.
     * @param usuarioId Is the principal key of the user to delete.
     * @return Nothing.
     */ 
    public void deleteUsuario(Integer usuarioId);
	
    /**
     * Deletes one of the theorems from the list of those that correspond
	 * to a specific user.
     * @param usuario Is user whose theorem will be the deleted.
	 * @param teorema Theorem to be deleted.
     * @return Nothing.
     */ 
    //public void deleteTeorema(Usuario usuario, Teorema teorema);
	
    /**
     * Method to get a list of all the theorems that correspond to a specific user.
	 * @param usuario Is the user whose theorems will be returned.
     */
    public List<Teorema> getAllTeoremas(Usuario usuario);
	
    /**
     * Method to get a list of all entries of the table that represent students, that is,
     * users that are not administrators.
     */
    public List<Usuario> getStudents();
}
