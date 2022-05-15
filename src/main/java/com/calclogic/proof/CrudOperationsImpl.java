package com.calclogic.proof;

import com.calclogic.controller.InferController;
import com.calclogic.lambdacalculo.App;
import com.calclogic.lambdacalculo.Bracket;
import com.calclogic.lambdacalculo.Const;
import com.calclogic.lambdacalculo.Sust;
import com.calclogic.lambdacalculo.Var;
import com.calclogic.lambdacalculo.Term;
import com.calclogic.lambdacalculo.TypeVerificationException;
import com.calclogic.lambdacalculo.TypedA;
import com.calclogic.lambdacalculo.TypedApp;
import com.calclogic.lambdacalculo.TypedI;
import com.calclogic.lambdacalculo.TypedL;
import com.calclogic.parse.CombUtilities;
import com.calclogic.parse.ProofMethodUtilities;
import com.calclogic.service.SimboloManager;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
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
public class CrudOperationsImpl implements CrudOperations {

    @Autowired
    private SimboloManager simboloManager;
    @Autowired
    private FinishedProofMethod finiPMeth;
    
    /**
     * This function will create a hint for the current base method given the hint's elements.In case the elements don't make sense it will return null.
     * @param theoremHint: theorem used on the hint
     * @param instantiation: instantiation used on the hint in the form of arrays of variables and terms
     * @param instantiationString: string that was used to parse instantiation
     * @param leibniz: bracket that represents Leibniz on the hint
     * @param leibnizString: string that was used to parse Leibniz
     * @param theoremBeingProved: theorem that we are proving using this hint
     * @param method: method used in the demonstration
     * @return a hint for the direct method
     * @throws com.calclogic.lambdacalculo.TypeVerificationException
     */
    @Override
    @Transactional
    public Term createBaseMethodInfer(Term theoremHint, ArrayList<Object> instantiation, String instantiationString, 
            Bracket leibniz, String leibnizString, Term theoremBeingProved, String method) 
            throws TypeVerificationException{

        Term infer = null;
        TypedI I = null;
        TypedA A = new TypedA(theoremHint);
        TypedL L = new TypedL(leibniz);
        Boolean noInstantiation = instantiationString.equals("");
        Boolean noLeibniz = leibnizString.equals("");
        String groupMethod = ("DM".equals(method) || "SS".equals(method)) ? "D" : (("TR".equals(method) || "WE".equals(method) || "ST".equals(method)) ? "T" : "N");

        switch(groupMethod){

            // Direct, starting from one side, transitivity, weakening or strengthening method
            case "D":
            case "T":
                Term C;       
                if (noInstantiation && noLeibniz){
                    infer = A;
                }
                else if (noInstantiation){
                    if (("T".equals(groupMethod)) && theoremHint instanceof App && ((App)theoremHint).p instanceof App &&
                         (C=((App)(((App)theoremHint).p)).p) != null && C instanceof Const &&
                         (((Const)C).getId() == 2 || ((Const)C).getId() == 3) ){

                        infer = Parity.parityLeibniz(leibniz, A);
                    }else {
                        infer = new TypedApp(L,A);
                    } 
                }
                else{

                    I = new TypedI(new Sust((ArrayList<Var>)instantiation.get(0), (ArrayList<Term>)instantiation.get(1)));
                    if (noLeibniz){
                        infer = new TypedApp(I,A);
                    }
                    else if (("T".equals(groupMethod)) && theoremHint instanceof App && ((App)theoremHint).p instanceof App &&
                            (C=((App)((App)theoremHint).p).p) != null && C instanceof Const &&
                            (((Const)C).getId() == 2 || ((Const)C).getId() == 3) ){

                        infer = Parity.parityLeibniz(leibniz,new TypedApp(I,A));
                    } else {
                        L = new TypedL((Bracket)leibniz);
                        infer = new TypedApp(L,new TypedApp(I,A));
                    }
                }
                break;

            // Natural deduction
            case "N":
                // First must check if we are dealing with a special modus ponens hint 
                // If its not a special hint (it's not an implication) just return the same we would do with the direct method
                if(!((App)((App)theoremHint).p).p.toStringInf(simboloManager, "").equals("\\Rightarrow")){
                    
                    if(!noLeibniz) { // If there is a leibniz add H to it 
                        if ("Natural Deduction,one-sided".equals(method)){
                            leibniz = new Bracket(new Var('z'), new App(new App(new Const("c_{5}"), leibniz.t), ((App)theoremBeingProved).q));
                        }else { // Direct method
                            leibniz = new Bracket(new Var('z'),new App( new App(new Const("c_{1}"), new App(new App(new Const("c_{5}"), leibniz.t), ((App)theoremBeingProved).q)) ,((App)theoremBeingProved).q));
                        }
                    }else {
                        // Use a leibniz that represents H /\ z
                        if ("Natural Deduction,one-sided".equals(method)){
                            leibniz = new Bracket(new Var('z'), new App(new App(new Const("c_{5}"), new Var('z')), ((App)theoremBeingProved).q));
                        } else { // Direct method
                            leibniz = new Bracket(new Var('z'),new App( new App(new Const("c_{1}"), new App(new App(new Const("c_{5}"), new Var('z')), ((App)theoremBeingProved).q)) ,((App)theoremBeingProved).q));
                        }
                        leibnizString = "69";
                    }
                    infer = createBaseMethodInfer(theoremHint, instantiation, instantiationString, leibniz, leibnizString, theoremBeingProved, "DM");
                }
                else { // IF REACHED HERE WE NEED A MODUS PONENS HINT
                    String e = "\\Phi_{}"; // by default use empty phi which represents leibniz z
                    Term iaRightTerm = A;
                    
                    // Example of left IA
                    // I^{[A,B,C,E := \equiv true q,\equiv q q,\equiv true true, \Phi_{cb} true \equiv]}A^{\Rightarrow (\equiv (\wedge (E C) A) (\wedge (E B) A)) (\Rightarrow (\equiv C B) A)}
                    
                    // A,B and C are in the hint being used 
                    Term cTerm = ((App)((App)((App)((App)theoremHint).p).q).p).q;
                    Term bTerm = ((App)((App)((App)theoremHint).p).q).q;
                    Term aTerm = ((App)theoremHint).q;
                
                    // If there is instantiation change a,b and c properly
                    if(!noInstantiation) {
                        I = new TypedI(new Sust((ArrayList<Var>)instantiation.get(0), (ArrayList<Term>)instantiation.get(1)));
                        cTerm = (new TypedApp(I, new TypedA(cTerm))).type();
                        bTerm = (new TypedApp(I, new TypedA(bTerm))).type();
                        aTerm = (new TypedApp(I, new TypedA(aTerm))).type();
                        // Need to add I to the right side
                        iaRightTerm = new TypedApp(I, iaRightTerm);
                    }
                    
                    // If there is leibniz change e properly
                    if(!leibnizString.equals("")) {
                        Term phiLeibniz = leibniz.traducBD();
                        e = phiLeibniz.toStringFinal();
                    }

                    String c = cTerm.toStringFinal();
                    String b = bTerm.toStringFinal();
                    String a = aTerm.toStringFinal();
                    
                    // Here is the left IA side of the modus ponens hint 
                    String iaLeftString;
                    if ("Natural Deduction,one-sided".equals(method)){
                        iaLeftString = "I^{[x_{65},x_{66},x_{67},x_{69} :=" +a+ "," +b+ "," +c+ "," +e+ "]}A^{c_{2} (c_{1} (c_{5} (x_{69} x_{67}) x_{65}) (c_{5} (x_{69} x_{66}) x_{65})) (c_{2} (c_{1} x_{67} x_{66}) x_{65})}";
                    } else { // Direct method
                        iaLeftString = "I^{[x_{65},x_{66},x_{67},x_{69} :=" +a+ "," +b+ "," +c+ "," +e+ "]}A^{c_{2} (c_{1} (c_{1} (c_{5} (x_{69} x_{67}) x_{65}) x_{65}) (c_{1}  (c_{5} (x_{69} x_{66}) x_{65}) x_{65})) (c_{2} (c_{1} x_{67} x_{66}) x_{65})}";
                    }
                    Term iaLeftTerm = CombUtilities.getTerm(iaLeftString);
                    
                    //throw new TypeVerificationException();
                    infer = new TypedApp(iaLeftTerm, iaRightTerm);
                }
                break;

            default:
                break;
        }
        return infer;
    }

