/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.howtodoinjava.service;

import com.howtodoinjava.dao.PublicacionDAO;
import com.howtodoinjava.dao.TerminoDAO;
import com.howtodoinjava.entity.Publicacion;
import com.howtodoinjava.entity.PublicacionId;
import com.howtodoinjava.entity.Termino;
import com.howtodoinjava.entity.TerminoId;
import com.howtodoinjava.lambdacalculo.Term;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.SerializationUtils;

/**
 *
 * @author federico
 */
@Service
public class TerminoManagerImpl implements TerminoManager{

    @Autowired
    private TerminoDAO terminoDAO;
    @Autowired
    private PublicacionDAO publicacionDAO;
    
    @Override
    @Transactional
    public void addTermino(Termino termino)
    {
        terminoDAO.addTermino(termino);
    }
    
    @Override
    @Transactional
    public void addPublicacion(Termino termino,Publicacion publicacion)
    {
        //publicacionDAO.addPublicacion(publicacion);
        terminoDAO.addTermino(termino);
        publicacionDAO.addPublicacion(publicacion);
    }

    @Override
    @Transactional
    public void deleteTermino(TerminoId id){
        terminoDAO.deleteTermino(id);
    }
    
    @Override
    @Transactional
    public void deletePublicacion(TerminoId id){
        PublicacionId publicacionid = new PublicacionId(id.getAlias(),id.getLogin());
        publicacionDAO.deletePublicacion(publicacionid);
        id.setLogin("publico");
        terminoDAO.deleteTermino(id);
    }
    
    @Override
    @Transactional
    public void modificarTermino(Termino termino){
        terminoDAO.deleteTermino(termino.getId());
        terminoDAO.addTermino(termino);
    }
    
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
    
    public Publicacion getPublicacion(PublicacionId id)
    {
        Publicacion publicacion = publicacionDAO.getPublicacion(id);
        TerminoId terminoid = new TerminoId(id.getAlias(),"publico");
        publicacion.setTermino(terminoDAO.getTermino(terminoid));
        
        return publicacion;
    }
    
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
    
    @Override
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
