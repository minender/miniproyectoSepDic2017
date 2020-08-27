/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.howtodoinjava.lambdacalculo;

import com.howtodoinjava.service.PredicadoManager;
import com.howtodoinjava.service.SimboloManager;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author shamuel
 */
public class Sust extends Term{
    
    final List<Var> vars;
    final List<Term> terms;

    public Sust(List<Var> vars, List<Term> terms) {
        this.vars = vars;
        this.terms = terms;
    }

    public List<Var> getVars() {
        return vars;
    }

    public List<Term> getTerms() {
        return terms;
    }

    public boolean occur(Var x)
    {
        return false;
    }
    
    public String position(Var x) {
        return "3";
    }
    
    @Override
    public Term subterm(String position) {
        if (position.equals(""))
           return this;
        else
           return null;
    }
    
    public Term sust(Var x,Term t)
    {
        return this;
    }  
    
    public Term type()
    {
        return null;
    }
    
    public boolean containTypedA()
    {
        return false;
    }
    
    public Term leibniz(int z, Term subterm)
    {
       if (this == subterm)
           return new Var(z);
       else
       {
           List<Term> list = new ArrayList();
           for (Term t: terms)
               list.add(t.leibniz(z, subterm));
           return new Sust(vars,list);
       }
    }
    
    public int setAlias(int currentAlia)
    {
        if(alias != null)
        {
            alias = alias+"@"+currentAlia;
            currentAlia++;
        }
        
        return currentAlia;
    }
 
    public int maxVar()
    {
        return -1;
    }
    
    public Tipo esRedex()
    {
        return new Tipo(false,false);
    }
    
    public Tipo esRedexFinal()
    {
        return new Tipo(false,false,false);
    }
    
    public Redex buscarRedexIzq(Term contexto,boolean p)
    {
        return null;
    }
    
    public Redex buscarRedexIzqFinal(Term contexto,boolean p)
    {
        return null;
    }
    
    public Term traducBD()
    {
        return this;
    }
    
    public List<Term> contandotraducBD()
    {
        List<Term> list=new ArrayList<Term>();
        
        return list;
    }
    
    public Term invBraBD()
    {
        return null;
    }
    
    public Term invBD()
    {
        return null;
    }
    
    public Term invBDOneStep()
    {
        return null;
    }
    
    public Term bracketAbsBD(Var x)
    {
        return new App(new Const("\\Phi_{K}"),this);
    }
    
    public Term bracketAbsSH(Var x)
    {
        return new App(new Const("K"),this);
    }
    
    public String toString()
    {
        String varss = "";
        String termss = "";
        for (Var v : vars)
            varss += v.toString()+",";
        
        for (Term t : terms)
            termss += t.toString()+",";
        
        varss = varss.substring(0, varss.length()-1);
        termss = termss.substring(0, termss.length()-1);
        
        return "["+varss+" := "+termss+"]";
    }
    
    @Override
    public String toStringInf(SimboloManager s,String numTeo) {
        String varss = "";
        String termss = "";
        for (Var v : vars)
            varss += v.toStringInf(s,"")+",";
        
        for (Term t : terms)
            termss += t.reducir().toStringInfFinal(s)+",";
        
         varss = varss.substring(0, varss.length()-1);
         termss = termss.substring(0, termss.length()-1);
        
        return varss+" := "+termss;
    }
    
    @Override
    public String toStringInfLabeled(SimboloManager s,int z, Term init, List<Term> leibniz, List<String> leibnizL, Id id, int nivel){
        id.id++;
        String varss = "";
        String termss = "";
        for (Var v : vars)
            varss += v.toStringInf(null,"")+",";
        
        for (Term t : terms)
            termss += t.reducir().toStringInf(null,"")+",";
        
         varss = varss.substring(0, varss.length()-1);
         termss = termss.substring(0, termss.length()-1);
         leibniz.add(init.leibniz(z, this));
//         leibniz.add(init.leibniz(z, this).toStringInfFinal(null).replace("\\", "\\\\"));
//         leibnizL.add(init.leibniz(z, this).toStringInf(s,"").replace("\\", "\\\\"));
        
        return "\\cssId{"+(id.id-1)+"}{\\class{"+nivel+" terminoClick}{["+varss+" := "+termss+"]}}";
    }

    @Override
    public String toStringFormatC(SimboloManager s, String pos, int id)
    {
        return toString();
    }
    /*public String toStringInFin() {
        String varss = "";
        String termss = "";
        for (Var v : vars)
            varss += v.toStringInFin()+",";
        
        for (Term t : terms)
            termss += t.toStringInFin()+",";
        
         varss = varss.substring(0, varss.length()-1);
         termss = termss.substring(0, termss.length()-1);
        
        return "["+varss+" := "+termss+"]";
    }*/
    
    @Override
    public String toStringWithInputs(SimboloManager s, String position) {
        String varss = "";
        String termss = "";
        for (Var v : vars)
            varss += v.toStringInf(s,"")+",";
        
        for (Term t : terms)
            termss += t.reducir().toStringInfFinal(s)+",";
        
         varss = varss.substring(0, varss.length()-1);
         termss = termss.substring(0, termss.length()-1);
        
        return "["+varss+" := "+termss+"]";
    }
    
    public ToString toStringAbrvV1(ToString toString)
    {
        toString.term=this.toString();
        return toString;
    }
    
    public ToString toStringAbrv(ToString toString)
    {
        toString.term=this.toString();
        return toString;
    }
    
    @Override
    public ToString toStringInfAbrv(ToString toString, SimboloManager s, PredicadoManager pm, 
                                    String nTeo)
    {
        toString.term=this.toStringInf(s,"");
        return toString;
    }

    @Override
    public int hashCode() {
        int hash = 7;
        return hash;
    }

    @Override
    public boolean equals(Object obj) {
        if (obj == null) {
            return false;
        }
        if (getClass() != obj.getClass()) {
            return false;
        }
        final Sust other = (Sust) obj;
        if (this.vars != other.vars && (this.vars == null || !this.vars.equals(other.vars))) {
            return false;
        }
        if (this.terms != other.terms && (this.terms == null || !this.terms.equals(other.terms))) {
            return false;
        }
        return true;
    }
    
    @Override
    protected Object clone() throws CloneNotSupportedException{
        return this;
    }

    @Override
    public Term sustParall(List<Var> Vars, List<Term> varsTerm) {
        return this;
    }

    @Override
    public Term checkApp() {
        /**List<Var> varss = ((Sust) termAux).vars;
        List<Term> termss = ((Sust) termAux).terms;             
        return this.sustParall((ArrayList<Var>) varss , (ArrayList<Term>) termss);
        * */
        return this;
    }
    
    @Override
	public String aliases(String position) {
		
		return "";
	}
    
}
