/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.howtodoinjava.service;

import com.howtodoinjava.entity.Publicacion;
import com.howtodoinjava.entity.Termino;
import com.howtodoinjava.entity.TerminoId;
import com.howtodoinjava.entity.Usuario;
import java.util.List;

/**
 *
 * @author federico
 */
public interface TerminoManager {
    
    public void addTermino(Termino termino);
    public void addPublicacion(Termino termino,Publicacion publicacion);
    public void deleteTermino(TerminoId id);
    public void deletePublicacion(TerminoId id);
    public void modificarTermino(Termino termino);
    public void modificarAlias(TerminoId anterior, TerminoId nuevo);
    public Termino getTermino(TerminoId id);
    public Termino getCombinador(String username, String comb);
    public List<Termino> getAllTerminos();
    public List<Termino> getAllTerminos(String username);
    public List<Termino> getAllPublicaciones(String username);
}
