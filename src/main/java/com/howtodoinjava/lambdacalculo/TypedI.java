/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.howtodoinjava.lambdacalculo;

/**
 *
 * @author federico
 */
public class TypedI extends I{
    
    private final Sust instantiation_;
    
    public TypedI(Sust instantiation)
    {
        instantiation_ = instantiation;
    }

   public Term type()
   {
       return instantiation_;
   }
}