    /**
     * The statement that is needed to prove changes inside a sub proof. This method 
     * calculates the statement within all the sub proofs a return the one in the 
     * current sub proof
     *  
     * @param beginFormula: general statement to be proved, is the base to calculate 
     *                      al de sub statement in the sub proofs
     * @param method: Term that represent the current state of the proof method. This
     *                term had the information about what is the current sub proof
     * @return Term that represent the statement to be proved in the current sub proof.
     */
    @Override
    @Transactional
    public Term initStatement(Term beginFormula, Term method) {
        if (method.toString().equals("AI")){
            return ((App)beginFormula).q;           
        }
        else if (method instanceof Const){
            return beginFormula;
        }
        else if ( ((App)method).p.toStringFinal().equals("CR") ) {
            Term antec = ((App)beginFormula).q;
            antec = new App(new Const(7 ,"c_{7}"), antec);
            Term consec = ((App)((App)beginFormula).p).q;
            consec = new App(new Const(7,"c_{7}"),consec);
            beginFormula = new App(new App(new Const(2,"c_{2}"),antec), consec);
            
            return initStatement(beginFormula, ((App)method).q);
        }
        else if ( ((App)method).p.toStringFinal().equals("CO") ) {
            beginFormula = new App(new App(new Const(2,"c_{2}"),new Const(9,"c_{9}")), new App(new Const(7,"c_{7}"),beginFormula));
            return initStatement(beginFormula, ((App)method).q);
        }
        // hay que poner else if para los otros metodos recursivos unarios
        else if ( ((App)method).p.toStringFinal().substring(0, 2).equals("AI") ) {
            if ( ((App)method).p instanceof Const ) {
               beginFormula = ((App)beginFormula).q;
               return initStatement(beginFormula, ((App)method).q);
            } else {
               beginFormula = ((App)((App)beginFormula).p).q;
               return initStatement(beginFormula, ((App)method).q); 
            }
        }
        else if (((App)method).p.toStringFinal().substring(0, 2).equals("CA")) {
            beginFormula = new App(new App(new Const(5,"c_{5}"),new App(new App(new Const(2,"c_{2}"),beginFormula),new App(new Const(7,"c_{7}"),new Const(8,"c_{8}")))) ,new App(new App(new Const(2,"c_{2}"), beginFormula),new Const(8,"c_{8}")));
            if ( ((App)method).p instanceof Const ) {
               beginFormula = ((App)beginFormula).q;
               return initStatement(beginFormula, ((App)method).q);
            } else {
               beginFormula = ((App)((App)beginFormula).p).q;
               return initStatement(beginFormula, ((App)method).q); 
            }
        }
        return null;
    }

