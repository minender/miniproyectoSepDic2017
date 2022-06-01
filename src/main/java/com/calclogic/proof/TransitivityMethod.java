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
public class TransitivityMethod extends GenericProofMethod {

    public TransitivityMethod(){
        setInitVariables("TR");
    }

    /**
     * Checks if the two arguments are of the form p op q and q op^{-1} p
     * 
     * @param t1: Term that represent a formula
     * @param t2: Term that represent a formula
     * @return true if and only if t1 and t2 are of the form p op q and q op^{-1} p respectively
     */    
    protected boolean isInverseImpl(Term t1, Term t2) {
        if ( !(t1 instanceof App) || !(((App)t1).p instanceof App)) {
            return false;
        }
        String op1 = ((App)((App)t1).p).p.toStringFinal();
        return (op1.equals("c_{2}") || op1.equals("c_{3}")) && 
                t2 instanceof App && ((App)t2).p instanceof App &&
                ((App)t1).q.equals(((App)((App)t2).p).q) && 
               ((App)((App)t1).p).q.equals(((App)t2).q) && 
               ((App)((App)t2).p).p.toString().equals((op1.equals("c_{2}")?"c_{3}":"c_{2}"));
    }

    /**
     * This function adds a step of a proof into a bigger proof, when 
     * the current method is a transitive one.
     *
     */
    protected String setBaseMethodProof(String historial, String user, Term typedTerm, boolean solved, 
                ResuelveManager resuelveManager, DisponeManager disponeManager, SimboloManager s)
    {
        String primExp;
        String newStep; // New part of the proof that will be added
        String lastline; // Plain string of the last line of the demonstration
        Term iter; // Iterator over the lines of a demonstration

        boolean reversed = solved && typedTerm instanceof TypedApp && ((TypedApp)typedTerm).inferType=='e' &&
                      isInverseImpl(((TypedApp)typedTerm).q.type(),typedTerm.type());
        iter = (reversed?((TypedApp)typedTerm).q:typedTerm);
        boolean lastEquan = solved && iter instanceof TypedApp && ((TypedApp)iter).inferType=='e' &&
                      ((TypedApp)iter).q.type().toStringFinal().equals("c_{8}");
        iter = (lastEquan?((TypedApp)iter).p:iter);
        int i = 0;
        int firstOpInf = transFirstOpInferIndex(iter, true);
        
        Term ultInf = null;
        while (iter!=ultInf){
            // iter is of the form TT with transitivity
            if (iter instanceof TypedApp && ((TypedApp)iter).inferType=='t') {
               ultInf = ((TypedApp)iter).q;
               iter = ((TypedApp)iter).p;   
            }
            else if (iter instanceof TypedApp && ((TypedApp)iter).inferType=='m' &&
                     ((TypedApp)iter).p instanceof TypedApp && 
                     ((TypedApp)((TypedApp)iter).p).inferType=='m' && 
                     ((TypedApp)((TypedApp)iter).p).p instanceof TypedApp &&
                     ((TypedApp)((TypedApp)((TypedApp)iter).p).p).inferType=='i'
                    ) { // iter is of the form ((IA)T)T wit modus pones
               ultInf = ((TypedApp)iter).q;
               iter = ((TypedApp)((TypedApp)iter).p).q;
            }
            else { // first inference
                // ultInf is a no =inference folowing with a matatheorem of true
                if ( iter instanceof TypedApp && ((TypedApp)iter).inferType=='e' &&
                     ((TypedApp)iter).p instanceof TypedApp && 
                     ((TypedApp)((TypedApp)iter).p).p instanceof TypedS
                   )// query that verifies if metatheorem was used i.e ultInf of the form 
                    // (S(T)).T with . equanimity
                    iter = ((TypedApp)iter).q;
                ultInf = iter;
                
            }
            i++;
            // if ultInf is a no =inference do this
            Term ultInfType = ultInf.type();
            if (ultInfType instanceof App && ((App)ultInfType).p instanceof App &&
                   !(((App)((App)ultInfType).p).p.toStringFinal().equals("c_{1}") ||
                     ((App)((App)ultInfType).p).p.toStringFinal().equals("c_{20}")
                    )
               )
            {
                primExp = ((App)ultInfType).q.toStringInf(s,""); 
                newStep = hintTransOpInfer(user, ultInf, resuelveManager, disponeManager, s);
            }
            else if (ultInf == iter){ // ultInf is a =inference or opinference and the first one
                    primExp = ((App)ultInfType).q.toStringInf(s,""); 
                    newStep = stepOneSideEq(user, ultInf, resuelveManager, disponeManager, s);
            } else if (i<firstOpInf){ // ultInf is a =inference and not the first one and  
                                    // after at least one no =inference
                primExp = ((App)((App)((App)ultInfType).q).p).q.toStringInf(s,""); 
                newStep = hintTransEqInfer(user, ultInf, resuelveManager, disponeManager, s);
            } else { // ultInf is a =inference and not the first one
                   // and before the first no =inference
                primExp = ((App)ultInfType).q.toStringInf(s,""); 
                newStep = stepOneSideEq(user, ultInf, resuelveManager, disponeManager, s);
            }
            historial = "~~~~~~" + primExp + " \\\\" + newStep + "\\\\" + historial;
            primExp = newStep = "";
        }
        if ( firstOpInf == 0 || i == 1)
        {
            Term last = (reversed?((App)typedTerm.type()).q:((App)((App)typedTerm.type()).p).q);
            lastline = (solved?last.toStringInf(s,"")+"$":last.toStringInfLabeled(s));
        }
        else {
            Term last = (reversed?((TypedApp)typedTerm).q:typedTerm);
            last = ((App)((App)((App)((App)(lastEquan?((TypedApp)last).p:last).type()).p).q).p).q;
            lastline = (solved?last.toStringInf(s,"")+"$":last.toStringInfLabeled(s));
        }
        return historial + "~~~~~~" + lastline;  
    }

