package com.calclogic.proof;

import com.calclogic.lambdacalculo.App;
import com.calclogic.lambdacalculo.Const;
import com.calclogic.lambdacalculo.Term;

/**
 *
 * @author ronald
 */
public class MutualImplicationMethod extends AndIntroductionMethod {

    public MutualImplicationMethod(){
        //setInitVariables("MI"); // RESTAURAR
        setInitVariables("CA"); // BORRAR
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
        return "By mutual implication method:<br><br>";
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
}