    @Override
    @Transactional
    public Term currentMethod(Term method) {
        if (method instanceof App) {
            while (method instanceof App) {
                method = ((App)method).q;
            }
            return method;
        }
        else
            return method;
    }

    /**
     * This method return the sub Term of typedTerm that represent the derivation tree 
     * of only the current sub proof of the first And Introduction method searched in 
     * method parameter.
     *  
     * @param typedTerm: Term that represent all the current proof.
     * @param method: Term that represent the current state of the proof method. This
     *                term had the information about what is the current sub proof
     * @return sub Term of typedTerm that represent the derivation tree 
     *         of only the current sub proof of the first And Introduction method searched 
     *         in method parameter.
     */
    @Override
    @Transactional
    public Term getSubProof(Term typedTerm, Term method) {
       return getSubProof(typedTerm, method, false);
    }
    
    /**
     * This method return the sub Term of typedTerm that represent the derivation tree 
     * of only the current sub proof if isRecursive parameter is true. If isRecursive 
     * is false this method return the sub Term of typedTerm that represent the derivation tree 
     * of only the current sub proof of the first And Introduction method searched in 
     * method parameter.
     *  
     * @param typedTerm: Term that represent all the current proof.
     * @param method: Term that represent the current state of the proof method. This
     *                term had the information about what is the current sub proof.
     * @param isRecursive: if the value is true, the search of the sub proof call this 
     *                     method recursively.
     * @return sub Term of typedTerm that represent the derivation tree 
     *         of only the current sub proof. The deep of the sub proof depend on the 
     *         value of isRecursive
     */
    @Override
    @Transactional
    public Term getSubProof(Term typedTerm, Term method, boolean isRecursive) {
        Term auxMethod = method;
        while (auxMethod instanceof App) {
            if (auxMethod instanceof App && ((App)auxMethod).p instanceof App && 
                    ((App)((App)auxMethod).p).p.toStringFinal().equals("AI") && 
                    !ProofBoolean.isAIProof2Started(auxMethod)
                    ){
                return null;
            }
            else if (ProofBoolean.isAIProof2Started(auxMethod) && ProofBoolean.isAIOneLineProof(typedTerm)){
                return ((Bracket)((TypedL)((App)((App)((App)((App)((App)typedTerm).p).q).q).q).p).type()).t;
            }
            else if (ProofBoolean.isAIProof2Started(auxMethod) && !ProofBoolean.isAIOneLineProof(typedTerm)){
                if (isRecursive){
                    return getSubProof(((App)((App)((App)((App)typedTerm).p).q).q).q,((App)auxMethod).q,true);
                }
                else{
                    return ((App)((App)((App)((App)typedTerm).p).q).q).q;
                }
            } else{
                auxMethod = ((App)auxMethod).q;
            }
        }
        return typedTerm;
    }

