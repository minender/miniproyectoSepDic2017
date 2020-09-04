/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.howtodoinjava.lambdacalculo;

import com.howtodoinjava.service.PredicadoManager;
import com.howtodoinjava.service.SimboloManager;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

/**
 *
 * @author federico
 */
public class Bracket extends Term{
    final Var x;
    public Term t;
    public String tipo;

    public Bracket(Var x, Term t, String tipo) {
        this.x = x;
        this.t = t;
        this.tipo = tipo;
    }
    
    
    public Bracket(Var x1,Term t1)
    {
        x=x1;
        t=t1;
    }
    
    public int x()
    {
        return x.indice;
    }
    
    public boolean occur(Var y)
    {
         if(x.equals(y))
             return false;
         else
             return t.occur(y);
    }
    
    public String position(Var y)
    {
         if(x.equals(y))
             return "3";
         else {
            if (t.occur(y))
             return "1"+t.position(y);
            else
             return "3";
         }
    }
    
    @Override
    public Term subterm(String position) {
        if (position.equals(""))
           return this;
        else if (position.charAt(0) == '1')
           return subterm(position.substring(1));
        else
           return null;
    }
    
    public Term sust(Var x,Term t)
    {
        return null;
    }
    
    public Term type()
    {
        return null;
    }
    
    public boolean containTypedA()
    {
        return t.containTypedA();
    }
    
    public Term leibniz(int z, Term subterm)
    {
       if (this == subterm)
           return new Var(z);
       else
           return new Bracket(x,t.leibniz(z, subterm));
    }
    
    public int setAlias(int currentAlia)
    {
        if(t.alias != null)
        {
            t.alias = t.alias+"@"+currentAlia;
            currentAlia++;
        }
        
        currentAlia = t.setAlias(currentAlia);
        return currentAlia;
    }
    
    public Term bracketAbsSH(Var y)
    {
        return t.bracketAbsSH(x).bracketAbsSH(y);
    }
    
    public Term bracketAbsBD(Var y)
    {
        return t.bracketAbsBD(x).bracketAbsBD(y);
    }
    
    public Term bracketAbsBD()
    {
        return t.bracketAbsBD(x);
    }
    
    public Term traducBD()
    {
        return t.traducBD().bracketAbsBD(x);
    }
    
    public List<Term> contandotraducBD()
    {
        List<Term> list=t.contandotraducBD();
        for (int i=0; i<list.size(); i++) {
            Var xaux = new Var(x.indice);
            list.set(i,new Bracket(xaux, list.get(i)));            
        }
        list.add(t.traducBD().bracketAbsBD(x));
        
        return list;
    }
    
    public int maxVar()
    {
        return t.maxVar();
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
        return t.buscarRedexIzq(this,false);
    }
    
    public Redex buscarRedexIzqFinal(Term contexto,boolean p)
    {
        return t.buscarRedexIzqFinal(this,false);
    }
    
    public Term invBraBD()
    {
        return this;
    }
    
    public Term invBD()
    {
        Term term = new Bracket(x,t.invBD());
        term.alias = this.alias;
        return term;
    }
    
    public Term invBDOneStep()
    {
        return new Bracket(x,t.invBDOneStep());
    }
    
    public String toString()
    {   
        if(t.alias == null)
            return "(\\lambda "+x.toString()+"."+t.toStringFinal()+")";
        else{
            return "(\\lambda "+x.toStringInfFinal(null)+"."+t.alias +")";
            //return "(\\lambda "+x.toString()+"."+t.alias.split("@")[0].replace("_", "\\_") +")";
        }
    }
    
    @Override
    public String toStringInf(SimboloManager s,String numTeo)
    {
       /* if(t.alias == null) {
            System.out.println(t instanceof App);
            if (t instanceof App) {
                if (((App) t).p instanceof App ) {
                    return "(forall "+x.toStringInf()+"|"+t.toStringFinalInf()+")";
                }
                return "(forall "+x.toStringInf()+"|"+t.toStringFinalInf()+")";
            }else{
                //FALTA IMPLEMENTAR FINAL
                //return "(\\lambda "+x.toStringInf()+"."+t.toStringFinalInf()+")";
                return "(\\forall "+x.toStringInf()+"|:"+t.toStringFinalInf()+")";
            }
        }else {
            //return "(\\lambda "+x.toStringInf()+"."+t.alias +")";
            return "(forall "+x.toStringInf()+"|"+t.toStringFinalInf()+")";
        }*/
        if(t.alias == null) {
            //FALTA IMPLEMENTAR FINAL
            return "(E^{"+x.toStringInf(s,"")+"}: "+t.toStringInf(s,"")+")";
            //return t.toStringInf(s,numTeo);
        }
        else {
            return "(E^{"+x.toStringInf(s,"")+"}: "+t.alias +")";
            //return t.alias;
        }//.split("@")[0].replace("_", "\\_") +")";
    }
    
