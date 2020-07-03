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
public class TypedS extends Const implements TypedTerm{
    
    private final Term simetry_;
    
    public TypedS(Term simetry) throws TypeVerificationException, ClassCastException
    {
        super("S");
        String con = ((Const)((App)((App)simetry).p).p).getCon().trim();
        int id = ((Const)((App)((App)simetry).p).p).getId();
        if (!con.equals("c_{1}") && !con.equals("c_{10}"))
           throw new TypeVerificationException();
        Term t1 = ((App)simetry).q;
        Term t2 = ((App)((App)simetry).p).q;
        simetry_ = new App(new App(new Const(1,"c_{1}",false,1,1),
                   new App(new App(new Const(id,con,false,1,1),t1),t2)),simetry);
    }
    
    public TypedS(Term simetry, int i) throws TypeVerificationException, ClassCastException
    {
        super("S");
        simetry_ = simetry;
    }
    
    public Term type()
    {
        return simetry_;
    }
}
