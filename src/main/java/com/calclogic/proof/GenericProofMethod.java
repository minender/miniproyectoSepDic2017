package com.calclogic.proof;

import com.calclogic.lambdacalculo.Bracket;
import com.calclogic.lambdacalculo.Term;
import com.calclogic.lambdacalculo.TypeVerificationException;
import com.calclogic.service.DisponeManager;
import com.calclogic.service.ResuelveManager;
import com.calclogic.service.SimboloManager;
import java.util.ArrayList;

/**
 *
 * @author ronald
 */
public interface GenericProofMethod {

    public String getMethodStr();
    public String getGroupMethod();
    public Boolean getIsRecursiveMethod();

    /**
     * The statement that is needed to prove may change inside a sub proof,
     * so this function calculates which that new statement is.
     *  
     * @param beginFormula: General statement to be proved, is the base to calculate 
     *                      all the sub statement in the sub proofs.
     * @return Term that represents the statement to be proved in the current sub proof,
     *         according to the demonstrarion method used
     */
    public Term initFormula(Term beginFormula);

    /**
     * Indicates the header that a proof that starts with the current demonstration
     * method must have.
     *  
     * @param phrase: Argument to complete the header, that will vary according to the method
     * @return The header message to be added to the proof
     */
    public String header(String phrase);

    /**
     * Indicates the header of a sub-proof of a branched recursive method
     *  
     * @param statement: Statement that needs to be demonstrated in the current sub-proof
     * @return The header message to be added to the proof
     */
    public String subProofInit(String statement);

    /**
     * This function will create a step for the current method if it is basic, given the hint's elements.
     * In case the elements don't make sense it will return null.
     *
     * @param user 
     * @param A: theorem used on the hint
     * @param instantiation: instantiation used on the hint in the form of arrays of variables and terms
     * @param instantiationString: string that was used to parse instantiation
     * @param leibniz: bracket that represents Leibniz on the hint
     * @param leibnizString: string that was used to parse Leibniz
     * @param formulaBeingProved: current formula that the user is proving using this hint
     *  >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> THIS PARAM I THINK WAS USED FOR NATURAL DEDUCTION, NOT PRESENT CURRENTLY.
     * @return a hint for the direct method
     * @throws com.calclogic.lambdacalculo.TypeVerificationException
     */
    public Term createOneStepInfer(String user,Term A, ArrayList<Object> instantiation, String instantiationString, 
            Bracket leibniz, String leibnizString, Term formulaBeingProved) throws TypeVerificationException;

    /**
     * Returns the index of the first inference that is not a 
     * equiv or = in a Transitivity method
     * 
     * @param typedTerm Derivation tree that code a Transitivity proof
     * @param reverse Determines if we want the index but counting in reverse
     * @return index of the first no =inference
     */
    public int transFirstOpInferIndex(Term typedTerm, Boolean reverse);

    /**
     * This function adds a step of a proof into a bigger proof.
     *
     * @param historial
     * @param user
     * @param typedTerm
     * @param solved
     * @param resuelveManager
     * @param disponeManager
     * @param s
     * @return 
     */
    public String setBaseMethodProof(String historial, String user, Term typedTerm, boolean solved, 
                ResuelveManager resuelveManager, DisponeManager disponeManager, SimboloManager s);

    /**
     * The finished function depends on if the demonstration method is basic,
     * linear recursive or branched recursive, so this calls the corresponding one.
     * 
     * @param originalTerm: It can be Formula that the user is trying to prove in this proof/sub-proof
     * or a part of the demosntration when the method is branched recursive.
     * @param proof: The proof tree so far
     * @return new proof if finished, else return the same proof
     */
    public Term finishedMethodProof(Term originalTerm, Term proof);

    /**
     * Auxiliar method for "finishedBaseMethodProof" that implements the corresponding
     * logic according to the current demonstration method.
     * 
     * @param formulaBeingProved: Formula that the user is trying to prove in this proof/sub-proof
     * @param proof: The proof tree so far
     * @param username: name of the user doing the proof
     * @param resuelveManager
     * @param simboloManager
     * @param expr: The root of the proof tree, which is the last line
     * @param initialExpr: The expression (could be a theorem) from which the user started the demonstration
     * @param finalExpr: The last line in the demonstration that the user has made
     * @return new proof if finished, else return the same proof
     * @throws com.calclogic.lambdacalculo.TypeVerificationException
     */
    public Term auxFinBaseMethodProof(Term formulaBeingProved, Term proof, String username,
                ResuelveManager resuelveManager, SimboloManager simboloManager,
                Term expr, Term initialExpr, Term finalExpr) throws TypeVerificationException;

    /**
     * The finished function depends on if the demonstration method is basic,
     * linear recursive or branched recursive, so this calls the corresponding one.
     * 
     * @param originalTerm: It can be Formula that the user is trying to prove in this proof/sub-proof
     * or a part of the demosntration when the method is branched recursive.
     * @param proof: The proof tree so far
     * @param username: name of the user doing the proof
     * @param resuelveManager
     * @param simboloManager
     * @return new proof if finished, else return the same proof
     */
    public Term finishedMethodProof(Term originalTerm, Term proof, String username,
            ResuelveManager resuelveManager, SimboloManager simboloManager);

    /**
     * This function checks if a base demonstration has finished depending on the method used, if it is basic.
     * If it determines it has not finished, it returns the same proof tree given as argument.
     * 
     * @param formulaBeingProved: Formula that the user is trying to prove in this proof/sub-proof
     * @param proof: The proof tree so far
     * @param username: name of the user doing the proof
     * @param resuelveManager
     * @param simboloManager
     * @return new proof if finished, else return the same proof
     */
    public Term finishedBaseMethodProof(Term formulaBeingProved, Term proof, String username, 
        ResuelveManager resuelveManager, SimboloManager simboloManager);

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
    public Term finishedLinearRecursiveMethodProof(String user, Term formulaBeingProved, Term proof);

    /**
     * This function will only be correct if called when using a branched recursive method.
     * Unlike the finished function for linear methods, this function will return a new tree 
     * each time the user makes a new inference in the second branch
     * 
     * @param user
     * @param originalTerm: The current proof  
     * @param finalProof: The proof of second sub proof
     * @return proof of conjunction of two sub proofs
     */
    public Term finishedBranchedRecursiveMethodProof(String user, Term originalTerm, Term finalProof);
}