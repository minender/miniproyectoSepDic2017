package com.calclogic.proof;

import com.calclogic.entity.Resuelve;
import com.calclogic.controller.InferController;
import com.calclogic.lambdacalculo.App;
import com.calclogic.lambdacalculo.Bracket;
import com.calclogic.lambdacalculo.Const;
import com.calclogic.lambdacalculo.Sust;
import com.calclogic.lambdacalculo.Var;
import com.calclogic.lambdacalculo.Term;
import com.calclogic.lambdacalculo.TypeVerificationException;
import com.calclogic.lambdacalculo.TypedA;
import com.calclogic.lambdacalculo.TypedApp;
import com.calclogic.lambdacalculo.TypedI;
import com.calclogic.lambdacalculo.TypedL;
import com.calclogic.lambdacalculo.TypedS;
import com.calclogic.service.DisponeManager;
import com.calclogic.service.ResuelveManager;
import com.calclogic.service.SimboloManager;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author ronald
 */
public class GenericProofMethod {

    // It can be "DM", "SS", "WE", etc.
    protected String methodStr = null; 

    // It will be "D" when methodStr is "DM" or "SS".
    // It will be "T" when methodStr is "TR", "WE" or "ST".
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

    public String getMethodStr(){
        return this.methodStr;
    }

    private void setGroupMethod(String method){
        if (method.equals("DM") || method.equals("SS")){
            this.groupMethod = "D";
        }
        else if (method.equals("TR") || method.equals("WE") || method.equals("ST")){
            this.groupMethod = "T";
        }
    }

    public String getGroupMethod(){
        return this.groupMethod;
    }

    private void setIsRecursiveMethod(String method){
        if (method.equals("CR") || method.equals("CO") || method.equals("AI") || method.equals("CA")){
            this.isRecursiveMethod = true;
        }
    }

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
    public Term initFormula(Term beginFormula){
        return beginFormula;
    }

    /**
     * This function will create a hint for the current method if it is basic, given the hint's elements.
     * In case the elements don't make sense it will return null.
     * 
     * @param theoremHint: theorem used on the hint
     * @param instantiation: instantiation used on the hint in the form of arrays of variables and terms
     * @param instantiationString: string that was used to parse instantiation
     * @param leibniz: bracket that represents Leibniz on the hint
     * @param leibnizString: string that was used to parse Leibniz
     * @param theoremBeingProved: theorem that we are proving using this hint
     * @return a hint for the direct method
     * @throws com.calclogic.lambdacalculo.TypeVerificationException
     */
    public Term createBaseMethodInfer(Term theoremHint, ArrayList<Object> instantiation, String instantiationString, 
            Bracket leibniz, String leibnizString, Term theoremBeingProved) throws TypeVerificationException
    {
        Term infer = null;
        TypedI I;
        TypedA A = new TypedA(theoremHint);
        TypedL L = new TypedL(leibniz);
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
                ResuelveManager resuelveManager, DisponeManager disponeManager, SimboloManager s)
    {
        return historial;
    }

