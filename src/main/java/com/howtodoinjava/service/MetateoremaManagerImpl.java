/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.howtodoinjava.service;

import com.howtodoinjava.dao.MetateoremaDAO;
import com.howtodoinjava.entity.Metateorema;
import com.howtodoinjava.lambdacalculo.Term;
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
public class MetateoremaManagerImpl implements MetateoremaManager {
       
    @Autowired
    private MetateoremaDAO metateoremaDAO;
    
    @Override
    @Transactional
    public Metateorema addMetateorema(Metateorema metateorema){
        // Este metateorema sera utilizado para ver si ya existe en la BD
        Metateorema metateorema2 = this.getMetateoremaByEnunciados(metateorema.getEnunciado().toString());
        if (metateorema2 != null) {
            return metateorema2;
        } /*else {
            // Este metateorema sera utilizado para ver si el inverso ya existe en la BD
            Metateorema metateorema3 = this.getMetateoremaByEnunciados(metateorema.getEnunciado().toString());
            if (metateorema3 != null) {
                return metateorema3;
            }
        }*/
        metateoremaDAO.addMetateorema(metateorema);
        return metateorema;
    }
    
    @Override
    @Transactional
    public void deleteMetateorema(int id){
        metateoremaDAO.deleteMetateorema(id);
    }
    
    @Override
    @Transactional
    public Metateorema getMetateorema(int id){
        Metateorema metaTeo = metateoremaDAO.getMetateorema(id);
        if (metaTeo != null) {
            metaTeo.setTeoTerm((Term) SerializationUtils.deserialize(metaTeo.getMetateoserializado()));
        }
        return metaTeo;
    }
    
    @Override
    @Transactional
    public List<Metateorema> getAllMetateoremas(){
        return metateoremaDAO.getAllMetateoremas();
    }
    
    @Override
    @Transactional
    public Metateorema getMetateoremaByEnunciados(String enunciado){
        return metateoremaDAO.getMetateoremaByEnunciados(enunciado);
    }

}
