package com.calclogic.proof;

import com.calclogic.lambdacalculo.App;
import com.calclogic.lambdacalculo.Sust;
import com.calclogic.lambdacalculo.Term;
import com.calclogic.lambdacalculo.TypeVerificationException;
import com.calclogic.lambdacalculo.TypedA;
import com.calclogic.lambdacalculo.TypedApp;
import com.calclogic.lambdacalculo.TypedI;
import com.calclogic.lambdacalculo.TypedS;
import com.calclogic.lambdacalculo.Var;
import com.calclogic.parse.CombUtilities;

import java.util.List;

/**
 *
 * @author ronald
 */
public class AndIntroductionMethod extends GenericProofMethod {

    public AndIntroductionMethod(){
        setInitVariables("AI");
    }

    /**
     * Indicates the header that a proof that starts with and introduction
     * method must have.
     *  
     * @param statement: New statement that needs to be proved according to this method
     * @return The header message to be added to the proof
     */
    @Override
    public String header(String statement){
        return "By conjunction by parts method:<br><br>";
    }

    /**
     * Auxiliar method for "finishedRecursiveMethodProof" that implements the corresponding
     * logic according to the and introduction method.
     *
     * It will return a new proof tree that connects in one proof of P/\Q,
     * two independent sub proofs of P and Q
     *
     * @param theoremBeingProved: The theorem that user is trying to prove 
     * @param vars: List of variables for doing parallel substitution
     * @param terms: List of terms for doing parallel substitution
     * @param proof: The proof tree so far
     * @return axiom tree that will later be used to build the complete proof
     * @throws com.calclogic.lambdacalculo.TypeVerificationException
     */
    @Override
    protected Term auxFinRecursiveMethodProof(Term theoremBeingProved, List<Var> vars, List<Term> terms, Term proof)
            throws TypeVerificationException
    {
        // This string says: (true == q) == q
        String str = "c_{1} x_{113} (c_{1} x_{113} c_{8})";
        Term st = CombUtilities.getTerm(str);

        // We make the formula above to be treated as an axiom
        TypedA A = new TypedA(st); 

        // Substitution [q := lastLine]
        vars.add(0, new Var(113)); // Letter 'q'
        terms.add(0, proof.type());
        Sust sus = new Sust(vars, terms);

        // We give the instantiation format to the substitution above
        TypedI I = new TypedI(sus);

        return new TypedApp(new TypedApp(new TypedS(),new TypedApp(I,A)),proof);
    }
}