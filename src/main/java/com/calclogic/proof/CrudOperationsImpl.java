package com.calclogic.proof;

import com.calclogic.controller.InferController;
import com.calclogic.entity.Resuelve;
import com.calclogic.entity.Dispone;
import com.calclogic.forms.GenericResponse;
import com.calclogic.lambdacalculo.App;
import com.calclogic.lambdacalculo.Bracket;
import com.calclogic.lambdacalculo.Const;
import com.calclogic.lambdacalculo.Var;
import com.calclogic.lambdacalculo.Term;
import com.calclogic.lambdacalculo.TypeVerificationException;
import com.calclogic.lambdacalculo.TypedApp;
import com.calclogic.lambdacalculo.TypedL;
import com.calclogic.parse.CombUtilities;
import com.calclogic.parse.ProofMethodUtilities;
import com.calclogic.service.ResuelveManager;
import com.calclogic.service.DisponeManager;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.logging.Level;
import java.util.logging.Logger;
import org.apache.commons.lang3.text.StrSubstitutor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

/**
 *
 * @author ronald
 */
@Service
public class CrudOperationsImpl implements CrudOperations {

    /**
     * This function gives the corresponding class of the specified
     * demonstration method
     *
     * @param method: Identifier of the method that will be created
     * @return The object with all variables and functions related to the method
     */
    @Override
    @Transactional
    public GenericProofMethod createProofMethodObject(String method) {
        switch (method){
            case "DM":
                return new DirectMethod();
            case "SS":
                return new StartingOneSideMethod();
            case "TR":
                return new TransitivityMethod();
            case "WE":
                return new WeakeningMethod();
            case "ST":
                return new StrengtheningMethod();
            case "CR":
                return new CounterReciprocalMethod();
            case "CO":
                return new ContradictionMethod();
            case "AI":
                return new AndIntroductionMethod();
            case "MI":
                return new MutualImplicationMethod();
            case "CA":
                return new CaseAnalysisMethod();
            default:
                return new GenericProofMethod();
        }
    }

