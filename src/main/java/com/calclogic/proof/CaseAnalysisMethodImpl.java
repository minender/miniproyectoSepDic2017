package com.calclogic.proof;

import com.calclogic.entity.PredicadoId;
import com.calclogic.lambdacalculo.App;
import com.calclogic.lambdacalculo.Bracket;
import com.calclogic.lambdacalculo.Const;
import com.calclogic.lambdacalculo.Term;
import com.calclogic.lambdacalculo.TypeVerificationException;
import com.calclogic.lambdacalculo.TypedA;
import com.calclogic.lambdacalculo.TypedApp;
import com.calclogic.lambdacalculo.TypedL;
import com.calclogic.lambdacalculo.TypedS;
import com.calclogic.lambdacalculo.TypedTerm;
import com.calclogic.lambdacalculo.Var;
import com.calclogic.parse.CombUtilities;
import com.calclogic.parse.TermUtilities;
import com.calclogic.service.PredicadoManager;
import com.calclogic.service.SimboloManager;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import org.springframework.beans.factory.annotation.Autowired;

import org.springframework.stereotype.Service;

/**
 *
 * @author ronald
 */
@Service
public class CaseAnalysisMethodImpl extends GenericProofMethodImpl implements CaseAnalysisMethod {

    @Autowired
    private CrudOperations crudOp;
    
    public CaseAnalysisMethodImpl(){
        setInitVariables("CA");
    }

    /**
     * Parse de cases C1,C2,..,CN and build a term (C1\/C2..\/CN)/\(C1=>stToProof)/\../\(CN=>stToProof)
     **/
    public static Term parseCases(String user, String cases, Term stToProof, PredicadoManager pm,
                                  SimboloManager sm) {
        ArrayList<Term> arr = null;
        Term aux1, aux2 = null;
        PredicadoId predicadoid = new PredicadoId();
           predicadoid.setLogin(user);
           if (!cases.equals("")){
            arr=TermUtilities.explist(cases, predicadoid, pm, sm);
           }
           int i = arr.size()-2;
           aux1 = arr.get(i+1);
           while (0<= i) {
               aux1 = new App(new Const(4,"c_{4}"), aux1);
               aux1 = new App(aux1, arr.get(i));
               i--;
           }
           i = arr.size()-1;
           aux2 = new App(new App(new Const(2,"c_{2}"),stToProof),arr.get(i));
           i--;
           while (0<= i) {
              aux2 = new App(new Const(5,"c_{5}"), aux2);
              aux2 = new App(aux2,new App(new App(new Const(2,"c_{2}"),stToProof),arr.get(i)));
              i--;
           }
           aux2 = new App(new Const(5,"c_{5}"), aux2);
           aux2 = new App(aux2,aux1);
           return aux2;
    }
    /**
     * Indicates the header that a proof that starts with case analysis
     * method must have.
     *  
     * @param statement: New statement that needs to be proved according to this method
     * @return The header message to be added to the proof
     */
    @Override
    public String header(String statement, Term formulaBeingProved){
        return "By case analysis method, the following must be proved:<br>"+statement+"Sub Proof:<br>";
    }

    /**
     * Indicates the header of a sub-proof of a branched recursive method
     *  
     * @param caseStatement: Case that needs to be demonstrated in the current sub-proof
     * @return The header message to be added to the proof
     */
    @Override
    public String subProofInit(String caseStatement){
        return "Case:<br>" + caseStatement + "Sub Proof:<br>";
    }

    /**
     * The statement that is needed to be proven may change inside a sub proof,
     * so this function calculates which that new statement is.
     *  
     * @param beginFormula: general statement to be proved, is the base to calculate 
     *                      al de sub statement in the sub proofs.
     * @return Term that represents the statement to be proved in the current sub proof.
     */
    @Override
    public Term initFormula(Term beginFormula, Term proof){
        if (proof instanceof TypedTerm)
          return proof.type();
        else
          return new App(new App(new Const(0,"="),new Const(-1,"T")),proof).abstractEq(null);//new App(new App(new Const(5,"c_{5}"),new App(new App(new Const(2,"c_{2}"),beginFormula),new App(new Const(7,"c_{7}"),new Const(8,"c_{8}")))) ,new App(new App(new Const(2,"c_{2}"), beginFormula),new Const(8,"c_{8}")));
    }
    
