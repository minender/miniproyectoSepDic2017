package com.calclogic.proof;

import com.calclogic.lambdacalculo.App;
import com.calclogic.lambdacalculo.Const;
import com.calclogic.lambdacalculo.Sust;
import com.calclogic.lambdacalculo.Term;
import com.calclogic.lambdacalculo.TypeVerificationException;
import com.calclogic.lambdacalculo.TypedA;
import com.calclogic.lambdacalculo.TypedApp;
import com.calclogic.lambdacalculo.TypedI;
import com.calclogic.lambdacalculo.TypedS;
import com.calclogic.lambdacalculo.Var;
import com.calclogic.parse.CombUtilities;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author ronald
 */
public class MutualImplicationMethod extends GenericProofMethod {

    public MutualImplicationMethod(){
        setInitVariables("MI");
    }

    /**
     * Indicates the header that a proof that starts with mutual implication
     * method must have.
     *  
     * @param statement: New statement that needs to be proved according to this method
     * @return The header message to be added to the proof
     */
    @Override
    public String header(String statement){
        return "By mutual implication method, the following must be proved:<br>"+statement+"Sub Proof:<br>";
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
    public Term initFormula(Term beginFormula){
        // "beginFormula" is of the form [L == R]
        Term prevLeftSide = ((App)beginFormula).q; // L
        Term prevRightSide = ((App)((App)beginFormula).p).q; // R

        Term newLeftSide = new App(new App(new Const(2 ,"c_{2}"), prevRightSide), prevLeftSide);  // [L ==> R]  written as  [(==> R) L]
        Term newRightSide = new App(new App(new Const(3 ,"c_{3}"), prevRightSide), prevLeftSide); // [L <== R]  written as  [(<== R) L]

        // [newLeftSide /\ newRightSide]  written as  [(/\ newRightSide) newLeftSide]
        return new App(new App(new Const(5,"c_{5}"), newRightSide), newLeftSide);
    }

    /**
     * Auxiliar method for "finishedLinearRecursiveMethodProof" that implements the corresponding
     * logic according to the counter reciprocal method.
     * 
     * @param formulaBeingProved: Formula that the user is trying to prove in this proof/sub-proof 
     * @param vars: List of variables for doing parallel substitution
     * @param terms: List of terms for doing parallel substitution
     * @return axiom tree that will later be used to build the complete proof
     */
    @Override
    protected Term auxFinLinearRecursiveMethodProof(Term formulaBeingProved, List<Var> vars, List<Term> terms)
            throws TypeVerificationException
    {
        System.out.println("\n\n\nEn final, formulaBeingProved = "+formulaBeingProved.toStringFinal());
        // This string says: ((p ==> q) /\ (p <== q)) == (p == q)
        String str = "c_{1} (c_{1} x_{113} x_{112}) (c_{5} (c_{3} x_{113} x_{112}) (c_{2} x_{113} x_{112}))";
        Term st = CombUtilities.getTerm(str);

        // We make the formula above to be treated as an axiom
        TypedA A = new TypedA(st);

        // Substitution [p,q := ...]
        vars.add(0, new Var(112)); // Letter 'p'
        vars.add(0, new Var(113)); // Letter 'q'
        terms.add(0, ((App)((App)formulaBeingProved).q).q); // Note .q is (p ==> q), so .q.q is 'p'.
        terms.add(0, ((App)((App)((App)formulaBeingProved).q).p).q); // .q.p is (==> q) so .q.p.q is 'q'.
        Sust sus = new Sust(vars, terms);

        // We give the instantiation format to the substitution above
        TypedI I = new TypedI(sus);

        return new TypedApp(I,A);
    }
}