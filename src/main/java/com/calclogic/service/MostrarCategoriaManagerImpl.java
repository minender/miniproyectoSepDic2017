
/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.calclogic.service;

import com.calclogic.dao.MostrarCategoriaDAO;
import com.calclogic.entity.Categoria;
import com.calclogic.entity.MostrarCategoria;
import com.calclogic.entity.Usuario;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

/**
 * This class has the implementation of "MostrarCategoriaManager" queries.
 *
 * @author jt
 */
@Service
public class MostrarCategoriaManagerImpl implements MostrarCategoriaManager {
       
    @Autowired
    private MostrarCategoriaDAO MostrarCategoriaDAO;
    
    /** 
     * Adds a new MostrarCategoria object to the table and then return again the object.
     * @param MostrarCategoria The new MostrarCategoria object to be added.
     */   
    @Override
    @Transactional
    public MostrarCategoria addMostrarCategoria(MostrarCategoria mostrarCategoria){
        MostrarCategoriaDAO.addMostrarCategoria(mostrarCategoria);
        return mostrarCategoria;
    }

    /**
     * Deletes one of the MostrarCategoria objects of the table.
     * @param id Is the principal key of the MostrarCategoria object to delete.
     * @return Nothing.
     */   
    @Override
    @Transactional
    public void deleteMostrarCategoria(int id){
        MostrarCategoriaDAO.deleteMostrarCategoria(id);
    }

    /**
     * Method to get a MostrarCategoria object by its principal key.
     * @param id Is the principal key of the MostrarCategoria object.
     */ 
    @Override
    @Transactional
    public MostrarCategoria getMostrarCategoria(int id){
        return MostrarCategoriaDAO.getMostrarCategoria(id);
    }

    /**
     * Method to get a list of all the entries of the table.
     */    
    @Override
    @Transactional
    public List<MostrarCategoria> getAllMostrarCategorias(){
        return MostrarCategoriaDAO.getAllMostrarCategorias();
    }

    /**
     * Method to get a list of all the entries of the table that correspond to a specific user.
     * @param usuario Is the Usuario object used to filter the search.
     */    
    @Override
    @Transactional
    public List<MostrarCategoria> getAllMostrarCategoriasByUsuario(Usuario usuario){
        List<MostrarCategoria> mostrarCategorias = MostrarCategoriaDAO.getAllMostrarCategoriasByUsuario(usuario);
        List<MostrarCategoria> mostrarCategoriasClean = new ArrayList<>();
        Set<Integer> seen = new HashSet<>();
        for (MostrarCategoria mc: mostrarCategorias) {
            Integer id = mc.getCategoria().getId();
            if (!seen.contains(id)) {
                seen.add(id);
                mostrarCategoriasClean.add(mc);
            }
        }
        //return MostrarCategoriaDAO.getAllMostrarCategoriasByUsuario(usuario);
        return mostrarCategoriasClean;
    }
    
    /**
     * Method to get an entry of the table that relates a category to a user
     * @param categoria Is the Categoria object used to filter the search.
     * @param usuario Is the Usuario object used to filter the search.
     */
    @Override
    @Transactional
    public MostrarCategoria getMostrarCategoriaByCategoriaAndUsuario(Categoria categoria, Usuario usuario){
        return MostrarCategoriaDAO.getMostrarCategoriaByCategoriaAndUsuario(categoria, usuario);
    }   
}
