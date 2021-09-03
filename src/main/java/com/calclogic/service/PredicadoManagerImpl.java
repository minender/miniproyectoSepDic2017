package com.calclogic.service;

import com.calclogic.dao.PredicadoDAO;
import com.calclogic.entity.Predicado;
import com.calclogic.entity.PredicadoId;
import com.calclogic.lambdacalculo.App;
import com.calclogic.lambdacalculo.Term;
import com.calclogic.lambdacalculo.Var;
import com.calclogic.parse.CombUtilities;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.SerializationUtils;

/**
 * This class has the implementation of "PredicadoManager" queries.
 *
 * @author miguel
 */
@Service
public class PredicadoManagerImpl implements PredicadoManager {
       
    @Autowired
    private PredicadoDAO predicadoDAO;
    
    @Autowired
    private CombUtilities combUtilities;
    
    /** 
     * Adds a new Predicado object to the table.
     * @param predicado The new Predicado object to be added.
     * @return Nothing.
     */   
    @Override
    @Transactional
    public void addPredicado(Predicado predicado){
        predicadoDAO.addPredicado(predicado);
    }
    
    /**
     * Deletes one of the Predicado objects of the table.
     * @param id Is the principal key of the Predicado object to delete.
     * @return Nothing.
     */ 
    @Override
    @Transactional
    public void deletePredicado(PredicadoId id){
        predicadoDAO.deletePredicado(id);
    }

    /**
     * Updates one of the Predicado objects of the table.
     * @param pre Is the Predicado object to be updated.
     * @return Nothing.
     */ 
    @Override
    @Transactional
    public void updatePredicado(Predicado pre) {
        predicadoDAO.updatePredicado(pre);
    }

    /**
     * Method to change the alias of one of the Predicado objects of the table.
     * To do that, it removes the object that was on the table and adds a new one,
     * with the new alias. 
     * @param anterior Is the previous principal key of the Predicado object.
     * @param nuevo Is the new principal key of the Predicado object.
     * @return Nothing.
     */   
    @Override
    @Transactional
    public void modificarAlias(PredicadoId anterior, PredicadoId nuevo) {
        Predicado pre=getPredicado(anterior);
        predicadoDAO.deletePredicado(anterior);
        pre.setId(nuevo);
        Term aux=pre.getTerm();
        aux.setAlias(nuevo.getAlias());
        pre.setTerm(aux);
        predicadoDAO.addPredicado(pre);
    }
    
    /**
     * Method to get a Predicado object by its principal key.
     * If it exists, it parses the string associated with the object.
     * @param id Is the principal key of the Predicado object.
     */
    @Override
    @Transactional
    public Predicado getPredicado(PredicadoId id){
        Predicado p=predicadoDAO.getPredicado(id);
        if(p!=null)
        {
            p.setTerm(combUtilities.getTerm(p.getPredicado()));    
        }
        return  p;
    }
    
    /**
     * Method to get a Predicado object that corresponds to a specific user and that have a specific string.
     * If it exists, it parses the string associated with the object.
     * If it does not exist, this tries to find the predicate among the admin's theorems.
     * @param username Is the string with which the user logs in, and that we use to filter the search.
     * @param comb Represents the predicate with which we filter the search.
     */
    public Predicado getPredicado(String username, String comb) {
        Predicado t=predicadoDAO.getPredicado(username, comb);
        if(t != null)
        {
            t.setTerm(combUtilities.getTerm(t.getPredicado()));    
            return t;
        }
        
        t=predicadoDAO.getPredicado("AdminTeoremas", comb);
        if(t != null)
            return t;
        
        return t;
    }
    
    /**
     * Method to get a list of all the entries of the table that correspond to a specific user.
     * It also parses all of them.
     * @param userLogin Is the string with which the user logs in, and that we use to filter the search.
     */
    @Override
    @Transactional
    public List<Predicado> getAllPredicadosByUser(String userLogin){
        List<Predicado> pres=predicadoDAO.getAllPredicadosByUser(userLogin);
        try
        {
            for(Predicado pre: pres) {
                String[] args = pre.getArgumentos().split(",");
                Term aux = combUtilities.getTerm(pre.getPredicado());
                for (int i=0; i < args.length; i++) 
                    aux=new App(aux,new Var(args[i].split("@")[0].trim().charAt(0)));
                aux = aux.evaluar();
                pre.setTerm(aux);
            }
        }
        catch(Exception e){e.printStackTrace();}
        
        return pres;
    }
}
