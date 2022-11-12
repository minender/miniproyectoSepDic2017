package com.calclogic.proof;

import com.calclogic.lambdacalculo.App;
import com.calclogic.lambdacalculo.Bracket;
import com.calclogic.lambdacalculo.Const;
import com.calclogic.lambdacalculo.Sust;
import com.calclogic.lambdacalculo.Var;
import com.calclogic.lambdacalculo.Term;
import com.calclogic.lambdacalculo.TypeVerificationException;
import com.calclogic.lambdacalculo.TypedApp;
import com.calclogic.lambdacalculo.TypedI;
import com.calclogic.lambdacalculo.TypedL;
import com.calclogic.service.DisponeManager;
import com.calclogic.service.ResuelveManager;
import com.calclogic.service.SimboloManager;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

import org.springframework.stereotype.Service;

/**
 *
 * @author ronald
 */
@Service
public class GenericProofMethodImpl implements GenericProofMethod{

    // It can be "DM", "SS", "WE", etc.
    protected String methodStr = null; 

    // It will be "D" when methodStr is "DM" or "SS".
    // It will be "T" when methodStr is "TR", "WE" or "ST".
    // It will be "B" when methodStr is "AI", "CA" or "MI".
    protected String groupMethod = null;

    // Determines if the method of the current class is basic or recursive
    protected Boolean isRecursiveMethod = false;

    /**
     * Establishes the necessary initial class variables according
     * to the current method.
     * 
     * @param method: String that represents the proof method of the current class
     */
    protected void setInitVariables(String method){
        setMethodStr(method);
        setGroupMethod(method);
        setIsRecursiveMethod(method);
    }

    private void setMethodStr(String method){
        this.methodStr = method;
    }

    @Override
    public String getMethodStr(){
        return this.methodStr;
    }

    private void setGroupMethod(String method){
        if (method.equals("DM") || method.equals("SS")){
            this.groupMethod = "D"; 
        }
        else if (method.equals("TR") || method.equals("WE") || method.equals("ST")){
            this.groupMethod = "T"; // All transitive methods
        }
        else if (method.equals("AI") || method.equals("CA")){
            this.groupMethod = "B"; // All recursive but branched methods (they split in more than one sub-proof)
        }
    }

    @Override
    public String getGroupMethod(){
        return this.groupMethod;
    }

    private void setIsRecursiveMethod(String method){
        if (method.equals("CR") || method.equals("CO") || method.equals("AI") || method.equals("CA") || method.equals("MI")){
            this.isRecursiveMethod = true;
        }
    }

    @Override
    public Boolean getIsRecursiveMethod(){
        return this.isRecursiveMethod;
    }

    /**
     * TO BE OVERWRITTEN
     * 
     * The statement that is needed to prove may change inside a sub proof,
     * so this function calculates which that new statement is.
     *  
     * @param beginFormula: general statement to be proved, is the base to calculate 
     *                      al de sub statement in the sub proofs.
     * @return Term that represents the statement to be proved in the current sub proof,
     *         according to the demonstrarion method used
     */
    @Override
    public Term initFormula(Term beginFormula){
        return beginFormula;
    }

    /**
     * TO BE OVERWRITTEN
     * 
     * Indicates the header that a proof that starts with the current demonstration
     * method must have.
     *  
     * @param phrase: Argument to complete the header, that will vary according to the method
     * @return The header message to be added to the proof
     */
    @Override
    public String header(String phrase){
        return "";
    }

    /**
     * Indicates the header of a sub-proof of a branched recursive method
     *  
     * @param statement: Statement that needs to be demonstrated in the current sub-proof
     * @return The header message to be added to the proof
     */
    @Override
    public String subProofInit(String statement){
        return "Statement:<br>" + statement + "Sub Proof:<br>";
    }