    /**
     * This method returns the sub Term of typedTerm that represent the derivation tree 
     * of only the current sub proof and the father tree of this subproof.
     *  
     * @param typedTerm: Term that represent all the current proof.
     * @param method: Term that represent the current state of the proof method. This
     *                term had the information about what is the current sub proof.
     * @param li
     * @return List with sub Term of typedTerm that represent the derivation tree 
     *         of only the current sub proof and the father of this sub proof.
     */
    @Override
    @Transactional
    public List<Term> getFatherAndSubProof(Term typedTerm, Term method, List<Term> li) {
        Term auxMethod = method;
        while (auxMethod instanceof App) {
            if (auxMethod instanceof App && ((App)auxMethod).p instanceof App && 
                    ((App)((App)auxMethod).p).p.toStringFinal().equals("AI") && 
                    !ProofBoolean.isProofStarted(((App)auxMethod).q)
                    ){
                li.add(0,typedTerm);
                return li;
            }
            else if (ProofBoolean.isAIProof2Started(auxMethod) && ProofBoolean.isAIOneLineProof(typedTerm)){
                li.add(0, typedTerm);
                li.add(0,((Bracket)((TypedL)((App)((App)((App)((App)((App)typedTerm).p).q).q).q).p).type()).t);
                return li;
            }
            else if (ProofBoolean.isAIProof2Started(auxMethod) && !ProofBoolean.isAIOneLineProof(typedTerm)){
                li.add(0, typedTerm);
                return getFatherAndSubProof(((App)((App)((App)((App)typedTerm).p).q).q).q,((App)auxMethod).q,li);
            }
            else{
                auxMethod = ((App)auxMethod).q;
            }
        }
        li.add(0, typedTerm);
        return li;
    }

    /**
     * This method adds a proof method for currentMethod to get a new compose method. 
     * If currentMethod is of the form ...M1 (M2 (M3...Mn)), then the method return  
     * ...M1 (M2 (M3...(Mn newMethod))). If currentMethod is of the from 
     * ...AI (M2 (M3...Mn)) where (M2 (M3...Mn)) is not waiting method then the method 
     * return ...((AI (M2 (M3...Mn))) newMethod). If currentMethod is of the from 
     * ...((AI (M2 (M3...Mn))) (N1 (N2 (N3...Nm)))) where (N1 (N2 (N3...Nm))) is 
     * waiting method, then the method return 
     * ...((AI (M2 (M3...Mn))) (N1 (N2 (N3...(Nm newMethod)))))
     *  
     * @param currentMethod: Term that represent the current state of the proof method
     * @param newMethod: new no compose Method 
     * @return Term that represent a new proof method compose by currentMethod and newMethod.
     */
    @Override
    @Transactional
    public Term updateMethod(String currentMethod, String newMethod) {
        
        if (currentMethod.equals(""))
            return new Const(newMethod);
        else {
            Term methodTerm = ProofMethodUtilities.getTerm(currentMethod);
            Term t = methodTerm;
            Term aux = null;
            Term father = methodTerm;
            
            if (t instanceof App)
               aux = ((App)t).q;  
            while (aux != null && !(aux instanceof Const) && ProofBoolean.isWaitingMethod(aux)) {
               father = t;
               t = aux;
               aux = ((App)aux).q;
            }
            if (aux == null)
               methodTerm = new App(methodTerm, new Const(newMethod));
            else if (aux instanceof Const && ProofBoolean.isWaitingMethod(aux)) 
               ((App)t).q = new App(aux, new Const(newMethod));
            else { 
                /*if (father == methodTerm && isWaitingMethod(t))
                  methodTerm = new App(methodTerm, new Const("DM"));
                else */
                if (father == t)
                    methodTerm = new App(methodTerm, new Const(newMethod));
                else
                    ((App)father).q = new App(t, new Const(newMethod));
            }
                  
            return methodTerm;      
        }
    }
    
