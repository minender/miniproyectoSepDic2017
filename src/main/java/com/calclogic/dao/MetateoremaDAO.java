/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.calclogic.dao;

import com.calclogic.entity.Metateorema;
import java.util.List;

/**
 *
 * @author miguel
 */
public interface MetateoremaDAO {
    
    public void addMetateorema(Metateorema metateorema);
    
    public void deleteMetateorema(int id);
    
    public Metateorema getMetateorema(int id);
    
    public List<Metateorema> getAllMetateoremas();
    
    public Metateorema getMetateoremaByEnunciados(String enunciado);   
    
}
