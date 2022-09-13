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
     * Indicates the header that a proof that starts with weakening method must have.
     *  
     * @param nTeo: Number of the theorem to be proved, expressed in a string
     * @return The header message to be added to the proof
     */
    @Override
    public String header(String nTeo){
        return "By weakening method<br>";
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
    @Override
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
                    nabla2 = wsl2(((App)root).q, ((App)((App)root).p).q, 
                                             (Const)((App)((App)root).p).p, ((App)((App)t).q).q);
                }
                else if ( (((Const)((App)((App)t).q).p).getId() != 1 ) ) {
                    Term root = nabla.type();
                    nabla2 = wsl1(((App)root).q, ((App)((App)root).p).q, 
                                             (Const)((App)((App)root).p).p, ((App)((App)t).q).q,
                                             (Const)((App)((App)t).q).p);
                }
                t = ((App)t).p;
            }
            else if (((App)t).q instanceof Const && ((App)t).p instanceof App) {
                if ( ((Const)((App)t).q).getId()==3 ) {
                    Term root = nabla.type();
                    nabla2 = wsr2(((App)root).q, ((App)((App)root).p).q, 
                                             (Const)((App)((App)root).p).p, ((App)((App)t).p).q);
                }
                else if (((Const)((App)t).q).getId() != 1) {
                    Term root = nabla.type();
                    nabla2 = wsr1(((App)root).q, ((App)((App)root).p).q, 
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
        String P = p.toString();
        String Q = q.toString();
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
    private Term wsl1(Term p, Term q, Const op, Term r, Const op1) {
        
        String P = p.toString();
        String Q = q.toString();
        String R = r.toString();
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
    private Term wsl2(Term p, Term q, Const op, Term r) {
        
        String op2 = (op.getId() == 2?"c_{3}":"c_{2}");
        String P = p.toString();
        String Q = q.toString();
        String R = r.toString();
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
    private Term wsr1(Term p, Term q, Const op, Term r, Const op1) {
        
        String P = p.toString();
        String Q = q.toString();
        String R = r.toString();
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
    private Term wsr2(Term p, Term q, Const op, Term r) {
        
        String op2 = (op.getId() == 2?"c_{3}":"c_{2}");
        String P = p.toString();
        String Q = q.toString();
        String R = r.toString();
        String wsr2 = "I^{[x_{112}, x_{113}, x_{114} := "+P+", "+Q+", "+R+"]}A^{c_{2} ("+op2+" (c_{3} x_{113} x_{114}) (c_{3} x_{112} x_{114})) ("+op+" x_{113} x_{112})}";
        
        return CombUtilities.getTerm(wsr2);
    }

    /**
     * Auxiliar method for "finishedBaseMethodProof" that implements the corresponding
     * logic according to the weakening or strengthening method.It assumes we have a proof that so far has proved A == ...== F
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
        String arrow = ((App)((App)formulaBeingProved).p).p.toString();
        Boolean rightArrow = arrow.equals("c_{2}"); // =>
        Boolean leftArrow = arrow.equals("c_{3}"); // <=

        // If we are weakening and the statement is A=>B or we are strengthening and the statement is A<=B
        if ((("WE".equals(this.methodStr)) && rightArrow) || (("ST".equals(this.methodStr)) && leftArrow)){
            // In this case we use the same finalization as in the transitivity method
            TransitivityMethod tr = new TransitivityMethod();
            return tr.auxFinBaseMethodProof(formulaBeingProved,proof,username,resuelveManager,simboloManager,expr,initialExpr,finalExpr);
        }
        /* If we are weakening and the statement is A<=B or we are strengthening and the statement is A=>B, 
           and at least one inference was made.
           >>>> NOTE: if the app forces to start from the left side, this case may be impossible (not sure)
        */
        if (((("WE".equals(this.methodStr)) && leftArrow) || (("ST".equals(this.methodStr)) && rightArrow)) && (transFirstOpInferIndex(proof,true)!=0)){
            // Axiom: (q => p) == (p <= q)
            TypedA axiom = new TypedA(CombUtilities.getTerm("c_{1} (c_{2} x_{112} x_{113}) (c_{3} x_{113} x_{112})") );
            TypedI instantiation;

            if (isInverseImpl(expr,formulaBeingProved)){
                if ("WE".equals(this.methodStr)){
                    instantiation = new TypedI((Sust)CombUtilities.getTerm("[x_{112}, x_{113} := "+((App)((App)expr).p).q+", "+((App)expr).q+"]"));
                }
                else {
                    instantiation = new TypedI((Sust)CombUtilities.getTerm("[x_{112}, x_{113} := "+((App)expr).q+", "+((App)((App)expr).p).q+"]"));
                }
                return new TypedApp(new TypedApp(instantiation,axiom),proof);
            }
            if (isInverseImpl(((App)((App)expr).p).q,formulaBeingProved)){
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