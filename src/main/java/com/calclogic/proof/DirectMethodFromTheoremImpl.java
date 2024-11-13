/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.calclogic.proof;

import com.calclogic.entity.Resuelve;
import com.calclogic.lambdacalculo.App;
import com.calclogic.lambdacalculo.Const;
import com.calclogic.lambdacalculo.Equation;
import com.calclogic.lambdacalculo.Sust;
import com.calclogic.lambdacalculo.Term;
import com.calclogic.lambdacalculo.TypeVerificationException;
import com.calclogic.lambdacalculo.TypedA;
import com.calclogic.lambdacalculo.TypedApp;
import com.calclogic.lambdacalculo.TypedI;
import com.calclogic.lambdacalculo.TypedM;
import com.calclogic.lambdacalculo.TypedS;
import com.calclogic.service.ResuelveManager;
import com.calclogic.service.SimboloManager;
import java.util.List;

/**
 *
 * @author feder
 */
public class DirectMethodFromTheoremImpl extends DirectMethodFromStatementImpl implements DirectMethodFromTheorem {
    
    public DirectMethodFromTheoremImpl(){
        setInitVariables("DT");
    }
    
    /**
     * Auxiliar method for "finishedBaseMethodProof" that implements the corresponding
     * logic according to the direct method.It assumes we have a proof that so far has proved A == ...== F
     * 
     * 
     * @param formulaBeingProved: Formula that the user is trying to prove in this proof/sub-proof
     * @param proof: The proof tree so far
     * @param username: name of the user doing the proof
     * @param resuelveManager
     * @param s
     * @param expr: The root of the proof tree, which is the last line
     * @param initialExpr: The expression (could be a theorem) from which the user started the demonstration
     * @param finalExpr: The last line in the demonstration that the user has made
     * @return new proof if finished, else returns the same proof
     * @throws com.calclogic.lambdacalculo.TypeVerificationException
     */
    @Override
    public Term auxFinBaseMethodProof(Term formulaBeingProved, Term proof, String username,
                ResuelveManager resuelveManager, SimboloManager s, 
                Term expr, Term initialExpr, Term finalExpr) throws TypeVerificationException
    {
        // Case when we started from the theorem being proved
        formulaBeingProved = ((App)formulaBeingProved).q.body();
        finalExpr = finalExpr.body();
        initialExpr = initialExpr.body();

        // Case when we started from another theorem
        if(finalExpr.equals(formulaBeingProved)) { 
            Term aux = new App(new App(new Const(0,"="),new Const(-1,"T")),initialExpr).abstractEq(null);
            TypedA A = new TypedA(aux.traducBD(),username);

            if (A.getNSt().equals("")) { 
                int idOp = ((Const)((App)((App)initialExpr).p).p).getId();
                initialExpr= new App(new App(new Const(0,"="),((App)((App)initialExpr).p).q),((App)initialExpr).q);
                initialExpr = initialExpr.abstractEq(null).traducBD(); 
                Term M = new TypedM(idOp,initialExpr,username); 
                return new TypedApp(proof, M);
            }
            else 
                return new TypedApp(proof, A);
        }
        return proof; 
    }
    
    /**
     * This function delete the last part of the proof depends of the method
     * 
     * @param proof: The current proof
     * @return proof without the last part of the proof that finish the proof
     */
    public Term deleteFinishProof(Term proof) {
        return ((App)proof).p;
    }
}
