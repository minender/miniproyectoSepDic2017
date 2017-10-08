/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.howtodoinjava.lambdacalculo;

import java.util.ArrayList;
import java.util.List;

/**
 *
 * Term v = mk.makeTerm("E_{p==p}^{q}");
         Term t0 = mk.makeTerm("r==q");
         Term a = mk.makeApp("p","r");
         boolean boo = v instanceof App;
         System.out.println("");
         if (v instanceof App) {
             Term termAux = ((App) v).q;
             
             if (termAux instanceof Sust){
                 System.out.println(t0.toStringInf());
                 System.out.println(true);
                 List<Var> varss = ((Sust) termAux).vars;
                 List<Term> termss = ((Sust) termAux).terms;             
                 t0 = t0.sustParall( (ArrayList<Var>) varss , (ArrayList<Term>) termss  );
                 System.out.println(t0.toStringInf());
                 System.out.println("-----------------------------");
                 System.out.println(t0.toString());
             }
         }
 * @author shamuel
 */
public class Check {

    public Check() {
    }
    
    public  boolean checkSustBool(Term v){
        boolean bool = false; 
         if (v instanceof App) {
             Term termAux = ((App) v).q;
             if (termAux instanceof Sust){
                 bool = true;
             }
         }    
        return bool;
    }
    
    public Term checkSust(Term v){
        if (v instanceof App) {
             Term termAux = ((App) v).q;
             if (termAux instanceof Sust){
                 List<Var> varss = ((Sust) termAux).vars;
                 List<Term> termss = ((Sust) termAux).terms;             
                 v = v.sustParall((ArrayList<Var>) varss , (ArrayList<Term>) termss);
             }
         }
        return v;
    }
    
}
