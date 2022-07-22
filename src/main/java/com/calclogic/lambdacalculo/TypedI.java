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
public class TypedI extends Const implements TypedTerm{
    
    private final Sust instantiation_;
    private final String combDBType_;
    
    public TypedI(Sust instantiation)
    {
        super("I");
        instantiation_ = instantiation;
        combDBType_ = instantiation.toStringFinal();
    }

   public Term type()
   {
       return instantiation_;
   }
   
    public String getCombDBType() {
        return combDBType_;
    }
   
   public Sust getInstantiation() {
	   return this.instantiation_;
   }
}
