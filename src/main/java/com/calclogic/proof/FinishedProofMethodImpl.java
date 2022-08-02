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
import com.calclogic.lambdacalculo.TypedM;
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
@Service
public class FinishedProofMethodImpl implements FinishedProofMethod {
    @Autowired
    private SimboloManager simboloManager;
    @Autowired
    private ResuelveManager resuelveManager;

    /**
     * This function checks if a base demonstration has finished depending on the method used.
     * If it determines it has not finished, it returns the same proof tree given as argument.
     * 
     * @param theoremBeingProved: The theorem the user is trying to prove
     * @param proof: The proof tree so far
     * @param username: name of the user doing the proof
     * @param method: method used in the demonstration
     * @return new proof if finished, else return the same proof
     */
    @Override
    @Transactional
    public Term finishedBaseMethodProof(Term theoremBeingProved, Term proof, String username, String method) {
        Term expr = proof.type(); // The root of the proof tree, which is the last line
        Term initialExpr = ((App)expr).q.body(); // The expression (could be a theorem) from which the user started the demonstration
        Term finalExpr = ((App)((App)expr).p).q.body(); // The last line in the demonstration that the user has made

        try{
            switch (method){
                // Direct method --> assume we have a proof that so far has proved A == ... == F
                case "DM":
                    return finishedDirectMethodProof(theoremBeingProved, proof, username, initialExpr, finalExpr);

                // Starting from one side --> assume we have a proof that so far has proved A == ... == F
                case "SS":
                    // If the theorem the user is trying to prove is of the form H => A == B, then H /\ A ==  H /\ B must be given instead)
                    if(initialExpr.equals(((App)((App)theoremBeingProved).p).q) && finalExpr.equals(((App)theoremBeingProved).q)){
                        return new TypedApp(new TypedS(proof.type()), proof);
                    }
                    break;

                // Transitivity method --> assume we have a proof that so far has proved A == ... == F
                case "TR":
                    // if at least one opInference was made and reaches the goal
                    if(InferenceIndex.wsFirstOpInferIndex(proof)!=0 && ((App)((App)expr).p).q.equals(theoremBeingProved) ){ 
                        return new TypedApp(proof,new TypedA(new Const("c_{8}"))); // true
                    }
                    break;

                // Weakening or strengthening method ---> do the last equanimity and symmetry of => steps to finish
                case "WE":
                case "ST":
                    return finishedWeakeningStrengtheningMethodProof(theoremBeingProved, proof, username, method, expr);

                // Starting from one side method with natural deduction ---> assume we have a proof that so far has proved  H /\ Bi == ... == H /\ Bn
                case "Natural Deduction,one-sided":
                    initialExpr = ((App)((App)initialExpr).p).q;
                    finalExpr = ((App)((App)finalExpr).p).q;
                    
                    Term b1 = ((App)((App)((App)theoremBeingProved).p).q).q;
                    Term bf = ((App)((App)((App)((App)theoremBeingProved).p).q).p).q;

                    Boolean startedFromRight = initialExpr.equals(bf) && finalExpr.equals(b1);

                    // If here then finished
                    if( (initialExpr.equals(b1) && finalExpr.equals(bf)) || startedFromRight){
                        Term H = ((App)theoremBeingProved).q;
                        TypedApp newProof = (TypedApp)proof;
                        
                        if (startedFromRight) {
                            newProof = new TypedApp(new TypedS(proof.type()),proof);
                        }
                        
                        // (p => (q == r)) == p /\ q == p /\ r
                        TypedA A = new TypedA(new App(new App(new Const("c_{1}"), 
                                new App( new App(new Const("c_{1}"),new App(new App(new Const("c_{5}"),new Var('r')),new Var('p'))),new App(new App(new Const("c_{5}"),new Var('q')),new Var('p')))),
                                new App(new App(new Const("c_{2}"),new App(new App(new Const("c_{1}"),new Var('r')),new Var('q'))), new Var('p'))));
                        
                        // Parallel substitution [p, q, r := H, B1, Bn]
                        List<Var> vars = new ArrayList<>();
                        List<Term> terms = new ArrayList<>();

                        Collections.addAll(vars, new Var('p'), new Var('q'), new Var('r'));
                        Collections.addAll(terms, H, b1, bf);           
                        Sust instantiation = new Sust(vars, terms);
                        TypedI I = new TypedI(instantiation);
                        
                        TypedApp left = new TypedApp(I, A);
                        left = new TypedApp(new TypedS(left.type()),left);
                        
                        return new TypedApp(left, newProof);
                    }
                    break;

                // Direct method with natural deduction ---> assume we have a proof that so far has proved (H == H /\ B1) == ... == (H == H /\ Bn)
                case "Natural Deduction,direct":
                    // Take away H == H /\
                    finalExpr = ((App)((App)((App)((App)finalExpr).p).q).p).q;
                    Term H = ((App)theoremBeingProved).q; 

                    // Take away H from H => B
                    theoremBeingProved = ((App)((App)theoremBeingProved).p).q;
                    
                    // Case when we started from another theorem (c_{8} is "true") and the proof has finished
                    if (initialExpr.equals(new Const("c_{8}")) && finalExpr.equals(theoremBeingProved)) {           
                        
                        // Parallel substitution [p, q := H, B] 
                        List<Var> vars = new ArrayList<>();
                        List<Term> terms = new ArrayList<>();

                        Collections.addAll(vars, new Var('p'), new Var('q'));
                        Collections.addAll(terms, H, finalExpr);  
                        Sust instantiation = new Sust(vars, terms);
                        TypedI I = new TypedI(instantiation);
                        
                        // p => q == (p == p /\ q)                
                        TypedA A = new TypedA(new App(new App(new Const("c_{1}"), new App(new App(new Const("c_{1}"), new App(new App(new Const("c_{5}"),new Var('q')),new Var('p'))), new Var('p'))),
                                new App(new App(new Const("c_{2}"), new Var('q')), new Var('p'))));
                        
                        // HINT (H => B) == (H == H /\ B) 
                        TypedApp hint = new TypedApp(I, A);
                        hint = new TypedApp(new TypedS(hint.type()), hint);
                        
                        TypedApp newProof = new TypedApp(proof, hint);
                        
                        // Need to add equanimity since proved true == H => B
                        return new TypedApp(newProof, new TypedA(new Const("c_{8}")));                             
                        
                    }
                    // Case when we started from the theorem being proved
                    else { 
                        
                        // List of theorems solved by the user. We examine them to check if the current proof already reached one 
                        List<Resuelve> resuelves = resuelveManager.getAllResuelveByUserOrAdminResuelto(username);
                        Term theorem, mt;
                        
                        for(Resuelve resu: resuelves){
                            theorem = resu.getTeorema().getTeoTerm(); // This is the theorem that is in the database
                            mt = new App(new App(new Const("c_{1}"),new Const("true")),theorem); // theorem == true
                            
                            // If the current theorem or theorem==true matches the final expression (and this theorem is not the one being proved) 
                            if(!theorem.equals(theoremBeingProved) && (theorem.equals(finalExpr) || mt.equals(finalExpr))) {
                                // ----- HINT 1 -----
                                
                                // H = H ^ z
                                Bracket leib = new Bracket(new Var('z'), new App( new App(new Const("c_{1}"), new App(new App(new Const("c_{5}"), new Var('z')), H)), H));
                                TypedL L = new TypedL(leib);
                                TypedApp metaTheorem = MetaTheorem.metaTheorem(theorem); // Create theorem == true
                                TypedApp hint1 = new TypedApp(L, metaTheorem);
                                
                                // ----- HINT 2 -----
                                
                                // H == z
                                leib = new Bracket(new Var('z'), new App(new App(new Const("c_{1}"), new Var('z')), H));
                                L = new TypedL(leib);
                                
                                // Parallel substitution [p := H] 
                                ArrayList<Var> vars = new ArrayList<>();
                                ArrayList<Term> terms = new ArrayList<>();
                                vars.add(new Var('p'));   
                                terms.add(H);
                                Sust instantiation = new Sust(vars, terms);
                                TypedI I = new TypedI(instantiation);
                                
                                // p /\ true == p
                                TypedA A = new TypedA(new App( new App( new Const("c_{1}") ,new Var('p')), new App(new App(new Const("c_{5}"), new Const("c_{8}")), new Var('p'))));
                                
                                TypedApp hint2 = new TypedApp(I, A);
                                hint2 = new TypedApp(L, hint2);
                                
                                // ----- HINT 3 -----
                                
                                // needs  true == (q == q) gotta prove it with associativity and true == q == q
                                
                                // true == (q == q)
                                A = new TypedA(new App(new App(new Const("c_{1}"), new App(new App(new Const("c_{1}"), new Var('q')),new Var('q'))),new Const("c_{8}")));
                                
                                // Parallel substitution [q := H] 
                                vars = new ArrayList<>();
                                vars.add(new Var('q'));   
                                instantiation = new Sust(vars, terms);
                                I = new TypedI(instantiation);
                                
                                TypedApp hint3 = new TypedApp(I,A);
                                TypedS S = new TypedS(hint3.type());
                                hint3 = new TypedApp(S, hint3);
                                
                                // ----- BUILD THE NEW PROOF -----
                                TypedApp newProof = new TypedApp(proof, hint1);
                                newProof = new TypedApp(newProof, hint2);
                                newProof = new TypedApp(newProof, hint3);          
                                
                                // Needs to add equanimity since proved H => B == true
                                return new TypedApp(new TypedApp(new TypedS(newProof.type()), newProof),new TypedA(new Const("c_{8}")));
                            }   
                        }
                    
                    }
                    break;
                default:
                    break;
            }
        }
        catch (TypeVerificationException e)  {
            Logger.getLogger(InferController.class.getName()).log(Level.SEVERE, null, e); 
        } 
        // If the proof hasn't finished
        return proof;
    } 

