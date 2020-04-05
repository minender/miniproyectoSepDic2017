/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.howtodoinjava.lambdacalculo;

import java.sql.Array;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.Queue;
import java.util.Stack;

/**
 *
 * @author shamuel
 */
public class Comprobacion {
    
    public Comprobacion() {
    }    

    public String dfs(Term t){
        String st = "";
        Stack<Term> pila = new Stack<Term>();
        pila.push(t);
        while (!pila.isEmpty()) {
            Term actual = pila.pop();
            if (actual instanceof Var) {
               st = st + actual.toStringInf(null,"") + ",";
            }
            else if (actual instanceof App) {
              pila.push(((App)actual).q);
              pila.push(((App)actual).p);
            }
        } 
        return st;
    }
}