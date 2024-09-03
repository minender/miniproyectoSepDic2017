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
 * @author federico
 */
public class I extends Term {
    final String  i;

    //public I() {}
    
    public I() {
        this.i = "|";
    }

    public String getCon() {
        return i;
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
           return this;
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
    
    public Tipo esRedex()
    {
        return new Tipo(false,false);
    }
    
    public Tipo esRedexFinal()
    {
        return new Tipo(false,false,false);
    }
    
    public Redex buscarRedexIzq(Term itexto,boolean p)
    {
        return null;
    }
    
    public Redex buscarRedexIzqFinal(Term itexto,boolean p)
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
    
    public List<Term> itandotraducBD()
    {
        List<Term> list=new ArrayList<Term>();
        
        return list;
    }
    
    public Term invBraBD(int n)
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
        return ""; //"|";
    }
   
    @Override
    public String toStringLaTeX(SimboloManager s,String numTeo,List transOp) {
            return ""; //"|";
    }     
    
    @Override
    public String toStringLaTeXLabeled(SimboloManager s,int z, Term t, String appPosition, List<Term> l, List<String> l2, Id id, int nivel){
            return ""; //"|";
    }
        
    @Override
    public String toStringFormatC(SimboloManager s, String pos, int id, String rootId)
    {
        return toStringAll();
    }
    
    public String toStringInFin() {
        return ""; //"|";
    }

    public String toStringInFin2() {
        return ""; //"|:";
    }
    
    @Override
    public String toStringLaTeXWithInputs(SimboloManager s, String position, String rootId) {
        return "";
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
        toString.term=this.toStringAll();
        return toString;
    }
        
    public String toStringType(String v) {
        return "NULL";
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
        return this;   
    }
    
    @Override
    public void freeVars(int[] set){
        ;
    }
    
    @Override
    public void freeVars(int[] set, int[] visitNum){
        ;
    }
    
    @Override
    public String stFreeVarsWithAnyIndex(String st) {
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
        return this;
    }

    @Override
    public List<Term> contandotraducBD() {
        throw new UnsupportedOperationException("Not supported yet.");
    }

    @Override
    public int hashCode() {
        int hash = 7;
        hash = 79 * hash + (this.i != null ? this.i.hashCode() : 0);
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
        final I other = (I) obj;
        if ((this.i == null) ? (other.i != null) : !this.i.equals(other.i)) {
            return false;
        }
        return true;
    }
    
    @Override
	public String aliases(String position) {
		
		return "";
	}
    
    
}
