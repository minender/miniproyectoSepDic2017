package com.calclogic.proof;

import com.calclogic.controller.InferController;
import com.calclogic.entity.Dispone;
import com.calclogic.forms.GenericResponse;
import com.calclogic.lambdacalculo.App;
import com.calclogic.lambdacalculo.Bracket;
import com.calclogic.lambdacalculo.Const;
import com.calclogic.lambdacalculo.Var;
import com.calclogic.lambdacalculo.Term;
import com.calclogic.lambdacalculo.TypeVerificationException;
import com.calclogic.lambdacalculo.TypedA;
import com.calclogic.lambdacalculo.TypedApp;
import com.calclogic.lambdacalculo.TypedL;
import com.calclogic.lambdacalculo.TypedM;
import com.calclogic.global.Information;
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
import org.springframework.beans.factory.annotation.Autowired;

/**
 *
 * @author ronald
 */
@Service
public class CrudOperationsImpl implements CrudOperations {
    @Autowired
    private GenericProofMethod genericMethod;
    @Autowired
    private AndIntroductionMethod andIntroduction;
    @Autowired
    private CaseAnalysisMethod caseAnalysis;
    @Autowired
    private ContradictionMethod contradiction;
    @Autowired
    private CounterReciprocalMethod counterReciprocal;
    @Autowired
    private DirectMethod directMethod;
    @Autowired
    private EqualityToOperator equalityToOp;
    @Autowired
    private OperatorToEquality operatorToEq;
    @Autowired
    private MutualImplicationMethod mutualImplication;
    @Autowired
    private StartingOneSideMethod startingOneSide;
    @Autowired
    private StrengtheningMethod strengthening;
    @Autowired
    private TransitivityMethod transitivity;
    @Autowired
    private WeakeningMethod weakening;

    @Autowired
    public Information globalInfo;

    /**
     * This function gives the corresponding class of the specified
     * demonstration method
     *
     * @param method: Identifier of the method that will be created
     * @return The object with all variables and functions related to the method
     */
    @Override
    @Transactional
    public GenericProofMethod returnProofMethodObject(String method) {
        switch (method){
            case "DM":
                return directMethod;
            case "EO":
                return equalityToOp;
            case "OE":
                return operatorToEq;
            case "SS":
                return startingOneSide;
            case "TR":
                return transitivity;
            case "WE":
                return weakening;
            case "ST":
                return strengthening;
            case "CR":
                return counterReciprocal;
            case "CO":
                return contradiction;
            case "AI":
                return andIntroduction;
            case "MI":
                return mutualImplication;
            case "CA":
                return caseAnalysis;
            default:
                return genericMethod;
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
            String strMethod = method.dsc("1").toString().substring(0, 2);
            GenericProofMethod objectMethod = returnProofMethodObject(strMethod);

            if (objectMethod.getIsRecursiveMethod()){
                beginFormula = objectMethod.initFormula(beginFormula);

                // Branched recursive methods
                if ("B".equals(objectMethod.getGroupMethod())){ 
                    if ( method.dsc("1") instanceof Const ) {
                        beginFormula = beginFormula.dsc("2");
                    } else {
                        beginFormula = beginFormula.dsc("12");
                    }
                }
            } else{
                return null; // When no possibility matched. 
            }
            return initStatement(beginFormula, method.dsc("2"));
        }
    }

