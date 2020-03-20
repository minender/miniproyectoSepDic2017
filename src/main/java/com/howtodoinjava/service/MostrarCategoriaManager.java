/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.howtodoinjava.service;

import com.howtodoinjava.entity.Categoria;
import com.howtodoinjava.entity.MostrarCategoria;
import com.howtodoinjava.entity.Usuario;
import java.util.List;

/**
 *
 * @author jt
 */
public interface MostrarCategoriaManager {
    
    
    public MostrarCategoria addMostrarCategoria(MostrarCategoria mostrarCategoria);
    
    public void updateMostrarCategoria(MostrarCategoria mostrarCategoria);
    
    public void deleteMostrarCategoria(int id);
    
    public MostrarCategoria getMostrarCategoria(int id);
    
    public List<MostrarCategoria> getAllMostrarCategorias();
    
    public List<MostrarCategoria> getAllMostrarCategoriasByUsuario(Usuario usuario);
    
    public MostrarCategoria getMostrarCategoriaByCategoriaAndUsuario(Categoria categoria, Usuario usuario);
    
}
