/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.calclogic.lambdacalculo;

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
        Stack<Term> pila = new Stack<>();
        pila.push(t);
        while (!pila.isEmpty()) {
            Term actual = pila.pop();
            if (actual instanceof Var) {
               st = st + actual.toStringLaTeX(null,"") + ",";
            }
            else if (actual instanceof App) {
              pila.push(actual.dsc("2"));
              pila.push(actual.dsc("1"));
            }
        } 
        return st;
    }
}