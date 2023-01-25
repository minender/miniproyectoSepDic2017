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
import com.calclogic.lambdacalculo.TypedM;
import com.calclogic.lambdacalculo.TypedS;
import com.calclogic.service.ResuelveManager;
import com.calclogic.service.SimboloManager;

import java.util.List;
import org.springframework.stereotype.Service;

/**
 *
 * @author ronald
 */
@Service
public class DirectMethodImpl extends StartingOneSideMethodImpl implements DirectMethod{

    public DirectMethodImpl(){
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
     * TO BE OVERWRITTEN
     * 
     * The statement that is needed to prove may change inside a sub proof,
     * so this function calculates which that new statement is.
     *  
     * @param beginFormula: general statement to be proved, is the base to calculate 
     *                      al de sub statement in the sub proofs.
     * @return Term that represents the statement to be proved in the current sub proof,
     *         according to the demonstrarion method used
     */
    @Override
    public Term initFormula(Term beginFormula){
        return beginFormula;
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
     * @param s
     * @param expr: The root of the proof tree, which is the last line
     * @param initialExpr: The expression (could be a theorem) from which the user started the demonstration
     * @param finalExpr: The last line in the demonstration that the user has made
     * @return new proof if finished, else returns the same proof
     * @throws com.calclogic.lambdacalculo.TypeVerificationException
     */
    @Override
    public Term auxFinBaseMethodProof(Term formulaBeingProved, Term proof, String username,
                ResuelveManager resuelveManager, SimboloManager s, 
                Term expr, Term initialExpr, Term finalExpr) throws TypeVerificationException
    {
        // Case when we started from the theorem being proved
        formulaBeingProved = ((App)formulaBeingProved).q.body();
        finalExpr = finalExpr.body();
        initialExpr = initialExpr.body();
        if(formulaBeingProved.equals(initialExpr.body())) {
            // List of theorems solved by the user. We examine them to check if the current proof already reached one 
            List<Resuelve> resuelves = resuelveManager.getAllResuelveByUserResuelto(username,true);
            Term theorem; //, mt;
            Term equanimityExpr = null; // Expression with which equanimity will be applied
            int[] c = new int[1];
                    
            for(Resuelve resu: resuelves){
                c[0] = 0;
                theorem = resu.getTeorema().getTeoTerm(); // This is the theorem that is in the database
                Term noEqTheo = ((Term)theorem).setToPrinting(resu.getVariables(),s,c);
                //System.out.println(c);
                //mt = new App(new App(new Const("c_{1}"),new Const("true")),noEqTheo); // theorem == true
                // acomodar esto para crear mt dependiendo de los metateoremas que se tienen guardados
                
                // We don't want to unify with the formulaBeingProved itself if it was already demonstrated
                if (noEqTheo.equals(formulaBeingProved)){
                    ;
                }
                // If the current theorem or theorem==true matches the final expression
                else if(noEqTheo.equals(finalExpr)){ //|| mt.equals(finalExpr)){
                    equanimityExpr = new TypedM(c[0],resu.getNumeroteorema(),username);
                }
                else {
                    // Check if the last line of the proof (finalExpr) is an instance of an already demonstrated theorem
                    // >>> It would not work if we did it backwards: (finalExpr, theorem)
                    Equation eq = new Equation(noEqTheo, finalExpr);
                    Sust sust = eq.mgu(s);

                    // Case whe lanst line is an instantiation of the compared theorem
                    if (sust != null) {
                        // The equanimity is applied with the instantiated theorem
                        equanimityExpr = new TypedApp(new TypedI(sust), new TypedM(c[0],resu.getNumeroteorema(), username)); 
                    }
                }
                if (equanimityExpr != null){
                    return new TypedApp(new TypedApp(new TypedS(proof.type()), proof), equanimityExpr);
                }
            }
        }
        // Case when we started from another theorem
        else if(finalExpr.equals(formulaBeingProved)) { 
            Term aux = new App(new App(new Const(0,"="),new Const(-1,"T")),initialExpr).abstractEq();
            TypedA A = new TypedA(aux.traducBD(),username);

            if (A.getNSt().equals("")) { 
                int idOp = ((Const)((App)((App)initialExpr).p).p).getId();
                initialExpr= new App(new App(new Const(0,"="),((App)((App)initialExpr).p).q),((App)initialExpr).q);
                initialExpr = initialExpr.abstractEq().traducBD(); 
                Term M = new TypedM(idOp,initialExpr,username); 
                return new TypedApp(proof, M);
            }
            else 
                return new TypedApp(proof, A);
        }
        return proof; 
    } 
}