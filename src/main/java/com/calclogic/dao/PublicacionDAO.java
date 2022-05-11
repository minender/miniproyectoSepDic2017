package com.calclogic.dao;

import com.calclogic.entity.Publicacion;
import com.calclogic.entity.PublicacionId;
import java.util.List;


/**
 * This interface is the API of the database queries that 
 * have to do with the table "Publicacion". 
 *
 * >>> This must be removed.
 *
 * @author federico
 */
public interface PublicacionDAO {
    
    /** 
     * Adds a new Publicacion object to the table.
     * @param publicacion The new Predicado object to be added.
     * @return Nothing.
     */
    public void addPublicacion(Publicacion publicacion);

    /**
     * Deletes one of the Publicacion objects of the table.
     * @param id Is the principal key of the Publicacion object to delete.
     * @return Nothing.
     */ 
    public void deletePublicacion(PublicacionId id);

    /**
     * Method to get a Publicacion object by its principal key.
     * @param id Is the principal key of the Publicacion object.
     */  
    public Publicacion getPublicacion(PublicacionId id);

    /**
     * Method to get a list of all the entries of the table.
     */
    public List<Publicacion> getAllPublicaciones();

    /**
     * Method to get a list of all the entries of the table that correspond to a specific user.
     * @param username Is the string with which the user logs in, and that we use to filter the search.
     */
    public List<Publicacion> getAllPublicaciones(String username);
}