    /**
     * This function will create a hint for the current method if it is basic, given the hint's elements.In case the elements don't make sense it will return null.
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
    @Override
    public Term createBaseMethodInfer(String user,Term A, ArrayList<Object> instantiation, String instantiationString, 
            Bracket leibniz, String leibnizString, Term formulaBeingProved) throws TypeVerificationException
    {
        Term infer = null;
        TypedI I;
        Term theoremHint = A.type().setToPrint();
        TypedL L;
        Boolean noInstantiation = instantiationString.equals("");
        Boolean noLeibniz = leibnizString.equals("");

        // Direct, starting from one side, transitivity, weakening or strengthening method
        if ( ("D".equals(this.groupMethod)) || ("T".equals(this.groupMethod)) ) {
            Term C;       
            if (noInstantiation && noLeibniz){
                infer = A;
            }
            else if (noInstantiation){
                if (("T".equals(this.groupMethod)) && theoremHint instanceof App && ((App)theoremHint).p instanceof App &&
                     (C=((App)(((App)theoremHint).p)).p) != null && C instanceof Const &&
                     (((Const)C).getId() == 2 || ((Const)C).getId() == 3) ){

                    infer = parityLeibniz(leibniz, A);
                }else {
                    L = new TypedL(leibniz);
                    infer = new TypedApp(L,A);
                } 
            }
            else{

                I = new TypedI(new Sust((ArrayList<Var>)instantiation.get(0), (ArrayList<Term>)instantiation.get(1)));
                if (noLeibniz){
                    infer = new TypedApp(I,A);
                }
                else if (("T".equals(this.groupMethod)) && theoremHint instanceof App && ((App)theoremHint).p instanceof App &&
                        (C=((App)((App)theoremHint).p).p) != null && C instanceof Const &&
                        (((Const)C).getId() == 2 || ((Const)C).getId() == 3) ){

                    infer = parityLeibniz(leibniz,new TypedApp(I,A));
                } else {
                    L = new TypedL((Bracket)leibniz);
                    infer = new TypedApp(L,new TypedApp(I,A));
                }
            }
        }
        // Assume the antecedent case should be here
        return infer;
    }

    /**
     * TO BE OVERWRITTEN
     * 
     * This method will return the typedTerm that represents the sub derivation
     * tree that infer de use on Leibniz in weakening/strengthening 
     * 
     * @param leibniz: Term that represent de Leibniz expression 
     * @param nabla: derivation with root P op Q. The root is to be use as argument 
     *             for Leibniz rule with op in {Rightarrow,Leftarrow}
     * 
     * @return new TypedTerm that represent a derivation with root 
     *         (lambda z.E)P op_2 (lambda z.E)Q with op_2 in {Rightarrow,Leftarrow}
     * @throws com.calclogic.lambdacalculo.TypeVerificationException
     */
    protected Term parityLeibniz(Term leibniz, Term nabla) throws TypeVerificationException {
        return nabla;
    }

    /**
     * TO BE OVERWRITTEN
     *
     * Returns the index of the first inference that is not a 
     * equiv or = in a Transitivity method
     * 
     * @param typedTerm Derivation tree that code a Transitivity proof
     * @param reverse Determines if we want the index but counting in reverse
     * @return index of the first no =inference
     */
    @Override
    public int transFirstOpInferIndex(Term typedTerm, Boolean reverse) {
        return -1;
    } 

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
    @Override
    public String setBaseMethodProof(String historial, String user, Term typedTerm, boolean solved, 
                ResuelveManager resuelveManager, DisponeManager disponeManager, SimboloManager s)
    {
        return historial;
    }

