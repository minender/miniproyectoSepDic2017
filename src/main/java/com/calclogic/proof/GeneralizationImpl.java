/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.calclogic.proof;

import com.calclogic.lambdacalculo.App;
import com.calclogic.lambdacalculo.Bracket;
import com.calclogic.lambdacalculo.Const;
import com.calclogic.lambdacalculo.Sust;
import com.calclogic.lambdacalculo.Term;
import com.calclogic.lambdacalculo.TypeVerificationException;
import com.calclogic.lambdacalculo.TypedA;
import com.calclogic.lambdacalculo.TypedApp;
import com.calclogic.lambdacalculo.TypedI;
import com.calclogic.lambdacalculo.TypedM;
import com.calclogic.lambdacalculo.TypedS;
import com.calclogic.lambdacalculo.Var;
import com.calclogic.parse.CombUtilities;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author feder
 */
public class GeneralizationImpl extends GenericProofMethodImpl implements Generalization{
    
        public GeneralizationImpl(){
        setInitVariables("GE");
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
    public Term initFormula(Term beginFormula, Term proof){
        // Quitas al paratodo y dejas solo el cuerpo del para todo
        Term aux = ((App)((App)((App)beginFormula).q.body()).p).q.body();
        if (aux instanceof Const && ((Const)aux).getId() == 8)
            aux = ((App)((App)beginFormula).q.body()).q.body();
        else
            aux = new App(new App(new Const(2,"c_{2}"),((App)((App)beginFormula).q.body()).q.body()),aux);
        return new App(new App(new Const(0,"="),new Const(-1,"T")),aux).abstractEq(null);
    }

    /**
     * Indicates the header that a proof that starts with contradiction
     * method must have.
     *  
     * @param statement: New statement that needs to be proved according to this method
     * @return The header message to be added to the proof
     */
    @Override
    public String header(String statement, Term beginFormula){
        Var x = ((Bracket)((App)((App)beginFormula).q.body()).q).x;
        return "By generalization method, the following must be proved considering an arbitrary "+x.toStringLaTeX(null, null)+":<br>"+statement+"<br>Sub Proof:<br>";
    }

    /**
     * Auxiliar method for "finishedLinearRecursiveMethodProof" that implements the corresponding
     * logic according to the contradiction method.
     * 
     * @param formulaBeingProved: Formula that the user is trying to prove in this proof/sub-proof
     *        formulaBeingProved is not the result of initFormula or the current statement to proof
     *        in this sub-proof. Instead formulaBeingProved is the argument formula of initFormula 
     *        to produce de current statement to proof in this sub-proof
     * @param vars: List of variables for doing parallel substitution
     * @param terms: List of terms for doing parallel substitution
     * @return axiom tree that will later be used to build the complete proof
     */
    @Override
    protected Term auxFinLinearRecursiveMethodProof(String user, Term formulaBeingProved, List<Var> vars, List<Term> terms) 
            throws TypeVerificationException
    {
        String str1 = "I^{[x_{82} := (\\lambda x_{120}.c_{8})]} A^{= (\\Phi_{K} c_{8}) (\\Phi_{cbb} (\\Phi_{K} c_{8}) (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5})) \\Phi_{b})}";
        Term st1 = CombUtilities.getTerm(str1,user,TypedA.sm_);

        return st1;
    }
    
    /**
     * This function will only be correct if called when using a linear recursive method.
     * It will return a new proof tree in case it finds out that the last inference
     * caused the whole proof to be correct under the sub-proof method. In other case it will return 
     * the proof given as argument.
     * 
     * The tree that this method construct depends of formulaBeingProved. If formulaBeingProved is 
     * of the form (forall x|:P.x) the tree will be
     * 
     *                                                    auxFinLinearRecursive
     * L^{lambda z.(forall x|true:z)} (M_{3} (proof))     I^{[R:=true]} [(forall x|R.x:true)=true]
     * ----------------------------------------------    -----------------------------------------
     *   [(forall x|true:st)=(forall x|true:true)]             [(forall x|true:true)=true]
     *   ---------------------------------------------------------------------------------
     *                    [(forall x|true:st)=true]
     *                    ------------------------ S       --------
     *                    [true=(forall x|true:st)]        [true]
     *                    ----------------------------------------
     *                               [(forall x|true:st)]
     * 
     * If formulaBeingProved is of the form (forall x|R.x:P.x) the tree will be
     * 
     *                                                    auxFinLinearRecursive
     * L^{lambda z.(forall x|true:z)} (M_{3} (proof))     I^{[R:=true]} [(forall x|R.x:true)=true]
     * -----------------------------------------------    -----------------------------------------
     * [(forall x|true:R.x=>P.x)=(forall x|true:true)]         [(forall x|R.x:true)=true]
     *  ---------------------------------------------------------------------------------
     *                     [(forall x|true:R.x=>P.x)=true]         I^{P,R:=P,R}  [(forall x|R.x:P.x)=(forall x|true:R.x=>P.x)]
     *                     ------------------------------- S       -----------------------------------------------------------
     *                                                               [(forall x|R.x:P.x)=(forall x|true:R.x=>P.x)]                                                             
     *                                                               -------------------------------------------- S  
     *                    [true=(forall x|true:R.x=>P.x)]            [(forall x|true:R.x=>P.x)=(forall x|R.x:P.x)]    
     *                    ---------------------------------------------------------------------------------------    ------
     *                                               [true=(forall x|R.x:P.x)]                                       [true]
     *                                               ----------------------------------------------------------------------
     *                                                               [(forall x|R.x:P.x)]
     * 
     * @param user
     * @param formulaBeingProved: Formula that the user is trying to prove in this proof/sub-proof 
     * @param proof: The proof tree so far
     * @return proof of formulaBeingProved if finished, else return the same proof
     */
    @Override
    public Term finishedLinearRecursiveMethodProof(String user, Term formulaBeingProved, Term proof) {
        try {
            Term aux = ((App)((App)((App)formulaBeingProved).q.body()).p).q.body();
            boolean withoutRange = aux instanceof Const && ((Const)aux).getId() == 8;
            Var x = ((Bracket)((App)((App)formulaBeingProved).q.body()).q).x;
            Term tree = auxFinLinearRecursiveMethodProof(user, formulaBeingProved, null, null);
            String str1 = "L^{\\lambda x_{-126}.c_{62} (\\Phi_{bb} \\Phi_{b} c_{5}) (\\Phi_{K} c_{8}) (\\lambda "+x+".x_{-126})} (M_{3} ("+proof+"))";
            Term finalProof = CombUtilities.getTerm(str1,user,TypedA.sm_);
            String str2 = "A^{= T c_{8}}";
            Term axiomTree = CombUtilities.getTerm(str2,user,TypedA.sm_);
            finalProof = new TypedApp(finalProof,tree);
            finalProof = new TypedApp(new TypedS(),finalProof);
            if (!withoutRange) {
                Term P = ((App)((App)formulaBeingProved).q.body()).q;
                Term R = ((App)((App)((App)formulaBeingProved).q.body()).p).q;
                str2 = "S (I^{[x_{80},x_{82}:="+P+","+R+"]} A^{= (\\Phi_{bb} (\\Phi_{bb} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5}) (\\Phi_{K} c_{8}))) (\\Phi_{(bb,b)} c_{2})) (\\Phi_{ccbb} \\Phi_{b} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5})) \\Phi_{cbb} \\Phi_{b})})";
                finalProof = new TypedApp(finalProof,CombUtilities.getTerm(str2,user,TypedA.sm_));
            }
            finalProof = new TypedApp(finalProof,axiomTree);
            return finalProof;
             
        } catch (TypeVerificationException e)  {
            Logger.getLogger(GenericProofMethod.class.getName()).log(Level.SEVERE, null, e); 
        }
        return proof;
    }
    
    /**
     * This function returns the closing comment of the proof i.e. the conclusion of the proof
     * 
     * @param proof: The current proof
     * @return String with the closing comment of the proof
     */
        @Override
    public String closingComment(Term proof, Term beginFormula) {
        Var x = ((Bracket)((App)((App)beginFormula).q.body()).q).x;
        return "since "+(char)x.indice+" was arbitrary, then the statement can be generalized $\\therefore~"+proof.type().toStringLaTeX(simboloManager, "")+"$";
    }
    
    /**
     * This function delete the last part of the proof depends of the method
     * 
     * @param proof: The current proof
     * @return proof without the last part of the proof that finish the proof
     */
        @Override
    public Term deleteFinishProof(Term proof) {
        if (((App)((App)proof).p).p instanceof TypedS)
           return ((TypedM)((App)((App)((App)((App)proof).p).q).p).q).getSubProof();
        else
           return  ((TypedM)((App)((App)((App)((App)((App)proof).p).p).q).p).q).getSubProof();
    }

}
