/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package com.calclogic.dao;


import com.calclogic.entity.Categoria;
import com.calclogic.entity.Teorema;
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
