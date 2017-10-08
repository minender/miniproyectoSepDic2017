/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.howtodoinjava.lambdacalculo;

/**
 *
 * @author federico
 */
public class SKI extends SK{
    
    Ii i;
    
    public SKI(){
        super();
        i=new Ii();
    }
    
    public String toString(){
        return "{"+s.toString()+","+k.toString()+","+i.toString()+"}";
    }
    
}
