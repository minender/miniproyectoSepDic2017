/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.calclogic.lambdacalculo;

import com.calclogic.parse.CombUtilities;

/**
 *
 * @author feder
 */
public class TypedMApp extends TypedApp implements TypedTerm{
 
    private Term proof_;
    
    public TypedMApp(Term t) throws TypeVerificationException{
        super(((App)t).p,((App)t).q);
        String l = ((App)((App)super.type()).p).q.body().toStringFinal();
        Term aux = CombUtilities.getTerm("L^{\\lambda x_{122}. c_{1} ("+l+") x_{122}}",null);
        aux = new TypedApp(aux,t);
        proof_ = CombUtilities.getTerm("I^{[x_{112}:="+l+"]} A^{= T (c_{1} x_{112} x_{112})}", null);
        proof_ = new TypedApp(aux,proof_);
    }
    
    public String toString() {
        return "(M_{1} "+super.toString()+")";
    }
    
    public Term type() {
        return proof_.type();
    }
}
