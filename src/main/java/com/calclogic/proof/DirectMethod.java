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
public class DirectMethod extends GenericProofMethod {

    public DirectMethod(){
        setInitVariables("DM");
    }

    /**
     * This function adds a step of a proof into a bigger proof, when the
     * current method is the direct one or starting from one side.
     *
     */
    protected String setBaseMethodProof(String historial, String user, Term typedTerm, boolean solved, 
                ResuelveManager resuelveManager, DisponeManager disponeManager, SimboloManager s)
    {
        String primExp;
        String newStep; // New part of the proof that will be added
        String lastline; // Plain string of the last line of the demonstration
        Term iter; // Iterator over the lines of a demonstration

        boolean equanimity = false; // Indicates ifequanimity was used
        String equanimityHint = ""; // Text that indicates in which already proven theorem the current demonstration finalized (if any)
        
        /* If the demonstrarion method is starting from one side, or the typedTerm is not an inference
           but just a functional application (an App) or is an equanimity inference */
        if (this.methodStr.equals("SS") || !(typedTerm instanceof TypedApp) || ((TypedApp)typedTerm).inferType!='e') {
            if (solved && typedTerm instanceof TypedApp && ((TypedApp)typedTerm).inferType=='s') 
                iter = ((TypedApp)typedTerm).q;
            else
                iter = typedTerm;
            Term aux = ((App)((App)iter.type()).p).q;
            lastline = (solved?aux.toStringInf(s,"")+"$":aux.toStringInfLabeled(s));
        }
        // Case when direct method is applied and we start from the expression to be proved
        else { 
            String eqSust = ""; // Indicates the instantiation (if any) that was necessary to apply to the already proven theorem

            // Case when we need to instantiate the already proven theorem so it matches the final expression of the current proof
            if (((TypedApp)typedTerm).q instanceof TypedApp){
                lastline = ((TypedApp)((TypedApp)typedTerm).q).q.type().toStringFinal();
                eqSust = "~with~"+ ((TypedApp)((TypedApp)typedTerm).q).p.type().toStringInf(s,"");
            }
            else {
                // Note that here we have a less "q" respect of the previous case because in there 
                // there was an additional tree representing the instantiation
                lastline = ((TypedApp)typedTerm).q.type().toStringFinal();
            }

            // We get the Resuelve row associated to the demonstrated theorem in order that we can 
            // later get its current number (established by the user) to indicate that it is what
            // was used to end the demonstration
            Resuelve eqHintResuel = resuelveManager.getResuelveByUserAndTeorema(user, lastline);

            // Case when the user could only see the theorem but had not a Resuelve object associated to it
            if (eqHintResuel == null){
                eqHintResuel = resuelveManager.getResuelveByUserAndTeorema("AdminTeoremas", lastline);
            }

            equanimityHint = "~~~-~\\text{st}~("+eqHintResuel.getNumeroteorema()+")"+eqSust;

            if( ((TypedApp)typedTerm).p instanceof TypedApp && 
                ((TypedApp)((TypedApp)typedTerm).p).inferType=='s' 
               ) 
            {
                iter = ((TypedApp)((TypedApp)typedTerm).p).q;       
                lastline = ((App)((App)iter.type()).p).q.toStringInf(s,"")+equanimityHint+"$";
            }
            else  {
                iter = ((TypedApp)typedTerm).p;
                equanimity = true;
                lastline = ((App)((App)iter.type()).p).q.toStringInf(s,"")+"$";
            }
        }

        Term ultInf = null;
        while (iter!=ultInf){
            if (iter instanceof TypedApp && ((TypedApp)iter).inferType=='t') {
                ultInf = ((TypedApp)iter).q;
                iter = ((TypedApp)iter).p;
                Term ultInfType = ultInf.type();
                primExp = ((App)ultInfType).q.toStringInf(s,""); 
            }
            else {
                ultInf = iter;
                Term ultInfType = ultInf.type();
                primExp = ((App)ultInfType).q.toStringInf(s,"");
                if (equanimity){
                    primExp += equanimityHint;
                }
            } 
            newStep = stepOneSideEq(user, ultInf, resuelveManager, disponeManager, s);
            historial = "~~~~~~" + primExp + " \\\\" + newStep + "\\\\" + historial;
            primExp = newStep = "";
        }
        return historial + "~~~~~~" + lastline;
    }

    /**
     * Auxiliar method for "finishedBaseMethodProof" that implements the corresponding
     * logic according to the direct method.
     * 
     * It assumes we have a proof that so far has proved A == ... == F
     * 
     * @param theoremBeingProved: The theorem the user is trying to prove
     * @param proof: The proof tree so far
     * @param username: name of the user doing the proof
     * @param expr: The root of the proof tree, which is the last line
     * @param initialExpr: The expression (could be a theorem) from which the user started the demonstration
     * @param finalExpr: The last line in the demonstration that the user has made
     * @return new proof if finished, else returns the same proof
     * @throws com.calclogic.lambdacalculo.TypeVerificationException
     */
    protected Term auxFinBaseMethodProof(Term theoremBeingProved, Term proof, String username, 
                Term expr, Term initialExpr, Term finalExpr) throws TypeVerificationException
    {
        // Case when we started from the theorem being proved
        if(theoremBeingProved.equals(initialExpr)) {
            // List of theorems solved by the user. We examine them to check if the current proof already reached one 
            List<Resuelve> resuelves = resuelveManager.getAllResuelveByUserOrAdminResuelto(username);
            Term theorem, mt;
            Term equanimityExpr = null; // Expression with which equanimity will be applied

            for(Resuelve resu: resuelves){ 
                theorem = resu.getTeorema().getTeoTerm(); // This is the theorem that is in the database
                mt = new App(new App(new Const("c_{1}"),new Const("true")),theorem); // theorem == true

                // We don't want to unify with the theoremBeingProved itself if it was already demonstrated
                if (theorem.equals(theoremBeingProved)){
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
        else if(finalExpr.equals(theoremBeingProved)) {
            return new TypedApp(proof, new TypedA(initialExpr));
        }
        return proof;
    }
}