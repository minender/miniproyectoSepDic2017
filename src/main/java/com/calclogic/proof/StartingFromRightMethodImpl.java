/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.calclogic.proof;

import com.calclogic.lambdacalculo.App;
import com.calclogic.lambdacalculo.Const;
import com.calclogic.lambdacalculo.Term;
import com.calclogic.lambdacalculo.TypeVerificationException;
import com.calclogic.lambdacalculo.TypedApp;
import com.calclogic.lambdacalculo.TypedM;
import com.calclogic.lambdacalculo.TypedS;
import com.calclogic.service.ResuelveManager;
import com.calclogic.service.SimboloManager;

/**
 *
 * @author feder
 */
public class StartingFromRightMethodImpl extends StartingFromLeftMethodImpl implements StartingFromRightMethod {
    
    public StartingFromRightMethodImpl(){
        setInitVariables("SR");
    }
    
    /**
     * Auxiliar method for "finishedBaseMethodProof" that implements the corresponding
     * logic according to the starting from one side method.
     * 
     * It assumes we have a proof that so far has proved A == ... == F
     * 
     * @param formulaBeingProved: Formula that the user is trying to prove in this proof/sub-proof
     * @param proof: The proof tree so far
     * @param username: name of the user doing the proof
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
        // If Formula that the user is trying to prove in this proof/sub-proof is of the form H => A == B, then H /\ A ==  H /\ B must be given instead)
        if(initialExpr.body().traducBD().equals(((App)((App)formulaBeingProved).p).q.body().traducBD()) 
                && finalExpr.body().traducBD().equals(((App)formulaBeingProved).q.body().traducBD())){
            proof = new TypedApp(new TypedS(proof.type()), proof);
        }// en el if anterior tienes que usar body() porque puede ser que el orden de la cadena de 
        // abstracciones, aunque tienen las mismas variables, estan en otro orden con respecto al 
        // enunciado inicial ya que esta volteado o simetrico y esto hace que la busqueda de variables
        // en inorden encuentre las variables en otro orden
        Term operatorTerm = ((App)((App)formulaBeingProved).p).p;
        // The Starting From One Side method only admits reflexive operators
        int resuelveKind = resuelveManager.isReflexiveOperatorForUser(username, operatorTerm.toString());
        new TypedM(resuelveKind, ((Const)operatorTerm).getId(), proof, "", username);
        return proof;
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
