package com.calclogic.proof;

import com.calclogic.lambdacalculo.Const;
import com.calclogic.lambdacalculo.Term;
import com.calclogic.parse.CombUtilities;

/**
 *
 * @author ronald
 */
public class DerivationTree {
    
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
    public static Term neg(Term p, Term q, Const op) {
        
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
    public static Term wsl1(Term p, Term q, Const op, Term r, Const op1) {
        
        String P = p.toStringFinal();
        String Q = q.toStringFinal();
        String R = r.toStringFinal();
        String wsl1 = "I^{[x_{112}, x_{113}, x_{114} := "+P+", "+Q+", "+R+"]}A^{c_{2} ("+op+" ("+op1+" x_{114} x_{113}) ("+op1+" x_{114} x_{112})) ("+op+" x_{113} x_{112})}";
        
        return CombUtilities.getTerm(wsl1);
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
    public static Term wsl2(Term p, Term q, Const op, Term r) {
        
        String op2 = (op.getId() == 2?"c_{3}":"c_{2}");
        String P = p.toStringFinal();
        String Q = q.toStringFinal();
        String R = r.toStringFinal();
        String wsl2 = "I^{[x_{112}, x_{113}, x_{114} := "+P+", "+Q+", "+R+"]}A^{c_{2} ("+op2+" (c_{2} x_{114} x_{113}) (c_{2} x_{114} x_{112})) ("+op+" x_{113} x_{112})}";
        
        return CombUtilities.getTerm(wsl2);
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
    public static Term wsr1(Term p, Term q, Const op, Term r, Const op1) {
        
        String P = p.toStringFinal();
        String Q = q.toStringFinal();
        String R = r.toStringFinal();
        String wsr1 = "I^{[x_{112}, x_{113}, x_{114} := "+P+", "+Q+", "+R+"]}A^{c_{2} ("+op+" ("+op1+" x_{113} x_{114}) ("+op1+" x_{112} x_{114})) ("+op+" x_{113} x_{112})}";
        
        return CombUtilities.getTerm(wsr1);
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
    public static Term wsr2(Term p, Term q, Const op, Term r) {
        
        String op2 = (op.getId() == 2?"c_{3}":"c_{2}");
        String P = p.toStringFinal();
        String Q = q.toStringFinal();
        String R = r.toStringFinal();
        String wsr2 = "I^{[x_{112}, x_{113}, x_{114} := "+P+", "+Q+", "+R+"]}A^{c_{2} ("+op2+" (c_{3} x_{113} x_{114}) (c_{3} x_{112} x_{114})) ("+op+" x_{113} x_{112})}";
        
        return CombUtilities.getTerm(wsr2);
    }
}