    /**
     * This function checks if a demonstration that uses direct method has finished.
     * 
     * @param theoremBeingProved: The theorem the user is trying to prove
     * @param proof: The proof tree so far
     * @param username: name of the user doing the proof
     * @param initialExpr: The expression (could be a theorem) from which the user started the demonstration
     * @param finalExpr: The last line in the demonstration that the user has made
     * @return new proof if finished, else return the same proof
     */
    @Override
    @Transactional
    public Term finishedDirectMethodProof(Term theoremBeingProved, Term proof, String username, 
                Term initialExpr, Term finalExpr) throws TypeVerificationException{
        // Case when we started from the theorem being proved
        if(theoremBeingProved.equals(initialExpr)) {
            // List of theorems solved by the user. We examine them to check if the current proof already reached one 
            List<Resuelve> resuelves = resuelveManager.getAllResuelveByUserOrAdminResuelto(username);
            Term theorem, mt;
            Term equanimityExpr = null; // Expression with which equanimity will be applied

            for(Resuelve resu: resuelves){ 
                theorem = resu.getTeorema().getTeoTerm(); // This is the theorem that is in the database
                Term noEqTheo = ((Term)theorem.clone2()).setToPrinting(resu.getVariables());
                mt = new App(new App(new Const("c_{1}"),new Const("true")),theorem); // theorem == true

                // We don't want to unify with the theoremBeingProved itself if it was already demonstrated
                if (noEqTheo.equals(theoremBeingProved)){
                    ;
                }
                // If the current theorem or theorem==true matches the final expression
                else if(noEqTheo.equals(finalExpr) || mt.equals(finalExpr)){
                    if (((App)((App)theorem).p).q.containT() )
                      equanimityExpr = new TypedA(theorem);
                    else
                      equanimityExpr = new TypedM(theorem,username);
                } 
                else {
                    // Check if the last line of the proof (finalExpr) is an instance of an already demonstrated theorem
                    // >>> It would not work if we did it backwards: (finalExpr, theorem)
                    Equation eq = new Equation(noEqTheo, finalExpr);
                    Sust sust = eq.mgu(simboloManager);

                    // Case whe lanst line is an instantiation of the compared theorem
                    if (sust != null){
                        //System.out.println("Por el sust != null");
                        // The equanimity is applied with the instantiated theorem, not with the last line instantiated
                        if (((App)((App)theorem).p).q.containT() )
                          equanimityExpr = new TypedApp(new TypedI(sust), new TypedA(theorem)); 
                        else 
                          equanimityExpr = new TypedM(theorem,username); 
                    }   
                }
                if (equanimityExpr != null){
                    return new TypedApp(new TypedApp(new TypedS(proof.type()), proof), equanimityExpr);
                }
            }
        }
        // Case when we started from another theorem
        else if(finalExpr.equals(theoremBeingProved)) {
            Term aux = new App(new App(new Const(0,"="),new Const(-1,"T")),initialExpr).abstractEq();
            TypedA A = new TypedA(aux.traducBD(),username);
            if (A.getNSt().equals("")) {
              initialExpr= new App(new App(new Const(0,"="),((App)((App)initialExpr).p).q),((App)initialExpr).q);
              initialExpr = initialExpr.abstractEq().traducBD();
              Term M = new TypedM(initialExpr,username);
              return new TypedApp(proof, M);
            }else
               return new TypedApp(proof, A);
        }
        return proof;
    }