    /**
     * This function generates the hint of a step of a demonstration when the proof method is 
     * a transitive one, and the current step was generated by the current transitive operator
     *
     * @param user 
     * @param ultInf
     * @param resuelveManager
     * @param disponeManager
     * @param s
     * @return The hint of the step as a string.
     */
    private String hintTransOpInfer(String user, Term typedTerm, ResuelveManager resuelveManager, DisponeManager disponeManager, SimboloManager s) {
        
        Term iter, ultInf;
        iter = typedTerm;
        ultInf = null;
        Term leibniz = new Var('z');
        String hint = "";
        
        while (iter != ultInf) {
            //iter of the form (TT)T
            if (iter instanceof TypedApp && ((TypedApp)iter).p instanceof TypedApp) {
                boolean modusPonens = ((TypedApp)iter).inferType=='m';
                ultInf = ((TypedApp)iter).p;
                iter = ((TypedApp)iter).q;
                
                Term t;
                if ( modusPonens ) {
                    App aux1 = (App)((App)((App)((App)((App)ultInf).q.type()).p).q).q;
                    App aux2 = (App)((App)((App)((App)ultInf.type()).p).q).q;
                    if ( ((Var)aux1.q).indice == 112 ) {
                        t = new App(((App)aux2).p,new Var('z'));
                    }
                    else {
                        t = new App(new App(((App)((App)aux2).p).p,new Var('z')),((App)aux2).q);
                    }
                }
                else {
                    t = new App(new Const(7,"c_{7}"),new Var('z'));
                }
                leibniz = leibniz.sust(new Var('z'), t);
                
            }
            else { // iter must be of the form IA or A
                ultInf = iter;
            }
        }
        hint = hintOneSide(user, ultInf, resuelveManager, disponeManager, s);
        hint = ((App)((App)typedTerm.type()).p).p.toStringInf(s,"")+hint.substring(hint.indexOf("~"));
        if (leibniz.toStringFinal().equals("x_{122}") )
            return hint;
        else
            return hint.substring(0, hint.length()-7)+"~and~E:"+leibniz.toStringInf(s, "")+"\\rangle";
    }

