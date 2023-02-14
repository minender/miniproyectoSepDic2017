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
                        methodStr.equals("EO") || 
                        methodStr.equals("OE") ||
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
        else if ( method instanceof App && (m1 = method.dsc("1")) instanceof Const &&
                    (
                        (methodStr=((Const)m1).getCon()).equals("ND") || 
                        methodStr.equals("EO") || 
                        methodStr.equals("OE") ||
                        methodStr.equals("CO") || 
                        methodStr.equals("CR") ||
                        methodStr.equals("MI")
                    )
                ) 
        {
            return isWaitingMethod(method.dsc("2"));
        }
        else if ( method instanceof App && (m1 = method.dsc("1")) instanceof Const &&
                    (
                        (methodStr=((Const)m1).getCon()).equals("AI") || 
                        methodStr.equals("CA")
                    )
                )
        {
            return true;
        }
        else if ( method instanceof App && (m1 = method.dsc("1")) instanceof App &&
                    (m2 = m1.dsc("1")) instanceof Const &&
                    (
                        (methodStr=((Const)m2).getCon()).equals("AI") || 
                        methodStr.equals("CA")
                    )
                )
        {
            return isWaitingMethod(method.dsc("2"));
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
     * Returns true if and only if method is a linear recursive method, i.e. a method 
     * that can't compose with another proof method. The base methods are 
     * Direct Method, Starting From One Side Method, Transitivity Method, 
     * Weakening Method, Strengthening Method
     *  
     * @param method: Term that represents the current state of the proof method
     * @return true if and only if method is a linear recursive method.
     */
    public static boolean isLinearRecursiveMethod(Term method) {
        if (method instanceof App){
            return false;
        }
        else{
            String methodStr;
            return (methodStr=((Const)method).getCon()).equals("CO") || 
                    methodStr.equals("CR") ||
                    methodStr.equals("MI") ||
                    methodStr.equals("EO") || 
                    methodStr.equals("OE") ||
             //       methodStr.equals("CA") ||
                    methodStr.equals("WI");
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
        Term aux = method; //muy complicado. Es mas facil si solo se ve si ocurren en
        while (aux instanceof App) {//method las constantes DM, SS, TR, WE o ST
            if (aux.dsc("1") instanceof App)
                return true;
            else 
                aux = aux.dsc("2");
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
        return method instanceof App && method.dsc("1") instanceof App && 
                (
                    (methodStr=method.dsc("11").toString()).equals("AI") ||
                    methodStr.equals("CA")
                )
                && isProofStarted(method.dsc("2"));
    }
    
    /**
     * True if and only if the method contains a branched recursive one 
     * and its second sub proof is already started.
     *
     * @param method: Term that represents the current state of the proof method. This
     *                term had the information about what is the current sub proof
     * @return True if and only if method contains a branched proof and in the second sub proof 
     * exists sub proof (can be the same second sub proof) that is already started.
     */
    public static boolean containsBranchedProof2Started(Term method) {
        String methodStr;
        Term aux = method;   
        while (aux instanceof App && aux.dsc("1") instanceof Const ) {
            aux = aux.dsc("2");
        }
        if (aux instanceof App)
           return aux.dsc("1") instanceof App && 
                   (
                    (methodStr=aux.dsc("11").toString()).equals("AI") ||
                     methodStr.equals("CA")
                   ) && isProofStarted(aux.dsc("2"));
        else
            return false;
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
        return typedTerm instanceof App && 
                            typedTerm.dsc("1") instanceof App &&
                            typedTerm.dsc("12") instanceof App && 
                            typedTerm.dsc("122") instanceof App &&
                            typedTerm.dsc("1222") instanceof App &&
                            typedTerm.dsc("12222") instanceof App &&
                            typedTerm.dsc("122221") instanceof TypedL &&
        !(((Bracket)((TypedL)typedTerm.dsc("122221")).type()).t.occur(new Var(122)));
    }

    public static boolean isIAA(Term root, SimboloManager s) {
        
        if(!(root instanceof App)) return false;
        
        Term leftSide = root.dsc("1").type();
        
        return root.dsc("2") instanceof TypedA &&
                root.dsc("1") instanceof App &&
                root.dsc("11") instanceof TypedI &&
                root.dsc("12") instanceof TypedA &&   
                
                leftSide instanceof App && leftSide.dsc("1") instanceof App &&
                leftSide.dsc("11").toStringLaTeX(s, "").equals("\\Rightarrow") &&
                leftSide.dsc("2").equals(root.dsc("2").type());    
    }
    
    public static boolean isIAIA(Term root, SimboloManager s) {
        if(!(root instanceof App)) return false;
        
        Term leftSide = root.dsc("1").type();
        
        return root.dsc("2") instanceof App &&
                root.dsc("21") instanceof TypedI &&
                root.dsc("22") instanceof TypedA &&
                root.dsc("1") instanceof App &&
                root.dsc("11") instanceof TypedI &&
                root.dsc("12") instanceof TypedA && 
                
                leftSide instanceof App && leftSide.dsc("1") instanceof App &&
                leftSide.dsc("11").toStringLaTeX(s, "").equals("\\Rightarrow") &&
                leftSide.dsc("2").equals(root.dsc("2").type());         
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
        if( root.dsc("1") instanceof TypedS && isIAIA(root.dsc("2"), s)) return "S(IAIA)";
        
        // Case 4: S(IAA)
        if( root.dsc("1") instanceof TypedS && isIAA(root.dsc("2"), s)) return "S(IAA)";
        
        return "NoModus";
    }
    
     /**
     * Checks if the two arguments are of the form p op q and q op^{-1} p
     * 
     * @param t1: Term that represent a formula
     * @param t2: Term that represent a formula
     * @return true if and only if t1 and t2 are of the form p op q and q op^{-1} p respectively
     */    
    public static boolean isInverseImpl(Term t1, Term t2) {   
        if ( !(t1 instanceof App) || !(t1.dsc("1") instanceof App)) {
            return false;
        }
        String op1 = t1.dsc("11").toString();
        return (op1.equals("c_{2}") || op1.equals("c_{3}")) && 
                t2 instanceof App && t2.dsc("1") instanceof App &&
                t1.dsc("2").equals(t2.dsc("12")) && 
                t1.dsc("12").equals(t2.dsc("2")) && 
                t2.dsc("11").toString().equals((op1.equals("c_{2}")?"c_{3}":"c_{2}"));
    } 
}