    /**
     * The statement that is needed to prove changes inside a sub proof. This method 
     * calculates the statement within all the sub proofs and returns the one in the 
     * current sub proof
     *  
     * @param beginFormula: general statement to be proved, is the base to calculate 
     *                      al the sub statements in the sub proofs
     * @param method: Term that represents the current state of the proof method. This
     *                term had the information about what the current sub proof is.
     * @return Term that represents the statement to be proved in the current sub proof.
     */
    @Override
    @Transactional
    public Term initStatement(Term beginFormula, Term method){
        if (method instanceof Const){ // Base methods
            return beginFormula;
        }
        else{
            String strMethod = ((App)method).p.toStringFinal().substring(0, 2);
            GenericProofMethod objectMethod = createProofMethodObject(strMethod);

            if (objectMethod.getIsRecursiveMethod()){
                beginFormula = objectMethod.initFormula(beginFormula);

                if ("B".equals(objectMethod.getGroupMethod())){ // Branched recursive methods
                    if ( ((App)method).p instanceof Const ) {
                        beginFormula = ((App)beginFormula).q;
                    } else {
                        beginFormula = ((App)((App)beginFormula).p).q;
                    }
                }
            } else{
                return null; // When no possibility matched. 
            }
            return initStatement(beginFormula, ((App)method).q);
        }
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
                    !ProofBoolean.isBranchedProof2Started(auxMethod)
                    ){
                return null;
            }
            else if (ProofBoolean.isBranchedProof2Started(auxMethod) && ProofBoolean.isAIOneLineProof(typedTerm)){
                return ((Bracket)((TypedL)((App)((App)((App)((App)((App)typedTerm).p).q).q).q).p).type()).t;
            }
            else if (ProofBoolean.isBranchedProof2Started(auxMethod) && !ProofBoolean.isAIOneLineProof(typedTerm)){
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
            else if (ProofBoolean.isBranchedProof2Started(auxMethod) && ProofBoolean.isAIOneLineProof(typedTerm)){
                li.add(0, typedTerm);
                li.add(0,((Bracket)((TypedL)((App)((App)((App)((App)((App)typedTerm).p).q).q).q).p).type()).t);
                return li;
            }
            else if (ProofBoolean.isBranchedProof2Started(auxMethod) && !ProofBoolean.isAIOneLineProof(typedTerm)){
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
     * When in a demonstration we need to use a theorem or metatheorem as a hint 
     * (for inference, instantiation or substitution), we need to get its 
     * statement. This function does it.
     *
     * @param response: Entry-exit parameter. In case there is an error, we set
     *                  that error here in the parameter and the caller must then
     *                  inmediately return the updated response.
     * @param nStatement: Number of the statement, as a string, that will be looked for.
     * @param username: login of the user that made the request.
     * @param resuelveManager
     * @param disponeManager
     * @return The statement of the theorem or metatheorem.
     */
    @Override
    public Term findStatement(GenericResponse response, String nStatement, String username, 
                                ResuelveManager resuelveManager, DisponeManager disponeManager){
        Term statementTerm = null;
        if (nStatement.length() >= 4) {
            // FIND THE THEOREM BEING USED IN THE HINT
            String tipoTeo = nStatement.substring(0, 2);
            String numeroTeo = nStatement.substring(3, nStatement.length());
        
            switch (tipoTeo) {
                case "ST":
                    Resuelve resuelve = resuelveManager.getResuelveByUserAndTeoNum(username, numeroTeo);
                    // Case when the user could only see the theorem but had not a Resuelve object associated to it
                    if (resuelve == null) {
                        resuelve = resuelveManager.getResuelveByUserAndTeoNum("AdminTeoremas",numeroTeo);
                    }
                    statementTerm = (resuelve!=null?resuelve.getTeorema().getTeoTerm():null);
                    break;
                case "MT":
                    Dispone dispone = disponeManager.getDisponeByUserAndTeoNum(username, numeroTeo);
                    if (dispone == null){
                        dispone = disponeManager.getDisponeByUserAndTeoNum("AdminTeoremas", numeroTeo);
                    }
                    statementTerm = (dispone!=null?dispone.getMetateorema().getTeoTerm():null);
                    break;
                default:
                    response.setError("statement format error");
            }
            if (statementTerm == null) {
                response.setError("The statement doesn't exist");
            }
        }
        else {
            response.setError("statement format error");
        }
        return statementTerm;
    }

    /**
     * It finds the id of the operator of a binary expression. 
     * For example, if we have P == Q, the main operator is ==, and its id is 1
     * 
     * @param formula: Expression whose main operator id will be found.
     * @param methodTerm: Tree of methods that the user has selected to do the proof
     * @return The id of the main operator.
     */
    @Override
    public int binaryOperatorId(Term formula, Term methodTerm){
        try{
            if (methodTerm != null){
                formula = initStatement(formula, methodTerm);
            }
            // In applicative notation, the expression "P operator Q" is written as "(operator Q) P",
            // so the attribute 'p' is "(operator Q)" and p.p is "operator". 
            return ((Const)((App)((App)formula).p).p).getId();
        }
        catch (ClassCastException e){
            return -1;
        }
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
     * @param objectMethod: object with all the functions related to a method
     * @return new TypedTerm that represents a new derivation tree that 
     *         adds in the last line of proof the infer
     * @throws com.calclogic.lambdacalculo.TypeVerificationException
     */
    @Override
    @Transactional
    public Term addInferToProof(Term proof, Term infer, GenericProofMethod objectMethod) throws TypeVerificationException {
        // In case the method is a transitive one
        if (objectMethod.getGroupMethod().equals("T")){
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
            int index = objectMethod.transFirstOpInferIndex(proof,true);
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
            Term prueba = new TypedApp(proof, infer);
            return prueba;
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
        Term auxMethod = method; // "method" is entry/exit, so if we use it directly we change its value in the caller
        while (auxMethod instanceof App) {
            if (ProofBoolean.isBranchedProof2Started(auxMethod) && ProofBoolean.containsBranchedProof2Started(((App)auxMethod).q)){
                Term aux = addFirstLineSubProof(formula, ((App)((App)((App)((App)typedTerm).p).q).q).q, 
                                                                                    ((App)auxMethod).q);

                GenericProofMethod objectMethod = createProofMethodObject("AI");
                return objectMethod.finishedMethodProof(typedTerm,aux);
            }
            else if (ProofBoolean.isBranchedProof2Started(auxMethod)) {
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
            Term aux;
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