    /**
     * This function generates the hint of a step of a demonstration when the proof method is 
     * a transitive one, but the current step was generated by an equivalence, not the current
     * transitive operator.
     * @param user 
     * @param ultInf
     * @param resuelveManager
     * @param disponeManager
     * @param s
     * @return The hint of the step as a string.
     */
    private String hintTransEqInfer(String user, Term ultInf, ResuelveManager resuelveManager, DisponeManager disponeManager, SimboloManager s) {
        Term aux = ((TypedApp)ultInf).q;
        int z = ((Bracket)((TypedApp)ultInf).p.type()).x();
        Term t = ((App)((App)((Bracket)((TypedApp)ultInf).p.type()).t).p).q;
        Term typedTerm;
        try {
            typedTerm = (t instanceof Var?aux:new TypedApp(new TypedL(new Bracket(new Var(z),t)),aux));
        }
        catch (TypeVerificationException e) {
            Logger.getLogger(TransitivityMethod.class.getName()).log(Level.SEVERE, null, e);
            return "";
        }
        return stepOneSideEq(user, typedTerm, resuelveManager, disponeManager, s);
    }

    /**
     * This method will return the typedTerm that represents the sub derivation
     * tree that infer de use on Leibniz in weakening/strengthening 
     * @param leibniz: Term that represent de Leibniz expression 
     * @param nabla: derivation with root P op Q. The root is to be use as argument 
     *             for Leibniz rule with op in {Rightarrow,Leftarrow}
     * @return new TypedTerm that represent a derivation with root 
     *         (lambda z.E)P op_2 (lambda z.E)Q with op_2 in {Rightarrow,Leftarrow}
     * @throws com.calclogic.lambdacalculo.TypeVerificationException
     */
    protected Term parityLeibniz(Term leibniz, Term nabla) throws TypeVerificationException {      
        Term t = leibniz.traducBD();
        
        while (t instanceof App) {
            Term nabla2 = nabla; // si no entra en ninguna guardia aborta el TApp(nabla,nabla)
            if (((App)t).q instanceof Const && ((Const)((App)t).q).getId() == 7 ) {
                Term root = nabla.type();
                nabla2 = neg(((App)root).q, ((App)((App)root).p).q, 
                                             (Const)((App)((App)root).p).p);
                t = ((App)t).p;
            }
            else if (((App)t).q instanceof App && ((App)((App)t).q).p instanceof Const) {
                if (((Const)((App)((App)t).q).p).getId() == 2 ) {
                    Term root = nabla.type();
                    nabla2 = transl2(((App)root).q, ((App)((App)root).p).q, 
                                             (Const)((App)((App)root).p).p, ((App)((App)t).q).q);
                }
                else if ( (((Const)((App)((App)t).q).p).getId() != 1 ) ) {
                    Term root = nabla.type();
                    nabla2 = transl1(((App)root).q, ((App)((App)root).p).q, 
                                             (Const)((App)((App)root).p).p, ((App)((App)t).q).q,
                                             (Const)((App)((App)t).q).p);
                }
                t = ((App)t).p;
            }
            else if (((App)t).q instanceof Const && ((App)t).p instanceof App) {
                if ( ((Const)((App)t).q).getId()==3 ) {
                    Term root = nabla.type();
                    nabla2 = transr2(((App)root).q, ((App)((App)root).p).q, 
                                             (Const)((App)((App)root).p).p, ((App)((App)t).p).q);
                }
                else if (((Const)((App)t).q).getId() != 1) {
                    Term root = nabla.type();
                    nabla2 = transr1(((App)root).q, ((App)((App)root).p).q, 
                                             (Const)((App)((App)root).p).p, ((App)((App)t).p).q,
                                             (Const)((App)t).q);
                }
                t = ((App)((App)t).p).p;
            }
            nabla = new TypedApp(nabla2,nabla);
        }
        return nabla;
    }

