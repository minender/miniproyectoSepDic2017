/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.calclogic.lambdacalculo;

import com.calclogic.service.SimboloManager;
import java.util.ArrayList;
import java.util.Collection;
import java.util.HashSet;
import java.util.List;
import java.util.Objects;
import java.util.Stack;

/**
 *
 * @author federico
 */
public class Equation {
        
    Term t1;
    Term t2;
        
    public Equation(Term t1, Term t2) {
        this.t1 = t1;
        this.t2 = t2;
    }
        
    public boolean occur(Var x) {
        return t1.occur(x) || t2.occur(x);
    }
        
    public void union(Collection<Equation> l) {
        boolean breakk = false;
        for (Equation eq: l) {
            if (this.equals(eq)) {
                breakk = true;
                break;
            }
        }
        if (!breakk) 
            l.add(this);
    }
        
    private static boolean isVar(Term t, boolean bothSides) {
        return (t instanceof Var) && (bothSides || ((Var)t).indice > 0);
    }
    /**
     * Most General Unifier
     */
    public Sust mgu(SimboloManager s, boolean bothSides) {
        HashSet<Equation> set = new HashSet<Equation>();
        if (!bothSides) {
            t2 = t2.inverseVars();
        }
        set.add(this);
        List<Equation> auxSet = new ArrayList<Equation>();
        Stack<Term> uf1;
        Stack<Term> uf2;
        boolean transform = true;
        int i=0;
        while (i < 10000 && transform) {
            transform = false;
            for (Equation eq: set) {
                if (eq.t1.equals(eq.t2)) {
                    set.remove(eq);  
                    transform = true;
                    break;
                }
                /*else if (!(eq.t1 instanceof Var) && eq.t2 instanceof Var) {
                    Term aux;
                    set.remove(eq);
                    aux = eq.t1;
                    eq.t1 = eq.t2;
                    eq.t2 = aux;
                    eq.union(set);
                    transform = true;
                    break;
                }*/
                else if (eq.t1 instanceof Bracket && eq.t2 instanceof Bracket && 
                         ((Bracket)eq.t1).x.indice==((Bracket)eq.t2).x.indice ) {
                    set.remove(eq);
                    (new Equation(((Bracket)eq.t1).t,((Bracket)eq.t2).t)).union(set);
                    transform = true;
                    break;
                }
                else if ((uf1 = eq.t1.unfold(s))!=null && (uf2 = eq.t2.unfold(s))!=null &&
                                    uf1.pop().equals(uf2.pop())){
                    set.remove(eq);
                    while (!uf1.empty()) 
                         (new Equation(uf1.pop(),uf2.pop())).union(set);
                    transform = true;
                    break;
                }
                else if (Equation.isVar(eq.t1, bothSides) && (!bothSides || !eq.t2.occur((Var)eq.t1)) ) {
                    boolean occur = false;
                    auxSet.clear();
                    for (Equation eq2: set) {
                        if (eq2 != eq && eq2.occur((Var)eq.t1)) {
                            auxSet.add(eq2);
                            /*
                            List vars = new ArrayList<Var>();
                            List terms = new ArrayList<Var>();
                            vars.add((Var)eq.t1);
                            terms.add(eq.t2);
                            eq2.t1.sustParall(vars,terms);
                            */
                            //auxSet.add(new Equation(eq2.t1.sust((Var)eq.t1, eq.t2),eq2.t2));
                            //eq2.t2.sust((Var)eq.t1, eq.t2);
                            occur = true;
                        }
                    }
                    if (occur) {
                        for (Equation eq2: auxSet) {
                            set.remove(eq2);
(new Equation(eq2.t1.sust((Var)eq.t1,eq.t2),(bothSides?eq2.t2.sust((Var)eq.t1,eq.t2):eq2.t2))).union(set);
                        }
                        transform = true;
                        break;
                    }
                    /*else
                        transform = false;*/
                }
                else if (bothSides && eq.t2 instanceof Var && !(eq.t1 instanceof Var)//&&!eq.t1.occur((Var)eq.t2) 
                        ) {
                    Term left = eq.t1;
                    Term right = eq.t2;
                    set.remove(eq);
                    (new Equation(right,left)).union(set);
                    transform = true;
                    break;
                }
                else
                    transform = false;
            }
            i++;
        }
        if (!bothSides) {
            t2 = t2.inverseVars();
        }
        ArrayList<Var> vars = new ArrayList<Var>();
        List<Term> terms = new ArrayList<Term>();
        for (Equation eq: set) {
            if (Equation.isVar(eq.t1, bothSides) && !vars.contains(eq.t1) && (!bothSides||!eq.t2.occur((Var)eq.t1))) {
                vars.add((Var)eq.t1);
                terms.add(bothSides?eq.t2:eq.t2.inverseVars());
            }
            else
                return null;
        }
        if (!bothSides){
            ArrayList<Var> varsAux = new ArrayList<Var>();
            List<Term> termsAux = new ArrayList<Term>();
            for (int j=0; j<vars.size(); j++) {
                if (!vars.get(j).equals(terms.get(j))) {
                    varsAux.add(vars.get(j));
                    termsAux.add(terms.get(j));
                }
            }
            vars = varsAux;
            terms = termsAux;
        }
        return new Sust(vars,terms);
    }

    @Override
    public String toString() {
        return t1 + "=" + t2;
    }

    @Override
    public int hashCode() {
        int hash = 5;
        hash = 17 * hash + Objects.hashCode(this.t1);
        hash = 17 * hash + Objects.hashCode(this.t2);
        return hash;
    }

    @Override
    public boolean equals(Object obj) {
        if (this == obj) {
            return true;
        }
        if (obj == null) {
            return false;
        }
        if (getClass() != obj.getClass()) {
            return false;
        }
        final Equation other = (Equation) obj;
        if (!Objects.equals(this.t1, other.t1)) {
            return false;
        }
        if (!Objects.equals(this.t2, other.t2)) {
            return false;
        }
        return true;
    }

}