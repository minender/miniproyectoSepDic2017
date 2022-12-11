/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.calclogic.proof;

import com.calclogic.lambdacalculo.App;
import com.calclogic.lambdacalculo.Const;
import com.calclogic.lambdacalculo.Sust;
import com.calclogic.lambdacalculo.Term;
import com.calclogic.lambdacalculo.TypeVerificationException;
import com.calclogic.lambdacalculo.TypedA;
import com.calclogic.lambdacalculo.TypedApp;
import com.calclogic.lambdacalculo.TypedI;
import com.calclogic.lambdacalculo.TypedM;
import com.calclogic.lambdacalculo.Var;
import com.calclogic.parse.CombUtilities;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import org.springframework.stereotype.Service;

/**
 * 
 * 
 *
 * @author feder
 */
@Service
public class OperatorToEqualityImpl extends GenericProofMethodImpl implements OperatorToEquality  {
    
    public OperatorToEqualityImpl(){
        setInitVariables("OE");
    }

    /**
     * The statement that is needed to be proven may change inside a sub proof,
     * so this function calculates which that new statement is.
     *  
     * @param beginFormula: general statement to be proved, is the base to calculate 
     *                      al de sub statement in the sub proofs.
     * @return Term that represents the statement to be proved in the current sub proof.
     */
    @Override
    public Term initFormula(Term beginFormula){
        // this convert formulas like lamb x.t1=lamb x.t2 into t1==t2
        return beginFormula.setToPrint();
    }

    /**
     * Indicates the header that a proof that starts with contradiction
     * method must have.
     *  
     * @param statement: New statement that needs to be proved according to this method
     * @return The header message to be added to the proof
     */
    @Override
    public String header(String statement){
        return "";
    }

    /**
     * Auxiliar method for "finishedLinearRecursiveMethodProof" that implements the corresponding
     * logic according to the contradiction method.
     * 
     * @param formulaBeingProved: Formula that the user is trying to prove in this proof/sub-proof 
     * @param vars: List of variables for doing parallel substitution
     * @param terms: List of terms for doing parallel substitution
     * @return axiom tree that will later be used to build the complete proof
     */
    @Override
    public Term finishedLinearRecursiveMethodProof(String user, Term formulaBeingProved, Term proof)
    {
        try {
            return new TypedM(4, 1, proof, "= \\Phi_{} (\\Phi_{cb} c_{8} c_{1})", user);
             
        } catch (TypeVerificationException e)  {
            Logger.getLogger(GenericProofMethod.class.getName()).log(Level.SEVERE, null, e); 
        }
        return proof;
    }
}