    /**
     * This method constructs a new derivation tree adding an one step infer to a proof.This is not a pure function; it may change the the values of its given params in an external context.
     * 
     * @param proof: Term that represents a proof
     * @param infer: Term that represents one step infer
     * @param method: method used in the demonstration
     * @return new TypedTerm that represents a new derivation tree that 
     *         adds in the last line of proof the infer
     * @throws com.calclogic.lambdacalculo.TypeVerificationException
     */
    @Override
    @Transactional
    public Term addInferToProof(Term proof, Term infer, String method) throws TypeVerificationException {
        if (method.equals("WE") || method.equals("ST") || method.equals("TR")) {
            Term type = proof.type();
            Term typeInf = infer.type();
            String op;
            String opInf;
            try {
                op = ((App)((App)type).p).p.toStringFinal();
                opInf = ((App)((App)typeInf).p).p.toStringFinal();
            }
            catch (ClassCastException e) {
                throw new TypeVerificationException();
            }
            if ( !op.equals("c_{1}") && !op.equals("c_{20}") ) {
                proof = MetaTheorem.metaTheoTrueLeft(proof);
                type = proof.type();
            }
            int index = InferenceIndex.wsFirstOpInferIndex(proof);
            boolean eqInf = opInf.equals("c_{1}") || opInf.equals("c_{20}");
            if ( index == 0 && eqInf) {
                return new TypedApp(proof, infer);
            }
            else if (index == 0 && !eqInf) {
                String eq = op;
                String st = "c_{2} (c_{2} (c_{1} (x_{69} x_{101}) c_{8}) (x_{69} x_{102})) ("+eq+" x_{102} x_{101})";
                String deriv = "";
                try {
                    String E = "\\Phi_{b} ("+ ((App)infer.type()).p+")";
                    deriv = "I^{[x_{101}, x_{102}, x_{69} := "+((App)type).q+", "+((App)((App)type).p).q+", "+E+"]} A^{"+st+"}";
                }
                catch (ClassCastException e) {
                    throw new TypeVerificationException();
                }
                return new TypedApp(new TypedApp(CombUtilities.getTerm(deriv), proof), infer);
            }
            else if (index != 0 && !eqInf) {
                String st = "c_{2} (c_{2} (c_{1} ("+opInf+" x_{114} x_{112}) c_{8}) ("+opInf+" x_{114} x_{113}))  (c_{1} ("+opInf+" x_{113} x_{112}) c_{8})";
                String deriv = "";
                try {
                    Term aux = (App)((App)((App)type).p).q;
                    deriv = "I^{[x_{112}, x_{113}, x_{114} := "+((App)aux).q+", "+((App)((App)aux).p).q+", "+((App)((App)typeInf).p).q+"]} A^{"+st+"}";
                }catch (ClassCastException e) {
                    throw new TypeVerificationException();
                }
                return new TypedApp(new TypedApp(CombUtilities.getTerm(deriv), proof), infer);
            }
            else {
                if ( infer instanceof TypedApp && ((TypedApp)infer).inferType=='l' ) {
                    Term aux = ((App)((App)type).p).q;
                    Term oldLeib = ((Bracket)((TypedApp)infer).p.type()).t;
                    Bracket leibniz = new Bracket(new Var('z'),new App(new App(((App)((App)aux).p).p,oldLeib),((App)aux).q));
                    infer = new TypedApp(new TypedL(leibniz),((TypedApp)infer).q);
                    return new TypedApp(proof, infer);
                }
                else {
                    Term aux = ((App)((App)type).p).q;
                    Bracket leibniz = new Bracket(new Var('z'),new App(new App(((App)((App)aux).p).p,new Var('z')),((App)aux).q));
                    infer = new TypedApp(new TypedL(leibniz),infer);
                    return new TypedApp(proof, infer);
                }
            }
        } else {
            return new TypedApp(proof, infer);
        }
    }

