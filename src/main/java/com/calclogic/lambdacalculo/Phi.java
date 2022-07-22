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
import java.util.LinkedList;
import java.util.List;
/**
 *
 * @author federico
 */
public class Phi extends Term{
    
    public ListaInd ind;
    
    public Phi(Indice in){
        ind=new ListaInd(in);
    }
    
    public Phi(){
        ind=new ListaInd();
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
        return 1;
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
    
    public Term bracketAbsBD(Var x)
    {
        return new App(new Const("\\Phi_{K}"),this);
    }
    
    public int maxVar()
    {
        return -1;
    }
    
    public int fresh(int n)
    {
        return n;
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
        if (ind.orden == 0) {
           Tipo tipo = new Tipo(false,false,true);
           return new Redex(contexto,tipo,p);
        }
        else
           return null;
    }
    
    public Term invBraBD(int n)
    {
        Var xn=new Var(n);
        
        return new Bracket(xn,(new App(this,xn)).kappaIndexado(n,xn));
    }
    
    public Term invBD()
    {
        return this.invBraBD(0).invBD();
    }
    
    public Term invBDOneStep()
    {
        return this.invBraBD(0);
    }
    
    public Term bracketAbsSH(Var x)
    {
        return new App(new Const("K"),this);
    }
    
    public String toString(){
        return "\\Phi_{"+ind.toString()+"}";
    }
    
    public String toStringInFin() {
        return "\\Phi_{"+ind.toString()+"}";
    }
    
    @Override
    public String toStringInfLabeled(SimboloManager s,int z, Term t, List<Term> leibniz, List<String> leibnizL, Id id, int nivel){
        String term = "\\cssId{"+id.id+"}{\\class{"+nivel+" terminoClick}{\\Phi_{"+ind.toString()+"}}}";
        leibniz.add(t.leibniz(z, this));
//        leibniz.add(t.leibniz(z, this).toStringFormatC(s,"",0).replace("\\", "\\\\"));
//        leibnizL.add(t.leibniz(z, this).toStringInf(s,"").replace("\\", "\\\\"));
        id.id++;
        return term;
    }
    
    @Override
    public String toStringInf(SimboloManager s,String numTeo) {
        return "\\Phi_{"+ind.toString()+"}";
    }
    
    @Override
    public String toStringFormatC(SimboloManager s, String pos, int id, String rootId)
    {
        return toString();
    }
    
    @Override
    public String toStringWithInputs(SimboloManager s, String position, String rootId) {
        return "\\Phi_{"+ind.toString()+"}";
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
    public ToString toStringInfAbrv(ToString toString, SimboloManager s,PredicadoManager pm,
                                    String nTeo)
    {
        toString.term=this.toStringInf(s,"");
        return toString;
    }

    @Override
    public boolean equals(Object obj) {
        if (obj == null) {
            return false;
        }
        if (getClass() != obj.getClass()) {
            return false;
        }
        final Phi other = (Phi) obj;
        if (this.ind != other.ind && (this.ind == null || !this.ind.equals(other.ind))) {
            return false;
        }
        return true;
    }
    
    @Override
    protected Object clone() throws CloneNotSupportedException
    {
        ListaInd cloneInd=(ListaInd)ind.clone();
        Phi phi=new Phi();
        phi.ind=cloneInd;
        phi.alias=this.alias;
        return phi;
    }

    public Term sustParall(List<Var> Vars, List<Term> varsTerm) {
        return this;
    }

    @Override
    public void freeVars(HashSet<String> hs){
        ;
    }
    
    @Override
    public Term abstractEq() {
        return null;
    }
    
    @Override
    public Term checkApp() {
        return this;
    }
    
    @Override
	public String aliases(String position) {
		
    	String currentAlias = "";
		if( this.alias != null) {
			currentAlias =  this.alias + ':' + position;
		}
		
		return currentAlias;
	}

    
}
