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
public class TypedS extends Const{
    
    private final Term simetry_;
    
    public TypedS(Term simetry)
    {
        super("S");
        simetry_ = simetry;
    }
    
    public Term type()
    {
        return simetry_;
    }
}
