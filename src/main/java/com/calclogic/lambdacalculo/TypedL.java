/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.calclogic.lambdacalculo;

/**
 *
 * @author federico
 */
public class TypedL extends Const implements TypedTerm{
    
    private final Bracket lambda_;
    private final String combDBType_;
    
    public TypedL(Bracket lambda)
    {
        super("L");
        lambda_ = lambda;
        combDBType_ = lambda.toStringFinal();
    }
    
    public Term type()
    {
        return lambda_;
    }
    
    public String getCombDBType() {
        return combDBType_;
    }
}