    /**
     * This method returns a derivation tree of the form: 
     *
     *     Gamma |- (x op y) == (!x op' !y)
     *     -------------------------------- I [x,y:=p,q]
     *     Gamma |- (p op q) == (!p op' !q)
     * 
     * where op' is ==> when op is <== and op' is <== when op is ==>
     * 
     * @param p: formula to be substituted in the tree
     * @param q: formula to be substituted in the tree
     * @param op: Constant that can be ==> or <==
     * @return typed term that represent the derivation tree before
     */
    private Term neg(Term p, Term q, Const op) {
        
        String op2 = (op.getId() == 2?"c_{3}":"c_{2}");
        String P = p.toStringFinal();
        String Q = q.toStringFinal();
        String neg = "I^{[x_{112}, x_{113} := "+P+", "+Q+"]}A^{c_{1} ("+op2+" (c_{7} x_{113}) (c_{7} x_{112})) ("+op+" x_{113} x_{112})}";
        
        return CombUtilities.getTerm(neg);
    }
    
    /**
     * This method returns a derivation tree of the form: 
     *
     *     Gamma |- (x op y) ==> ((x op1 z) op (y op1 z))
     *     ---------------------------------------------- I [x,y,z:=p,q,r]
     *     Gamma |- (p op q) ==> ((p op1 r) op (q op1 r))
     * 
     * where op' is ==> when op is <== and op' is <== when op is ==> 
     * and op1 can be /\, \/, or <==
     * 
     * @param p: formula to be substituted in the tree
     * @param q: formula to be substituted in the tree
     * @param op: Constant that can be ==> or <==
     * @param r: formula to be substituted in the tree
     * @param op1: Constant that can be /\, \/, or <==
     * @return typed term that represent the derivation tree before
     */
    private Term transl1(Term p, Term q, Const op, Term r, Const op1) {
        
        String P = p.toStringFinal();
        String Q = q.toStringFinal();
        String R = r.toStringFinal();
        String transl1 = "I^{[x_{112}, x_{113}, x_{114} := "+P+", "+Q+", "+R+"]}A^{c_{2} ("+op+" ("+op1+" x_{114} x_{113}) ("+op1+" x_{114} x_{112})) ("+op+" x_{113} x_{112})}";
        
        return CombUtilities.getTerm(transl1);
    }
    
    /**
     * This method returns a derivation tree of the form: 
     *
     *     Gamma |- (x op y) ==> ((x ==> z) op' (y ==> z))
     *     ---------------------------------------------- I [x,y,z:=p,q,r]
     *     Gamma |- (p op q) ==> ((p ==> r) op' (q ==> r))
     * 
     * where op' is ==> when op is <== and op' is <== when op is ==> 
     * and op1 can be /\, \/, or <==
     * 
     * @param p: formula to be substituted in the tree
     * @param q: formula to be substituted in the tree
     * @param op: Constant that can be ==> or <==
     * @param r: formula to be substituted in the tree
     * @return typed term that represent the derivation tree before
     */
    private Term transl2(Term p, Term q, Const op, Term r) {
        
        String op2 = (op.getId() == 2?"c_{3}":"c_{2}");
        String P = p.toStringFinal();
        String Q = q.toStringFinal();
        String R = r.toStringFinal();
        String transl2 = "I^{[x_{112}, x_{113}, x_{114} := "+P+", "+Q+", "+R+"]}A^{c_{2} ("+op2+" (c_{2} x_{114} x_{113}) (c_{2} x_{114} x_{112})) ("+op+" x_{113} x_{112})}";
        
        return CombUtilities.getTerm(transl2);
    }
    
    /**
     * This method returns a derivation tree of the form: 
     *
     *     Gamma |- (x op y) ==> ((z op1 x) op (z op1 y))
     *     ---------------------------------------------- I [x,y,z:=p,q,r]
     *     Gamma |- (p op q) ==> ((r op1 p) op (r op1 q))
     * 
     * where op is ==> or <== and op1 can be /\, \/, or ==>
     * 
     * @param p: formula to be substituted in the tree
     * @param q: formula to be substituted in the tree
     * @param op: Constant that can be ==> or <==
     * @param r: formula to be substituted in the tree
     * @param op1: Constant that can be /\, \/, or ==>
     * @return typed term that represent the derivation tree before
     */
    private Term transr1(Term p, Term q, Const op, Term r, Const op1) {
        
        String P = p.toStringFinal();
        String Q = q.toStringFinal();
        String R = r.toStringFinal();
        String transr1 = "I^{[x_{112}, x_{113}, x_{114} := "+P+", "+Q+", "+R+"]}A^{c_{2} ("+op+" ("+op1+" x_{113} x_{114}) ("+op1+" x_{112} x_{114})) ("+op+" x_{113} x_{112})}";
        
        return CombUtilities.getTerm(transr1);
    }
    
