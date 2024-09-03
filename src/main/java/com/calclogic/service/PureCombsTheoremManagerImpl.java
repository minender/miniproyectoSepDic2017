/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.calclogic.service;

import com.calclogic.dao.PureCombsTheoremDAO;
import com.calclogic.entity.PureCombsTheorem;
import com.calclogic.lambdacalculo.Term;
import com.calclogic.parse.CombUtilities;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.transaction.annotation.Transactional;

/**
 *
 * @author feder
 */
public class PureCombsTheoremManagerImpl implements PureCombsTheoremManager{
    
    @Autowired
    private PureCombsTheoremDAO pureCombsTheoremDAO;

    /** 
     * Adds a new theorem to the table.
     * @param teorema The new theorem to be added.
     * @return Nothing.
     */
    @Override
    @Transactional
    public PureCombsTheorem addPureCombsTheorem(PureCombsTheorem teorema) {
        // Este teorema sera utilizado para ver si ya existe en la BD
        PureCombsTheorem teorema2 = this.getTeoremaByEnunciado(teorema.getStatement().toString());
        if (teorema2 != null) {
            return teorema2;
        } /*else {
            // Este teorema sera utilizado para ver si el inverso ya existe en la BD
            Teorema teorema3 = this.getTeoremaByEnunciados(teorema.getEnunciadoder().toString(), teorema.getEnunciadoizq().toString());
            if (teorema3 != null) {
                return teorema3;
            }
        }*/
        pureCombsTheoremDAO.addPureCombsTheorem(teorema);
        return teorema;
    }

	/**
     * Deletes one of the theorems of the table.
     * @param id Is the principal key of the theorem to delete.
     * @return Nothing.
     */ 
    @Override
    @Transactional
    public void deletePureCombsTheorem(int id) {
        pureCombsTheoremDAO.deletePureCombsTheorem(id);
    }
    
    @Override
    @Transactional
    public PureCombsTheorem updatePureCombsTheorem(PureCombsTheorem teorema) {
        pureCombsTheoremDAO.updatePureCombsTheorem(teorema);
        
        return null;
    }

	/**
     * Method to get a theorem by its principal key.
	 * If it exists, it parses the string associated with the object.
     * @param id Is the principal key of the theorem.
     */
    @Override
    @Transactional
    public PureCombsTheorem getPureCombsTheorem(int id) {
        PureCombsTheorem teo = pureCombsTheoremDAO.getPureCombsTheorem(id);
        if (teo != null) {
            teo.setStatementTerm(CombUtilities.getTerm(teo.getStatement(),null,null));
        }
        return teo;
    }

    /**
     * Method to get a list of all the entries of the table (all the theorems),
	 * and parsing them in order to be used.
     */
    @Override
    @Transactional
    public List<PureCombsTheorem> getAllPureCombsTheorem() {
        List<PureCombsTheorem> teoList = pureCombsTheoremDAO.getAllPureCombsTheorem();
        try {
            for (PureCombsTheorem teo : teoList) {
                //ter.setTermObject((Term)ToString.fromString(ter.getSerializado()));
                teo.setStatementTerm(CombUtilities.getTerm(teo.getStatement(),null,null));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return teoList;
    }

    /**
     * Method to get a theorem that corresponds to a statement, and then parsing it.
     * @param enunciado Is the statement used to filter the search.
     */
    @Override
    public PureCombsTheorem getTeoremaByEnunciado(String enunciado) {
        PureCombsTheorem teo = pureCombsTheoremDAO.getTeoremaByEnunciado(enunciado);
        if (teo != null) {
            teo.setStatementTerm(CombUtilities.getTerm(teo.getStatement(),null,null));
        }
        return teo;
    }
}
