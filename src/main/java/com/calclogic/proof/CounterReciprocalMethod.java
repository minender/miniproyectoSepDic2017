package com.calclogic.proof;

import com.calclogic.lambdacalculo.App;
import com.calclogic.lambdacalculo.Const;
import com.calclogic.lambdacalculo.Sust;
import com.calclogic.lambdacalculo.Var;
import com.calclogic.lambdacalculo.Term;
import com.calclogic.lambdacalculo.TypeVerificationException;
import com.calclogic.lambdacalculo.TypedA;
import com.calclogic.lambdacalculo.TypedApp;
import com.calclogic.lambdacalculo.TypedI;
import com.calclogic.lambdacalculo.TypedS;
import com.calclogic.parse.CombUtilities;
import java.util.List;

/**
 *
 * @author ronald
 */
public class CounterReciprocalMethod extends GenericProofMethod {

    public CounterReciprocalMethod(){
        setInitVariables("CR");
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
        Term antec = ((App)beginFormula).q;
        antec = new App(new Const(7 ,"c_{7}"), antec);
        Term consec = ((App)((App)beginFormula).p).q;
        consec = new App(new Const(7,"c_{7}"),consec);
        return new App(new App(new Const(2,"c_{2}"),antec), consec);
    }

    /**
     * Auxiliar method for "finishedRecursiveMethodProof" that implements the corresponding
     * logic according to the counter reciprocal method.
     * 
     * @param theoremBeingProved: The theorem that user is trying to prove 
     * @param vars: List of variables for doing parallel substitution
     * @param terms: List of terms for doing parallel substitution
     * @return axiom tree that will later be used to build the complete proof
     */
    @Override
    protected Term auxFinRecursiveMethodProof(Term theoremBeingProved, List<Var> vars, List<Term> terms)
            throws TypeVerificationException
    {
        // This string says: p => q == ¬q => ¬p
        String str = "c_{1} (c_{2} (c_{7} x_{112}) (c_{7} x_{113})) (c_{2} x_{113} x_{112})";
        Term st = CombUtilities.getTerm(str);

        // We make that formula to be treated as an axiom
        TypedA A = new TypedA(st); 

        // Substitution [p,q := ...]
        vars.add(0, new Var(112)); // Letter 'p'
        vars.add(0, new Var(113)); // Letter 'q'
        terms.add(0, ((App)theoremBeingProved).q);
        terms.add(0, ((App)((App)theoremBeingProved).p).q);
        Sust sus = new Sust(vars, terms);
        
        // We give the instantiation format to the substitution above
        TypedI I = new TypedI(sus);

        return new TypedApp(new TypedS(),new TypedApp(I,A));
    }
}