    /**
     * This function checks if a demonstration that uses weakening or strengthening method has finished.
     * 
     * @param theoremBeingProved: The theorem the user is trying to prove
     * @param proof: The proof tree so far
     * @param username: name of the user doing the proof
     * @param method: method used in the demonstration
     * @param expr: The root of the proof tree, which is the last line
     * @return new proof if finished, else return the same proof
     */
    @Override
    @Transactional
    public Term finishedWeakeningStrengtheningMethodProof(Term theoremBeingProved, Term proof,
                String username, String method, Term expr) throws TypeVerificationException{
        
        String arrow = ((App)((App)theoremBeingProved).p).p.toStringFinal();
        Boolean rightArrow = arrow.equals("c_{2}"); // =>
        Boolean leftArrow = arrow.equals("c_{3}"); // <=

        // If we are weakening and the statement is A=>B or we are strengthening and the statement is A<=B
        if ((("WE".equals(method)) && rightArrow) || (("ST".equals(method)) && leftArrow)){
            return finishedBaseMethodProof(theoremBeingProved, proof, username, "TR");
        }
        /* If we are weakening and the statement is A<=B or we are strengthening and the statement is A=>B,
           and at least one inference was made.
           >>>> NOTE: if the app forces to start from the left side, this case may be impossible (not sure) */
        if (((("WE".equals(method)) && leftArrow) || (("ST".equals(method)) && rightArrow)) && (InferenceIndex.wsFirstOpInferIndex(proof)!=0)){
            // Axiom: (q => p) == (p <= q)
            TypedA axiom = new TypedA(CombUtilities.getTerm("c_{1} (c_{2} x_{112} x_{113}) (c_{3} x_{113} x_{112})",null) );
            TypedI instantiation;

            if (ProofBoolean.isInverseImpl(expr,theoremBeingProved)){
                if ("WE".equals(method)){
                    instantiation = new TypedI((Sust)CombUtilities.getTerm("[x_{112}, x_{113} := "+((App)((App)expr).p).q+", "+((App)expr).q+"]",null));
                }
                else {
                    instantiation = new TypedI((Sust)CombUtilities.getTerm("[x_{112}, x_{113} := "+((App)expr).q+", "+((App)((App)expr).p).q+"]",null));
                }
                return new TypedApp(new TypedApp(instantiation,axiom),proof);
            }
            if (ProofBoolean.isInverseImpl(((App)((App)expr).p).q,theoremBeingProved)){
                Term aux;
                if ("WE".equals(method)){
                    instantiation = new TypedI((Sust)CombUtilities.getTerm("[x_{112}, x_{113} := "+((App)((App)((App)((App)expr).p).q).p).q+", "+((App)((App)((App)expr).p).q).q+"]",null));
                    aux = new TypedApp(instantiation,axiom);

                    return new TypedApp(new TypedApp(new TypedS(aux.type()),aux),new TypedApp(proof,new TypedA(new Const("c_{8}"))));
                }
                else {
                    instantiation = new TypedI((Sust)CombUtilities.getTerm("[x_{112}, x_{113} := "+((App)((App)((App)expr).p).q).q+", "+((App)((App)((App)((App)expr).p).q).p).q+"]",null));
                    aux = new TypedApp(instantiation,axiom);

                    return new TypedApp(aux,new TypedApp(proof,new TypedA(new Const("c_{8}"))));
                }
            }
        }
        return proof;
    }

