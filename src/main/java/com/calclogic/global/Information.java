package com.calclogic.global;

/**
 *
 * @author ronald
 */
public interface Information {

    /**
     * This function gives the latex notation of an operator, given its identifier as a number
     *
     * @param operatorId
     * @return The latex notation
     */
    public String operatorStrNotationFromId(Integer operatorId);

    /**
     * This function gives the id of an operator written as C_{num}
     *
     * @param cNotation
     * @return The id of the operator
     */
    public Integer operatorIdFromCNotation(String cNotation);
    
    /**
     * This function gives the latex notation of an operator written as C_{num}
     *
     * @param cNotation
     * @return The latex notation
     */
    public String operatorStrNotationFromCNotation(String cNotation);

    /**
     * Determines if an operator is an implication or a consequence,
     * given its id.
     *
     * @param operatorId
     * @return The boolean result
     */
    public Boolean idIsImplicationOrConsequence(Integer operatorId);

    /**
     * Determines if an operator, written as C_{num}, is an implication or a consequence,
     *
     * @param cNotation
     * @return The boolean result
     */
    public Boolean cNotationIsImplicationOrConsequence(String cNotation);
}