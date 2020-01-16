/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.howtodoinjava.service;

import com.howtodoinjava.entity.Resuelve;
import com.howtodoinjava.entity.Teorema;
import java.util.List;

/**
 *
 * @author miguel
 */
public interface TeoremaManager {
    
    public Teorema addTeorema(Teorema teorema);
    
    public void deleteTeorema(int id);
    
    public Teorema getTeorema(int id);
    
    public List<Teorema> getAllTeoremas();
    
    public Teorema getTeoremaByEnunciados(String enunciado);
    
    public List<Teorema> getTeoremaByResuelveList(List<Resuelve> resList);
    
    public List<Teorema> getTeoremasByCategoria(int categoriaId);
}
