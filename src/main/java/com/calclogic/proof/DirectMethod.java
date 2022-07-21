package com.calclogic.proof;

import com.calclogic.entity.Resuelve;
import com.calclogic.lambdacalculo.App;
import com.calclogic.lambdacalculo.Const;
import com.calclogic.lambdacalculo.Equation;
import com.calclogic.lambdacalculo.Sust;
import com.calclogic.lambdacalculo.Term;
import com.calclogic.lambdacalculo.TypeVerificationException;
import com.calclogic.lambdacalculo.TypedA;
import com.calclogic.lambdacalculo.TypedApp;
import com.calclogic.lambdacalculo.TypedI;
import com.calclogic.lambdacalculo.TypedS;
import com.calclogic.service.ResuelveManager;
import com.calclogic.service.SimboloManager;
import java.util.List;

/**
 *
 * @author ronald
 */
public class DirectMethod extends StartingOneSideMethod {

    public DirectMethod(){
        setInitVariables("DM");
    }

    /**
     * Indicates the header that a proof that starts with direct method must have.
     *  
     * @param nTeo: Number of the theorem to be proved, expressed in a string
     * @return The header message to be added to the proof
     */
    @Override
    public String header(String nTeo){
        return "By direct method<br>";
    }

    /**
     * Auxiliar method for "finishedBaseMethodProof" that implements the corresponding
     * logic according to the direct method.It assumes we have a proof that so far has proved A == ...== F
     * 
     * 
     * @param formulaBeingProved: Formula that the user is trying to prove in this proof/sub-proof
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
    protected Term auxFinBaseMethodProof(Term formulaBeingProved, Term proof, String username,
                ResuelveManager resuelveManager, SimboloManager simboloManager, 
                Term expr, Term initialExpr, Term finalExpr) throws TypeVerificationException
    {
        // Case when we started from the theorem being proved
        if(formulaBeingProved.equals(initialExpr)) {
            // List of theorems solved by the user. We examine them to check if the current proof already reached one 
            List<Resuelve> resuelves = resuelveManager.getAllResuelveByUserOrAdminResuelto(username);
            Term theorem, mt;
            Term equanimityExpr = null; // Expression with which equanimity will be applied

            for(Resuelve resu: resuelves){ 
                theorem = resu.getTeorema().getTeoTerm(); // This is the theorem that is in the database
                mt = new App(new App(new Const("c_{1}"),new Const("true")),theorem); // theorem == true

                // We don't want to unify with the formulaBeingProved itself if it was already demonstrated
                if (theorem.equals(formulaBeingProved)){
                    ;
                }
                // If the current theorem or theorem==true matches the final expression
                else if(theorem.equals(finalExpr) || mt.equals(finalExpr)){
                    equanimityExpr = new TypedA(finalExpr);
                } 
                else {
                    // Check if the last line of the proof (finalExpr) is an instance of an already demonstrated theorem
                    // >>> It would not work if we did it backwards: (finalExpr, theorem)
                    Equation eq = new Equation(theorem, finalExpr);
                    Sust sust = eq.mgu(simboloManager);

                    // Case whe lanst line is an instantiation of the compared theorem
                    if (sust != null){
                        //System.out.println("Por el sust != null");
                        // The equanimity is applied with the instantiated theorem, not with the last line instantiated
                        equanimityExpr = new TypedApp(new TypedI(sust), new TypedA(theorem)); 
                    }   
                }
                if (equanimityExpr != null){
                    return new TypedApp(new TypedApp(new TypedS(proof.type()), proof), equanimityExpr);
                }
            }
        }
        // Case when we started from another theorem
        else if(finalExpr.equals(formulaBeingProved)) {
            return new TypedApp(proof, new TypedA(initialExpr));
        }
        return proof;
    }
}