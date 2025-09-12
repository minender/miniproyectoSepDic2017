/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.calclogic.proof;

import com.calclogic.lambdacalculo.Term;
import com.calclogic.lambdacalculo.TypeVerificationException;
import com.calclogic.lambdacalculo.TypedApp;
import com.calclogic.lambdacalculo.TypedS;
import com.calclogic.lambdacalculo.Var;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author feder
 */
public class EquanimityFromRightMethodImpl extends ModusPonensMethodImpl implements EquanimityFromRightMethod{
     
    public EquanimityFromRightMethodImpl(){
        setInitVariables("ER");
    }

    /**
     * This function will only be correct if called when using a linear recursive method.
     * It will return a new proof tree in case it finds out that the last inference
     * caused the whole proof to be correct under the sub-proof method. In other case it will return 
     * the proof given as argument.
     * 
     * @param user
     * @param formulaBeingProved: Formula that the user is trying to prove in this proof/sub-proof 
     * @param proof: The proof tree so far
     * @return proof of formulaBeingProved if finished, else return the same proof
     */
    @Override
    public Term finishedLinearRecursiveMethodProof(String user, Term formulaBeingProved, Term proof) {
        try {
            // The next two lists are for doing a parallel substitution [x1, x2,... := t1, t2, ...]
            List<Var> vars = new ArrayList<>();
            List<Term> terms = new ArrayList<>();

            Term axiomTree = auxFinLinearRecursiveMethodProof(user, formulaBeingProved, vars, terms);

            return new TypedApp(axiomTree, proof);
             
        } catch (TypeVerificationException e) {
            Logger.getLogger(GenericProofMethod.class.getName()).log(Level.SEVERE, null, e); 
        }
        return proof;
    }    
}
