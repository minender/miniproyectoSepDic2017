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
         
         
    public String bfs(Term t){
        Stack<Term> pila = new Stack<Term>();
        pila.push(t);
        HashSet<Term> visitados = new HashSet<Term>();
        while (!pila.isEmpty()) {
              Term actual = pila.pop();
              if (!visitados.contains(actual)) {
                    visitados.add(actual);
                    ArrayList<Term> arrayList = new ArrayList<Term>();
                    if ( actual instanceof App){
                        arrayList.add(((App)actual).p);
                        arrayList.add(((App)actual).q );
                    }else if(actual instanceof Var){
                        return actual.toStringInf();
                    }
                    for (Term n : arrayList) {
                        pila.push(n);
                  }
              }
        } 
        return "";
                
    }

    
    
    
 



    
}
