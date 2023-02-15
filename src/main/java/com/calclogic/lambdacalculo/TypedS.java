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
public class TypedS extends Const implements TypedTerm{
    
    private Term simmetry_;
    
    public TypedS(Term simmetry) throws TypeVerificationException, ClassCastException{
        super("S");
        String con = ((Const)simmetry.dsc("11")).getCon().trim();
        int id = ((Const)simmetry.dsc("11")).getId();
        if (!con.equals("="))
           throw new TypeVerificationException();
        Term t1 = simmetry.dsc("2");    
        Term t2 = simmetry.dsc("12");
        simmetry_ = new App(new App(new Const(1,"c_{2}",false,1,1),
                   new App(new App(new Const(id,con,false,1,1),t1),t2)),simmetry);
    }
    
    public TypedS(Term simmetry, int i) throws TypeVerificationException, ClassCastException{
        super("S");
        simmetry_ = simmetry;
    }
    
    public TypedS() throws TypeVerificationException, ClassCastException{
        super("S");
        simmetry_ = null;
    }

    public void setSimetry(Term simmetry) {
        simmetry_ = simmetry;
    }
    
    public Term type(){
        return simmetry_;
    }
    
    public String getCombDBType(){
        return simmetry_.toString();
    }
}
