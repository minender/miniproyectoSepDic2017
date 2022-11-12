package com.calclogic.proof;

import com.calclogic.forms.GenericResponse;
import com.calclogic.lambdacalculo.Term;
import com.calclogic.lambdacalculo.TypeVerificationException;
import com.calclogic.service.ResuelveManager;
import com.calclogic.service.DisponeManager;

import java.util.List;

/**
 *
 * @author ronald
 */
public interface CrudOperations {
    
    /**
     * This function gives the corresponding class of the specified
     * demonstration method
     *
     * @param method: Identifier of the method that will be created
     * @return The object with all variables and functions related to the method
     */
    public GenericProofMethod returnProofMethodObject(String method);

    /**
     * The statement that is needed to prove changes inside a sub proof. This method 
     * calculates the statement within all the sub proofs a return the one in the 
     * current sub proof
     *  
     * @param beginFormula: general statement to be proved, is the base to calculate 
     *                      al de sub statement in the sub proofs
     * @param method: Term that represent the current state of the proof method. This
     *                term had the information about what is the current sub proof
     * @return Term that represent the statement to be proved in the current sub proof.
     */
    public Term initStatement(Term beginFormula, Term method);

    public Term currentMethod(Term method);

    /**
     * This method return the sub Term of typedTerm that represent the derivation tree 
     * of only the current sub proof of the first And Introduction method searched in 
     * method parameter.
     *  
     * @param typedTerm: Term that represent all the current proof.
     * @param method: Term that represent the current state of the proof method. This
     *                term had the information about what is the current sub proof
     * @return sub Term of typedTerm that represent the derivation tree 
     *         of only the current sub proof of the first And Introduction method searched 
     *         in method parameter.
     */
    public Term getSubProof(Term typedTerm, Term method);
    
    /**
     * This method return the sub Term of typedTerm that represent the derivation tree 
     * of only the current sub proof if isRecursive parameter is true. If isRecursive 
     * is false this method return the sub Term of typedTerm that represent the derivation tree 
     * of only the current sub proof of the first And Introduction method searched in 
     * method parameter.
     *  
     * @param typedTerm: Term that represent all the current proof.
     * @param method: Term that represent the current state of the proof method. This
     *                term had the information about what is the current sub proof.
     * @param isRecursive: if the value is true, the search of the sub proof call this 
     *                     method recursively.
     * @return sub Term of typedTerm that represent the derivation tree 
     *         of only the current sub proof. The deep of the sub proof depend on the 
     *         value of isRecursive
     */
    public Term getSubProof(Term typedTerm, Term method, boolean isRecursive);

    /**
     * This method returns the sub Term of typedTerm that represent the derivation tree 
     * of only the current sub proof and the father tree of this subproof.
     *  
     * @param typedTerm: Term that represent all the current proof.
     * @param method: Term that represent the current state of the proof method. This
     *                term had the information about what is the current sub proof.
     * @param li
     * @return List with sub Term of typedTerm that represent the derivation tree 
     *         of only the current sub proof and the father of this sub proof.
     */
    public List<Term> getFatherAndSubProof(Term typedTerm, Term method, List<Term> li);

    /**
     * When in a demonstration we need to use a theorem or metatheorem as a hint 
     * (for inference, instantiation or substitution), we need to get its 
     * statement. This function does it.
     *
     * @param response: Entry-exit parameter. In case there is an error, we set
     *                  that error here in the parameter and the caller must then
     *                  inmediately return the updated response.
     * @param nStatement: Number of the statement, as a string, that will be looked for.
     * @param username: login of the user that made the request.
     * @param resuelveManager
     * @param disponeManager
     * @return The statement of the theorem or metatheorem.
     */
    public Term findStatement(GenericResponse response, String nStatement, String username, 
                                ResuelveManager resuelveManager, DisponeManager disponeManager);

    /**
     * It finds the id of the operator of a binary expression. 
     * For example, if we have P == Q, the main operator is ==, and its id is 1
     * 
     * @param formula: Expression whose main operator id will be found.
     * @param methodTerm: Tree of methods that the user has selected to do the proof
     * @return The id of the main operator.
     */
    public int binaryOperatorId(Term formula, Term methodTerm);

    /**
     * This method adds a proof method for currentMethod to get a new compose method. 
     * If currentMethod is of the form ...M1 (M2 (M3...Mn)), then the method return  
     * ...M1 (M2 (M3...(Mn newMethod))). If currentMethod is of the from 
     * ...AI (M2 (M3...Mn)) where (M2 (M3...Mn)) is not waiting method then the method 
     * return ...((AI (M2 (M3...Mn))) newMethod). If currentMethod is of the from 
     * ...((AI (M2 (M3...Mn))) (N1 (N2 (N3...Nm)))) where (N1 (N2 (N3...Nm))) is 
     * waiting method, then the method return 
     * ...((AI (M2 (M3...Mn))) (N1 (N2 (N3...(Nm newMethod)))))
     *  
     * @param currentMethod: Term that represent the current state of the proof method
     * @param newMethod: new no compose Method 
     * @return Term that represent a new proof method compose by currentMethod and newMethod.
     */
    public Term updateMethod(String currentMethod, String newMethod);
    
    /**
     * This method constructs a new derivation tree adding an one step infer to a proof.This is not a pure function; it may change the the values of its given params in an external context.
     * 
     * @param proof: Term that represents a proof
     * @param infer: Term that represents one step infer
     * @param objectMethod: object with all the functions related to a method
     * @return new TypedTerm that represents a new derivation tree that 
     *         adds in the last line of proof the infer
     * @throws com.calclogic.lambdacalculo.TypeVerificationException
     */
    public Term addInferToProof(String user, Term proof, Term infer, GenericProofMethod objectMethod) throws TypeVerificationException;

    /**
     * This method add 'formula' in one line sub proof for the current sub proof in 
     * (typedTerm, method).
     *  
     * @param formula: first line to add for the current sub proof
     * @param typedTerm: term that represent the current proof
     * @param method: Term that represent the current state of the proof method. This
     *                term had the information about what is the current sub proof
     * @return Term that represent the statement to be proved in the current sub proof.
     */
    public Term addFirstLineSubProof(String user, Term formula, Term typedTerm, Term method);
    
    /**
     * This method erase one basic proof method for currentMethod. 
     * If currentMethod is of the form ...M1 (M2 (M3...(Mn M))), then the method return  
     * ...M1 (M2 (M3...Mn)). If currentMethod is of the from 
     * ...(AI (M2 (M3...Mn)) M) then the method  return ...(AI (M2 (M3...Mn))). 
     * If currentMethod is of the from ...((AI (M2 (M3...Mn))) (N1 (N2 (N3...(Nm M))))) is 
     * then the method return ...((AI (M2 (M3...Mn))) (N1 (N2 (N3...Nm))))
     *  
     * @param currentMethod: String that encode the current state of the proof method
     * @return Term that represent a new proof method exactly as currentMethod but without the 
     *         last proof method. If currentMethod encode an Atomic method return null.
     */
    public Term eraseMethod(String currentMethod);
}