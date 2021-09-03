package com.calclogic.service;

import com.calclogic.entity.Categoria;
import com.calclogic.entity.MostrarCategoria;
import com.calclogic.entity.Usuario;
import java.util.List;

/**
 * This interface is the use of the "MostrarCategoriaDAO" 
 * api in this application.
 * 
 * @author jt
 */
public interface MostrarCategoriaManager {
    
    /** 
     * Adds a new MostrarCategoria object to the table and then return again the object.
     * @param MostrarCategoria The new MostrarCategoria object to be added.
     */  
    public MostrarCategoria addMostrarCategoria(MostrarCategoria mostrarCategoria);
    
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
    public MostrarCategoria getMostrarCategoriaByCategoriaAndUsuario(Categoria categoria, Usuario usuario);   
}