    /**
     * This generates a step in the demonstration of a theorem when the we already have a side 
     * of an equivalence and the next step is the other side. 
     * 
     * At first this might seem exclusive to the starting from one side method, but it is also
     * needed for transitive ones.
     *
     * @param user 
     * @param typedTerm
     * @param resuelveManager
     * @param disponeManager
     * @param s
     * @return The new step of the demonstration as a string
     */
    protected String stepOneSideEq(String user, Term typedTerm, ResuelveManager resuelveManager, DisponeManager disponeManager, SimboloManager s) {
        String teo, leib, inst, newStep;
        teo = leib = inst = newStep = "";

        // if the inference is a modus pones that simulates natural deduction is true this
        boolean naturalInfer=typedTerm instanceof TypedApp && ((TypedApp)typedTerm).inferType=='m';
        Term ultInf = (naturalInfer?((TypedApp)typedTerm).p:typedTerm);

        if (ultInf instanceof App){
            if (((App)ultInf).q instanceof App){
                if (((App)((App)ultInf).q).q instanceof App){
                    //  Term aux = ((App)ultInf.type()).q;
                    // primExp = aux.toStringInf(s,"")+(aux.equals(goal)?equanimityHint:"");
                    teo = ((App)((App)((App)ultInf).q).q).q.type().toStringFinal();
                    inst = ((App)((App)((App)ultInf).q).q).p.type().toStringInf(s,"");
                    inst = "~\\text{with}~" + inst;
                    leib = ((App)((App)ultInf).q).p.type().toStringInf(s,"");
                    leib = "~\\text{and}~" + leib;
                }
                else {
                    //Term aux = ((App)ultInf.type()).q;
                    //primExp = aux.toStringInf(s,"")+(aux.equals(goal)?equanimityHint:"");
                    teo = ((App)((App)ultInf).q).q.type().toStringFinal();
                    if (((App)ultInf).p instanceof TypedS){
                        if (((App)((App)ultInf).q).p instanceof TypedI){
                            inst = ((App)((App)ultInf).q).p.type().toStringInf(s,"");
                            inst = "~\\text{with}~" + inst;
                        }
                        else {
                            leib = ((App)((App)ultInf).q).p.type().toStringInf(s,"");
                            leib = "~\\text{and}~" + leib;
                        }
                    } else {
                        inst = ((App)((App)ultInf).q).p.type().toStringInf(s,"");
                        inst = "~\\text{with}~" + inst;
                        leib = ((App)ultInf).p.type().toStringInf(s,"");
                        leib = "~\\text{and}~" + leib;
                    }
                }
            } else {
                Term pType = ((App)ultInf).p.type();
                if (((App)ultInf).p instanceof TypedI){
                    inst = pType.toStringInf(s,"");
                    inst = "~\\text{with}~" + inst;
                }
                else if (((App)ultInf).p instanceof TypedL){
                    leib = "~\\text{and}~" + pType.toStringInf(s,"");
                }
                // The SA case does not fulfill any of the two conditions above, and only "teo" is assigned
                teo = ((App)ultInf).q.type().toStringFinal();
            }
        } else {
            Term aux = ultInf.type();
            teo = aux.toStringFinal();
            //  primExp = ((App)aux).q.toStringInf(s,"")+(aux.equals(goal)?equanimityHint:"");
        } 

        int conId =(naturalInfer? ((Const)((App)((App)((App)((App)ultInf.type()).p).q).p).p).getId() 
                                :((Const)((App)((App)ultInf.type()).p).p).getId());
        String op = s.getSimbolo(conId).getNotacion_latex();

        Resuelve theo = resuelveManager.getResuelveByUserAndTeorema(user, teo);
        Boolean entry = true;
        if (theo == null){
            theo = resuelveManager.getResuelveByUserAndTeorema("AdminTeoremas", teo);

            if (theo == null){
                teo = disponeManager.getDisponeByUserAndMetaeorema(user, teo).getNumerometateorema();
                newStep = op+"~~~~~~\\langle \\text{mt}~("+teo+")"+inst+leib+"\\rangle";
                entry = false;
            }
        }

        if (entry){
            teo = theo.getNumeroteorema();
            newStep = op+"~~~~~~\\langle \\text{st}~("+teo+")"+inst+leib+"\\rangle";         
        }
        return newStep;
    }

    /**
     * The finished function depends on if the demonstration method is basic or recursive,
     * so this calls the corresponding one.
     * 
     * @param theoremBeingProved: The theorem the user is trying to prove
     * @param proof: The proof tree so far
     * @param username: name of the user doing the proof
     * @param resuelveManager
     * @param simboloManager
     * @return new proof if finished, else return the same proof
     */
    public Term finishedMethodProof(Term theoremBeingProved, Term proof, String username,
            ResuelveManager resuelveManager, SimboloManager simboloManager) 
    {
        if (this.isRecursiveMethod){
            return finishedRecursiveMethodProof(theoremBeingProved, proof);
        }
        return finishedBaseMethodProof(theoremBeingProved, proof, username, resuelveManager, simboloManager);
    }