    /**
     * This method returns a derivation tree of the form: 
     *
     *     Gamma |- (x op y) ==> ((z <== x) op' (z <== y))
     *     ----------------------------------------------- I [x,y,z:=p,q,r]
     *     Gamma |- (p op q) ==> ((r <== p) op' (r <== q))
     * 
     * where where op' is ==> when op is <== and op' is <== when op is ==> 
     * 
     * @param p: formula to be substituted in the tree
     * @param q: formula to be substituted in the tree
     * @param op: Constant that can be ==> or <==
     * @param r: formula to be substituted in the tree
     * @return typed term that represent the derivation tree before
     */
    private Term transr2(Term p, Term q, Const op, Term r) {
        
        String op2 = (op.getId() == 2?"c_{3}":"c_{2}");
        String P = p.toStringFinal();
        String Q = q.toStringFinal();
        String R = r.toStringFinal();
        String transr2 = "I^{[x_{112}, x_{113}, x_{114} := "+P+", "+Q+", "+R+"]}A^{c_{2} ("+op2+" (c_{3} x_{113} x_{114}) (c_{3} x_{112} x_{114})) ("+op+" x_{113} x_{112})}";
        
        return CombUtilities.getTerm(transr2);
    }

    /**
     * Auxiliar method for "finishedBaseMethodProof" that implements the corresponding
     * logic according to the transitivity method.
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
        // If at least one opInference was made and reaches the goal
        if(transFirstOpInferIndex(proof,true)!=0 && ((App)((App)expr).p).q.equals(theoremBeingProved) ){ 
            return new TypedApp(proof,new TypedA(new Const("c_{8}"))); // true
        }
        return proof;
    }
    
    /**
     * Returns the index of the first inference that is not a 
     * equiv or = in a Transitivity method
     * 
     * @param typedTerm Derivation tree that code a Transitivity proof
     * @param reverse Determines if we want the index but counting in reverse
     * @return index of the first no =inference
     */
    public int transFirstOpInferIndex(Term typedTerm, Boolean reverse) {
        Term iter;
        iter = typedTerm;
        Term ultInf = null;
        int i = 0;
        int firstOpInf = 0;
        while (iter!=ultInf){
            if (iter instanceof TypedApp && ((TypedApp)iter).inferType=='t') {// TT
               ultInf = ((TypedApp)iter).q;
               iter = ((TypedApp)iter).p;   
            }
            else if (iter instanceof TypedApp && ((TypedApp)iter).inferType=='m' &&
                     ((TypedApp)iter).p instanceof TypedApp && 
                     ((TypedApp)((TypedApp)iter).p).inferType=='m' && 
                     ((TypedApp)((TypedApp)iter).p).p instanceof TypedApp &&
                     ((TypedApp)((TypedApp)((TypedApp)iter).p).p).inferType=='i'
                    ) { // ((IA)T)T
               ultInf = ((TypedApp)iter).q;
               iter = ((TypedApp)((TypedApp)iter).p).q;
            }
            else { // first inference
                if ( iter instanceof TypedApp && ((TypedApp)iter).inferType=='e' &&
                     ((TypedApp)iter).p instanceof TypedApp && 
                     ((TypedApp)((TypedApp)iter).p).inferType=='s'
                   ) 
                    iter = ((TypedApp)iter).q;
                ultInf = iter;
            }
            i++;
            Term ultInfType = ultInf.type();
            if (ultInfType instanceof App && ((App)ultInfType).p instanceof App &&
                   !(((App)((App)ultInfType).p).p.toStringFinal().equals("c_{1}") ||
                     ((App)((App)ultInfType).p).p.toStringFinal().equals("c_{20}")
                    )
               )
                firstOpInf = i;
        }
        if (!reverse && (firstOpInf != 0))
            firstOpInf = i+1-firstOpInf;
        return firstOpInf;
    } 
}