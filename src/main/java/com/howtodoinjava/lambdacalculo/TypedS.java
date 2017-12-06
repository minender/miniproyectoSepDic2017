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
    
    public TypedS(Term simetry) throws TypeVerificationException, ClassCastException
    {
        super("S");
        if (!((Const)((App)((App)simetry).p).p).getCon().trim().equals("\\equiv"))
           throw new TypeVerificationException();
        Term t1 = ((App)simetry).q;
        Term t2 = ((App)((App)simetry).p).q;
        simetry_ = new App(new App(new Const("\\equiv ",false,1,1),
                   new App(new App(new Const("\\equiv ",false,1,1),t1),t2)),simetry);
    }
    
    public Term type()
    {
        return simetry_;
    }
}
