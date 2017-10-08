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
    
    public Const(String cons)
    {
        con=cons;
    }

    public String getCon() {
        return con;
    }
 
    public boolean occur(Var x)
    {
        return false;
    }
    
    public Term sust(Var x,Term t)
    {
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
   
        @Override
    public String toStringInFin() {
        String res;
        System.out.println("++++++");
        System.out.println(con);
        System.out.println("++++++");
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
    }     
        
    @Override
    public String toStringInf() {
        return con;
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
    public Term sustParall(ArrayList<Var> Vars, ArrayList<Term> varsTerm) {
        return this;
    }

    @Override
    public Term checkApp() {
        return this;
    }

    
   
   
}
