package com.calclogic.global;

import org.springframework.stereotype.Service;
import org.springframework.beans.factory.annotation.Autowired;

/**
 *
 * @author ronald
 */
@Service
public class InformationImpl implements Information {
    
    // Operators of the database
    private String o1;
    private String o2;
    private String o3;
    private String o4;
    private String o5;
    private String o6;
    private String o7;
    private String o8;
    private String o9;
    private String o15;

    public String getO1() {
        return o1;
    }

    public void setO1(String o1) {
        this.o1 = o1;
    }

    public String getO2() {
        return o2;
    }

    public void setO2(String o2) {
        this.o2 = o2;
    }

    public String getO3() {
        return o3;
    }

    public void setO3(String o3) {
        this.o3 = o3;
    }

    public String getO4() {
        return o4;
    }

    public void setO4(String o4) {
        this.o4 = o4;
    }

    public String getO5() {
        return o5;
    }

    public void setO5(String o5) {
        this.o5 = o5;
    }

    public String getO6() {
        return o6;
    }

    public void setO6(String o6) {
        this.o6 = o6;
    }

    public String getO7() {
        return o7;
    }

    public void setO7(String o7) {
        this.o7 = o7;
    }

    public String getO8() {
        return o8;
    }

    public void setO8(String o8) {
        this.o8 = o8;
    }

    public String getO9() {
        return o9;
    }

    public void setO9(String o9) {
        this.o9 = o9;
    }

    public String getO15() {
        return o15;
    }

    public void setO15(String o15) {
        this.o15 = o15;
    }

    @Autowired
    public InformationImpl() {}

    /**
     * This function gives the latex notation of an operator, given its identifier as a number
     *
     * @param operatorId
     * @return The latex notation
     */
    @Override
    public String operatorStrNotationFromId(Integer operatorId){
        switch(operatorId){
            case 1:
                return o1;
            case 2:
                return o2;
            case 3:
                return o3;
            case 4:
                return o4;
            case 5:
                return o5;
            case 6:
                return o6;
            case 7:
                return o7;
            case 8:
                return o8;
            case 9:
                return o9;
            case 15:
                return o15;
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