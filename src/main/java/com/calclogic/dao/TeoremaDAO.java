package com.calclogic.dao;

import com.calclogic.entity.Categoria;
import com.calclogic.entity.Teorema;
import java.util.List;

/**
 * This interface is the API of the database queries that 
 * have to do with the table "Teorema". 
 *
 * That table has all the theorems that have been added to the
 * application.
 *
 * @author miguel
 */
public interface TeoremaDAO {
    
    /** 
     * Adds a new theorem to the table.
     * @param teorema The new theorem to be added.
     * @return Nothing.
     */
    public void addTeorema(Teorema teorema);
    
    /**
     * Deletes one of the theorems of the table.
     * @param id Is the principal key of the theorem to delete.
     * @return Nothing.
     */ 
    public void deleteTeorema(int id);
    
    /**
     * Method to get a theorem by its principal key.
     * @param id Is the principal key of the theorem.
     */
    public Teorema getTeorema(int id);
    
    /**
     * Method to get a list of all the entries of the table (all the theorems).
     */
    public List<Teorema> getAllTeoremas();
    
    /**
     * Method to get a theorem that corresponds to a statement.
     * @param enunciado Is the statement used to filter the search.
     */
    public Teorema getTeoremaByEnunciados(String enunciado);
    //
//    public List<Teorema> getPublicTeoremas(Categoria categoria);
}
