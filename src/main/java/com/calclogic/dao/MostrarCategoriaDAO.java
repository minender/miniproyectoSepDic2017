package com.calclogic.dao;

import com.calclogic.entity.Categoria;
import com.calclogic.entity.MostrarCategoria;
import com.calclogic.entity.Usuario;
import java.util.List;

/**
 * This interface is the API of the database queries that 
 * have to do with the table "MostrarCategoria". 
 *
 * That table implements the relation between the users and
 * the categories (objects of the "Categoria" table) that they
 * can see.
 *
 * @author jt
 */
public interface MostrarCategoriaDAO {

    /** 
     * Adds a new MostrarCategoria object to the table.
     * @param MostrarCategoria The new MostrarCategoria object to be added.
     * @return Nothing.
     */
    public void addMostrarCategoria(MostrarCategoria MostrarCategoria);
    
    /**
     * Deletes one of the MostrarCategoria objects of the table.
     * @param id Is the principal key of the MostrarCategoria object to delete.
     * @return Nothing.
     */ 
    public void deleteMostrarCategoria(int id);
    
    /**
     * Method to get a MostrarCategoria object by its principal key.
     * @param id Is the principal key of the MostrarCategoria object.
     */
    public MostrarCategoria getMostrarCategoria(int id);
    
    /**
     * Method to get a list of all the entries of the table.
     */
    public List<MostrarCategoria> getAllMostrarCategorias();
  
    /**
     * Method to get a list of all the entries of the table that correspond to a specific user.
     * @param usuario Is the Usuario object used to filter the search.
     */
    public List<MostrarCategoria> getAllMostrarCategoriasByUsuario(Usuario usuario);
    
    /**
     * Method to get an entry of the table that relates a category to a user
     * @param categoria Is the Categoria object used to filter the search.
     * @param usuario Is the Usuario object used to filter the search.
     */
    public MostrarCategoria getMostrarCategoriaByCategoriaAndUsuario(Categoria categoria,Usuario usuario);
}