    /**
     * This function will only be correct if called when using a waiting method
     * It will return a new proof tree in case it finds out that the last inference
     * caused the whole proof to be correct under the sub-proof method. In other case it will return 
     * the proof given as argument.
     * 
     * @param theoremBeingProved: The theorem that user is trying to prove 
     * @param proof: The proof tree so far
     * @param method: method used in the demonstration
     * @return proof of theoremBeingProved if finished, else return the same proof
     */
    @Override
    @Transactional
    public Term finishedWaitingMethodProof(Term theoremBeingProved, Term proof, String method) {
        try {
            // The next two lists are for doing a parallel substitution [x1, x2,... := t1, t2, ...]
            List<Var> vars = new ArrayList<>();
            List<Term> terms = new ArrayList<>();

            Term axiomTree = null;
            Sust sus = null;
            TypedI I = null;
            TypedA A = null;
            TypedA A2 = null;
            String str = null;
            String str2 = null;
            Term st = null;
            Term st2 = null;

            switch (method){
                // Counter-reciprocal
                case "CR": 
                    // This string says: p => q == ¬q => ¬p
                    str = "c_{1} (c_{2} (c_{7} x_{112}) (c_{7} x_{113})) (c_{2} x_{113} x_{112})";
                    st = CombUtilities.getTerm(str,null);

                    // We make that formula to be treated as an axiom
                    A = new TypedA(st); 
            
                    // Substitution [p,q := ...]
                    vars.add(0, new Var(112)); // Letter 'p'
                    vars.add(0, new Var(113)); // Letter 'q'
                    terms.add(0, ((App)theoremBeingProved).q);
                    terms.add(0, ((App)((App)theoremBeingProved).p).q);
                    sus = new Sust(vars, terms);
                    
                    // We give the instantiation format to the substitution above
                    I = new TypedI(sus);

                    axiomTree = new TypedApp(new TypedS(),new TypedApp(I,A));
                    break;

                // Contradiction
                case "CO":
                    // This string says: ¬p => false == ¬(¬p)
                    str = "c_{1} (c_{7} (c_{7} x_{112})) (c_{2} c_{9} (c_{7} x_{112}))";
                    st = CombUtilities.getTerm(str,null);

                    // This string says: ¬(¬p) == p
                    str2 = "c_{1} x_{112} (c_{7} (c_{7} x_{112}))";
                    st2 = CombUtilities.getTerm(str2,null);

                    // We make the two formulas above to be treated as axioms
                    A = new TypedA(st);
                    A2 = new TypedA(st2);

                    // Substitution [p := teoremProved]
                    vars.add(0, new Var(112)); // Letter'p'
                    terms.add(0, theoremBeingProved);
                    sus = new Sust(vars, terms);

                    // We give the instantiation format to the substitution above
                    I = new TypedI(sus);

                    axiomTree = new TypedApp(new TypedApp(I,A),new TypedApp(I,A2));
                    break;

                default:
                    break;
            }
            return new TypedApp(axiomTree, proof);
             
        }catch (TypeVerificationException e)  {
            Logger.getLogger(InferController.class.getName()).log(Level.SEVERE, null, e); 
        }
        return proof;
    }
    
