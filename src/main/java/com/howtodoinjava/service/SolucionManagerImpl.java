/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.howtodoinjava.service;

import com.howtodoinjava.dao.SolucionDAO;
import com.howtodoinjava.entity.Solucion;
import com.howtodoinjava.lambdacalculo.PasoInferencia;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

/**
 *
 * @author miguel
 */
@Service
public class SolucionManagerImpl implements SolucionManager {
       
    @Autowired
    private SolucionDAO solucionDAO;
    
    
    @Override
    @Transactional
    public void addSolucion(Solucion solucion){
        solucionDAO.addSolucion(solucion);
    }
    
    
    
    @Override
    @Transactional
    public void addPaso(int solucionId, PasoInferencia paso){
        Solucion sol = solucionDAO.getSolucion(solucionId);
        sol.addArregloInferencias(paso);
        solucionDAO.updateSolucion(sol);
    }
    
    @Override
    @Transactional
    public void updateSolucion(Solucion solucion){
        solucionDAO.updateSolucion(solucion);
    }
    
    @Override
    @Transactional
    public void deleteSolucion(int id){
        solucionDAO.deleteSolucion(id);
    }
    
    
    @Override
    @Transactional
    public Solucion getSolucion(int id){
        Solucion solucion = solucionDAO.getSolucion(id);
        solucion.deserialize();
        return solucion;
    }
    
    
    @Override
    @Transactional
    public List<Solucion> getAllSolucionesByResuelve(int resuelveId){
        List<Solucion> sols = solucionDAO.getAllSolucionesByResuelve(resuelveId);
        for (Solucion sol: sols)
            sol.deserialize();
        return sols;
    }
}
