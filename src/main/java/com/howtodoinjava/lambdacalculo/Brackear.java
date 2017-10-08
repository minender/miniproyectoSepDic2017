/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.howtodoinjava.lambdacalculo;


import java.util.ArrayList;


/**
 *
 * @author shamuel
 */
public class Brackear {

    public Brackear() {
    }
    
    public Term appBrack(ArrayList<String> vars, Term term){
        MakeTerm mk = new MakeTerm();
        
        for(int i = vars.toArray().length -1;  0 <= i ; i--){
            term = new Bracket((Var) mk.makeTerm(vars.get(i).toString()), term);     
        }  
        return term;
    }
        
    
    public ArrayList<Var>  listVars(ArrayList<String>  vars){

        ArrayList<Var> auxList = new ArrayList<Var>();
        MakeTerm mk = new MakeTerm();

        for(int i = vars.toArray().length -1;  0 <= i ; i--){
            auxList.add((Var) mk.makeTerm(vars.get(i).toString()));
        }  

        return auxList;

    }    
    
    
    public boolean check(Term t){
         if (t instanceof App) {
                System.out.println("a");
              
            }    else if (t instanceof Bracket) {
                                    System.out.println("b");

                    
               }else if(t instanceof Const){
                    
                                    System.out.println("c");

                    
                }else{
                                System.out.println("ulti");

                }       
        return true;
    }

}