    /**
     * This method add 'formula' in one line sub proof for the current sub proof in 
     * (typedTerm, method).
     *  
     * @param formula: first line to add for the current sub proof
     * @param typedTerm: term that represent the current proof
     * @param method: Term that represent the current state of the proof method. This
     *                term had the information about what is the current sub proof
     * @return Term that represent the statement to be proved in the current sub proof.
     */
    @Override
    @Transactional
    public Term addFirstLineSubProof(Term formula, Term typedTerm, Term method) {
        Term auxMethod = method;
        while (auxMethod instanceof App) {
            if (ProofBoolean.isAIProof2Started(auxMethod) && ProofBoolean.isAIProof2Started(((App)auxMethod).q)){
                Term aux = addFirstLineSubProof(formula, ((App)((App)((App)((App)typedTerm).p).q).q).q, 
                                                                                    ((App)auxMethod).q);
                return finiPMeth.finishedAI2Proof(typedTerm,aux);
            }
            // si la segunda prueba del AI es otro metodo que adentro tiene un AI, esto no funciona
            else if (ProofBoolean.isAIProof2Started(auxMethod)) {
                Map<String,String> values1 = new HashMap<>();
                values1.put("ST1",new App(new App(new Const(1,"c_{1}"),formula),formula).toStringFinal());
                String aux;
                values1.put("ST2", formula.toStringFinal());
                StrSubstitutor sub1 = new StrSubstitutor(values1, "%(",")");
                String metaTheoT= "S (I^{[x_{113} := %(ST1)]} A^{c_{1} x_{113} (c_{1} x_{113} c_{8})}) (L^{\\lambda x_{122}.%(ST2)} A^{c_{1} x_{113} x_{113}})";
                String metaTheo = sub1.replace(metaTheoT);
                Map<String,String> values2 = new HashMap<>();
                values2.put("MT", metaTheo);
                values2.put("T1Type", typedTerm.type().toStringFinal());
                aux = typedTerm.toStringFinal();
                values2.put("T1", (typedTerm instanceof Const?aux:"("+aux+")"));
                StrSubstitutor sub2 = new StrSubstitutor(values2, "%(",")");
                String template = "S (I^{[x_{112}:=%(T1Type)]} A^{c_{1} x_{112} (c_{5} c_{8} x_{112})}) (L^{\\lambda x_{122}. c_{5} x_{122} (%(T1Type))} (%(MT)) )";
                String proof = sub2.replace(template);
                Term proofTerm = null;
                try {
                    proofTerm = new TypedApp(CombUtilities.getTerm(proof),typedTerm);
                }
                catch (TypeVerificationException e) {
                    Logger.getLogger(InferController.class.getName()).log(Level.SEVERE, null, e);
                }
                return proofTerm;
            }else{
                auxMethod = ((App)auxMethod).q;
            }
        }
        return formula;
    }
    
    /**
     * This method erase one basic proof method for currentMethod. 
     * If currentMethod is of the form ...M1 (M2 (M3...(Mn M))), then the method return  
     * ...M1 (M2 (M3...Mn)). If currentMethod is of the from 
     * ...(AI (M2 (M3...Mn)) M) then the method  return ...(AI (M2 (M3...Mn))). 
     * If currentMethod is of the from ...((AI (M2 (M3...Mn))) (N1 (N2 (N3...(Nm M))))) is 
     * then the method return ...((AI (M2 (M3...Mn))) (N1 (N2 (N3...Nm))))
     *  
     * @param currentMethod: String that encode the current state of the proof method
     * @return Term that represent a new proof method exactly as currentMethod but without the 
     *         last proof method. If currentMethod encode an Atomic method return null.
     */
    @Override
    @Transactional
    public Term eraseMethod(String currentMethod) {
        // revisa en las llamadas a este metodo si se ahorra algo al recibir String 
        // en lugar de Term
        if (currentMethod.length() <= 3)
            return null;
        else {
            Term currMethodTerm = ProofMethodUtilities.getTerm(currentMethod);
            Term father = currMethodTerm;
            Term q = ((App)father).q;
            Term aux = null;
            if (q instanceof Const)
               return ((App)father).p;
            else {
              aux = q;
              q = ((App)q).q;
            }
            while ( q instanceof App) {
                father = aux;
                aux = ((App)father).q;
                q = ((App)aux).q;
            }
            ((App)father).q = ((App)aux).p;
            
            return currMethodTerm;
        }
    }
}