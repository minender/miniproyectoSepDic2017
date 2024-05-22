/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.calclogic.proof;

import com.calclogic.lambdacalculo.App;
import com.calclogic.lambdacalculo.Bracket;
import com.calclogic.lambdacalculo.Const;
import com.calclogic.lambdacalculo.Term;
import com.calclogic.lambdacalculo.TypeVerificationException;
import com.calclogic.lambdacalculo.TypedA;
import com.calclogic.lambdacalculo.TypedApp;
import com.calclogic.lambdacalculo.TypedM;
import com.calclogic.lambdacalculo.TypedS;
import com.calclogic.lambdacalculo.Var;
import com.calclogic.parse.CombUtilities;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author feder
 */
public class WitnessMethodImpl extends GenericProofMethodImpl implements WitnessMethod{
    
        public WitnessMethodImpl(){
        setInitVariables("WI");
    }
        
    private Term changeDummyForFreshVar(Term beginFormula) {
        Term P = ((App)((App)((App)beginFormula).q.body()).p).q;
        Term Q = ((App)((App)((App)beginFormula).q.body()).q).q;
        Term R = ((App)((App)((App)((App)beginFormula).q.body()).q).p).q;
        String tree;
        // Esto hace un trading en caso que la beginFormula sea de la forma (exists x|R.x:Q.x)=>P 
        // con R distito de true
        if (!(R.body() instanceof Const) || !(((Const)R.body()).getId() == 8)) {
            tree = "I^{[x_{80},x_{82}:="+Q+","+R+"]} A^{= (\\Phi_{bb} (\\Phi_{bb} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{K} c_{8}))) (\\Phi_{(bb,b)} c_{5})) (\\Phi_{ccbb} \\Phi_{b} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{4})) \\Phi_{cbb} \\Phi_{b})}"; 
            beginFormula = CombUtilities.getTerm(tree,"AdminTeoremas", simboloManager).type();
            Q = ((App)((App)((App)beginFormula).p).q.body()).q;
            R = ((App)((App)((App)((App)beginFormula).p).q.body()).p).q;
        }
        // Del beginFormula que debe ser de la foma (exists x|R.x:Q.x)=>P
        // aplicas una distributivad P\/(forall x|R.x:Q.x)=(forall x|R.x:P\/Q.x) y luego
        // (forall x|R.x:P\/Q.x)=(forall x|R.x:Q.x\/P) para que cambie el nombre de x 
        // asi x no ocurre en P     => P (exists x|R.x:Q.x)
        tree = "A^{= (\\Phi_{bbbb} (\\Phi_{ccb} \\Phi_{cbb} c_{4}) \\Phi_{bccb} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5})) \\Phi_{b}) (\\Phi_{cbbb} \\Phi_{b} (\\Phi_{bbbb} \\Phi_{b} c_{4}) (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5})) \\Phi_{b})}";
        tree = "I^{[x_{82},x_{81},x_{80}:="+R+","+Q+","+P+"]} "+tree; // variables R,Q,P corresponden a x82,x81,x80
        Term t = CombUtilities.getTerm(tree,"AdminTeoremas", simboloManager).type();
        
        return t;
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
        Term t = changeDummyForFreshVar(beginFormula);
        Term P = ((App)((App)((App)((App)t).p).q.body()).q.body()).q;
        Term Q = ((App)((App)((App)((App)((App)t).p).q.body()).q.body()).p).q;
        Term R = ((App)((App)((App)((App)t).p).q.body()).p).q.body();
        // Quitas al existe y dejas solo el cuerpo del existe
        Var x = ((Bracket)((App)((App)((App)t).p).q.body()).q).x;
        Term result = new App(new App(new Const(2,"c_{2}"),P),Q);

        return new App(new App(new Const(0,"="),new Const(-1,"T")),result).abstractEq(null);
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
        Term t = changeDummyForFreshVar(beginFormula);
        Var x = ((Bracket)((App)((App)((App)t).p).q.body()).q).x;
        return "By witness method, the following must be proved considering "+(char)x.indice+" as witness:<br>"+statement+"<br>Sub Proof:<br>";
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
     * @param user
     * @param formulaBeingProved: Formula that the user is trying to prove in this proof/sub-proof 
     *        formulaBeingProved is not the result of initFormula or the current statement to proof
     *        in this sub-proof. Instead formulaBeingProved is the argument formula of initFormula 
     *        to produce de current statement to proof in this sub-proof
     * @param proof: The proof tree so far
     * @return proof of formulaBeingProved if finished, else return the same proof
     */
    @Override
    public Term finishedLinearRecursiveMethodProof(String user, Term formulaBeingProved, Term proof) {
        try {
            Term aux = ((App)((App)((App)((App)formulaBeingProved).q.body()).q).p).q.body();
            boolean withoutRange = aux instanceof Const && ((Const)aux).getId() == 8;
            Term t = changeDummyForFreshVar(formulaBeingProved);
            Var x = ((Bracket)((App)((App)((App)t).p).q.body()).q).x;
            Term type = proof.type();
            Term P = ((App)((App)type).q.body()).q;
            Term Q = ((App)((App)((App)type).q.body()).p).q;
            Term tree = auxFinLinearRecursiveMethodProof(user, formulaBeingProved, null, null);
            String str1 = "L^{\\lambda x_{-126}.c_{62} (\\Phi_{bb} \\Phi_{b} c_{5}) (\\Phi_{K} c_{8}) (\\lambda "+x+".x_{-126})} (M_{3} ("+proof+"))";
            Term finalProof = CombUtilities.getTerm(str1,user,TypedA.sm_);
            String str2 = "A^{= T c_{8}}";
            Term axiomTree = CombUtilities.getTerm(str2,user,TypedA.sm_);
            finalProof = new TypedApp(finalProof,tree);
            finalProof = new TypedApp(new TypedS(),finalProof);
            finalProof = new TypedApp(finalProof,axiomTree);
            // esto es (forall x|:P.x=>Q)=(forall x|:!P.x\/Q)
            str1 = "L^{\\lambda x_{-126}.c_{62} (\\lambda x_{120}.\\lambda x_{121}.c_{5} x_{120} x_{121}) (\\lambda "+x+".c_{8}) (\\lambda "+x+".x_{-126})} ";
            str1 +="(I^{[x_{113},x_{112} := "+Q+","+P+"]} A^{= (\\Phi_{cbb} c_{7} \\Phi_{bb} c_{4}) (\\Phi_{bb} \\Phi_{b} c_{2})})";
            tree = CombUtilities.getTerm(str1,user,TypedA.sm_);
            // esto es (forall x|:!P.x\/Q)=(forall x|:Q\/!P.x)
            str1 = "(L^{\\lambda x_{-126}.c_{62} (\\lambda x_{120}.\\lambda x_{121}.c_{5} x_{120} x_{121}) (\\lambda "+x+".c_{8}) (\\lambda "+x+".x_{-126})} ";
            str1 +="(I^{[x_{112},x_{113} := (c_{7} ("+P+")),"+Q+"]} A^{= (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{cb} c_{4} \\Phi_{cb})}))";
            axiomTree = CombUtilities.getTerm(str1,user,TypedA.sm_);
            tree = new TypedApp(tree,axiomTree);
            // esto es (forall x|:Q\/!P.x)=Q\/(forall x|:!P.x)
            str1 = "(S (I^{[x_{82},x_{81},x_{80} := (\\lambda "+x+".c_{8}),(\\lambda "+x+".c_{7} ("+P+")),"+Q+"]} ";
            str1 += "A^{= (\\Phi_{bbbb} (\\Phi_{ccb} \\Phi_{cbb} c_{4}) \\Phi_{bccb} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5})) \\Phi_{b}) (\\Phi_{cbbb} \\Phi_{b} (\\Phi_{bbbb} \\Phi_{b} c_{4}) (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5})) \\Phi_{b})}))";
            axiomTree = CombUtilities.getTerm(str1,user,TypedA.sm_);
            tree = new TypedApp(tree,axiomTree);
            // esto es Q\/(forall x|:!P.x)=(forall x|:!P.x)\/Q
            str1 = "(I^{[x_{112},x_{113} := "+Q+",(c_{62} (\\lambda x_{120}.\\lambda x_{121}.c_{5} x_{120} x_{121}) (\\lambda "+x+".c_{8}) (\\lambda "+x+".c_{7} ("+P+")))]} ";
            str1 += "A^{= (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{cb} c_{4} \\Phi_{cb})})";
            axiomTree = CombUtilities.getTerm(str1,user,TypedA.sm_);
            tree = new TypedApp(tree,axiomTree);
            // esto es (forall x|:!P.x)\/Q=!!(forall x|:!P.x)\/Q
            str1 = "(S (L^{\\lambda x_{-126}.c_{4} ("+Q+") x_{-126}} ";
            str1 += "(I^{[x_{112} := (c_{62} (\\lambda x_{120}.\\lambda x_{121}.c_{5} x_{120} x_{121}) (\\lambda "+x+".c_{8}) (\\lambda "+x+".c_{7} ("+P+")))]} A^{= \\Phi_{} (\\Phi_{bb} c_{7} c_{7})})))";
            axiomTree = CombUtilities.getTerm(str1,user,TypedA.sm_);
            tree = new TypedApp(tree,axiomTree);
            // esto es !!(forall x|:!P.x)\/Q=!(exists x|:P.x)\/Q
            str1 = "(S (L^{\\lambda x_{-126}.c_{4} ("+Q+") (c_{7} x_{-126})} (I^{[x_{82},x_{80} := (\\lambda "+x+".c_{8}),(\\lambda "+x+". "+P+")]} ";
            str1 += "A^{= (\\Phi_{cbbb} (\\Phi_{bb} c_{7}) (\\Phi_{bbb} c_{7}) (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5})) \\Phi_{b}) (\\Phi_{cbbb} \\Phi_{b} \\Phi_{bb} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{4})) \\Phi_{b})})))";
            axiomTree = CombUtilities.getTerm(str1,user,TypedA.sm_);
            tree = new TypedApp(tree,axiomTree);
            // esto es !(exists x|:P.x)\/Q=(exists x|:P.x)=>Q
            str1 = "(S (I^{[x_{113},x_{112}:="+Q+",c_{62} (\\lambda x_{120}.\\lambda x_{121}.c_{4} x_{120} x_{121}) (\\lambda "+x+".c_{8}) (\\lambda "+x+". "+P+")]} ";
            str1 += "A^{= (\\Phi_{cbb} c_{7} \\Phi_{bb} c_{4}) (\\Phi_{bb} \\Phi_{b} c_{2})}))";
            axiomTree = CombUtilities.getTerm(str1,user,TypedA.sm_);
            tree = new TypedApp(tree,axiomTree);
            if (!withoutRange) {
                Term R = ((App)P).q;
                P = ((App)((App)P).p).q;
                // esto es (exists x|:R.x/\P.x)=>Q=(exists x|R.x:P.x)=>Q
                str1 = "S (L^{\\lambda x_{-126}.c_{2} ("+Q+") x_{-126}} (I^{[x_{80},x_{82}:=\\lambda "+x+"."+P+",\\lambda "+x+"."+R+"]} A^{= (\\Phi_{bb} (\\Phi_{bb} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{K} c_{8}))) (\\Phi_{(bb,b)} c_{5})) (\\Phi_{ccbb} \\Phi_{b} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{4})) \\Phi_{cbb} \\Phi_{b})}))";
                axiomTree = CombUtilities.getTerm(str1,user,TypedA.sm_);
                tree = new TypedApp(tree,axiomTree);
            }
            finalProof = new TypedApp(tree,finalProof);
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
        return "$\\therefore~"+proof.type().toStringLaTeX(simboloManager, "")+"$";
    }
    
    /**
     * This function delete the last part of the proof depends of the method
     * 
     * @param proof: The current proof
     * @return proof without the last part of the proof that finish the proof
     */
    @Override
    public Term deleteFinishProof(Term proof) {
        return ((TypedM)((App)((App)((App)((App)((App)proof).q).p).q).p).q).getSubProof();
    }
}