    /**
     * This function will only be correct if called when using a linear recursive method.
     * It will return a new proof tree in case it finds out that the last inference
     * caused the whole proof to be correct under the sub-proof method. In other case it will return 
     * the proof given as argument.
     * 
     * @param user
     * @param formulaBeingProved: Formula that the user is trying to prove in this proof/sub-proof 
     *        formulaBeingProved is not the result of initFormula or the current statement to proof
     *        in this sub-proof. Instead formulaBeingProved is the argument formula of initFormula 
     *        to produce de current statement to proof in this sub-proof
     * @param proof: The proof tree so far
     * @return proof of formulaBeingProved if finished, else return the same proof
     */
    @Override
    public Term finishedLinearRecursiveMethodProof(String user, Term formulaBeingProved, Term proof) {
        try {
            Term st = proof.type();
            Term cases = ((App)((App)st).q.body()).q;
            Term implcations = ((App)((App)((App)st).q.body()).p).q;
            ArrayList<Term> arr = new ArrayList<Term>();
            ArrayList<Term> arr2 = new ArrayList<Term>();
            Term aux = implcations;
            while (((App)((App)aux).p).p instanceof Const && 
                    ((Const)((App)((App)aux).p).p).getId() == 5 ) {
              arr.add(((App)((App)aux).q).q);
              aux = ((App)((App)aux).p).q;
            }
            arr.add(((App)aux).q);
            String implDefSt = "";
            Term leibniz;
            Term finalProof = null;
            for (int z = 0; z < arr.size(); z++) {
              if (0==z) {
                leibniz = new Var(-126);
                implDefSt = "(I^{[x_{113},x_{112} := "+((App)formulaBeingProved).q.body()+","+arr.get(z)+"]} A^{= (\\Phi_{cbb} c_{7} \\Phi_{bb} c_{4}) (\\Phi_{bb} \\Phi_{b} c_{2})})";
              } else if (0>z)
                leibniz = new App(new App(new Const(2,"c_{2}"),((App)formulaBeingProved).q.body()),arr.get(0));
              else
                leibniz = arr2.get(0);
              int i = 1;
              while (i < arr.size()) {
                Term implAux;
                if (i==z) {
                  implAux = new Var(-126);
                  implDefSt = "(I^{[x_{113},x_{112} := "+((App)formulaBeingProved).q.body()+","+arr.get(z)+"]} A^{= (\\Phi_{cbb} c_{7} \\Phi_{bb} c_{4}) (\\Phi_{bb} \\Phi_{b} c_{2})})";
                }
                else if (i>z)
                  implAux = new App(new App(new Const(2,"c_{2}"),((App)formulaBeingProved).q.body()),arr.get(i));
                else
                  implAux = arr2.get(i);
                leibniz = new App(new App(new Const(5,"c_{5}"),implAux),leibniz); 
                i++;
              }
              Term implDef = CombUtilities.getTerm(implDefSt, user, simboloManager);
              arr2.add(z, ((App)((App)implDef.type()).p).q.body());
              leibniz = CombUtilities.getTerm("L^{\\lambda x_{-126}.c_{5} ("+leibniz+") ("+cases+")} ", user, simboloManager);
              finalProof = (finalProof==null?new TypedApp(leibniz,implDef):new TypedApp(finalProof,new TypedApp(leibniz,implDef)));
            }
            String absorptionProofSt = "(I^{[x_{113},x_{112} := "+((App)formulaBeingProved).q.body()+","+arr.get(0)+"]} A^{= (\\Phi_{bb} \\Phi_{b} c_{5}) (\\Phi_{cbb} c_{7} (\\Phi_{(bbb,)} c_{5}) c_{4})})";
            String transProofSt = "I^{[x_{102},x_{101} := c_{5} ("+((App)formulaBeingProved).q.body()+") ("+cases+"),c_{5} (c_{2} ("+((App)formulaBeingProved).q.body()+") ("+cases+")) ("+cases+")]} A^{= (\\Phi_{K} (\\Phi_{K} (\\Phi_{K} T))) (\\Phi_{c(ccb,)} c_{1} c_{1} (\\Phi_{(bbb,b)} c_{2}) \\Phi_{(cbbb,b)})}";
            Term absorptionProof = CombUtilities.getTerm(absorptionProofSt,user,TypedA.sm_);
            finalProof = new TypedApp(finalProof,absorptionProof);
            return finalProof;
             
        } catch (TypeVerificationException e)  {
            Logger.getLogger(GenericProofMethod.class.getName()).log(Level.SEVERE, null, e); 
        }
        return proof;
    }
}