/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.calclogic.dao;
import com.calclogic.entity.Categoria;
import com.calclogic.entity.MostrarCategoria;
import com.calclogic.entity.Usuario;
import java.util.List;

/**
 *
 * @author jt
 */
public interface MostrarCategoriaDAO {
    

    public void addMostrarCategoria(MostrarCategoria MostrarCategoria);
    
    public void updateMostrarCategoria(MostrarCategoria MostrarCategoria);
    
    public void deleteMostrarCategoria(int id);
    
    public MostrarCategoria getMostrarCategoria(int id);
    
    public List<MostrarCategoria> getAllMostrarCategorias();
    
    public List<MostrarCategoria> getAllMostrarCategoriasByUsuario(Usuario usuario);
    
    public MostrarCategoria getMostrarCategoriaByCategoriaAndUsuario(Categoria categoria,Usuario usuario);
    

}