    /**
     * This function will only be correct if called when using And Introduction method
     * This function will return a new proof tree that connects in one proof of P/\Q, 
     * two independent sub proofs of P and Q.
     * 
     * @param originalTerm: The current proof  
     * @param finalProof: The proof of second sub proof
     * @return proof of conjunction of two sub proofs
     */
    @Override
    @Transactional
    public Term finishedAI2Proof(Term originalTerm, Term finalProof) {
        Map<String,String> values = new HashMap<>();
        values.put("T1",finalProof.toStringFinal());
        values.put("T1Type", finalProof.type().toStringFinal());
        StrSubstitutor sub = new StrSubstitutor(values, "%(",")");
        String metaTheo = "S (I^{[x_{113} := %(T1Type)]} A^{c_{1} x_{113} (c_{1} x_{113} c_{8})}) (%(T1))";
        String theo = sub.replace(metaTheo);
        Term theoTerm = CombUtilities.getTerm(theo,null);
        Term firstProof = ((App)originalTerm).q;
        Term firstStAndTrue = ((App)((App)originalTerm).p).p;
        Term leibniz = ((App)((App)((App)originalTerm).p).q).p;
        try {
            Term newProof = new TypedApp(new TypedApp(firstStAndTrue,new TypedApp(leibniz,theoTerm)),firstProof);
            return newProof;
        }
        catch (TypeVerificationException e) {
            Logger.getLogger(InferController.class.getName()).log(Level.SEVERE, null, e);
            return originalTerm;
        }
    }
}