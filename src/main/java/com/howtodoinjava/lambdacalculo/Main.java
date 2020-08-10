/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.howtodoinjava.lambdacalculo;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;
import org.apache.commons.lang3.text.StrSubstitutor;

/**
 *
 * @author federico
 */
public class Main {

    public static void main(String argss[]) 
    {
        int args = 1;
        String[] arr = {"p"};
        Map<String,String> values = new HashMap<String, String>();
        for (int i=0; i < args; i++)
            values.put("a"+(i+1),arr[i]);
        StrSubstitutor sub = new StrSubstitutor(values, "%(",")");
        System.out.println("\\neg %(a1)".contains("%(a1)"));
        String s = sub.replace("\\neg %(a1)");
        System.out.println(s);
        Term t = new Bracket(new Var(32),new App(new App(new Const("c_{1}"),new Var(32)),new Const("c_{8}")));
        System.out.println(t.traducBD().reducir().toStringFinal());
        /*ArrayList<Object> lisObj = new ArrayList<Object>();
        ArrayList<Term> lisTerm = new ArrayList<Term>();
        ArrayList<Var> lisVar = new ArrayList<Var>();


        MakeTerm mk = new MakeTerm();
        Term t2 = mk.makeTerm("p /\\ E_{(p == p)}^{q} ");
        Term t1 = mk.makeTerm("p  /\\  (p  \\/ (p  ==  p))");

        Term v = mk.makeTerm("(p \\/ Conj(p,q))");
        Term v1 = mk.makeCuant("(existsx|R:P) == (forallx|P:Q)");
        Term a = mk.makeApp("p", "r");*/
        
        //System.out.println(t1.toStringInFin());
        //System.out.println("+++++++++++++----------+++++++++++++++++");
        //System.out.println("++++++++++++++++++++++++++++++");
        //System.out.println(v.toStringInfFinal(null));
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