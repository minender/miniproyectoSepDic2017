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
public class TypedL extends Const{
    
    private final Bracket lambda_;
    
    public TypedL(Bracket lambda)
    {
        super("L");
        lambda_ = lambda;
    }
    
    public Term type()
    {
        return lambda_;
    }
}
