/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.calclogic.service;

import com.calclogic.dao.SolucionDAO;
import com.calclogic.entity.Solucion;
import com.calclogic.lambdacalculo.PasoInferencia;
import com.calclogic.lambdacalculo.Term;
import com.calclogic.parse.CombUtilities;

import java.util.HashMap;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.SerializationUtils;

/**
 *
 * @author miguel
 */
@Service
public class SolucionManagerImpl implements SolucionManager {
       
    @Autowired
    private SolucionDAO solucionDAO;
    
    @Autowired
    private CombUtilities combUtilities;
    
    
    @Override
    @Transactional
    public void addSolucion(Solucion sol){        
        List<Solucion> sols = solucionDAO.getAllSolucionesByResuelve(sol.getResuelve().getId());
        boolean allResuelto = true;
        for (Solucion otherSol: sols) {
            allResuelto = allResuelto && otherSol.getResuelto();
            if (!allResuelto)
                break;
        }
        if (allResuelto)
            solucionDAO.addSolucion(sol);
    }
    
    
    
    /*@Override
    @Transactional
    public void addPaso(int solucionId, PasoInferencia paso){
        Solucion sol = solucionDAO.getSolucion(solucionId);
        sol.addArregloInferencias(paso);
        solucionDAO.updateSolucion(sol);
    }*/
    
    @Override
    @Transactional
    public void updateSolucion(int solucionId, Term typedTerm){
        Solucion sol = solucionDAO.getSolucion(solucionId);
        sol.setTypedTerm(typedTerm);
        solucionDAO.updateSolucion(sol);
    }
    
    @Override
    @Transactional
    public void updateSolucion(Solucion sol){
        solucionDAO.updateSolucion(sol);
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
        if (!solucion.getDemostracion().equals(""))
            solucion.setTypedTerm(combUtilities.getTerm(solucion.getDemostracion()));
        else // case when all the proof was erased by the go back button
            solucion.setTypedTerm(null);
        return solucion;
    }
    
    
    @Override
    @Transactional
    public List<Solucion> getAllSolucionesByResuelve(int resuelveId){
        List<Solucion> sols = solucionDAO.getAllSolucionesByResuelve(resuelveId);
        for (Solucion sol: sols)
            if (!sol.getDemostracion().equals(""))
                sol.setTypedTerm(combUtilities.getTerm(sol.getDemostracion()));
            else
                sol.setTypedTerm(null);
        return sols;
    }
    
    
    @Override
    @Transactional
    public HashMap<String,Integer> getAllSolucionesIdByResuelve(int resuelveId){

        HashMap<String, Integer> listaSoluciones = new HashMap();
        
        List<Integer> idSoluciones = solucionDAO.getAllSolucionesIdByResuelve(resuelveId); 
        String nombreSolucion;
        int i = 1;
        for (int id : idSoluciones){
            
            nombreSolucion = "Proof " + i;
            listaSoluciones.put(nombreSolucion,id);
            i++;
        }
        List<Integer> idSoluciones2 = solucionDAO.getIncompleteSolucionIdByResuelve(resuelveId);
        for (int id : idSoluciones2){
            
            nombreSolucion = "(Incomplete) Proof " + i;
            listaSoluciones.put(nombreSolucion,id);
            i++;
        }
        
        return listaSoluciones;
    
    };
}
