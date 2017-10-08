/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.howtodoinjava.lambdacalculo;

import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author federico
 */
public class Main {

    public static void main(String args[]) 
    {
        ArrayList<Object> lisObj = new ArrayList<Object>();
        ArrayList<Term> lisTerm = new ArrayList<Term>();
        ArrayList<Var> lisVar = new ArrayList<Var>();


        MakeTerm mk = new MakeTerm();
        Term t2 = mk.makeTerm("p /\\ E_{(p == p)}^{q} ");
        Term t1 = mk.makeTerm("p  /\\  (p  \\/ (p  ==  p))");

        Term v = mk.makeTerm("(p \\/ Conj(p,q))");
        Term v1 = mk.makeCuant("(existsx|R:P) == (forallx|P:Q)");
        Term a = mk.makeApp("p", "r");
        
        //System.out.println(t1.toStringInFin());
        //System.out.println("+++++++++++++----------+++++++++++++++++");
        //System.out.println("++++++++++++++++++++++++++++++");
        System.out.println(v.toStringFinalInFin());
        //System.out.println(v1.toString());
        //System.out.println(v1.toStringInFin());
        //System.out.println("++++++++++++---------------++++++++++++++++++");
        //System.out.println("++++++++++++++++++++++++++++++");
        //System.out.println(t1.toStringInf());
        //System.out.println("++++++++++++---------------++++++++++++++++++");
        //System.out.println("++++++++++++++++++++++++++++++");       
        
        
       /*ArrayList<Object> arr =  mk.makeInsta("E := p\\/q");         
       t2 = t2.sustParall((ArrayList<Var>)arr.get(0),(ArrayList<Term>) arr.get(1));
       System.out.println(t2.toString());
       
       System.out.println("++++++++++++++++++++++++++++++");
        System.out.println("++++++++++++++++++++++++++++++");
        Term t6 = t2.checkApp();
        System.out.println(t6.toStringInf());
        System.out.println("++++++++++++++++++++++++++++++");
        System.out.println(t6.toString());
         */
         
    }


}