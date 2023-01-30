package com.calclogic.global;

/**
 *
 * @author ronald
 */
public interface Information {

    /**
     * This function gives the latex notation of an operator, given its identifier as a number
     *
     * @param cNotation
     * @return The latex notation
     */
    public String operatorStrNotationFromId(Integer operatorId);
    
    /**
     * This function gives the latex notation of an operator written as C_{num}
     *
     * @param cNotation
     * @return The latex notation
     */
    public String operatorStrNotationFromCNotation(String cNotation);
}