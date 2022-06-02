package com.calclogic.proof;

import com.calclogic.lambdacalculo.App;
import com.calclogic.lambdacalculo.Const;
import com.calclogic.lambdacalculo.Term;

/**
 *
 * @author ronald
 */
public class CaseAnalysisMethod extends AndIntroductionMethod {

    public CaseAnalysisMethod(){
        setInitVariables("CA");
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
        return new App(new App(new Const(5,"c_{5}"),new App(new App(new Const(2,"c_{2}"),beginFormula),new App(new Const(7,"c_{7}"),new Const(8,"c_{8}")))) ,new App(new App(new Const(2,"c_{2}"), beginFormula),new Const(8,"c_{8}")));
    }
}