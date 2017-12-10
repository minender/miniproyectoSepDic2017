/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.howtodoinjava.lambdacalculo;

import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author federico
 */
public class Const extends Term
{
    final String con;
    final boolean funNotation;
    final int preced;
    final int asociat; //1:izquierda 2:derecha 0:sin regla de asociatividad
    
    
    public Const(String cons)
    {
        con=cons;
        funNotation = false;
        preced = 0;
        asociat = 0;
    }
    
    public Const(String cons, boolean funNota, int prec, int asoc)
    {
        con=cons;
        funNotation = funNota;
        preced = prec;
        asociat = asoc;
    }

    public String getCon() {
        return con;
    }
    
    public boolean getFunNotation() {
        return funNotation;
    }
    
    public int getPreced() {
        return preced;
    }
    
    public int getAsociat() {
        return asociat;
    }
 
    public boolean occur(Var x)
    {
        return false;
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
       return this instanceof TypedA;
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
        return con;
    }
   
    /*@Override
    public String toStringInFin() {
        String res;
        System.out.println(con);
        if (con.startsWith("\\equiv")) {
           res =" == ";
        }else if (con.startsWith("\\Rightarrow")){
            res =  " ==> ";
        }else if (con.startsWith("\\Leftarrow")){
            res = " <== ";
        }else if (con.startsWith("\\vee")){
            res = " \\/ ";
        }else if (con.startsWith("\\wedge")){
            res = " /\\ ";
        }else if (con.startsWith("\\nequiv")){
            res = " !== ";
        }else if (con.startsWith("\\neg")){
            res = "!";
        }else{
            res = con;
        }
        return res;
    } */    
        
    @Override
    public String toStringInf() {
        return con;
    }
    
    public String toStringInfLabeled(int z, Term t, List<String> leibniz, Id id, int nivel){
        String term = "\\cssId{"+id.id+"}{\\class{"+nivel+" terminoClick}{"+con+"}}";
        leibniz.add(t.leibniz(z, this).toStringInfFinal().replace("\\", "\\\\"));
        id.id++;
        return term;
    }

    /*public Tripla toStringInfLabeled(Id id, int nivel, Tripla tri){
        id.id++;
        tri.term = "\\cssId{"+(id.id-1)+"}{\\class{"+nivel+" terminoClick}{"+con+"}}";
        tri.valores.add("lambda z.z");
        return tri;
    }*/
    
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
    
    public ToString toStringInfAbrv(ToString toString)
    {
        toString.term=this.toStringInf();
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
        final Const other = (Const) obj;
        if ((this.con == null) ? (other.con != null) : !this.con.trim().equals(other.con.trim())) {
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
        return this;
    }

    
   
   
}
