package com.calclogic.service;

import com.calclogic.dao.TeoriaDAO;
import com.calclogic.dao.SolucionDAO;
import com.calclogic.entity.Teoria;
import com.calclogic.entity.Solucion;
import com.calclogic.entity.Teorema;
import com.calclogic.lambdacalculo.Term;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.SerializationUtils;

/**
 * This class has the implementation of "TeoriaManager" queries.
 *
 * @author jt
 */
@Service
public class TeoriaManagerImpl implements TeoriaManager {
       
    @Autowired
    private TeoriaDAO TeoriaDAO;
    
    @Autowired
    private SolucionDAO solucionDAO;
    
    /** 
     * Adds a new theory to the table.
     * @param Teoria The new theory to be added.
     * @return Teoria This function returns again the just added theory.
     */
    @Override
    @Transactional
    public Teoria addTeoria(Teoria Teoria){
        TeoriaDAO.addTeoria(Teoria);
        return Teoria;
    }
   
    /**
     * Updates one of the theories of the table.
     * @param Teoria Is the theory to be updated.
     * @return Nothing.
     */    
    @Override   
    @Transactional
    public void updateTeoria(Teoria Teoria){
        TeoriaDAO.updateTeoria(Teoria);
    }
    
    /**
     * Deletes one of the theories of the table.
     * @param id Is the principal key of the theory to delete.
     * @return Nothing.
     */ 
    @Override
    @Transactional
    public void deleteTeoria(int id){
        TeoriaDAO.deleteTeoria(id);
    }
    
    /**
     * Method to get a theory by its principal key.
     * @param id Is the principal key of the theory.
     */
    @Override
    @Transactional
    public Teoria getTeoria(int id){
        return TeoriaDAO.getTeoria(id);
    }
    
    /**
     * Method to get a list of all the entries of the table (all the theories).
     */
    @Override
    @Transactional
    public List<Teoria> getAllTeoria(){
        return TeoriaDAO.getAllTeoria();
    }
    
}
