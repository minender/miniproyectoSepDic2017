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
import com.calclogic.service.ResuelveManager;
import com.calclogic.service.SimboloManager;
import com.calclogic.parse.CombUtilities;

/**
 *
 * @author ronald
 */
public class WeakeningMethod extends TransitivityMethod {

    public WeakeningMethod(){
        setInitVariables("WE");
    }

    /**
     * Auxiliar method for "finishedBaseMethodProof" that implements the corresponding
     * logic according to the weakening or strengthening method.It assumes we have a proof that so far has proved A == ...== F
     * 
     * 
     * @param theoremBeingProved: The theorem the user is trying to prove
     * @param proof: The proof tree so far
     * @param username: name of the user doing the proof
     * @param resuelveManager
     * @param simboloManager
     * @param expr: The root of the proof tree, which is the last line
     * @param initialExpr: The expression (could be a theorem) from which the user started the demonstration
     * @param finalExpr: The last line in the demonstration that the user has made
     * @return new proof if finished, else returns the same proof
     * @throws com.calclogic.lambdacalculo.TypeVerificationException
     */
    @Override
    protected Term auxFinBaseMethodProof(Term theoremBeingProved, Term proof, String username,
                ResuelveManager resuelveManager, SimboloManager simboloManager, 
                Term expr, Term initialExpr, Term finalExpr) throws TypeVerificationException
    {
        String arrow = ((App)((App)theoremBeingProved).p).p.toStringFinal();
        Boolean rightArrow = arrow.equals("c_{2}"); // =>
        Boolean leftArrow = arrow.equals("c_{3}"); // <=

        // If we are weakening and the statement is A=>B or we are strengthening and the statement is A<=B
        if ((("WE".equals(this.methodStr)) && rightArrow) || (("ST".equals(this.methodStr)) && leftArrow)){
            // In this case we use the same finalization as in the transitivity method
            TransitivityMethod tr = new TransitivityMethod();
            return tr.auxFinBaseMethodProof(theoremBeingProved,proof,username,resuelveManager,simboloManager,expr,initialExpr,finalExpr);
        }
        /* If we are weakening and the statement is A<=B or we are strengthening and the statement is A=>B, 
           and at least one inference was made.
           >>>> NOTE: if the app forces to start from the left side, this case may be impossible (not sure)
        */
        if (((("WE".equals(this.methodStr)) && leftArrow) || (("ST".equals(this.methodStr)) && rightArrow)) && (InferenceIndex.wsFirstOpInferIndex(proof)!=0)){
            // Axiom: (q => p) == (p <= q)
            TypedA axiom = new TypedA(CombUtilities.getTerm("c_{1} (c_{2} x_{112} x_{113}) (c_{3} x_{113} x_{112})") );
            TypedI instantiation;

            if (isInverseImpl(expr,theoremBeingProved)){
                if ("WE".equals(this.methodStr)){
                    instantiation = new TypedI((Sust)CombUtilities.getTerm("[x_{112}, x_{113} := "+((App)((App)expr).p).q+", "+((App)expr).q+"]"));
                }
                else {
                    instantiation = new TypedI((Sust)CombUtilities.getTerm("[x_{112}, x_{113} := "+((App)expr).q+", "+((App)((App)expr).p).q+"]"));
                }
                return new TypedApp(new TypedApp(instantiation,axiom),proof);
            }
            if (isInverseImpl(((App)((App)expr).p).q,theoremBeingProved)){
                Term aux;
                if ("WE".equals(this.methodStr)){
                    instantiation = new TypedI((Sust)CombUtilities.getTerm("[x_{112}, x_{113} := "+((App)((App)((App)((App)expr).p).q).p).q+", "+((App)((App)((App)expr).p).q).q+"]"));
                    aux = new TypedApp(instantiation,axiom);

                    return new TypedApp(new TypedApp(new TypedS(aux.type()),aux),new TypedApp(proof,new TypedA(new Const("c_{8}"))));
                }
                else {
                    instantiation = new TypedI((Sust)CombUtilities.getTerm("[x_{112}, x_{113} := "+((App)((App)((App)expr).p).q).q+", "+((App)((App)((App)((App)expr).p).q).p).q+"]"));
                    aux = new TypedApp(instantiation,axiom);

                    return new TypedApp(aux,new TypedApp(proof,new TypedA(new Const("c_{8}"))));
                }
            }
        }
        return proof;
    }
}