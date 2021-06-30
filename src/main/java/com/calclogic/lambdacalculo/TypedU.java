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
public class TypedU extends Const implements TypedTerm{
    
    public TypedU()
    {
        super("U");
    }
    
    public Term type()
    {
        return new Const("U");
    }
}
