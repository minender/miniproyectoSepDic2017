package com.calclogic.proof;

import com.calclogic.controller.InferController;
import com.calclogic.lambdacalculo.App;
import com.calclogic.lambdacalculo.Term;
import com.calclogic.lambdacalculo.TypeVerificationException;
import com.calclogic.lambdacalculo.TypedApp;
import com.calclogic.parse.CombUtilities;
import java.util.HashMap;
import java.util.Map;
import java.util.logging.Level;
import java.util.logging.Logger;
import org.apache.commons.lang3.text.StrSubstitutor;

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
     * This function will only be correct if called when using a branched (non linear) recursive method.
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
    @Override
    public Term finishedBranchedRecursiveMethodProof(Term theoremBeingProved, Term proof) {
        Map<String,String> values = new HashMap<>();
        values.put("T1",proof.toStringFinal());
        values.put("T1Type", proof.type().toStringFinal());
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
            Logger.getLogger(AndIntroductionMethod.class.getName()).log(Level.SEVERE, null, e);
            return theoremBeingProved;
        }
    }
}