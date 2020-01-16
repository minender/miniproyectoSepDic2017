/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.howtodoinjava.lambdacalculo;

/**
 *
 * @author federico
 */
public class SKICB extends SKI{
    
    C c;
    B b;
    
    public SKICB(){
        super();
        c=new C();
        b=new B();
    }
    
    public String toString(){
        return "{"+s.toString()+","+k.toString()+","+i.toString()
                +c.toString()+","+b.toString()+"}";
    }
    
}
