package com.calclogic.proof;

import com.calclogic.lambdacalculo.App;
import com.calclogic.lambdacalculo.Const;
import com.calclogic.lambdacalculo.Sust;
import com.calclogic.lambdacalculo.Term;
import com.calclogic.lambdacalculo.TypeVerificationException;
import com.calclogic.lambdacalculo.TypedA;
import com.calclogic.lambdacalculo.TypedApp;
import com.calclogic.lambdacalculo.TypedI;
import com.calclogic.lambdacalculo.Var;
import com.calclogic.parse.CombUtilities;
import java.util.List;

import org.springframework.stereotype.Service;

/**
 *
 * @author ronald
 */
@Service
public class MutualImplicationMethodImpl extends GenericProofMethodImpl implements MutualImplicationMethod{

    public MutualImplicationMethodImpl(){
        setInitVariables("MI");
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
        // "beginFormula" is of the form [L == R]
        Term aux = ((App)beginFormula).q.body();
        Term prevLeftSide = ((App)aux).q; // L
        Term prevRightSide = ((App)((App)aux).p).q; // R

        Term newLeftSide = new App(new App(new Const(2 ,"c_{2}"), prevRightSide), prevLeftSide);  // [L ==> R]  written as  [(==> R) L]
        Term newRightSide = new App(new App(new Const(3 ,"c_{3}"), prevRightSide), prevLeftSide); // [L <== R]  written as  [(<== R) L]

        // [newLeftSide /\ newRightSide]  written as  [(/\ newRightSide) newLeftSide]
        return new App(new App(new Const(0,"="),new Const(-1,"T")) ,new App(new App(new Const(5,"c_{5}"), newRightSide), newLeftSide)).abstractEq(null);
    }

    /**
     * Indicates the header that a proof that starts with mutual implication
     * method must have.
     *  
     * @param statement: New statement that needs to be proved according to this method
     * @return The header message to be added to the proof
     */
    @Override
    public String header(String statement, Term beginFormula){
        return "By mutual implication method, the following must be proved:<br>"+statement+"Sub Proof:<br>";
    }

    /**
     * Auxiliar method for "finishedLinearRecursiveMethodProof" that implements the corresponding
     * logic according to the counter reciprocal method.
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
        // This string says: ((p ==> q) /\ (q ==> p)) == (p == q)
        String A1 = "A^{= (\\Phi_{bb} \\Phi_{b} c_{1}) (\\Phi_{(cb,b)} c_{2} (\\Phi_{(bcb,b)} c_{5}) c_{2})}";
                //"c_{1} (c_{1} x_{113} x_{112}) (c_{5} (c_{3} x_{113} x_{112}) (c_{2} x_{113} x_{112}))";

        String p = ((App)((App)formulaBeingProved).q.body()).q+"";
        String q = ((App)((App)((App)formulaBeingProved).q.body()).p).q+"";
        String L = "L^{\\lambda x_{122}.c_{5} x_{122} (c_{2} ("+q+") ("+p+"))}";
        String I1 = "I^{[x_{112},x_{113}:="+p+","+q+"]}";
        String I2 = "I^{[x_{113},x_{112}:="+q+","+p+"]}";
        // this string says: p <== q == q ==> p
        String A2 = "A^{= (\\Phi_{bb} \\Phi_{b} c_{2}) (\\Phi_{cb} c_{3} \\Phi_{cb})}";
        String str = L+" ("+I1+" "+A2+")";
        str += " ("+I2+" "+A1+")";
        //Term A11 = CombUtilities.getTerm(str,user,TypedA.sm_);
        // We make the formula above to be treated as an axiom
        //TypedA A = new TypedA(st);

        // Substitution [p,q := ...]
        /*vars.add(0, new Var(112)); // Letter 'p'
        vars.add(0, new Var(113)); // Letter 'q'
        terms.add(0, ((App)((App)formulaBeingProved).q.body()).q); // Note .q is (p ==> q), so .q.q is 'p'.
        terms.add(0, ((App)((App)((App)formulaBeingProved).q.body()).p).q); // .q.p is (==> q) so .q.p.q is 'q'.
        Sust sus = new Sust(vars, terms);*/

        // We give the instantiation format to the substitution above
        //TypedI I = new TypedI(sus);

        return CombUtilities.getTerm(str,user,TypedA.sm_);//new TypedApp(I,A);
    }
    
    /**
     * This function returns the closing comment of the proof i.e. the conclusion of the proof
     * 
     * @param proof: The current proof
     * @return String with the closing comment of the proof
     */
    @Override
    public String closingComment(Term proof, Term beginFormula) {
        return "$\\therefore~"+proof.type().toStringLaTeX(simboloManager, "", null)+"$";
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