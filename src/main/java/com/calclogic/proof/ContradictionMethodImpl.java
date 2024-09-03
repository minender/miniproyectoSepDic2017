package com.calclogic.proof;

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
import com.calclogic.parse.CombUtilities;
import java.util.List;

import org.springframework.stereotype.Service;

/**
 *
 * @author ronald
 */
@Service
public class ContradictionMethodImpl extends GenericProofMethodImpl implements ContradictionMethod {

    public ContradictionMethodImpl(){
        setInitVariables("CO");
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
        // This is saying: Â¬formula => false = T, but the notation must be prefix and the first operand goes to the right.
        // So, here what is really expressed is: (=> false) (Â¬formula) = T.
        
        Term aux = ((App)beginFormula).q.body();
        aux = new App(new App(new Const(2,"c_{2}"),new Const(9,"c_{9}")), new App(new Const(7,"c_{7}"),aux));
        
        return new App(new App(new Const(0,"="),((App)((App)beginFormula).p).q.body()),aux).abstractEq(null);
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
        return "By contradiction method, the following must be proved:<br>"+statement+"Sub Proof:<br>";
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
        formulaBeingProved = ((App)formulaBeingProved).q.body();
        // This string says: ¬p => false == ¬(¬p)
        String str1 = "I^{[x_{112}:=c_{7} ("+formulaBeingProved+")]} A^{= (\\Phi_{b} c_{7}) (\\Phi_{b} (c_{2} c_{9}))}";
                //"c_{1} (c_{7} (c_{7} x_{112})) (c_{2} c_{9} (c_{7} x_{112}))";
        //Term A1 = CombUtilities.getTerm(str1,null,null);

        // This string says: ¬(¬p) == p
        String str2 = "A^{= \\Phi_{} (\\Phi_{bb} c_{7} c_{7})}"; //"c_{1} x_{112} (c_{7} (c_{7} x_{112}))";
        //Term A2 = CombUtilities.getTerm(str2,null,null);

        String sust = "I^{[x_{112}:="+formulaBeingProved+"]}";
        // We make the two formulas above to be treated as axioms
        // TypedA A1 = new TypedA(st1);
        // TypedA A2 = new TypedA(st2);

        // Substitution [p := formulaBeingProved]
        //vars.add(0, new Var(112)); // Letter'p'
        //terms.add(0, formulaBeingProved);
        //Sust sus = new Sust(vars, terms);

        // We give the instantiation format to the substitution above
        //TypedI I = new TypedI(sus);
        String st = str1+" ("+sust+" "+str2+")";
        Term t = CombUtilities.getTerm(st, user, TypedA.sm_);
        return t;//new TypedApp(new TypedApp(I,A1),new TypedApp(I,A2));
    }
    
    /**
     * This function returns the closing comment of the proof i.e. the conclusion of the proof
     * 
     * @param proof: The current proof
     * @return String with the closing comment of the proof
     */
    @Override
    public String closingComment(Term proof, Term beginFormula) {
        return "$\\therefore~"+proof.type().toStringLaTeX(simboloManager, "",null)+"$";
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