/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.howtodoinjava.service;

import com.howtodoinjava.dao.TeoremaDAO;
import com.howtodoinjava.entity.Resuelve;
import com.howtodoinjava.entity.Teorema;
import com.howtodoinjava.lambdacalculo.Term;
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
            teo.setTeoTerm((Term) SerializationUtils.deserialize(teo.getTeoserializado()));
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
                teo.setTeoTerm((Term) SerializationUtils.deserialize(teo.getTeoserializado()));
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
            teo.setTeoTerm((Term) SerializationUtils.deserialize(teo.getTeoserializado()));
        }
        return teo;
    }

    @Override
    @Transactional
    public List<Teorema> getTeoremaByResuelveList(List<Resuelve> resList) {
        List<Teorema> teoList = new ArrayList<Teorema>();
        Teorema teorema;
        for (Resuelve res : resList) {
            teorema = res.getTeorema();
            teorema.setTeoTerm((Term) SerializationUtils.deserialize(teorema.getTeoserializado()));
            teoList.add(teorema);
        }

        Collections.sort(teoList, new TeoremaComparator());

        return teoList;
    }

    class TeoremaComparator implements Comparator<Teorema> {

        public int compare(Teorema teo1, Teorema teo2) {
            return teo1.getCategoria().getId() - teo2.getCategoria().getId();
        }
    }

    @Override
    @Transactional
    public List<Teorema> getTeoremasByCategoria(int categoriaId) {
        List<Teorema> teos = teoremaDAO.getTeoremasByCategoria(categoriaId);
        if (teos != null) {
            for (Teorema teo : teos){
               teo.setTeoTerm((Term) SerializationUtils.deserialize(teo.getTeoserializado()));
            }
        }
        return teos;
    }
}
