package com.calclogic.global;

import org.springframework.stereotype.Service;

/**
 *
 * @author ronald
 */
@Service
public class InformationImpl implements Information {


    /**
     * This function gives the latex notation of an operator, given its identifier as a number
     *
     * @param cNotation
     * @return The latex notation
     */
    @Override
    public String operatorStrNotationFromId(Integer operatorId){
        switch(operatorId){
            case 1:
                return "equiv";
            case 2:
                return "Rightarrow";
            case 3:
                return "Leftarrow";
            case 4:
                return "vee";
            case 5:
                return "wedge";
            case 6:
                return "not equiv";
            case 7:
                return "neg";
            case 8:
                return "true";
            case 9:
                return "false";
            case 15:
                return "=";
            default:
                return "";
        }
    }

    /**
     * This function gives the latex notation of an operator written as C_{num}
     *
     * @param cNotation
     * @return The latex notation
     */
    @Override
    public String operatorStrNotationFromCNotation(String cNotation){
        // We must extract the number (the id) from the cNotation
        return this.operatorStrNotationFromId(Integer.parseInt(cNotation.split("\\{")[1].split("\\}")[0]));
    }
}