package com.calclogic.proof;

import com.calclogic.lambdacalculo.App;
import com.calclogic.lambdacalculo.Bracket;
import com.calclogic.lambdacalculo.Const;
import com.calclogic.lambdacalculo.Var;
import com.calclogic.lambdacalculo.Term;
import com.calclogic.lambdacalculo.TypedA;
import com.calclogic.lambdacalculo.TypedI;
import com.calclogic.lambdacalculo.TypedL;
import com.calclogic.lambdacalculo.TypedS;
import com.calclogic.service.SimboloManager;

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
        String methodStr;
        if (method instanceof Const && 
                (
                    (methodStr=((Const)method).getCon()).equals("DM") || 
                    methodStr.equals("SS") || 
                    methodStr.equals("TR") || 
                    methodStr.equals("WE") || 
                    methodStr.equals("ST")    
                )
           ) 
        {
           return false;    
        }
        else if (method instanceof Const && 
                    (
                        (methodStr=((Const)method).getCon()).equals("ND") || 
                        methodStr.equals("CO") || 
                        methodStr.equals("CR") || 
                        methodStr.equals("AI") || 
                        methodStr.equals("MI") || 
                        methodStr.equals("CA") || 
                        methodStr.equals("WI")
                    )
                ) 
        {
            return true;
        }
        else if ( method instanceof App && (m1 = ((App)method).p) instanceof Const &&
                    (
                        (methodStr=((Const)m1).getCon()).equals("ND") || 
                        methodStr.equals("CO") || 
                        methodStr.equals("CR")
                    )
                ) 
        {
            return isWaitingMethod(((App)method).q);
        }
        else if ( method instanceof App && (m1 = ((App)method).p) instanceof Const &&
                    (
                        (methodStr=((Const)m1).getCon()).equals("AI") || 
                        methodStr.equals("MI") || 
                        methodStr.equals("CA")
                    )
                )
        {
            return true;
        }
        else if ( method instanceof App && (m1 = ((App)method).p) instanceof App &&
                    (m2 = ((App)m1).p) instanceof Const &&
                    (
                        (methodStr=((Const)m2).getCon()).equals("AI") || 
                        methodStr.equals("MI") || 
                        methodStr.equals("CA")
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
            String methodStr;
            return (methodStr=((Const)method).getCon()).equals("DM") || 
                    methodStr.equals("SS") ||
                    methodStr.equals("TR") ||
                    methodStr.equals("WE") ||
                    methodStr.equals("ST");
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
        String methodStr;
        return aux instanceof Const && 
                (
                    (methodStr=((Const)aux).getCon()).equals("DM") || 
                    methodStr.equals("SS") ||   
                    methodStr.equals("TR") ||
                    methodStr.equals("WE") ||
                    methodStr.equals("ST")
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
     * True if and only if the method is a branched recursive one 
     * and its second sub proof is already started.
     *
     * @param method: Term that represents the current state of the proof method. This
     *                term had the information about what is the current sub proof
     * @return True if and only if method is an And Introduction proof and in the second sub proof 
     * exists sub proof (can be the same second sub proof) that is already started.
     */
    public static boolean isBranchedProof2Started(Term method) {
        String methodStr;
        return method instanceof App && ((App)method).p instanceof App && 
                (
                    "AI".equals(((App)((App)method).p).p.toStringFinal())
                    // (methodStr=((App)((App)method).p).p.toStringFinal()).equals("AI") ||
                    // methodStr.equals("MI") ||
                    // methodStr.equals("CA")
                )
                && isProofStarted(((App)method).q);
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

    public static boolean isIAA(Term root, SimboloManager s) {
        
        if(!(root instanceof App)) return false;
        
        Term leftSide = ((App)root).p.type();
        
        return ((App)root).q instanceof TypedA &&
                ((App)root).p instanceof App &&
                ((App)((App)root).p).p instanceof TypedI &&
                ((App)((App)root).p).q instanceof TypedA &&
                
                leftSide instanceof App && ((App)leftSide).p instanceof App &&
                (((App)((App)leftSide).p).p).toStringInf(s, "").equals("\\Rightarrow") &&
                ((App)leftSide).q.equals(((App)root).q.type());    
    }
    
    public static boolean isIAIA(Term root, SimboloManager s) {
        if(!(root instanceof App)) return false;
        
        Term leftSide = ((App)root).p.type();
        
        return ((App)root).q instanceof App &&
                ((App)((App)root).q).p instanceof TypedI &&
                ((App)((App)root).q).q instanceof TypedA &&
                ((App)root).p instanceof App &&
                ((App)((App)root).p).p instanceof TypedI &&
                ((App)((App)root).p).q instanceof TypedA &&
                
                leftSide instanceof App && ((App)leftSide).p instanceof App &&
                (((App)((App)leftSide).p).p).toStringInf(s, "").equals("\\Rightarrow") &&
                ((App)leftSide).q.equals(((App)root).q.type());         
    }
    
    /**
     * This function checks if the given Term represents a modus ponens hint
     * @param root root node of the hint 
     * @param s
     * @return "Nomodus" if is not modus ponens, another string depending on the case
     */
    public static String isModusPonens(Term root, SimboloManager s) {
        
        if(!(root instanceof App)) return "NoModus";
        
        // Case 1: IAA
        if(isIAA(root, s)) return "IAA";
        
        // Case 2: IAIA
        if(isIAIA(root, s)) return "IAIA";
        
        // Case 3: S(IAIA)
        if( ((App)root).p instanceof TypedS && isIAIA(((App)root).q, s)) return "S(IAIA)";
        
        // Case 4: S(IAA)
        if( ((App)root).p instanceof TypedS && isIAA(((App)root).q, s)) return "S(IAA)";
        
        return "NoModus";
    }
}