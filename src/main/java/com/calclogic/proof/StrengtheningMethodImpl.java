package com.calclogic.proof;

import com.calclogic.lambdacalculo.App;
import com.calclogic.lambdacalculo.Term;
import org.springframework.stereotype.Service;

/**
 *
 * @author ronald
 */
@Service
public class StrengtheningMethodImpl extends WeakeningMethodImpl implements StrengtheningMethod{

    public StrengtheningMethodImpl(){
        setInitVariables("ST");
    }

    /**
     * Indicates the header that a proof that starts with strengthening method must have.
     *  
     * @param nTeo: Number of the theorem to be proved, expressed in a string
     * @return The header message to be added to the proof
     */
    @Override
    public String header(String nTeo, Term beginFormula){
        return "By strengthening method<br>";
    }
    
    /**
     * This function delete the last part of the proof depends of the method
     * 
     * @param proof: The current proof
     * @return proof without the last part of the proof that finish the proof
     */
    public Term deleteFinishProof(Term proof) {
        return null;
    }
}