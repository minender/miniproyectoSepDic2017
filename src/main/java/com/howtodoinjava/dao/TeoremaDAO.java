/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package com.howtodoinjava.dao;


import com.howtodoinjava.entity.Categoria;
import com.howtodoinjava.entity.Teorema;
import java.util.List;
/**
 *
 * @author miguel
 */
public interface TeoremaDAO {
    
    public void addTeorema(Teorema teorema);
    
    public void deleteTeorema(int id);
    
    public Teorema getTeorema(int id);
    
    public List<Teorema> getAllTeoremas();
    
    public Teorema getTeoremaByEnunciados(String enunciado);
    //
//    public List<Teorema> getPublicTeoremas(Categoria categoria);
}