    @Override
    @Transactional
    public Term currentMethod(Term method) {
        if (method instanceof App) {
            while (method instanceof App) {
                method = method.dsc("2");
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
            if (auxMethod instanceof App && auxMethod.dsc("1") instanceof App && 
                    auxMethod.dsc("11").toString().equals("AI") && 
                    !ProofBoolean.isBranchedProof2Started(auxMethod)
                )
            {
                return null;// no deberia devolver this, no seria mas homogeneo?
            }
            else if (ProofBoolean.isBranchedProof2Started(auxMethod) && ProofBoolean.isAIOneLineProof(typedTerm)){
                return ((Bracket)((TypedL)typedTerm.dsc("122221")).type()).t; 
            }
            else if (ProofBoolean.isBranchedProof2Started(auxMethod) && !ProofBoolean.isAIOneLineProof(typedTerm)){
                if (isRecursive){
                    return getSubProof(typedTerm.dsc("12222"),auxMethod.dsc("2"),true);
                }
                else{
                    return typedTerm.dsc("12222");
                }
            } else{
                auxMethod = auxMethod.dsc("2");
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
        String m;
        while (auxMethod instanceof App) {
            if (auxMethod instanceof App && auxMethod.dsc("1") instanceof App && 
                    ((m=auxMethod.dsc("11").toString()).equals("AI") || m.equals("CA")) && 
                    !ProofBoolean.isProofStarted(auxMethod.dsc("2"))
                )
            {
                li.add(0,typedTerm);
                return li;
            }
            else if (ProofBoolean.isBranchedProof2Started(auxMethod) && ProofBoolean.isAIOneLineProof(typedTerm)){
                li.add(0, typedTerm);
                li.add(0,((Bracket)((TypedL)typedTerm.dsc("122221")).type()).t);
                return li;
            }
            else if (ProofBoolean.isBranchedProof2Started(auxMethod) && !ProofBoolean.isAIOneLineProof(typedTerm)){
                li.add(0, typedTerm);  
                return getFatherAndSubProof(typedTerm.dsc("12222"),auxMethod.dsc("2"),li);
            }
            else{
                auxMethod = auxMethod.dsc("2");
            }
        }
        li.add(0, typedTerm);
        return li;
    }

    /**
     * When in a proof we need to use a theorem or metatheorem as a hint 
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
        TypedA statementTerm = null;
        if (nStatement.length() >= 4) {
            // FIND THE THEOREM BEING USED IN THE HINT
            String tipoTeo = nStatement.substring(0, 2);
            String numeroTeo = nStatement.substring(3, nStatement.length());
        
            switch (tipoTeo) {
                case "ST":
                    statementTerm = new TypedA(numeroTeo,username);
                    /*Resuelve resuelve = resuelveManager.getResuelveByUserAndTeoNum(username, numeroTeo,false);
                    // Case when the user could only see the theorem but had not a Resuelve object associated to it
                    if (resuelve == null) {
                        resuelve = resuelveManager.getResuelveByUserAndTeoNum("AdminTeoremas",numeroTeo, false);
                    }
                    statementTerm = (resuelve!=null?resuelve.getTeorema().getTeoTerm():null);*/
                    break;
                case "MT":
                    /*Dispone dispone = disponeManager.getDisponeByUserAndTeoNum(username, numeroTeo);
                    if (dispone == null){
                        dispone = disponeManager.getDisponeByUserAndTeoNum("AdminTeoremas", numeroTeo);
                    }
                    statementTerm = (dispone!=null?dispone.getMetateorema().getTeoTerm():null);*/
                    statementTerm = new TypedA(numeroTeo,username);
                    statementTerm = MetaTheorem.metaTheorem3(statementTerm, statementTerm.getCombDBType(), username);
                    break;
                default:
                    response.setError("statement format error");
            }
            if (statementTerm.getNSt().equals("")) {
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
            // so the attribute "1" is "(operator Q)" and "11" is "operator". 
            return ((Const)formula.dsc("11")).getId();
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
               aux = t.dsc("2");  
            while (aux != null && !(aux instanceof Const) && ProofBoolean.isWaitingMethod(aux)) {
               father = t;
               t   = aux;
               aux = aux.dsc("2");
            }
            if (aux == null){
                methodTerm = new App(methodTerm, new Const(newMethod));
            }
            else if (aux instanceof Const && ProofBoolean.isWaitingMethod(aux)){
                t.setChild(new App(aux, new Const(newMethod)),'2');
            }
            else { 
                /*if (father == methodTerm && isWaitingMethod(t))
                  methodTerm = new App(methodTerm, new Const("DM"));
                else */
                if (father == t){
                    methodTerm = new App(methodTerm, new Const(newMethod));
                }
                else {
                    father.setChild(new App(t, new Const(newMethod)),'2');
                }
            }
                  
            return methodTerm;      
        }
    }
    
    /**
     * This method constructs a new derivation tree adding an one step infer to a proof.This is not a pure function; it may change the the values of its given params in an external context.
     * 
     * @param user
     * @param proof: Term that represents a proof
     * @param infer: Term that represents one step infer
     * @param objectMethod: object with all the functions related to a method
     * @return new TypedTerm that represents a new derivation tree that 
     *         adds in the last line of proof the infer
     * @throws com.calclogic.lambdacalculo.TypeVerificationException
     */
    @Override
    @Transactional
    public Term addInferToProof(String user, Term proof, Term infer, GenericProofMethod objectMethod) throws TypeVerificationException {
        // In case the method is a transitive one
        if (objectMethod.getGroupMethod().equals("T")){
            Term type = proof.type();
            Term typeInf = infer.type();
            String op, opInf;
            try {
                op    = type.containT()    ? type.dsc("2").body().dsc("11").toString()    : type.dsc("11").toString();
                opInf = typeInf.containT() ? typeInf.dsc("2").body().dsc("11").toString() : typeInf.dsc("11").toString();
            }
            catch (ClassCastException e) {
                throw new TypeVerificationException();
            }
            if ( !op.equals("=") ) {
                proof = MetaTheorem.metaTheoTrueLeft(proof);
                type = proof.type();
            }

            int index = objectMethod.transFirstOpInferIndex(proof,true);
            boolean eqInf = opInf.equals("=");
            if (index == 0 && eqInf) {
                return new TypedApp(proof, infer);
            }
            else if (index == 0 && !eqInf) {
                String eq    = "c_{1}";//op;
                String st    = "= T (c_{2} (c_{2} (c_{1} (x_{69} x_{101}) c_{8}) (x_{69} x_{102})) (" + eq + " x_{102} x_{101}))";
                String deriv = "";
                typeInf = typeInf.dsc("2").body();
                try {
                    String E = "\\Phi_{b} (" + typeInf.dsc("1") + ")";
                    deriv = "I^{[x_{101}, x_{102}, x_{69} := " + type.dsc("2").body() + ", " + type.dsc("12").body() + ", " + E + "]} A^{" + st + "}";
                }
                catch (ClassCastException e) {
                    throw new TypeVerificationException();
                }
                return new TypedApp(new TypedApp(CombUtilities.getTerm(deriv,null), new TypedM(1,type,user)), infer);
            }
            else if (index != 0 && !eqInf) {
                String st = "= T (c_{2} (c_{2} (c_{1} (" + opInf + " x_{114} x_{112}) c_{8}) (" + opInf + " x_{114} x_{113}))  (c_{1} (" + opInf + " x_{113} x_{112}) c_{8}))";
                String deriv = "";
                typeInf = typeInf.dsc("2").body();

                try {
                    Term aux = (App)type.dsc("2").body().dsc("12"); // >>> PREGUNTAR POR ESTE APP DE MÁS. ¿ES NECESARIO?
                    deriv = "I^{[x_{112}, x_{113}, x_{114} := " + aux.dsc("2") + ", " + aux.dsc("12") + ", " + typeInf.dsc("12") + "]} A^{" + st + "}";
                } 
                catch (ClassCastException e) {
                    throw new TypeVerificationException();
                }
                return new TypedApp(new TypedApp(CombUtilities.getTerm(deriv,user), proof), infer);
            }
            else {
                Term aux = type.dsc("12").body();



                if ( infer instanceof TypedApp && ((TypedApp)infer).inferType=='l'){
                    Term oldLeib = ((Bracket)infer.dsc("1", true).type()).t;
                    Bracket leibniz = new Bracket( new Var('z'), new App(new App(aux.dsc("11"),oldLeib), aux.dsc("2")) );

                    infer = new TypedApp(new TypedL(leibniz), infer.dsc("2", true));
                }
                else {
                    if (aux instanceof Var){
                        infer = new TypedApp(proof, new Var('z'));
                    }
                    else{
                        Bracket leibniz = new Bracket( new Var('z'), 
                                                        new App(
                                                            new App(aux.dsc("11"),new Var('z')), 
                                                            aux.dsc("2")
                                                        )
                                                    );
                        infer = new TypedApp(new TypedL(leibniz),infer); 
                    }                     
                }
                return new TypedApp(proof, infer);
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
     * @param usr
     * @param formula: first line to add for the current sub proof
     * @param typedTerm: term that represent the current proof
     * @param method: Term that represent the current state of the proof method. This
     *                term had the information about what is the current sub proof
     * @return Term that represent the statement to be proved in the current sub proof.
     */
    @Override
    @Transactional
    public Term addFirstLineSubProof(String usr, Term formula, Term typedTerm, Term method) {
        Term auxMethod = method; // "method" is entry/exit, so if we use it directly we change its value in the caller
        while (auxMethod instanceof App) {
            if (ProofBoolean.isBranchedProof2Started(auxMethod) && 
                ProofBoolean.containsBranchedProof2Started(auxMethod.dsc("2"))    
               )
            {
                Term aux = addFirstLineSubProof(usr,formula, typedTerm.dsc("1222"), auxMethod.dsc("2"));

                GenericProofMethod objectMethod = returnProofMethodObject("AI");
                return objectMethod.finishedMethodProof(typedTerm,aux);
            }
            else if (ProofBoolean.isBranchedProof2Started(auxMethod)) {
                Map<String,String> values1 = new HashMap<>();
                //values1.put("ST1",new App(new App(new Const(1,"c_{1}"),formula),formula).toString());

                String aux;
                values1.put("ST2", formula.toString());
                StrSubstitutor sub1 = new StrSubstitutor(values1, "%(",")");
                //String fLineEncode = "L^{\\lambda x_{122}."+formula.toStringFinal()+"} A^{= x_{113} x_{113}}";
                //String l = ((App)((App)CombUtilities.getTerm(fLineEncode,null).type()).p).q.body().toStringFinal();
                //String lamb = "L^{\\lambda x_{122}. c_{1} ("+l+") x_{122}}";
                //String metaTheoT= "L^{\\lambda x_{122}. c_{1} (%(ST2)) x_{122}} (L^{\\lambda x_{122}.%(ST2)} A^{= x_{113} x_{113}}) (I^{[x_{112}:= %(ST2)]} A^{= c_{8} (c_{1} x_{112} x_{112})})";
                String metaTheoT = "I^{[x_{113}:= %(ST2)]} A^{= (\\Phi_{(b,)} c_{1}) (\\Phi_{K} c_{8})} (L^{\\lambda x_{122}. c_{1} x_{122} (%(ST2))} (L^{\\lambda x_{122}.%(ST2)} A^{= (\\Phi_{(b,)} c_{1}) (\\Phi_{K} c_{8})}))";
                String metaTheo = sub1.replace(metaTheoT);
                Map<String,String> values2 = new HashMap<>();
                values2.put("MT", metaTheo);
                values2.put("T1Type", typedTerm.type().setToPrint(null).toString());
                aux = typedTerm.toString();
                values2.put("T1", (typedTerm instanceof Const ? aux : "(" + aux + ")") );
                StrSubstitutor sub2 = new StrSubstitutor(values2, "%(",")");
                String template = "S (I^{[x_{112}:=%(T1Type)]} A^{= \\Phi_{} (\\Phi_{b} (c_{5} c_{8}))}) (L^{\\lambda x_{122}. c_{5} x_{122} (%(T1Type))} (%(MT)) )";
                String proof = sub2.replace(template);
                Term proofTerm = null;
                try {
                    proofTerm = new TypedApp(CombUtilities.getTerm(proof,usr),typedTerm);
                }
                catch (TypeVerificationException e) {
                    Logger.getLogger(InferController.class.getName()).log(Level.SEVERE, null, e);
                }
                return proofTerm;
            }else{
                auxMethod = auxMethod.dsc("2");
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
        if (currentMethod.length() <= 3){
            return null;
        }
        else {
            Term currMethodTerm = ProofMethodUtilities.getTerm(currentMethod);
            Term father = currMethodTerm;
            Term q = father.dsc("2");
            Term aux;
            if (q instanceof Const){
                return father.dsc("1");
            }
            else {
                aux = q;
                q   = q.dsc("2");
            }
            while ( q instanceof App) {
                father = aux;
                aux = father.dsc("2");
                q   = aux.dsc("2");
            }
            father.setChild(aux.dsc("1"),'2');
            
            return currMethodTerm;
        }
    }

    /**
     * Returns the Information class object
     * @return globalInfo bean
     */
    @Override
    public Information getGlobalInfo(){
        return globalInfo;
    }
}