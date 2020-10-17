/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.calclogic.service;

import com.calclogic.entity.Categoria;
import com.calclogic.entity.MostrarCategoria;
import com.calclogic.entity.Usuario;
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