    @Override
    public String toStringInfLabeled(SimboloManager s,int z, Term t, List<Term> leibniz, 
                                     List<String> l2, Id id, int nivel){
        id.id++;
        //leibniz.add(t.leibniz(z, this).toStringInfFinal(null).replace("\\", "\\\\"));
        //leibnizL.add(t.leibniz(z, this).toStringWithInputs(s,"").replace("\\", "\\\\"));
        leibniz.add(t.leibniz(z, this));
        l2.add(l2.remove(0)+id.id+",");
        if(t.alias == null) {
            //FALTA IMPLEMENTAR FINAL
            return "\\cssId{"+(id.id-1)+"}{\\class{"+nivel+" terminoClick}{(\\lambda "+x.toStringInfFinal(null)+"."+t.toStringInfFinal(null)+")}}";
        }
        else {
            return "\\cssId{"+(id.id-1)+"}{\\class{"+nivel+" terminoClick}{(\\lambda "+x.toStringInfFinal(null)+"."+t.alias +")}}";
        }
    }
    
    @Override
    public String toStringFormatC(SimboloManager s, String pos, int id)
    {
        char ascii = (char) x.indice; 
        return "(\\lambda "+ascii+"."+t.toStringFormatC(s,pos,id)+")";
    }
    
    @Override
    public String toStringWithInputs(SimboloManager s, String position) {
        char ascii = (char) x.indice; 
        return "(E^{"+ascii+"}:"+t.toStringWithInputs(s,position)+")";
    }
    
    public ToString toStringAbrv(ToString toString)
    {
        if(t.alias == null)
        {
            t.toStringAbrvFinal(toString);
            toString.term= "(\\lambda "+x.toString()+"."+toString.term+")";
            return toString;
        }
        else
        {
            toString.setNuevoAlias(t.alias, t);
            toString.term="(\\lambda "+x.toString()+"."+toString.term+")";
            return toString;
        }
        
    }
    
    @Override
    public ToString toStringInfAbrv(ToString toString,SimboloManager s, PredicadoManager p,String nTeo)
    {
        if(t.alias == null)
        {
            t.toStringInfAbrvFinal(toString);
            toString.term= "(\\lambda "+x.toStringInf(s,"")+"."+toString.term+")";
            return toString;
        }
        else
        {
            toString.setNuevoAlias(t.alias, t);
            toString.term="(\\lambda "+x.toStringInf(s,"")+"."+toString.term+")";
            return toString;
        }
        
    }
    
    public ToString toStringAbrvV1(ToString toString)
    {
        if(t.alias == null)
        {
            t.toStringAbrvFinalV1(toString);
            toString.term= "(\\lambda "+x.toString()+"."+toString.term+")";
            return toString;
        }
        else
        {
            toString.setNuevoAliasV1(t.alias, t);
            toString.term="(\\lambda "+x.toString()+"."+toString.term+")";
            return toString;
        }
        
    }

    @Override
    public boolean equals(Object obj) {
        if (obj == null) {
            return false;
        }
        if (getClass() != obj.getClass()) {
            return false;
        }
        final Bracket other = (Bracket) obj;
        if (this.x != other.x && (this.x == null || !this.x.equals(other.x))) {
            return false;
        }
        if (this.t != other.t && (this.t == null || !this.t.equals(other.t))) {
            return false;
        }
        return true;
    }
    
    @Override
    protected Object clone() throws CloneNotSupportedException{
        Term term=new Bracket(x,(Term)t.clone());
        term.alias=this.alias;
        return term;
    }

    @Override
    public Term sustParall(List<Var> Vars, List<Term> varsTerm) {
        ArrayList<Var> aux = new ArrayList<Var>();
        int i = 0;
        for (Iterator<Var> it = Vars.iterator(); it.hasNext();) {
            Var var = it.next();
            if (!(var.occur(x))) {
                aux.add(x);     
                varsTerm.remove(i);
            } 
            i++;
        }
        if (aux.size() != 0) {
            
            return new Bracket((Var) x,t.sustParall(aux, varsTerm));
        }else{
            return this;
        }
        
            
        }

    @Override
    public Term checkApp() {
        
        return this;
    }
    
    @Override
	public String aliases(String position) {
		
		return "";
	}

    
    }

