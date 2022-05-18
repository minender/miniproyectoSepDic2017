package com.calclogic.proof;

import com.calclogic.lambdacalculo.Term;
import com.calclogic.lambdacalculo.TypeVerificationException;

/**
 *
 * @author ronald
 */
public interface FinishedProofMethod {

    /**
     * This function checks if a base demonstration has finished depending on the method used.
     * If it determines it has not finished, it returns the same proof tree given as argument.
     * 
     * @param theoremBeingProved: The theorem the user is trying to prove
     * @param proof: The proof tree so far
     * @param username: name of the user doing the proof
     * @param method: method used in the demonstration
     * @return new proof if finished, else return the same proof
     */
    public Term finishedBaseMethodProof(Term theoremBeingProved, Term proof, String username, String method);

    /**
     * This function checks if a demonstration that uses direct method has finished.
     * 
     * @param theoremBeingProved: The theorem the user is trying to prove
     * @param proof: The proof tree so far
     * @param username: name of the user doing the proof
     * @param initialExpr: The expression (could be a theorem) from which the user started the demonstration
     * @param finalExpr: The last line in the demonstration that the user has made
     * @return new proof if finished, else return the same proof
     * @throws com.calclogic.lambdacalculo.TypeVerificationException
     */
    public Term finishedDirectMethodProof(Term theoremBeingProved, Term proof, String username, 
                Term initialExpr, Term finalExpr) throws TypeVerificationException;

    /**
     * This function checks if a demonstration that uses weakening or strengthening method has finished.
     * 
     * @param theoremBeingProved: The theorem the user is trying to prove
     * @param proof: The proof tree so far
     * @param username: name of the user doing the proof
     * @param method: method used in the demonstration
     * @param expr: The root of the proof tree, which is the last line
     * @return new proof if finished, else return the same proof
     * @throws com.calclogic.lambdacalculo.TypeVerificationException
     */
    public Term finishedWeakeningStrengtheningMethodProof(Term theoremBeingProved, Term proof,
                String username, String method, Term expr) throws TypeVerificationException;
    
    /**
     * This function will only be correct if called when using a waiting method
     * It will return a new proof tree in case it finds out that the last inference
     * caused the whole proof to be correct under the sub-proof method. In other case it will return 
     * the proof given as argument.
     * 
     * @param theoremBeingProved: The theorem that user is trying to prove 
     * @param proof: The proof tree so far
     * @param method: method used in the demonstration
     * @return proof of theoremBeingProved if finished, else return the same proof
     */
    public Term finishedWaitingMethodProof(Term theoremBeingProved, Term proof, String method);
    
    /**
     * This function will only be correct if called when using And Introduction method
     * This function will return a new proof tree that connects in one proof of P/\Q, 
     * two independent sub proofs of P and Q.
     * 
     * @param originalTerm: The current proof  
     * @param finalProof: The proof of second sub proof
     * @return proof of conjunction of two sub proofs
     */
    public Term finishedAI2Proof(Term originalTerm, Term finalProof);
}