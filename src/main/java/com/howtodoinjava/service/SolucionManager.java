/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.howtodoinjava.service;

import com.howtodoinjava.entity.Solucion;
import com.howtodoinjava.lambdacalculo.PasoInferencia;
import com.howtodoinjava.lambdacalculo.Term;
import java.util.List;
import java.util.HashMap;

/**
 *
 * @author miguel
 */
public interface SolucionManager {
        
    public void addSolucion(Solucion solucion);

    //public void addPaso(int solucionId, PasoInferencia paso);
    
    public void updateSolucion(int solucionId, Term infer);
    
    public void updateSolucion(Solucion solucion);
    
    public void deleteSolucion(int id);

    public Solucion getSolucion(int id);
    
    public List<Solucion> getAllSolucionesByResuelve(int resuelveId);
    
    public HashMap<String,Integer> getAllSolucionesIdByResuelve(int resuelveId);
    
}