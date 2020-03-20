
/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.howtodoinjava.service;

import com.howtodoinjava.dao.MostrarCategoriaDAO;
import com.howtodoinjava.entity.Categoria;
import com.howtodoinjava.entity.MostrarCategoria;
import com.howtodoinjava.entity.Usuario;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

/**
 *
 * @author jt
 */
@Service
public class MostrarCategoriaManagerImpl implements MostrarCategoriaManager {
       
    @Autowired
    private MostrarCategoriaDAO MostrarCategoriaDAO;
    
    
    @Override
    @Transactional
    public MostrarCategoria addMostrarCategoria(MostrarCategoria mostrarCategoria){
        MostrarCategoriaDAO.addMostrarCategoria(mostrarCategoria);
        return mostrarCategoria;
    }
    
    
    @Override   
    @Transactional
    public void updateMostrarCategoria(MostrarCategoria mostrarCategoria){
        MostrarCategoriaDAO.updateMostrarCategoria(mostrarCategoria);
    }
    
    @Override
    @Transactional
    public void deleteMostrarCategoria(int id){
        MostrarCategoriaDAO.deleteMostrarCategoria(id);
    }
    
    @Override
    @Transactional
    public MostrarCategoria getMostrarCategoria(int id){
        return MostrarCategoriaDAO.getMostrarCategoria(id);
    }
    
    @Override
    @Transactional
    public List<MostrarCategoria> getAllMostrarCategorias(){
        return MostrarCategoriaDAO.getAllMostrarCategorias();
    }
    
    @Override
    @Transactional
    public List<MostrarCategoria> getAllMostrarCategoriasByUsuario(Usuario usuario){
        return MostrarCategoriaDAO.getAllMostrarCategoriasByUsuario(usuario);
    }
    
    @Override
    @Transactional
    public MostrarCategoria getMostrarCategoriaByCategoriaAndUsuario(Categoria categoria, Usuario usuario){
        return MostrarCategoriaDAO.getMostrarCategoriaByCategoriaAndUsuario(categoria, usuario);
    }

 
    
}
