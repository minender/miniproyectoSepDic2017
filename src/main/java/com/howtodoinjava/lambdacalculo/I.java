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
   
   public boolean containTypedA()
   {
       return false;
   }
   
   public Term leibniz(int z, Term subterm)
   {
       if (this == subterm)
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
    
    public List<Term> itandotraducBD()
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
        return ""; //"|";
    }
   
    @Override
    public String toStringInf(SimboloManager s,String numTeo) {
            return ""; //"|";
    }     
    
    @Override
    public String toStringInfLabeled(SimboloManager s,int z, Term t, List<Term> l, List<String> l2, Id id, int nivel){
            return ""; //"|";
    }
        
    @Override
    public String toStringFormatC(SimboloManager s, String pos, int id)
    {
        return toString();
    }
    
    public String toStringInFin() {
        return ""; //"|";
    }

    public String toStringInFin2() {
        return ""; //"|:";
    }
    
    @Override
    public String toStringWithInputs(SimboloManager s, String position) {
        return "";
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
        toString.term=this.toString();
        return toString;
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
