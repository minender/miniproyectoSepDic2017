package com.calclogic.proof;

import com.calclogic.lambdacalculo.App;
import com.calclogic.lambdacalculo.Bracket;
import com.calclogic.lambdacalculo.Const;
import com.calclogic.lambdacalculo.Var;
import com.calclogic.lambdacalculo.Term;
import com.calclogic.lambdacalculo.TypedL;

/**
 *
 * @author ronald
 */
public class ProofBoolean {
    
    /**
     * This method return true if and only if method is an incomplete non atomic proof method
     *  
     * @param method: Term that represent the current state of the proof method
     * @return true if and only if method is waiting the selection of 
     * another proof method to start de proof
     */
    public static boolean isWaitingMethod(Term method) {
        
        Term m1, m2 = null;
        if (method instanceof Const && 
            (
             ((Const)method).getCon().equals("DM") ||
             ((Const)method).getCon().equals("SS") ||   
             ((Const)method).getCon().equals("TR") ||
             ((Const)method).getCon().equals("WE") ||
             ((Const)method).getCon().equals("ST")    
            )
           ) 
        {
           return false;    
        }
        else if (method instanceof Const && 
                 (
                  ((Const)method).getCon().equals("ND") ||
                  ((Const)method).getCon().equals("CO") ||   
                  ((Const)method).getCon().equals("CR") ||
                  ((Const)method).getCon().equals("AI") ||
                  ((Const)method).getCon().equals("CA") ||
                  ((Const)method).getCon().equals("WI")
                 )
                ) 
        {
            return true;
        }
        else if ( method instanceof App && (m1 = ((App)method).p) instanceof Const &&
                 (
                  ((Const)m1).getCon().equals("ND") || 
                  ((Const)m1).getCon().equals("CO") || 
                  ((Const)m1).getCon().equals("CR") 
                 )
                ) 
        {
            return isWaitingMethod(((App)method).q);
        }
        else if ( method instanceof App && (m1 = ((App)method).p) instanceof Const &&
                 (
                  ((Const)m1).getCon().equals("AI") || 
                  ((Const)m1).getCon().equals("CA") 
                 )
                )
        {
            return true;
        }
        else if ( method instanceof App && (m1 = ((App)method).p) instanceof App &&
                  (m2 = ((App)m1).p) instanceof Const &&
                  (
                   ((Const)m2).getCon().equals("AI") || 
                   ((Const)m2).getCon().equals("CA") 
                  )
                )
        {
            return isWaitingMethod(((App)method).q);
        }
        else
            return true;
    }    
    
    /**
     * Return true if and only if method is a base method, i.e. a method 
     * that can't compose with another proof method. The base methods are 
     * Direct Method, Starting From One Side Method, Transitivity Method, 
     * Weakening Method, Strengthening Method
     *  
     * @param method: Term that represent the current state of the proof method
     * @return true if and only if method is a base method.
     */
    public static boolean isBaseMethod(Term method) {
        if (method instanceof App){
            return false;
        }
        else{
            return ((Const)method).getCon().equals("DM") || 
                    ((Const)method).getCon().equals("SS") ||
                    ((Const)method).getCon().equals("TR") ||
                    ((Const)method).getCon().equals("WE") ||
                    ((Const)method).getCon().equals("ST");
        }
    }
    
    /**
     * True if and only if exists a sub proof that is already started. This information 
     * can be inferred from the method term.
     *  
     * @param method: Term that represent the current state of the proof method. This
     *                term had the information about what is the current sub proof
     * @return True if and only if exists sub proof that is already started.
     */
    public static boolean isProofStarted(Term method) {
        Term aux = method;
        while (aux instanceof App) {
            if (((App)aux).p instanceof App)
                return true;
            else 
               aux = ((App)aux).q;
        }
        return aux instanceof Const && 
                       (((Const)aux).getCon().equals("DM") ||
                        ((Const)aux).getCon().equals("SS") ||   
                        ((Const)aux).getCon().equals("TR") ||
                        ((Const)aux).getCon().equals("WE") ||
                        ((Const)aux).getCon().equals("ST")
                       );
    }

    /**
     * True if and only if the proof only consists in one line
     *
     * @param proof Term that represents the proof
     * @return Boolean indicating if the proof onlu has one line or not
     */
    public static boolean isOneLineProof(Term proof){
        return (proof.type() == null);
    }
    
    /**
     * True if and only if method is an And Introduction proof and in the second sub proof 
     * exists sub proof (can be the same second sub proof) that is already started.
     * 
     * @param method: Term that represents the current state of the proof method. This
     *                term had the information about what is the current sub proof
     * @return True if and only if method is an And Introduction proof and in the second sub proof 
     * exists sub proof (can be the same second sub proof) that is already started.
     */
    public static boolean isAIProof2Started(Term method) {
        return method instanceof App && ((App)method).p instanceof App && 
               ((App)((App)method).p).p.toStringFinal().equals("AI") && 
               isProofStarted(((App)method).q);
    }
    
    /**
     * True if and only if the proof that represent typedTerm is an And Introduction 
     * proof with only one line in the second proof.
     *  
     * @param typedTerm: Term that represent the proof.
     * @return True if and only if the proof that represent typedTerm is an And Introduction 
     *         proof with only one line in the second proof.
     */
    public static boolean isAIOneLineProof(Term typedTerm) {
        return typedTerm instanceof App && ((App)typedTerm).p instanceof App &&
                                    ((App)((App)typedTerm).p).q instanceof App && 
                                   ((App)((App)((App)typedTerm).p).q).q instanceof App &&
                       ((App)((App)((App)((App)typedTerm).p).q).q).q instanceof App &&
                    ((App)((App)((App)((App)((App)typedTerm).p).q).q).q).p instanceof TypedL &&
    !(((Bracket)((TypedL)((App)((App)((App)((App)((App)typedTerm).p).q).q).q).p).type()).t.occur(new Var(122)));
    }

    /**
     * Checks if the two arguments are of the form p op q and q op^{-1} p
     * 
     * @param t1: Term that represent a formula
     * @param t2: Term that represent a formula
     * @return true if and only if t1 and t2 are of the form p op q and q op^{-1} p respectively
     */    
    public static boolean isInverseImpl(Term t1, Term t2) {
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
}