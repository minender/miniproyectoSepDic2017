package com.calclogic.service;

import com.calclogic.dao.MetateoremaDAO;
import com.calclogic.entity.Metateorema;
import com.calclogic.lambdacalculo.Term;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.SerializationUtils;

/**
 * This class has the implementation of "MetateoremaManager" queries.
 *
 * >>> Unused for the moment.
 *
 * @author miguel
 */
@Service
public class MetateoremaManagerImpl implements MetateoremaManager {
       
    @Autowired
    private MetateoremaDAO metateoremaDAO;
    
    /** 
     * Adds a new object entry to the table only if an equivalent one has not been added yet,
     * and if so then returns again the object.
     * Otherwise, it returns the equivalent object that was previously added.
     * @param metateorema The new matatheorem to be added.
     */
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
    
    /**
     * Deletes one of the metatheorems of the table.
     * @param id Is the principal key of the metatheorem to delete.
     * @return Nothing.
     */ 
    @Override
    @Transactional
    public void deleteMetateorema(int id){
        metateoremaDAO.deleteMetateorema(id);
    }

    /**
     * Method to get a metatheorem by its principal key.
     * If it exists, it first deserializes the term of the metatheorem.
     * @param id Is the principal key of the metatheorem.
     */    
    @Override
    @Transactional
    public Metateorema getMetateorema(int id){
        Metateorema metaTeo = metateoremaDAO.getMetateorema(id);
        if (metaTeo != null) {
            metaTeo.setTeoTerm((Term) SerializationUtils.deserialize(metaTeo.getMetateoserializado()));
        }
        return metaTeo;
    }

    /**
     * Method to get a list of all the entries of the table (all the metatheorems).
     */    
    @Override
    @Transactional
    public List<Metateorema> getAllMetateoremas(){
        return metateoremaDAO.getAllMetateoremas();
    }

    /**
     * Method to get a metatheorem that corresponds to a statement.
     * @param enunciado Is the statement used to filter the search.
     */  
    @Override
    @Transactional
    public Metateorema getMetateoremaByEnunciados(String enunciado){
        return metateoremaDAO.getMetateoremaByEnunciados(enunciado);
    }

}
