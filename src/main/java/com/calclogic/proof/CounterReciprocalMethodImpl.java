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
import com.calclogic.service.SimboloManager;

import java.util.List;
import org.springframework.stereotype.Service;
import org.springframework.beans.factory.annotation.Autowired;

/**
 *
 * @author ronald
 */
@Service
public class CounterReciprocalMethodImpl extends GenericProofMethodImpl implements CounterReciprocalMethod{
    @Autowired
    private SimboloManager simboloManager;

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
    private Integer binaryOperatorId(Term formula){
        // In applicative notation, the expression "P operator Q" is written as "(operator Q) P",
        // so the attribute "1" is "(operator Q)" and "11" is "operator". 
        return ((Const)formula.des("11")).getId();
    }

    /**
     * The statement that is needed to be proven may change inside a sub proof,
     * so this function calculates which that new statement is.
     *  
     * @param beginFormula: General statement to be proved, is the base to calculate 
     *                      all the sub statement in the sub proofs.
     * @return Term that represents the statement to be proved in the current sub proof.
     */
    @Override
    public Term initFormula(Term beginFormula){
        beginFormula = beginFormula.containT() ? beginFormula.setToPrint(simboloManager) : beginFormula;

        // "beginFormula" is of the form  [L op R], where "op" is ==> or <==
        Term leftSide = beginFormula.des("2"); // L  
        Term rightSide = beginFormula.des("12"); // R
        // Now we negate the sides
        leftSide = new App(new Const(7 ,"c_{7}"), leftSide); // !L
        rightSide = new App(new Const(7,"c_{7}"), rightSide); // !R

        Integer operatorId = binaryOperatorId(beginFormula);

        // [!R op !L]  written as  [(op !L) R]
        return new App(new App(new Const(operatorId,"c_{"+operatorId.toString()+"}"),leftSide), rightSide);
    }

    /**
     * Indicates the header that a proof that starts with counter-reciprocal
     * method must have.
     *  
     * @param statement: New statement that needs to be proved according to this method
     * @return The header message to be added to the proof
     */
    @Override
    public String header(String statement){
        return "By counter-reciprocal method, the following must be proved:<br>"+statement+"Sub Proof:<br>";
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
    protected Term auxFinLinearRecursiveMethodProof(String user, Term formulaBeingProved, List<Var> vars, List<Term> terms)
            throws TypeVerificationException
    { 
        String operatorIdSt = binaryOperatorId(formulaBeingProved).toString();

        // This string can say: [p => q == !q => !p] or [p <= q == !q <= !p] as well
        String str = "c_{1} (c_{"+operatorIdSt+"} (c_{7} x_{112}) (c_{7} x_{113})) (c_{"+operatorIdSt+"} x_{113} x_{112})";
        Term st = CombUtilities.getTerm(str,null);

        // We make the formula above to be treated as an axiom
        TypedA A = new TypedA(st); 

        // Substitution [p,q := ...]
        vars.add(0, new Var(112)); // Letter 'p'
        vars.add(0, new Var(113)); // Letter 'q'
        terms.add(0, formulaBeingProved.des("2"));   
        terms.add(0, formulaBeingProved.des("12"));
        Sust sus = new Sust(vars, terms);
        
        // We give the instantiation format to the substitution above
        TypedI I = new TypedI(sus);

        return new TypedApp(new TypedS(),new TypedApp(I,A));
    }
}