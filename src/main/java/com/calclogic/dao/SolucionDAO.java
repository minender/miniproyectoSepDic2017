/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.calclogic.dao;

import com.calclogic.entity.Solucion;
import java.util.List;

/**
 *
 * @author miguel
 */
public interface SolucionDAO {
    
    public void addSolucion(Solucion solucion);
    
    public void updateSolucion(Solucion solucion);
    
    public void deleteSolucion(int id);
    
    public Solucion getSolucion(int id);
    
    public List<Solucion> solutionsWithAxiom(int idTeo);
    
    public List<Solucion> getAllSolucionesByResuelve(int resuelveId);
    
    public List<Integer> getAllSolucionesIdByResuelve(int resuelveId);
    
    public List<Integer> getIncompleteSolucionIdByResuelve(int resuelveId);
}
