/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.calclogic.dao;

import com.calclogic.entity.Termino;
import com.calclogic.entity.TerminoId;
import com.calclogic.entity.Usuario;
import java.util.List;


/**
 *
 * @author federico
 */
public interface TerminoDAO {
    
    public void addTermino(Termino termino);
    public void deleteTermino(TerminoId id);
    public Termino getTermino(TerminoId id);
    public List<Termino> getAllTerminos();
    public Termino getCombinador(String username, String comb);
    public List<Termino> getAllTerminos(String user);
    public List<Termino> getAllPublicaciones(String user);
}
