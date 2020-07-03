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
public class TypedA extends Const implements TypedTerm{
    
    private final Term type_;
    
    public TypedA(Term type)
    {
        super("A");
        type_ = type;
    }
    
    public Term type()
    {
        return type_;
    }
}
