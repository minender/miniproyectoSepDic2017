/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.calclogic.lambdacalculo;

import com.calclogic.service.PredicadoManager;
import com.calclogic.service.ResuelveManager;
import com.calclogic.service.SimboloManager;
import java.util.ArrayList;
import java.util.HashSet;
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
        type_ = null;
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
    
    public Term sustWithoutClone(Var x,Term t) {
        return this;
    }
    
    public Term type()
    {
        return null;
    }
    
    public int nPhi()
    {
        return 0;
    }
    
    public boolean containTypedA()
    {
        return false;
    }
    
    public boolean containT()
    {
        return false;
    }
    
    public void getAxioms(List<String> l)
    {
        ;
    }
    
    public Term leibniz(int z, String subtermId, String thisId, SimboloManager s)
    {
       if (thisId.equals(subtermId))
           return new Var(z);
       else
       {
           List<Term> list = new ArrayList();
           for (Term t: terms)
               list.add(t.leibniz(z, subtermId, thisId, s));
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
    
    public int fresh(int n, int[] max)
    {
        return n;
    }
    
    public int absoluteFresh(int n, int[] max)
    {
        return n;
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
    
    public Term traducBD(List<String> l)
    {
        return this;
    }
    
    public List<Term> contandotraducBD()
    {
        List<Term> list=new ArrayList<Term>();
        
        return list;
    }
    
    public Term deleteLambdAtZScope(Var z) {
        return this;
    }
    
    public Term invBraBD(Var x)
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
    
    @Override
    public Term etaReduc() {
        return this;
    }
    
    public String toStringAll()
    {
        String varss = "";
        String termss = "";
        for (Var v : vars)
            varss += v.toStringAll()+",";
        
        for (Term t : terms)
            termss += t.toStringAll()+",";
        
        varss = varss.substring(0, varss.length()-1);
        termss = termss.substring(0, termss.length()-1);
        
        return "["+varss+" := "+termss+"]";
    }
    
    @Override
    public String toStringLaTeX(SimboloManager s,String numTeo,List transOp) {
        String varss = "";
        String termss = "";
        for (Var v : vars)
            varss += v.toStringLaTeX(s,"",null)+",";
        
        for (Term t : terms)
            termss += t.reducir().toStringLaTeX(s,"",null)+",";
        
         varss = varss.substring(0, varss.length()-1);
         termss = termss.substring(0, termss.length()-1);
        
        return varss+" := "+termss;
    }
    
    @Override
    public String toStringLaTeXLabeled(SimboloManager s,int z, Term init, String appPosition, List<Term> leibniz, List<String> leibnizL, Id id, int nivel){
        id.id++;
        String varss = "";
        String termss = "";
        for (Var v : vars)
            varss += v.toStringLaTeX(null,"",null)+",";
        
        for (Term t : terms)
            termss += t.reducir().toStringLaTeX(null,"",null)+",";
        
        varss = varss.substring(0, varss.length()-1);
        termss = termss.substring(0, termss.length()-1);
        leibniz.add(init.leibniz(z, leibnizL.get(leibnizL.size()-1), "", s));
        
        return "\\cssId{"+(id.id-1)+"}{\\class{"+nivel+" terminoClick}{["+varss+" := "+termss+"]}}";
    }

    @Override
    public String toStringFormatC(SimboloManager s, String pos, int id, String rootId)
    {
        return toStringAll();
    }

    
    @Override
    public String toStringLaTeXWithInputs(SimboloManager s, String position, String rootId) {
        String varss = "";
        String termss = "";
        for (Var v : vars)
            varss += v.toStringLaTeX(s,"",null)+",";
        
        for (Term t : terms)
            termss += t.reducir().toStringLaTeXFinal(s)+",";
        
         varss = varss.substring(0, varss.length()-1);
         termss = termss.substring(0, termss.length()-1);
        
        return "["+varss+" := "+termss+"]";
    }
    
    public ToString toStringAbrvV1(ToString toString)
    {
        toString.term=this.toStringAll();
        return toString;
    }
    
    public ToString toStringAbrv(ToString toString)
    {
        toString.term=this.toStringAll();
        return toString;
    }
    
    @Override
    public ToString toStringLaTeXAbrv(ToString toString, SimboloManager s, PredicadoManager pm, 
                                    String nTeo, List transOp)
    {
        toString.term=this.toStringLaTeX(s,"",null);
        return toString;
    }

    public String toStringType(String v) {
        return "NULL";
    }
    
    public String printType() {
        return "";
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
    public Term inverseVars() {
        List<Var> vars2 = new ArrayList<Var>();
        List<Term> terms2 = new ArrayList<Term>();
        for (int i=0; i < vars.size(); i++)  {
            vars2.add(i,(Var)vars.get(i).inverseVars());
            terms2.add(i, terms.get(i).inverseVars());
        }
        return new Sust(vars2, terms2);
    }
    
    @Override
    public void freeVars(int[] set){
        for(Term li: terms)
            li.freeVars(set);
    }
    
    @Override
    public void freeVars(int[] set, int[] index){
        for(Term li: terms) {
            li.freeVars(set, index);
        }
    }
    
    @Override
    public String stFreeVarsWithAnyIndex(String st) {
        for(Term li: terms) {
           st = li.stFreeVarsWithAnyIndex(st);
        }
        return st;
    }
    
    @Override
    public void boundVars(String[] vars) {
        ;
    }
    
    @Override
    public Term replaceConstByVars() {
        return this;
    }
    
    @Override
    public Term abstractEq(Term[] varTypes) {
        return null;
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
