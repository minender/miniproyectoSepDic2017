package com.calclogic.proof;

import com.calclogic.lambdacalculo.App;
import com.calclogic.lambdacalculo.Sust;
import com.calclogic.lambdacalculo.Term;
import com.calclogic.lambdacalculo.TypeVerificationException;
import com.calclogic.lambdacalculo.TypedA;
import com.calclogic.lambdacalculo.TypedApp;
import com.calclogic.lambdacalculo.TypedI;
import com.calclogic.lambdacalculo.TypedM;
import com.calclogic.lambdacalculo.TypedS;
import com.calclogic.lambdacalculo.Var;
import com.calclogic.parse.CombUtilities;

import java.util.List;
import org.springframework.stereotype.Service;

/**
 *
 * @author ronald
 */
@Service
public class AndIntroductionMethodImpl extends GenericProofMethodImpl implements AndIntroductionMethod {

    public AndIntroductionMethodImpl(){
        setInitVariables("AI");
    }

    /**
     * Indicates the header that a proof that starts with and introduction
     * method must have.
     *  
     * @param statement: New statement that needs to be proved according to this method
     * @return The header message to be added to the proof
     */
    @Override
    public String header(String statement, Term beginFormula){
        return "By proof by parts method:<br><br>";
    }

    /**
     * Auxiliar method for "finishedBranchedRecursiveMethodProof" that implements the corresponding
     * logic according to the and introduction method.
     *
     * It will return a new proof tree that connects in one proof of P/\Q,
     * two independent sub proofs of P and Q
     *
     * @param user
     * @param originalTerm: The current proof  
     * @param vars: List of variables for doing parallel substitution
     * @param terms: List of terms for doing parallel substitution
     * @param finalProof: The proof of second sub proof
     * @return axiom tree that will later be used to build the complete proof
     * @throws com.calclogic.lambdacalculo.TypeVerificationException
     */
    @Override
    protected Term auxFinBranchedRecursiveMethodProof(String user, Term originalTerm, List<Var> vars, List<Term> terms, Term finalProof)
            throws TypeVerificationException
    {
        // This string says: (true == q) == q
        //String str = "= \\Phi_{} (\\Phi_{cb} c_{8} c_{1})";
        
        //Term st = CombUtilities.getTerm(str,null);

        // We make the formula above to be treated as an axiom
        //TypedA A = new TypedA(st, user);
        Term fProofType = finalProof.type();
        int[] c = new int[1];
        c[0] = 0;
        fProofType.setToPrinting(null,simboloManager,c);
        
        //finalProof pudo no haber terminado, por lo que puede ser una igualdad distinta de [q=T]
        if (!fProofType.containT())
           finalProof = new TypedM(5,c[0],finalProof,"= T c_{8}",user);
        else
           finalProof = new TypedM(3,c[0],finalProof,"= T c_{8}",user);

        // Substitution [q := lastLine]
        /*vars.add(0, new Var(113)); // Letter 'q'
        terms.add(0,finalProof.type().setToPrint(simboloManager));
        Sust sus = new Sust(vars, terms);*/

        // We give the instantiation format to the substitution above
        //TypedI I = new TypedI(sus);

        //Term auxiliarTree = new TypedApp(new TypedApp(new TypedS(),new TypedApp(I,A)),finalProof);
        Term auxiliarTree = new TypedApp(new TypedS(),finalProof);

        Term firstProof = ((App)originalTerm).q;
        Term firstStAndTrue = ((App)((App)originalTerm).p).p;
        Term leibniz = ((App)((App)((App)originalTerm).p).q).p;

        return new TypedApp(new TypedApp(firstStAndTrue,new TypedApp(leibniz,auxiliarTree)),firstProof);
    }
}