    /**
     * This function checks if a base demonstration has finished depending on the method used, if it is basic.
     * If it determines it has not finished, it returns the same proof tree given as argument.
     * 
     * @param theoremBeingProved: The theorem the user is trying to prove
     * @param proof: The proof tree so far
     * @param username: name of the user doing the proof
     * @param resuelveManager
     * @param simboloManager
     * @return new proof if finished, else return the same proof
     */
    public Term finishedBaseMethodProof(Term theoremBeingProved, Term proof, String username, 
        ResuelveManager resuelveManager, SimboloManager simboloManager)
    {
        Term expr = proof.type(); // The root of the proof tree, which is the last line
        Term initialExpr = ((App)expr).q; // The expression (could be a theorem) from which the user started the demonstration
        Term finalExpr = ((App)((App)expr).p).q; // The last line in the demonstration that the user has made

        try{
            return auxFinBaseMethodProof(theoremBeingProved, proof, username, resuelveManager, simboloManager, 
                                        expr, initialExpr, finalExpr);
        }
        catch (TypeVerificationException e)  {
            Logger.getLogger(InferController.class.getName()).log(Level.SEVERE, null, e); 
        } 
        return proof;
    }

    /**
     * TO BE OVERWRITTEN
     * 
     * Auxiliar method for "finishedBaseMethodProof" that implements the corresponding
     * logic according to the current demonstration method.
     * 
     * @param theoremBeingProved: The theorem the user is trying to prove
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
    protected Term auxFinBaseMethodProof(Term theoremBeingProved, Term proof, String username,
                ResuelveManager resuelveManager, SimboloManager simboloManager,
                Term expr, Term initialExpr, Term finalExpr) throws TypeVerificationException
    {
        return proof;
    }

    /**
     * This function will only be correct if called when using a recursive method.
     * It will return a new proof tree in case it finds out that the last inference
     * caused the whole proof to be correct under the sub-proof method. In other case it will return 
     * the proof given as argument.
     * 
     * @param theoremBeingProved: The theorem that user is trying to prove 
     * @param proof: The proof tree so far
     * @return proof of theoremBeingProved if finished, else return the same proof
     */
    public Term finishedRecursiveMethodProof(Term theoremBeingProved, Term proof) {
        try {
            // The next two lists are for doing a parallel substitution [x1, x2,... := t1, t2, ...]
            List<Var> vars = new ArrayList<>();
            List<Term> terms = new ArrayList<>();

            Term axiomTree = auxFinRecursiveMethodProof(theoremBeingProved, vars, terms);
            return new TypedApp(axiomTree, proof);
             
        } catch (TypeVerificationException e)  {
            Logger.getLogger(InferController.class.getName()).log(Level.SEVERE, null, e); 
        }
        return proof;
    }

    /**
     * TO BE OVERWRITTEN

     * Auxiliar method for "finishedRecursiveMethodProof" that implements the corresponding
     * logic according to the current demonstration method.
     * 
     * @param theoremBeingProved: The theorem that user is trying to prove 
     * @param vars: List of variables for doing parallel substitution
     * @param terms: List of terms for doing parallel substitution
     * @return axiom tree that will later be used to build the complete proof
     * @throws com.calclogic.lambdacalculo.TypeVerificationException
     */
    protected Term auxFinRecursiveMethodProof(Term theoremBeingProved, List<Var> vars, List<Term> terms)
            throws TypeVerificationException
    {
        return null;
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
    public int transFirstOpInferIndex(Term typedTerm, Boolean reverse) {
        return -1;
    } 
}