    /**
     * The finished function depends on if the demonstration method is basic,
     * linear recursive or branched recursive, so this calls the corresponding one.
     * 
     * @param originalTerm: It can be Formula that the user is trying to prove in this proof/sub-proof
     * or a part of the demosntration when the method is branched recursive.
     * @param proof: The proof tree so far
     * @return new proof if finished, else return the same proof
     */
    @Override
    public Term finishedMethodProof(Term originalTerm, Term proof){
        return finishedMethodProof(originalTerm, proof, null, null, null);
    }

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
    @Override
    public Term finishedMethodProof(Term originalTerm, Term proof, String username,
            ResuelveManager resuelveManager, SimboloManager simboloManager) 
    {
        if ("B".equals(this.groupMethod)){
            return finishedBranchedRecursiveMethodProof(username, originalTerm, proof);
        }
        else if (this.isRecursiveMethod){
            return finishedLinearRecursiveMethodProof(username,originalTerm, proof);
        }

        return finishedBaseMethodProof(originalTerm, proof, username, resuelveManager, simboloManager);
    }

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
    @Override
    public Term finishedBaseMethodProof(Term formulaBeingProved, Term proof, String username, 
        ResuelveManager resuelveManager, SimboloManager simboloManager)
    {
        Term expr = proof.type().setToPrint(); // The root of the proof tree, which is the last line
        Term initialExpr = ((App)expr).q; // The expression (could be a theorem) from which the user started the demonstration
        Term finalExpr = ((App)((App)expr).p).q; // The last line in the demonstration that the user has made

        try{
            return auxFinBaseMethodProof(formulaBeingProved, proof, username, resuelveManager, simboloManager, 
                                        expr, initialExpr, finalExpr);
        }
        catch (TypeVerificationException e)  {
            Logger.getLogger(GenericProofMethod.class.getName()).log(Level.SEVERE, null, e); 
        } 
        return proof;
    }

    /**
     * TO BE OVERWRITTEN
     * 
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
                Term expr, Term initialExpr, Term finalExpr) throws TypeVerificationException
    {
        return proof;
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
             
        } catch (TypeVerificationException e)  {
            Logger.getLogger(GenericProofMethod.class.getName()).log(Level.SEVERE, null, e); 
        }
        return proof;
    }

    /**
     * TO BE OVERWRITTEN
     *
     * Auxiliar method for "finishedLinearRecursiveMethodProof" that implements the corresponding
     * logic according to the current demonstration method.
     * 
     * @param user
     * @param formulaBeingProved: Formula that the user is trying to prove in this proof/sub-proof 
     * @param vars: List of variables for doing parallel substitution
     * @param terms: List of terms for doing parallel substitution
     * @return axiom tree that will later be used to build the complete proof
     * @throws com.calclogic.lambdacalculo.TypeVerificationException
     */
    protected Term auxFinLinearRecursiveMethodProof(String user, Term formulaBeingProved, List<Var> vars, List<Term> terms)
            throws TypeVerificationException
    {
        return null;
    }

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
    @Override
    public Term finishedBranchedRecursiveMethodProof(String user,Term originalTerm, Term finalProof) {
        try {
            // The next two lists are for doing a parallel substitution [x1, x2,... := t1, t2, ...]
            List<Var> vars = new ArrayList<>();
            List<Term> terms = new ArrayList<>();

            return auxFinBranchedRecursiveMethodProof(user, originalTerm, vars, terms, finalProof);
        } 
        catch (TypeVerificationException e)  {
            Logger.getLogger(GenericProofMethod.class.getName()).log(Level.SEVERE, null, e); 
        }
        return finalProof;
    }

    /**
     * TO BE OVERWRITTEN

     * Auxiliar method for "finishedBranchedRecursiveMethodProof" that implements the corresponding
     * logic according to the current demonstration method.
     *
     * @param user
     * @param originalTerm: The current proof  
     * @param vars: List of variables for doing parallel substitution
     * @param terms: List of terms for doing parallel substitution
     * @param finalProof: The proof of second sub proof
     * @return axiom tree that will later be used to build the complete proof
     * @throws com.calclogic.lambdacalculo.TypeVerificationException
     */
    protected Term auxFinBranchedRecursiveMethodProof(String user, Term originalTerm, List<Var> vars, List<Term> terms, Term finalProof)
            throws TypeVerificationException
    {
        return null;
    }
}