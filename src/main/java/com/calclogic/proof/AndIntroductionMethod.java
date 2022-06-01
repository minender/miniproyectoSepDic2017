package com.calclogic.proof;

import com.calclogic.entity.Resuelve;
import com.calclogic.controller.InferController;
import com.calclogic.lambdacalculo.App;
import com.calclogic.lambdacalculo.Bracket;
import com.calclogic.lambdacalculo.Const;
import com.calclogic.lambdacalculo.Equation;
import com.calclogic.lambdacalculo.Sust;
import com.calclogic.lambdacalculo.Var;
import com.calclogic.lambdacalculo.Term;
import com.calclogic.lambdacalculo.TypeVerificationException;
import com.calclogic.lambdacalculo.TypedA;
import com.calclogic.lambdacalculo.TypedApp;
import com.calclogic.lambdacalculo.TypedI;
import com.calclogic.lambdacalculo.TypedL;
import com.calclogic.lambdacalculo.TypedS;
import com.calclogic.service.ResuelveManager;
import com.calclogic.service.SimboloManager;
import com.calclogic.parse.CombUtilities;


import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Collections;
import java.util.logging.Level;
import java.util.logging.Logger;
import org.apache.commons.lang3.text.StrSubstitutor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

/**
 *
 * @author ronald
 */
public class AndIntroductionMethod extends GenericProofMethod {

    public AndIntroductionMethod(){
        setInitVariables("AI");
    }

    /**
     * The statement that is needed to prove may change inside a sub proof,
     * so this function calculates which that new statement is.
     *  
     * @param beginFormula: general statement to be proved, is the base to calculate 
     *                      al de sub statement in the sub proofs.
     * @return Term that represents the statement to be proved in the current sub proof.
     */
    public Term initFormula(Term beginFormula){
        return ((App)beginFormula).q;
    }

    /**
     * This function will return a new proof tree in case it finds out that the last inference
     * caused the whole proof to be correct under the sub-proof method. In other case it will return 
     * the proof given as argument.
     * 
     * It will return a new proof tree that connects in one proof of P/\Q, 
     * two independent sub proofs of P and Q
     * 
     * @param theoremBeingProved: The theorem that user is trying to prove 
     * @param proof: The proof tree so far
     * @return proof of theoremBeingProved if finished, else returns the same proof
     */
    protected Term finishedRecursiveMethodProof(Term theoremBeingProved, Term proof) {
        Map<String,String> values = new HashMap<>();
        values.put("T1",finalProof.toStringFinal());
        values.put("T1Type", finalProof.type().toStringFinal());
        StrSubstitutor sub = new StrSubstitutor(values, "%(",")");
        String metaTheo = "S (I^{[x_{113} := %(T1Type)]} A^{c_{1} x_{113} (c_{1} x_{113} c_{8})}) (%(T1))";
        String theo = sub.replace(metaTheo);
        Term theoTerm = CombUtilities.getTerm(theo);
        Term firstProof = ((App)theoremBeingProved).q;
        Term firstStAndTrue = ((App)((App)theoremBeingProved).p).p;
        Term leibniz = ((App)((App)((App)theoremBeingProved).p).q).p;
        try {
            Term newProof = new TypedApp(new TypedApp(firstStAndTrue,new TypedApp(leibniz,theoTerm)),firstProof);
            return newProof;
        }
        catch (TypeVerificationException e) {
            Logger.getLogger(InferController.class.getName()).log(Level.SEVERE, null, e);
            return theoremBeingProved;
        }
    }
}