/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.howtodoinjava.service;
import com.howtodoinjava.dao.TeoremaDAO;
import com.howtodoinjava.dao.ResuelveDAO;
import com.howtodoinjava.entity.Resuelve;
import com.howtodoinjava.entity.Teorema;
import com.howtodoinjava.lambdacalculo.Term;
import com.howtodoinjava.parse.CombUtilities;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
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
public class TeoremaManagerImpl implements TeoremaManager {

    @Autowired
    private TeoremaDAO teoremaDAO;
    private ResuelveDAO resuelveDAO;
    
    @Autowired
    private CombUtilities combUtilities;

    @Override
    @Transactional
    public Teorema addTeorema(Teorema teorema) {
        // Este teorema sera utilizado para ver si ya existe en la BD
        Teorema teorema2 = this.getTeoremaByEnunciados(teorema.getEnunciado().toString());
        if (teorema2 != null) {
            return teorema2;
        } /*else {
            // Este teorema sera utilizado para ver si el inverso ya existe en la BD
            Teorema teorema3 = this.getTeoremaByEnunciados(teorema.getEnunciadoder().toString(), teorema.getEnunciadoizq().toString());
            if (teorema3 != null) {
                return teorema3;
            }
        }*/
        teoremaDAO.addTeorema(teorema);
        return teorema;
    }

    @Override
    @Transactional
    public void deleteTeorema(int id) {

        // Si solo hay 1 usuario usandolo, entonces aplica teoremaDAO.deleteTeorema(id)
        teoremaDAO.deleteTeorema(id);
    }

    @Override
    @Transactional
    public Teorema getTeorema(int id) {
        Teorema teo = teoremaDAO.getTeorema(id);
        if (teo != null) {
            teo.setTeoTerm(combUtilities.getTerm(teo.getEnunciado()));
        }
        return teo;
    }

    @Override
    @Transactional
    public List<Teorema> getAllTeoremas() {
        List<Teorema> teoList = teoremaDAO.getAllTeoremas();
        try {
            for (Teorema teo : teoList) {
                //ter.setTermObject((Term)ToString.fromString(ter.getSerializado()));
                teo.setTeoTerm(combUtilities.getTerm(teo.getEnunciado()));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return teoList;
    }

    @Override
    @Transactional
    public Teorema getTeoremaByEnunciados(String enunciado) {
        Teorema teo = teoremaDAO.getTeoremaByEnunciados(enunciado);
        if (teo != null) {
            teo.setTeoTerm(combUtilities.getTerm(teo.getEnunciado()));
        }
        return teo;
    }

    @Override
    @Transactional
    public List<Teorema> getTeoremaByResuelveList(List<Resuelve> resList) {
        List<Teorema> teoList = new ArrayList<Teorema>();
        Teorema teorema;
        
        Collections.sort(resList, new ResuelveComparator());
        
        for (Resuelve res : resList) {
            teorema = res.getTeorema();
            teorema.setTeoTerm(combUtilities.getTerm(teorema.getEnunciado()));
            teoList.add(teorema);
        }

        return teoList;
    }

    class ResuelveComparator implements Comparator<Resuelve> {

        public int compare(Resuelve res1, Resuelve res2) {
            return res1.getCategoria().getId() - res2.getCategoria().getId();
        }
    }

    @Override
    @Transactional
    public List<Teorema> getTeoremasByCategoria(int categoriaId) {
        List<Resuelve> res = resuelveDAO.getResuelveByCategoria(categoriaId);
        List<Teorema> teos = new ArrayList<Teorema>();
        for (int i=0;i<=res.size();i++){
            teos.add(res.get(i).getTeorema());
        }
        if (teos != null) {
            for (Teorema teo : teos){
               teo.setTeoTerm(combUtilities.getTerm(teo.getEnunciado()));
            }
        }
        return teos;
    }
}
