package com.calclogic.proof;

import com.calclogic.lambdacalculo.App;
import com.calclogic.lambdacalculo.Const;
import com.calclogic.lambdacalculo.Term;
import com.calclogic.lambdacalculo.TypeVerificationException;
import com.calclogic.lambdacalculo.TypedApp;

/**
 *
 * @author ronald
 */
public class Parity {    
    
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
    public static Term parityLeibniz(Term leibniz, Term nabla) throws TypeVerificationException {
        
        Term t = leibniz.traducBD();
        
        while (t instanceof App) {
            Term nabla2 = nabla; // si no entra en ninguna guardia aborta el TApp(nabla,nabla)
            if (((App)t).q instanceof Const && ((Const)((App)t).q).getId() == 7 ) {
                Term root = nabla.type();
                nabla2 = DerivationTree.neg(((App)root).q, ((App)((App)root).p).q, 
                                             (Const)((App)((App)root).p).p);
                t = ((App)t).p;
            }
            else if (((App)t).q instanceof App && ((App)((App)t).q).p instanceof Const) {
                if (((Const)((App)((App)t).q).p).getId() == 2 ) {
                    Term root = nabla.type();
                    nabla2 = DerivationTree.wsl2(((App)root).q, ((App)((App)root).p).q, 
                                             (Const)((App)((App)root).p).p, ((App)((App)t).q).q);
                }
                else if ( (((Const)((App)((App)t).q).p).getId() != 1 ) ) {
                    Term root = nabla.type();
                    nabla2 = DerivationTree.wsl1(((App)root).q, ((App)((App)root).p).q, 
                                             (Const)((App)((App)root).p).p, ((App)((App)t).q).q,
                                             (Const)((App)((App)t).q).p);
                }
                t = ((App)t).p;
            }
            else if (((App)t).q instanceof Const && ((App)t).p instanceof App) {
                if ( ((Const)((App)t).q).getId()==3 ) {
                    Term root = nabla.type();
                    nabla2 = DerivationTree.wsr2(((App)root).q, ((App)((App)root).p).q, 
                                             (Const)((App)((App)root).p).p, ((App)((App)t).p).q);
                }
                else if (((Const)((App)t).q).getId() != 1) {
                    Term root = nabla.type();
                    nabla2 = DerivationTree.wsr1(((App)root).q, ((App)((App)root).p).q, 
                                             (Const)((App)((App)root).p).p, ((App)((App)t).p).q,
                                             (Const)((App)t).q);
                }
                t = ((App)((App)t).p).p;
            }
            nabla = new TypedApp(nabla2,nabla);
        }
        
        return nabla;
    }
}