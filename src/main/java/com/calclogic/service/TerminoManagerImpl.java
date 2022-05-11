package com.calclogic.service;

import com.calclogic.dao.PublicacionDAO;
import com.calclogic.dao.TerminoDAO;
import com.calclogic.entity.Publicacion;
import com.calclogic.entity.PublicacionId;
import com.calclogic.entity.Termino;
import com.calclogic.entity.TerminoId;
import com.calclogic.lambdacalculo.Term;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.SerializationUtils;

/**
 * This class has the implementation of "TerminoManager" queries.
 *
 * @author federico
 */
@Service
public class TerminoManagerImpl implements TerminoManager{

    @Autowired
    private TerminoDAO terminoDAO;
    //@Autowired
    //private PublicacionDAO publicacionDAO;
    
    /** 
     * Adds a new term to the table.
     * @param termino The new term to be added.
     * @return Nothing.
     */
    @Override
    @Transactional
    public void addTermino(Termino termino)
    {
        terminoDAO.addTermino(termino);
    }
    
    /** 
	 * >>> Deprecated, since the Publicacion table must be removed.
     */
    /*@Override
    @Transactional
    public void addPublicacion(Termino termino,Publicacion publicacion)
    {
        //publicacionDAO.addPublicacion(publicacion);
        terminoDAO.addTermino(termino);
        publicacionDAO.addPublicacion(publicacion);
    }*/

    /**
     * Deletes one of the terms of the table.
     * @param id Is the principal key of the term to delete.
     * @return Nothing.
     */ 
    @Override
    @Transactional
    public void deleteTermino(TerminoId id){
        terminoDAO.deleteTermino(id);
    }
    
    /** 
	 * >>> Deprecated, since the Publicacion table must be removed.
     */
/*    @Override
    @Transactional
    public void deletePublicacion(TerminoId id){
        PublicacionId publicacionid = new PublicacionId(id.getAlias(),id.getLogin());
        publicacionDAO.deletePublicacion(publicacionid);
        id.setLogin("publico");
        terminoDAO.deleteTermino(id);
    }
  */
    
    /**
     * Updates one of the terms of the table.
	 * It deletes the previous entry and adds a new one.
     * @param termino Is the new term to be added.
     * @return Nothing.
     */ 
    @Override
    @Transactional
    public void modificarTermino(Termino termino){
        terminoDAO.deleteTermino(termino.getId());
        terminoDAO.addTermino(termino);
    }
    
    /**
     * Modifies the alias of a term.
	 * It deletes the previous entry and adds a new one.
     * @param anterior Is principal key of the term that will be deleted.
	 * @param nuevo Is the principal key of the term that will be added.
     * @return Nothing.
     */ 
    @Override
    @Transactional
    public void modificarAlias(TerminoId anterior, TerminoId nuevo)
    {
        Termino termino=getTermino(anterior);
        terminoDAO.deleteTermino(anterior);
        termino.setId(nuevo);
        Term aux=termino.getTermObject();
        aux.setAlias(nuevo.getAlias());
        termino.setTermObject(aux);
        terminoDAO.addTermino(termino);
    }
	
    /** 
	 * >>> Deprecated, since the Publicacion table must be removed.
     */
/*    public Publicacion getPublicacion(PublicacionId id)
    {
        Publicacion publicacion = publicacionDAO.getPublicacion(id);
        TerminoId terminoid = new TerminoId(id.getAlias(),"publico");
        publicacion.setTermino(terminoDAO.getTermino(terminoid));
        
        return publicacion;
    }
  */
    
    /**
     * Method that parses returns a term given its principal key
	 * If it does not find it in the table, it tries setting the current login first
	 * as "publico" and then as "admin, just in case it is private.
     * @param id Is the principal key of the term.
     */
    @Override
    @Transactional    
    public Termino getTermino(TerminoId id){
        Termino t=terminoDAO.getTermino(id);
        if(t!=null)
        {
            t.setTermObject((Term)SerializationUtils.deserialize(t.getSerializado()));
            return  t;    
        }
        
        id.setLogin("publico");
        t=terminoDAO.getTermino(id);
        if(t!=null)
        {
            t.setTermObject((Term)SerializationUtils.deserialize(t.getSerializado()));
            return  t;    
        }
        
        id.setLogin("admin");
        t=terminoDAO.getTermino(id);
        if(t!=null)
        {
            t.setTermObject((Term)SerializationUtils.deserialize(t.getSerializado()));
            return  t;    
        }
        
        return t;
    }
    
    /**
     * Method to get a list of all the entries of the table (all the terms).
     */
    @Override
    @Transactional
    public List<Termino> getAllTerminos(){
        List<Termino> terms=terminoDAO.getAllTerminos();
        try{
            for(Termino ter: terms)
            {
                //ter.setTermObject((Term)ToString.fromString(ter.getSerializado()));
                ter.setTermObject((Term)SerializationUtils.deserialize(ter.getSerializado()));
            }
        }
        catch(Exception e){e.printStackTrace();}
        
        return terms;
    }
    
    /**
     * Method to get a list of all the entries of the table that correspond to a specific user.
     * @param username Is the string with which the user logs in, and that we use to filter the search.
     */
    @Override
    @Transactional
    public List<Termino> getAllTerminos(String username)
    {
        List<Termino> terms=terminoDAO.getAllTerminos( username);
        try
        {
            for(Termino ter: terms)
            {
                //ter.setTermObject((Term)ToString.fromString(ter.getSerializado()));
                ter.setTermObject((Term)SerializationUtils.deserialize(ter.getSerializado()));
            }
        }
        catch(Exception e){e.printStackTrace();}
        
        return terms;
    }
    
    /** 
	 * >>> Deprecated, since the Publicacion table must be removed.
     */
/*    @Override
    @Transactional
    public List<Termino> getAllPublicaciones(String username)
    {
         List<Termino> terms=terminoDAO.getAllPublicaciones(username);
         try
        {
            for(Termino ter: terms)
            {
                //ter.setTermObject((Term)ToString.fromString(ter.getSerializado()));
                ter.setTermObject((Term)SerializationUtils.deserialize(ter.getSerializado()));
            }
        }
        catch(Exception e){e.printStackTrace();}
        
        return terms;
    }
  */
    
    /**
     * Method to get a list of all the entries of the table that correspond to a specific user,
     * and that have a specific "combinador" attribute.
	 * If it does not find it in the table, it tries setting the current login first
	 * as "publico" and then as "admin, just in case it is private.
     * @param username Is the string with which the user logs in, and that we use to filter the search.
     * @param comb Is the "combinador" attribute used to filter the search.
     */
    @Override
    @Transactional
    public Termino getCombinador(String username, String comb){
        Termino t=terminoDAO.getCombinador(username, comb);
        if(t != null)
            return t;
            
        t=terminoDAO.getCombinador("publico", comb);
        if(t != null)
            return t;
        
        t=terminoDAO.getCombinador("admin", comb);
        if(t != null)
            return t;
        
        return t;
    }
}
