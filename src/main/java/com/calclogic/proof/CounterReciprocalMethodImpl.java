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
import org.springframework.stereotype.Service;

/**
 *
 * @author ronald
 */
@Service
public class CounterReciprocalMethodImpl extends GenericProofMethodImpl implements CounterReciprocalMethod{

    public CounterReciprocalMethodImpl(){
        setInitVariables("CR");
    }

    /**
     * It finds the id of the operator of a binary expression. 
     * For example, if we have P == Q, the main operator is ==, and its id is 1
     * 
     * Note: We cannot access the almost equivalent CrudOperations function
     * without splitting this file in interface and implementation
     *
     * @param formula: Expression whose main operator id will be found.
     * @return The id of the main operator.
     */
    private int binaryOperatorId(Term formula){
        // In applicative notation, the expression "P operator Q" is written as "(operator Q) P",
        // so the attribute 'p' is "(operator Q)" and p.p is "operator". 
        return ((Const)((App)((App)formula).p).p).getId();
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
        // "beginFormula" is of the form  [L op R], where "op" is ==> or <==
        Term aux = ((App)beginFormula).q.body();
        Term leftSide = ((App)aux).q; // L
        Term rightSide = ((App)((App)aux).p).q; // R
        // Now we negate the sides
        leftSide = new App(new Const(7 ,"c_{7}"), leftSide); // !L
        rightSide = new App(new Const(7,"c_{7}"), rightSide); // !R

        int operatorId = binaryOperatorId(aux);
        beginFormula = new App(new App(new Const(operatorId,"c_{"+operatorId+"}"),leftSide), rightSide);
        
        // [!R op !L]  written as  [(op !L) R]
        return new App(new App(new Const(0,"="),new Const(-1,"T")),beginFormula).abstractEq(null);
    }

    /**
     * Indicates the header that a proof that starts with counter-reciprocal
     * method must have.
     *  
     * @param statement: New statement that needs to be proved according to this method
     * @return The header message to be added to the proof
     */
    @Override
    public String header(String statement, Term beginFormula){
        return "By counter-reciprocal method, the following must be proved:<br>"+statement+"Sub Proof:<br>";
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
    {   formulaBeingProved = ((App)formulaBeingProved).q.body();
        int operatorIdSt = binaryOperatorId(formulaBeingProved);
        Term p = ((App)formulaBeingProved).q;
        Term q = ((App)((App)formulaBeingProved).p).q;

        String str = "";
        if (operatorIdSt == 3) {
            str = "I^{[x_{112},x_{113}:="+p+","+q+"]} A^{= (\\Phi_{bb} \\Phi_{b} c_{2}) (\\Phi_{cb} c_{3} \\Phi_{cb})}";
            str = str+" (I^{[x_{112},x_{113}:="+q+","+p+"]} A^{= (\\Phi_{cbbb} c_{7} \\Phi_{bb} c_{2} c_{7}) (\\Phi_{cb} c_{2} \\Phi_{cb})})";
            str = str+" (S (I^{[x_{112},x_{113}:=c_{7} ("+q+"),c_{7} ("+p+")]} A^{= (\\Phi_{bb} \\Phi_{b} c_{2}) (\\Phi_{cb} c_{3} \\Phi_{cb})}))";
        }
        else {
          // This string can say: [p => q == !q => !p] or [p <= q == !q <= !p] as well
          str = "I^{[x_{112},x_{113}:="+p+","+q+"]} A^{= (\\Phi_{cbbb} c_{7} \\Phi_{bb} c_{2} c_{7}) (\\Phi_{cb} c_{2} \\Phi_{cb})}";
        }
        Term T = CombUtilities.getTerm(str,user,TypedA.sm_); 

        return new TypedApp(new TypedS(),T);
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