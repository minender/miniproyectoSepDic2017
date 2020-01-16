/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.howtodoinjava.lambdacalculo;

/**
 *
 * @author federico
 */
public class SK extends Z{
    
    S s;
    K k;
    
    public SK(){
        s=new S();
        k=new K();
    }
    
    public String toString(){
        return "{"+s.toString()+","+k.toString()+"}";
    }
    
}
