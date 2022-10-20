package com.calclogic.proof;

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
    public String header(String nTeo){
        return "By strengthening method<br>";
    }
}