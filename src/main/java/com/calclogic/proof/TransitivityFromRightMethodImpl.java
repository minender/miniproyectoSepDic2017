/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.calclogic.proof;

import com.calclogic.lambdacalculo.App;
import com.calclogic.lambdacalculo.Term;
import com.calclogic.lambdacalculo.TypeVerificationException;
import com.calclogic.service.ResuelveManager;
import com.calclogic.service.SimboloManager;

/**
 *
 * @author feder
 */
public class TransitivityFromRightMethodImpl extends TransitivityFromLeftMethodImpl implements TransitivityFromRightMethod{

    public TransitivityFromRightMethodImpl() {
        Bool = true;
        setInitVariables("TR");
    }
    
    /**
     * Auxiliar method for "finishedBaseMethodProof" that implements the corresponding
     * logic according to the transitivity method.It assumes we have a proof that so far has proved A == ...== F
     * 
     * 
     * @param formulaBeingProved: Formula that the user is trying to prove in this proof/sub-proof
     * @param proof: The proof tree so far
     * @param username: name of the user doing the proof
     * @param resuelveManager
     * @param simboloManager
     * @param expr: The root of the proof tree, which is the last line
     * @param initialExpr: The expression (could be a theorem) from which the user started the demonstration
     * @param finalExpr: The last line in the demonstration that the user has made
     * @return new proof if finished, else returns the same proof
     * @throws com.calclogic.lambdacalculo.TypeVerificationException
     */
    @Override
    public Term auxFinBaseMethodProof(Term formulaBeingProved, Term proof, String username,
                ResuelveManager resuelveManager, SimboloManager simboloManager, 
                Term expr, Term initialExpr, Term finalExpr) throws TypeVerificationException
    {
        return auxFinBaseMethodReversed(formulaBeingProved, proof, username, resuelveManager, 
                                        simboloManager, expr, initialExpr, finalExpr);
    }
    
    /**
     * This function delete the last part of the proof depends of the method
     * 
     * @param proof: The current proof
     * @return proof without the last part of the proof that finish the proof
     */
    public Term deleteFinishProof(Term proof) {
        return ((App)proof).q;
    }
}
